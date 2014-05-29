unit uRoute;

interface

uses Messages, Dialogs, Windows, SysUtils, Classes,
  Controls, Forms, Menus, Graphics, StdCtrls, ImageLib, ExtCtrls,
  CommonTypes, Math, xControls, ADODB, xMnemonics, uDevices, uLogger, uGlobals;

{$define debug}

type
  TxRouteError = ( errDeviceBlock, errNoDBConnection, errInvalidRouteID, errRouteMisc );
  TxRouteErrorSet = set of TxRouteError;

  TxBunkersArray = array[1..8] of TxCommonDevice;

{
  TxRoute - Route (chain of devices) classs
}
  TxRoute = class (TComponent)
  private
    fDeviceList : TList;
    fCurrentDevice : integer;

    fActive     : boolean;    { Device activation done }
    fError      : TxRouteErrorSet;

    { route devices }
    fAuger      : TxTransportDevice;
    fElevator   : TxTransportDevice;
    fFlap1      : TxBranchingDevice;
    fFlap2      : TxBranchingDevice;          
    fRoulette   : TxRouletteDevice;

    fBunkers    : TxBunkersArray;

    fDischarge  : TxTransportDevice;

    fDBConnection: TADOConnection;
    fLog        : TxLogger;

    fSelectedBunker: integer;

    { event hooks }
    fStateChangeEventHandler : TNotifyEvent;

    { getters/setters }
    procedure SetLog( Value: TxLogger );
    procedure SetActive( Value: boolean );

    function GetBunker(Index: integer): TxCommonDevice;

  public
  { public properties }
    property DBConnection: TADOConnection read fDBConnection write fDBConnection;
    property Active: boolean read fActive;

    property Log: TxLogger read fLog write SetLog;

  { route devices }
    property Auger   : TxTransportDevice read fAuger;
    property Elevator: TxTransportDevice read fElevator;
    property Flap1   : TxBranchingDevice read fFlap1;
    property Flap2   : TxBranchingDevice read fFlap2;
    property Roulette: TxRouletteDevice read fRoulette;

    property Bunkers[Index: integer]: TxCommonDevice read GetBunker;

  { event hooks }
    property OnStateChange: TNotifyEvent read fStateChangeEventHandler write fStateChangeEventHandler;

  { public methods }
    constructor Create(AOwner: TComponent);
    destructor Destroy;

    { event handlers }
    procedure OnDeviceReady   ( Sender: TObject );
    procedure OnDeviceError   ( Sender: TObject );
    procedure OnBunkerOverflow( Sender: TObject );

    procedure AddDevice(ADevice: TxDevice);
    procedure RemDevice(ADevice: TxDevice);

    function StartChain(RouteID: integer): boolean;
    function StopChain: boolean;
    function CheckUp: boolean;

    procedure ProcessInput( buff: TxInBuffer );
    procedure ModifyOutput( var buff: TxOutBuffer );

    procedure LogEvent(Msg: string; Note: string; EventType: TxEventType);
  end;

implementation

(******************************************************)
(* TxRoute - Route (chain of devices) classs          *)
(******************************************************)

