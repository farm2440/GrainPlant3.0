unit uDevices;

interface

uses Messages, Dialogs, Windows, SysUtils, Classes,
  Controls, Forms, Menus, Graphics, StdCtrls, ImageLib, ExtCtrls,
  CommonTypes, Math, xControls, ADODB, xMnemonics, uLogger, uGlobals;

type
  TxDeviceError = ( errBlock, errMisc, errTimeout, errOverflow );
  TxDeviceErrorSet = set of TxDeviceError;

  TxRouteError = ( errDeviceBlock, errNoDBConnection, errInvalidRouteID, errRouteMisc );
  TxRouteErrorSet = set of TxRouteError;

  TxInBuffer = array[0..5] of byte;
  TxOutBuffer = array[0..5] of byte;

{
  TxDevice - Device base classs
}
  TxDevice = class (TComponent)
  protected
    fCaption : string;

    fDeviceID : integer;

    fError : TxDeviceErrorSet;

    fContactorIn      : boolean;        { physical device feedback }
    fContactorIn2     : boolean;        { physical device feedback 2 - for 2-end state devices /flaps/ }
    fContactorOut     : boolean;        { output signal            }

    fOldState         : boolean;

    fRequestedState   : boolean;        { requested device state   }

    fPending          : boolean;
    fOutputReady      : boolean;
    fReady            : boolean;

    fBitIn            : integer;
    fBitIn2           : integer;
    fBitOut           : integer;
    fBitOverflow      : integer;

    fLog              : TxLogger;

    fTimeout          : integer;
    fViewEnabledBit   : integer;
    fViewEnabled      : boolean;

    fTimeoutTimer     : TTimer;
    fBlockTimer       : TTimer;

    fTimeoutHandler   : TNotifyEvent;
    fReadyHandler     : TNotifyEvent;
    fStateChangeHandler: TNotifyEvent;
    fErrorHandler     : TNotifyEvent;
    fBlockHandler     : TNotifyEvent;
    fOverflowHandler  : TNotifyEvent;

    fMnemonic         : TxMnemonic;
//    soContactor       : TxStatusObj;

    { event handlers }
    procedure OnTimeoutTimer( Sender: TObject );
    procedure OnBlockTimer  ( Sender: TObject );

    { getters / setters }
    procedure SetContactorIn ( Value: boolean );
    procedure SetContactorIn2( Value: boolean );
    procedure SetContactorOut( Value: boolean );

    procedure SetMnemonic( Value: TxMnemonic );

    procedure SetCaption(Value: string);

    function GetErrorStr: string;

    procedure DisposeTimer;
    procedure DisposeBlockTimer;

  public
    { properties }
    property Caption: string read fCaption write SetCaption;

    property DeviceID: integer read fDeviceID write fDeviceID;
    property Error: TxDeviceErrorSet read fError;
    property ErrorStr: string read GetErrorStr;

    property ViewEnabledBit: integer read fViewEnabledBit write fViewEnabledBit;
    property ViewEnabled: boolean read fViewEnabled;
    property Timeout: integer read fTimeout write fTimeout;

    property Ready: boolean read fReady;

    property Log: TxLogger read fLog write fLog;

    property Mnemonic: TxMnemonic read fMnemonic write SetMnemonic;

    { event hooks }
//    property OnTimeout    : TNotifyEvent read fTimeoutHandler write fTimeoutHandler;
    property OnReady      : TNotifyEvent read fReadyHandler write fReadyHandler;
    property OnStateChange: TNotifyEvent read fStateChangeHandler write fStateChangeHandler;
    property OnError      : TNotifyEvent read fErrorHandler write fErrorHandler;
//    property OnBlock      : TNotifyEvent read fBlockHandler write fBlockHandler;
//    property OnOveflow    : TNotifyEvent read fOverflowHandler write fOverflowHandler;

    { public methods }
    constructor Create( AOwner: TComponent ); virtual;
    destructor Destroy; virtual;

    procedure ProcessInput( buff: TxInBuffer ); virtual;
    procedure ModifyOutput( var buff: TxOutBuffer ); virtual;

    procedure Execute; virtual;

    procedure LogEvent(Msg: string; Note: string; EventType: TxEventType);
  end;

{
  TxCommonDevice
}
  TxCommonDevice = class (TxDevice)
  private
    fEnableOutput : boolean;

  public
    { public properties }
    property EnableOutput: boolean read fEnableOutput write fEnableOutput;

    property ContactorIn : boolean read fContactorIn;
    property ContactorOut: boolean read fContactorOut write SetContactorOut;
    property RequestedState: boolean read fRequestedState write fRequestedState;

    property BitIn : integer read fBitIn  write fBitIn;
    property BitOut: integer read fBitOut write fBitOut;
    property BitOverflow: integer read fBitOverflow write fBitOverflow;

    { public methods }
    constructor Create(AOwner: TComponent); virtual;

    procedure ModifyOutput( var buff: TxOutBuffer ); virtual;
  end;

{
  TxSwitchingDevice - Time switching deviceclass
}
  TxSwitchingDevice = class (TxDevice)
  private
    fSwitching        : boolean;
    fSwitchTime       : integer;

    fSwitchTimer      : TTimer;

    fSwitchHandler    : TNotifyEvent;

    fOldState         : boolean;

    fExecuted         : boolean;

    { event handlers }
    procedure OnTimeoutTimer( Sender: TObject );
    procedure OnSwitchTimer( Sender: TObject );

    { private methods }
    procedure DisposeSwitchTimer;

  public
    { event hooks }
    property OnTimeout    : TNotifyEvent read fTimeoutHandler write fTimeoutHandler;
    property OnSwitch     : TNotifyEvent read fSwitchHandler write fSwitchHandler;

    { public properties }
    property ContactorIn : boolean read fContactorIn;
    property ContactorOut: boolean read fContactorOut write SetContactorOut;
    property RequestedState: boolean read fRequestedState write fRequestedState;

    property BitIn : integer read fBitIn  write fBitIn;
    property BitOut: integer read fBitOut write fBitOut;

    property Executed: boolean read fExecuted write fExecuted;

    { public methods }
    constructor Create( AOwner: TComponent ); virtual;
    destructor Destroy; virtual;

    procedure ModifyOutput( var buff: TxOutBuffer ); virtual;

    procedure Switch( Value: boolean; SwitchTime: integer );
  end;

{
  TxTransportDevice - Transport device class
}
  TxTransportDevice = class (TxDevice)
  private

  public
    property ContactorIn : boolean read fContactorIn;
    property ContactorOut: boolean read fContactorOut write SetContactorOut;
    property RequestedState: boolean read fRequestedState write fRequestedState;

    property BitIn : integer read fBitIn  write fBitIn;
    property BitOut: integer read fBitOut write fBitOut;
  end;

{
  TxBranchingDevice - Branching device classs
}
  TxBranchingDevice = class (TxDevice)
  private

    { getters / setters }
    procedure SetContactorIn ( Value: boolean );
    procedure SetContactorIn2( Value: boolean );

    procedure CheckContactors;

  public
    property BranchedLeft: boolean read fContactorIn;
    property BranchedRight: boolean read fContactorIn2;
//    property BranchLeft  : boolean read fContactorOut write SetContactorOut;
    property RequestedRight: boolean read fRequestedState write fRequestedState;

    property BitIn : integer read fBitIn  write fBitIn;
    property BitIn2: integer read fBitIn2 write fBitIn2;
    property BitOut: integer read fBitOut write fBitOut;

    procedure ProcessInput( buff: TxInBuffer ); virtual;
  end;