constructor TxRoute.Create(AOwner: TComponent);
var i: integer;
begin
  inherited Create(AOwner);

  DBConnection := nil;
  FDeviceList := TList.Create;

  fAuger := TxTransportDevice.Create(Self);
  fAuger.Name := 'auger';
  fAuger.Caption := 'Шнек';
  fAuger.BitIn  := 25;

  fElevator := TxTransportDevice.Create(Self);
  fElevator.Name := 'elevator';
  fElevator.Caption := 'Елеватор';
  fElevator.Timeout   := uGlobals.elevator_timeout * 1000;
  fElevator.OnError   := OnDeviceError;
  fElevator.OnReady   := OnDeviceReady;
  fElevator.BitIn  := 24;
  fElevator.BitOut := 17;

  fFlap1 := TxBranchingDevice.Create(Self);
  fFlap1.Name := 'flap1';
  fFlap1.Caption := 'Клапа 1';
  fFlap1.Timeout   := uGlobals.flap1_timeout * 1000;
  fFlap1.OnError   := OnDeviceError;
  fFlap1.OnReady   := OnDeviceReady;
  fFlap1.BitIn  := 20;
  fFlap1.BitIn2 := 21;
  fFlap1.BitOut := 22;

  fFlap2 := TxBranchingDevice.Create(Self);
  fFlap2.Name := 'flap2';
  fFlap2.Caption := 'Клапа 2';
  fFlap2.Timeout   := uGlobals.flap2_timeout * 1000;
  fFlap2.OnError   := OnDeviceError;
  fFlap2.OnReady   := OnDeviceReady;
  fFlap2.BitIn  := 22;
  fFlap2.BitIn2 := 23;
  fFlap2.BitOut := 23;

  fRoulette := TxRouletteDevice.Create(Self);
  fRoulette.Name := 'roulette';
  fRoulette.Caption := 'Бункери 1-6';
  fRoulette.Timeout   := uGlobals.roulette_timeout * 1000;
  fRoulette.OnError   := OnDeviceError;
  fRoulette.OnReady   := OnDeviceReady;
  fRoulette.BitInFrom := 1;
  fRoulette.BitInTo   := 6;
  fRoulette.BitOutFrom:= 24;
  fRoulette.BitOutTo  := 29;
//  fRoulette.BitOverflowFrom := 32;
//  fRoulette.BitOverflowTo := 37;

  fDischarge := TxTransportDevice.Create(Self);
  fDischarge.Name := 'discharge';
  fDischarge.BitIn  := 29;
  fDischarge.BitOut := 2;

  for i:=1 to 6 do
    begin
      fBunkers[i] := TxCommonDevice.Create(Self);
      fBunkers[i].Name         := 'bunker' + IntToStr(i);
      fBunkers[i].Caption      := 'Бункер ' + IntToStr(i);
      fBunkers[i].EnableOutput := false;
      fBunkers[i].BitIn        := i;
      fBunkers[i].BitOverflow  := 32 + i - 1;
      fBunkers[i].OnError      := OnBunkerOverflow;
      fBunkers[i].DeviceID     := i;
      fBunkers[i].ViewEnabledBit := 20;
    end;

  fBunkers[7] := TxCommonDevice.Create(Self);
  fBunkers[7].Name         := 'bunker7';
  fBunkers[7].Caption      := 'Бункер 7';
  fBunkers[7].EnableOutput := false;
  fBunkers[7].BitIn        := 22;
  fBunkers[7].BitOverflow  := 38;
  fBunkers[7].OnError      := OnBunkerOverflow;
  fBunkers[7].DeviceID     := 7;
  fBunkers[7].ViewEnabledBit := 21;

  fBunkers[8] := TxCommonDevice.Create(Self);
  fBunkers[8].Name         := 'bunker8';
  fBunkers[8].Caption      := 'Бункер 8';
  fBunkers[8].EnableOutput := false;
  fBunkers[8].BitIn        := 23;
  fBunkers[8].BitOverflow  := 39;
  fBunkers[8].OnError      := OnBunkerOverflow;
  fBunkers[8].DeviceID     := 8;
  fBunkers[8].ViewEnabledBit := 21;

(*  AddDevice( fAuger    ); *)
  AddDevice( fElevator );
  AddDevice( fRoulette );
  AddDevice( fFlap2    );
  AddDevice( fFlap1    );

  fSelectedBunker := 1;
end;

destructor TxRoute.Destroy;
begin
  fDeviceList.Free;

  fAuger   .Free;
  fElevator.Free;
  fFlap1   .Free;
  fFlap2   .Free;
  fRoulette.Free;

  fDischarge.Free;

  inherited Destroy;
end;

procedure TxRoute.SetLog( Value: TxLogger );
var i: integer;
begin
  fLog := Value;

  for i:=0 to fDeviceList.Count-1 do TxDevice( fDeviceList[i] ).Log := fLog;
end;

procedure TxRoute.SetActive( Value: boolean );
begin
  if (fActive <> Value) and Assigned(OnStateChange) then
    begin
      fActive := Value;
      OnStateChange(Self);
    end
  else
    fActive := Value;