{
  TxRouletteDevice - Roulette branching device classs
}
  TxRouletteDevice = class (TxDevice)
  protected
    fBranchNrOut : integer;
    fBranchNrIn  : integer;

    fRequestedBranchNr: integer;

    fOverflow    : array[1..6] of boolean;

    fBitInFrom   : integer;
    fBitInTo     : integer;

    fBitOverflowFrom : integer;
    fBitOverflowTo   : integer;

    fBitOutFrom  : integer;
    fBitOutTo    : integer;

    { getters/setters }
    procedure SetBranchNr( Value: integer );
    procedure SetBranchedNr( Value: integer );

  public
    { public properties }
    property BitInFrom: integer read fBitInFrom write fBitInFrom;
    property BitInTo: integer read fBitInTo write fBitInTo;
    property BitOutFrom: integer read fBitOutFrom write fBitOutFrom;
    property BitOutTo: integer read fBitOutTo write fBitOutTo;
    property BitOverflowFrom: integer read fBitOverflowFrom write fBitOverflowFrom;
    property BitOverflowTo: integer read fBitOverflowTo write fBitOverflowTo;

    property Mnemonic: TxMnemonic read fMnemonic write SetMnemonic;
    
    property BranchNr: integer read fBranchNrOut write SetBranchNr;
    property CurrentBranchNr: integer read fBranchNrIn;
    property RequestedBranchNr: integer read fRequestedBranchNr write fRequestedBranchNr;

    { public methods }
    constructor Create(AOwner: TComponent); virtual;

    procedure ProcessInput( buff: TxInBuffer ); override;
    procedure ModifyOutput( var buff: TxOutBuffer ); override;

    procedure Execute; override;
  end;

implementation

(******************************************************)
(* TxDevice - Device base classs                      *)
(******************************************************)

constructor TxDevice.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  fError := [];

  fDeviceID := -1;

  fBitIn  := -1;
  fBitIn2 := -1;
  fBitOut := -1;
  fBitOverflow := -1;

  fLog := nil;

  fPending     := false;
  fOutputReady := false;
  fReady       := false;

  fTimeout     := 5000; { 5sec default timeout }

  fViewEnabledBit := -1;
  fViewEnabled := true;

  fTimeoutTimer := nil;
  fBlockTimer   := nil;

  fTimeoutHandler     := nil;
  fReadyHandler       := nil;
  fStateChangeHandler := nil;
{
  soContactor := TxStatusObj.Create( 'CONTACTOR', 'CONTACTOR', clLime, clGray, clYellow, False, False );
  with soContactor do begin
    Top      := 2;
    Left     := 2;
    Width    := 64;
    Height   := 12;
  end;
}  
end;

destructor TxDevice.Destroy;
begin
  DisposeTimer;
//  soContactor.Free;

  inherited Destroy;
end;

function TxDevice.GetErrorStr: string;
begin
  Result := '';

  if errBlock in fError then Result := Result + 'Блокирал механизъм;';
  if errMisc  in fError then Result := Result + 'Друга грешка;';
end;

procedure TxDevice.DisposeTimer;
begin
  if Assigned( fTimeoutTimer ) then
    begin
(**)  LogEvent( Self.Name + ': спиране на таймера', '', etMisc);
      fTimeoutTimer.Enabled := false;
      fTimeoutTimer.Free;
      fTimeoutTimer := nil;
    end;
end;

procedure TxDevice.DisposeBlockTimer;
begin
  if Assigned( fBlockTimer ) then
    begin
(**)  LogEvent( Self.Name + ': спиране на таймера за блокировка', '', etMisc);
      fBlockTimer.Enabled := false;
      fBlockTimer.Free;
      fBlockTimer := nil;
    end;
end;

procedure TxDevice.OnTimeoutTimer( Sender: TObject );
begin
  fError := fError + [errTimeout];

(**)LogEvent( Self.Name + ': не реагира', '', etError);

  DisposeTimer;

//  if Assigned(OnTimeout) then OnTimeout(Self);
  if Assigned(OnError) then OnError(Self);
end;

procedure TxDevice.OnBlockTimer( Sender: TObject );
begin
  fError := fError + [errBlock];

(**)LogEvent( Self.Name + ': блокирана', '', etError);

  DisposeBlockTimer;

//  if Assigned(fMnemonic) then fMnemonic.StaticImageIndex := 2;
  if Assigned(OnError) then OnError(Self);
end;

procedure TxDevice.SetContactorIn( Value: boolean );
var st: integer;
begin
  try
{}st := 0;
    fContactorIn := Value;

{}st := 1;
    if (fContactorIn <> fOldState) and Assigned(OnStateChange) then OnStateChange(Self);

{}st := 2;
    fOldState := fContactorIn;

{}st := 3;
    if fOutputReady then
      begin
//(**)  LogEvent( Self.Name + ': changing input state', false);
        if fPending and (fContactorIn = fContactorOut) then
          begin
            fReady := true;

{}st := 4;
            DisposeTimer;

{}st := 5;
(**)        LogEvent( Self.Name + ': превключен(а)', '', etMisc);
{}st := 6;
            if Assigned( OnReady ) then OnReady(Self);
            fPending := false;
          end;
      end;
   except
     on exception do ShowMessage('TxDevice.SetContactorIn: step ' + IntToStr(st) +
                                 ' (' + Self.Caption + ')');
   end;
end;

procedure TxDevice.SetContactorIn2( Value: boolean );
begin
  fContactorIn2 := Value;

  { if both contactors are in the same state, start a block timer }
  if fContactorIn = fContactorIn2 then
    begin
      { create a new block timer }
      fBlockTimer := TTimer.Create(Self);
      fBlockTimer.Interval := Self.fTimeout;
      fBlockTimer.OnTimer := OnBlockTimer;
      fBlockTimer.Enabled := true;
    end
  else
    DisposeBlockTimer;
end;

procedure TxDevice.SetContactorOut( Value: boolean );
begin
  fContactorOut := Value;

  fOutputReady := false;
  fReady       := false;
  fPending     := true;

(**)LogEvent( Self.Name + ': промяна на изходния сигнал в ' + BoolToStr(Value), '', etMisc);

  { if a timeout timer is already started, release it }
  DisposeTimer;

  { create a new tiumeout timer }
  fTimeoutTimer := TTimer.Create(Self);
  fTimeoutTimer.Interval := fTimeout;
  fTimeoutTimer.OnTimer := OnTimeoutTimer;
  fTimeoutTimer.Enabled := true;

  { clear the timeout error if set }
  fError := fError - [errTimeout];

(**)LogEvent( Format('%s: стартиране на timeout таймера (%d sec)', [Self.Name, round(Self.Timeout/1000)]), '', etMisc);
end;

procedure TxDevice.SetMnemonic( Value: TxMnemonic );
begin
  fMnemonic := Value;

  if not Assigned(fMnemonic) then Exit;

  fMnemonic.StatusObjects.Clear;
//  fMnemonic.StatusObjects.Add( soContactor )
end;

procedure TxDevice.SetCaption(Value: string);
begin
  fCaption := Value;

  if Assigned(fMnemonic) then fMnemonic.Caption := fCaption;
end;

procedure TxDevice.ProcessInput( buff: TxInBuffer );
var byte_no, bit_no: integer;
begin
  if fViewEnabledBit >= 0 then
    begin
      byte_no := fViewEnabledBit div 8;
      bit_no  := fViewEnabledBit mod 8;
      fViewEnabled := buff[byte_no] and byte(round(power(2, bit_no))) <> 0;
    end;

  if fBitIn >= 0 then
    begin
      byte_no := fBitIn div 8;
      bit_no  := fBitIn mod 8;
      SetContactorIn (buff[byte_no] and byte(round(power(2, bit_no))) <> 0);
    end;

  if fBitIn2 >= 0 then
    begin
      byte_no := fBitIn2 div 8;
      bit_no  := fBitIn2 mod 8;
      SetContactorIn2(buff[byte_no] and byte(round(power(2, bit_no))) <> 0);
    end;

  if fBitOverflow >= 0 then
    begin
      byte_no := fBitOverflow div 8;
      bit_no  := fBitOverflow mod 8;
      if (buff[byte_no] and byte(round(power(2, bit_no))) <> 0) then
        begin
          fError := fError + [errOverflow];
          if Assigned(OnError) then OnError(Self);
        end
      else
        fError := fError - [errOverflow];
    end;