end;

function TxRoute.GetBunker(Index: integer): TxCommonDevice;
begin
  Result := nil;
  if (Index >= 1) and (Index <= 8) then Result := fBunkers[Index];
end;

procedure TxRoute.OnDeviceReady( Sender: TObject );
begin
  if not fActive then Exit;
(**)LogEvent( Self.Name + ': устройството е активирано', '', etMisc);

  Dec( fCurrentDevice );
  if fCurrentDevice <= 0 then
    begin
(**)  LogEvent( Self.Name + ': маршрутът е пуснат', '', etMisc);
//      SetActive(false);
    end
  else
    begin
(**)  LogEvent( Self.Name + ': стартиране на следващо устройство', '', etStart);
      if TxDevice( fDeviceList[fCurrentDevice-1] ).Name = 'roulette' then
        if not fFlap1.RequestedRight then
          TxDevice( fDeviceList[fCurrentDevice-1] ).Execute
        else
          OnDeviceReady(fRoulette)
      else
      if TxDevice( fDeviceList[fCurrentDevice-1] ).Name = 'flap2' then
        if fFlap1.RequestedRight then
          TxDevice( fDeviceList[fCurrentDevice-1] ).Execute
        else
          OnDeviceReady(fRoulette)
      else
        TxDevice( fDeviceList[fCurrentDevice-1] ).Execute
    end;
end;

procedure TxRoute.OnDeviceError( Sender: TObject );
var dev: TxDevice;
begin
  if fActive then
    begin
      StopChain;

      dev := TxDevice(Sender);

      if errTimeout in dev.Error then
        begin
(**)      LogEvent( Self.Name + ': устройството не реагира!', '', etError);
          MessageDlg(dev.Caption + ': устройството не реагира!', mtError, [mbOK], 0);
        end;
      if errOverflow in dev.Error then
        begin
(**)      LogEvent( Self.Name + ': препълване', '', etError);
          MessageDlg(dev.Caption + ': препълване!', mtError, [mbOK], 0);
        end;
      if errBlock in dev.Error then
        begin
(**)      LogEvent( Self.Name + ': блокирана', '', etError);
          MessageDlg(dev.Caption + ': блокирана!', mtError, [mbOK], 0);
        end;
    end;    
end;

procedure TxRoute.OnBunkerOverflow( Sender: TObject );
begin
{
  if fActive then
    begin
      if TxCommonDevice(Sender).DeviceID = fSelectedBunker then
        begin
          StopChain;
          MessageDlg( TxCommonDevice(Sender).Caption + ' е препълнен! Маршрутът е спрян!',
                      mtWarning, [mbOK], 0);
        end
      else
        begin
          MessageDlg( TxCommonDevice(Sender).Caption + ' е препълнен!',
                      mtWarning, [mbOK], 0);
        end;
    end;
}    
end;

procedure TxRoute.AddDevice(ADevice: TxDevice);
begin
  fDeviceList.Add( ADevice );
end;

procedure TxRoute.RemDevice(ADevice: TxDevice);
var i: integer;
begin
  for i:=0 to fDeviceList.Count-1 do
    if TxDevice(fDeviceList[i]) = ADevice then
      begin
        fDeviceList.Delete(i);
        Break;
      end;
end;

function TxRoute.StartChain(RouteID: integer): boolean;
var q: TADOQuery;
    st: integer;
begin
  if uGlobals.manual then
    begin
      MessageDlg( 'Системата е в ръчен режим на управление!', mtWarning, [mbOK], 0 );
      Exit;
    end;

 try
  Result := False;

  st := 0;
(**)LogEvent( Self.Name + ': стартиране на маршрут...', '', etStart);

  st := 1;
  if not Assigned(DBConnection) then
    begin
      fError := fError + [ errNoDBConnection ];
(**)  LogEvent( Self.Name + ': няма връзка с базата данни!', '', etError);
      Exit;
    end
  else fError := fError - [ errNoDBConnection ];

  q := TADOQuery.Create(Self);
  q.Connection := DBConnection;

  st := 2;
  q.SQL.Text := 'SELECT * FROM routes WHERE id = :id';
  q.Parameters.ParamByName('id').Value := RouteID;

  try
    try
      q.Open;

      if q.IsEmpty then
        begin