//  soContactor.StateIn := fContactorIn;
  if Assigned( fMnemonic ) then
    if not (fError = []) and (fMnemonic.ImageLib.Images.Count >= 3) then
      fMnemonic.StaticImageIndex := 2
    else
      if not fContactorIn or not fViewEnabled then
        fMnemonic.StaticImageIndex := 0
      else
        fMnemonic.StaticImageIndex := 1;
end;

procedure TxDevice.ModifyOutput( var buff: TxOutBuffer );
var byte_no, bit_no: integer;
begin
  if fBitOut < 0 then Exit;

  byte_no := fBitOut div 8;
  bit_no  := fBitOut mod 8;

  if fContactorOut then
    buff[byte_no] := buff[byte_no] or byte(round(power(2, bit_no)))
  else
    buff[byte_no] := buff[byte_no] and not byte(round(power(2, bit_no)));

//  soContactor.StateOut := fContactorOut;
{
  if Assigned( fMnemonic ) then
    if fContactorOut then fMnemonic.StaticImageIndex := 0
    else fMnemonic.StaticImageIndex := 1;
}
  fOutputReady := true;
end;

procedure TxDevice.Execute;
begin
  if uGlobals.manual then
    begin
      MessageDlg( 'Системата е в ръчен режим на управление!', mtWarning, [mbOK], 0 );
      Exit;
    end;

  SetContactorOut( fRequestedState );
end;

procedure TxDevice.LogEvent(Msg: string; Note: string; EventType: TxEventType);
begin
  if Assigned(Log) then Log.LogEvent(Msg, Note, EventType);
end;

(******************************************************)
(* TxSwitchingDevice - Time switching device classs   *)
(******************************************************)

constructor TxSwitchingDevice.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );

  fSwitching := false;
  fSwitchTimer := nil;
end;

destructor TxSwitchingDevice.Destroy;
begin
  DisposeSwitchTimer;

  inherited Destroy;
end;

procedure TxSwitchingDevice.ModifyOutput( var buff: TxOutBuffer );
begin
  inherited ModifyOutput( buff );

  if fSwitching then
    begin
      fSwitchTimer := TTimer.Create(Self);
      fSwitchTimer.Interval := fSwitchTime;
      fSwitchTimer.OnTimer := OnSwitchTimer;
      fSwitchTimer.Enabled := true;
      fSwitching := false;
    end;
end;

procedure TxSwitchingDevice.Switch( Value: boolean; SwitchTime: integer );
begin
  if (ContactorOut <> Value) and (SwitchTime > 0) then
    begin
      fSwitchTime := SwitchTime;
      fOldState := ContactorOut;
      ContactorOut := Value;
      fSwitching := true;
      fExecuted := false;
    end;
end;

procedure TxSwitchingDevice.OnTimeoutTimer( Sender: TObject );
begin
  inherited OnTimeoutTimer( Sender );
  DisposeSwitchTimer;
end;

procedure TxSwitchingDevice.OnSwitchTimer( Sender: TObject );
begin
  DisposeSwitchTimer;
  ContactorOut := fOldState;
  fSwitching := false;
end;

procedure TxSwitchingDevice.DisposeSwitchTimer;
begin
  if Assigned( fSwitchTimer ) then
    begin
(**)  LogEvent( Self.Name + ': спиране на таймера за превключване', '', etMisc);
      fSwitchTimer.Enabled := false;
      fSwitchTimer.Free;
      fSwitchTimer := nil;
    end;
end;


(******************************************************)
(* TxTransportDevice - Device base classs             *)
(******************************************************)

(******************************************************)
(* TxBranchingDevice - Device base classs             *)
(******************************************************)

procedure TxBranchingDevice.ProcessInput( buff: TxInBuffer );
var byte_no, bit_no: integer;
begin
  if fViewEnabledBit >= 0 then
    begin
      byte_no := fViewEnabledBit div 8;
      bit_no  := fViewEnabledBit mod 8;
      fViewEnabled := buff[byte_no] and byte(round(power(2, bit_no))) <> 0;
    end;

  if fBitIn >= 0 then
    begin
      byte_no := fBitIn div 8;
      bit_no  := fBitIn mod 8;
      Self.SetContactorIn (buff[byte_no] and byte(round(power(2, bit_no))) <> 0);
    end;

  if fBitIn2 >= 0 then
    begin
      byte_no := fBitIn2 div 8;
      bit_no  := fBitIn2 mod 8;
      Self.SetContactorIn2(buff[byte_no] and byte(round(power(2, bit_no))) <> 0);
    end;

  if fBitOverflow >= 0 then
    begin
      byte_no := fBitOverflow div 8;
      bit_no  := fBitOverflow mod 8;
      if (buff[byte_no] and byte(round(power(2, bit_no))) <> 0) then
        begin
          fError := fError + [errOverflow];
          if Assigned(OnError) then OnError(Self);
        end
      else
        fError := fError - [errOverflow];
    end;

//  soContactor.StateIn := fContactorIn;
  if Assigned( fMnemonic ) then
    if not (fError = []) and (fMnemonic.ImageLib.Images.Count >= 3) then
      fMnemonic.StaticImageIndex := 2
    else
      if fViewEnabled then
        if     fContactorIn and not fContactorIn2 then
          fMnemonic.StaticImageIndex := 0
        else
        if not fContactorIn and fContactorIn2 then
          fMnemonic.StaticImageIndex := 1
        else
          fMnemonic.StaticImageIndex := 2;
end;

procedure TxBranchingDevice.SetContactorIn( Value: boolean );
begin
  fContactorIn := Value;
{
  if (fContactorIn <> fOldState) and Assigned(OnStateChange) then OnStateChange(Self);

  fOldState := fContactorIn;
}
  CheckContactors;
end;

procedure TxBranchingDevice.SetContactorIn2( Value: boolean );
begin
  fContactorIn2 := Value;

  CheckContactors;
end;

procedure TxBranchingDevice.CheckContactors;
begin
  { if both contactors are in the same state, start a block timer }
  if fPending and fOutputReady and not fReady and (fContactorIn = fContactorIn2) then
    begin
      { create a new block timer }
      if not Assigned( fBlockTimer ) then
        begin
          fBlockTimer := TTimer.Create(Self);
          fBlockTimer.Interval := Self.fTimeout;
          fBlockTimer.OnTimer := OnBlockTimer;
          fBlockTimer.Enabled := true;
        end;
    end
  else
    begin
      DisposeBlockTimer;

      if fOutputReady then
        begin
          if fPending and
            not (fContactorIn  = fContactorOut) and
            (fContactorIn2 = fContactorOut) then
            begin
              fReady := true;
              DisposeTimer;
(**)          LogEvent( Self.Name + ': превключен(а)', '', etMisc);
              if Assigned( OnReady ) then OnReady(Self);
              fPending := false;
            end;
        end;
    end;
end;


(******************************************************)
(* TxCommonDevice - Device base classs                *)
(******************************************************)

constructor TxCommonDevice.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  fEnableOutput := true;
//  fEnableOutput := false;
end;

procedure TxCommonDevice.ModifyOutput( var buff: TxOutBuffer );
begin
  if EnableOutput then inherited ModifyOutput(buff); 
end;

(******************************************************)
(* TxRouletteDevice - Device base classs              *)
(******************************************************)