(**)      LogEvent( Self.Name + ': маршрутът не е намерен!', '', etError);
          fError := fError + [errInvalidRouteID]
        end
      else
        begin
          fError := fError - [errInvalidRouteID];

          { Load requested states }
(*          fAuger.RequestedState := q.FieldByName( 'auger' ).AsBoolean; *)
          fElevator.RequestedState := q.FieldByName( 'elevator' ).AsBoolean;
          fFlap1.RequestedRight := q.FieldByName( 'flap1' ).AsBoolean;
          fFlap2.RequestedRight := q.FieldByName( 'flap2' ).AsBoolean;
          fRoulette.RequestedBranchNr := q.FieldByName( 'roulette' ).AsInteger;

          if not fFlap1.RequestedRight then
            fSelectedBunker := fRoulette.RequestedBranchNr
          else
            if not fFlap2.RequestedRight then
              fSelectedBunker := 7
            else
              fSelectedBunker := 8;

          if not (errOverflow in fBunkers[fSelectedBunker].Error) then
            begin
(**           LogEvent('Auger: ' + IntToStr( Integer( q.FieldByName( 'auger' ).AsBoolean )), '', etMisc);        (**)
(**)          LogEvent('Елеватор: ' + IntToStr( Integer( q.FieldByName( 'elevator' ).AsBoolean )), '', etMisc);  (**)
(**)          LogEvent('Клапа 1: '  + IntToStr( Integer( q.FieldByName( 'flap1'    ).AsBoolean )), '', etMisc);  (**)
(**)          LogEvent('Клапа 2: '  + IntToStr( Integer( q.FieldByName( 'flap2'    ).AsBoolean )), '', etMisc);  (**)
(**)          LogEvent('Рулетка: '  + IntToStr( q.FieldByName( 'roulette' ).AsInteger), '', etMisc);  (**)

              { Start from the last device }
              fCurrentDevice := fDeviceList.Count;
              TxDevice(fDeviceList.Last).Execute;

              Result := True;
              SetActive(True);
            end
          else
            begin
              MessageDlg('Избраният бункер е препълнен!', mtWarning, [mbOK], 0);
            end;
        end;

      q.Close;

    except
      on Exception do
        begin
(**)      LogEvent('SQL exception', '', etError);
          Exit;
        end;
    end;
  finally
    q.Free;
  end;
 except
   on exception do ShowMessage( ''  );
 end;
end;

function TxRoute.StopChain: boolean;
begin
(**)LogEvent( Self.Name + ': спиране на маршрут', '', etStop);

  { close the discharge flap }
  fDischarge.ContactorOut := false;

  { stop the transport devices }
(*  fAuger.ContactorOut := false; *)
  fElevator.ContactorOut := false;

  SetActive(false);
  
  Result := True;
end;

function TxRoute.CheckUp: boolean;
begin
  { if the route is active }
  if fActive then
    { check if the target bunker is overflown }
    if errOverflow in fBunkers[fSelectedBunker].Error then StopChain;

  Result := fActive;  
end;

procedure TxRoute.ProcessInput( buff: TxInBuffer );
var i: integer;
begin
  fAuger    .ProcessInput(buff);
  fElevator .ProcessInput(buff);
  fFlap1    .ProcessInput(buff);
  fFlap2    .ProcessInput(buff);
  fRoulette .ProcessInput(buff);
  fDischarge.ProcessInput(buff);

  for i:=1 to 8 do
    fBunkers[i].ProcessInput( buff );
end;

procedure TxRoute.ModifyOutput( var buff: TxOutBuffer );
var i: integer;
begin
  fElevator .ModifyOutput( buff );
  fFlap1    .ModifyOutput( buff );
  fFlap2    .ModifyOutput( buff );
  fRoulette .ModifyOutput( buff );
end;

procedure TxRoute.LogEvent(Msg: string; Note: string; EventType: TxEventType);
begin
  if Assigned(Log) then Log.LogEvent(Msg, Note, EventType);
end;

end.