constructor TxRouletteDevice.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  fBitOverflowFrom := -1;
  fBitOverflowTo   := -1;

  fBitInFrom       := -1;
  fBitInTo         := -1;

  fBitOutFrom      := -1;
  fBitOutTo        := -1;

  fBranchNrOut     := -1;
  fBranchNrIn      := -1;

  FillChar(fOverflow, SizeOf(fOverflow), False);
end;

procedure TxRouletteDevice.SetBranchNr( Value: integer );
begin
  if Value < 0 then fBranchNrOut := 0 else
  if Value > 6 then fBranchNrOut := 6 else
    fBranchNrOut := Value;

  fOutputReady := false;
  fReady       := false;
  fPending     := true;
  fBranchNrIn  := -1;

(**)LogEvent( Self.Name + ': превключване в позиция ' + IntToStr( fBranchNrOut ), '', etMisc);

  { if a timeout timer is already started, release it }
  DisposeTimer;

  { create a new tiumeout timer }
  fTimeoutTimer := TTimer.Create(Self);
  fTimeoutTimer.Interval := fTimeout;
  fTimeoutTimer.OnTimer := OnTimeoutTimer;
  fTimeoutTimer.Enabled := true;

(**)LogEvent( Format('%s: стартиране на timeout таймера (%d sec)', [Self.Name, round(Self.Timeout/1000)]), '', etMisc);
end;

procedure TxRouletteDevice.SetBranchedNr( Value: integer );
begin
  fBranchNrIn := Value;

  if fOutputReady then
    begin
//(**)  LogEvent( Self.Name + ': changing input state to ' + IntToStr( fBranchNrIn ), false);
      if fPending and (fBranchNrIn = fBranchNrOut) then
        begin
          DisposeTimer;

(**)      LogEvent( Self.Name + ': превключен(а)', '', etMisc);
          if Assigned( OnReady ) then OnReady(Self);
          fReady := true;

          fPending := false;
        end;
    end;
end;

procedure TxRouletteDevice.ProcessInput( buff: TxInBuffer );
var byte_no, bit_no: integer;
    i : integer;
    ovfl: boolean;
begin
  ovfl := false;

//  if fBitOverflowFrom >=0 then
  for i:=1 to 6 do
    begin
      { get the input state /current bunker/ }
      if fBitInFrom >= 0 then
        begin
          byte_no := (fBitInFrom + i - 1) div 8;
          bit_no  := (fBitInFrom + i - 1) mod 8;

          if buff[byte_no] and byte(round(power(2, bit_no))) <> 0 then
            begin
              Self.SetBranchedNr( i );
              break;
            end;
        end;
(**)
      { get the overflow status for each bunker }
      if fBitOverFlowFrom >= 0 then
        begin
          byte_no := (fBitOverflowFrom + i - 1) div 8;
          bit_no  := (fBitOverflowFrom + i - 1) mod 8;

          fOverflow[i] := buff[byte_no] and byte(round(power(2, bit_no))) <> 0;
          ovfl := ovfl or fOverflow[i];
        end;
(**)
    end;

  if Assigned(fMnemonic) then
    fMnemonic.StaticImageIndex := CurrentBranchNr - 1;

  if ovfl then
    begin
      fError := fError + [errOverflow];
      if Assigned(OnError) then OnError(Self);
    end
  else
    fError := fError - [errOverflow];
end;

procedure TxRouletteDevice.ModifyOutput( var buff: TxOutBuffer );
var byte_no, bit_no: integer;
    i : integer;
begin
  for i:=1 to 6 do
    begin
      byte_no := (fBitOutFrom + i - 1) div 8;
      bit_no  := (fBitOutFrom + i - 1) mod 8;

      if fBranchNrOut = i then
        buff[byte_no] := buff[byte_no] or byte(round(power(2, bit_no)))
      else
        buff[byte_no] := buff[byte_no] and not byte(round(power(2, bit_no)));
    end;

  fOutputReady := true;
end;

procedure TxRouletteDevice.Execute;
begin
  SetBranchNr( fRequestedBranchNr );
end;


end.
