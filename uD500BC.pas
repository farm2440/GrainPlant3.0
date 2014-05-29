unit uD500BC;

interface

uses
  Messages, Windows, SysUtils, Classes,
  Controls, Forms, Menus, Graphics, StdCtrls, ImageLib, ExtCtrls,
  CommonTypes, Math, xControls, ADODB, DB, RSConnection, Dialogs, fmProgress, uRecipe;

const
  ubFrom  = #$07;
  ubTo    = #$06;
  ubEsc   = #$04;
  ubMul   = #$09;
  ubUp    = #$05;
  ubFn    = #$08;
  ubCE    = #$7F;
  ubAE    = #$5D;
  ubZero  = #$00;
  ubTare  = #$01;
  ubTOut  = #$02;
  ubPrint = #$03;

  chSTX = #$02;
  chETX = #$03;

  cInvalidWeight = -99999;

type
  TxDataReadyEvent = procedure (Sender: TObject; Package: string);

  TxD500BC = class (TComponent)
  private
    fBuffIn  : string;

    fStatus  : byte;
    fSign    : char;
    fWeight  : string;
    fDigIn   : string[2];
    fDigOut  : string[3];

    fRSin    : TRSConnection;
    fRSout   : TRSConnection;

    fEmptyLoops : integer;

    fReadTimer : TTimer;

    fTare    : integer;
    fZero    : integer;

    fTimeoutEventHandler   : TNotifyEvent;
    fDataReadyEventHandler : TNotifyEvent;

    function GetWeight: integer;

    { event handlers }
    procedure OnReadTimer(Sender: TObject);

    procedure DataReady(Package: string);

    procedure SetRSIn( Value: TRSConnection );
    procedure SetRSOut( Value: TRSConnection );

  public
    { public properties }
    property RSin: TRSConnection read fRSin write fRSin;      
    property RSout: TRSConnection read fRSout write fRSout;      

    property Status: byte read fStatus;
    property Sign: char read fSign;
    property WeightStr: string read fWeight;
    property Weight: integer read GetWeight;
    property Tare: integer read fTare write fTare;
    property Zero: integer read fZero write fZero;

    { event hooks }
    property OnTimeout: TNotifyEvent read fTimeoutEventHandler write fTimeoutEventHandler;
    property OnDataReady: TNotifyEvent read fDataReadyEventHandler write fDataReadyEventHandler;

    { public declarations }
    constructor Create(AOwner: TComponent; inPort, inBaud: integer; outPort, outBaud: integer); overload;
    destructor Destroy; override;
  end;

implementation

constructor TxD500BC.Create(AOwner: TComponent; inPort, inBaud: integer; outPort, outBaud: integer);
begin
  inherited Create(AOwner);
{
  fRSin := TRSConnection.Create( nil );
  fRSin.Port := inPort;
  fRSin.Baud := inBaud;
  fRSin.StopBits := 1;
  fRSin.DataBits := 8;
  fRSin.Flush;
  fRSin.Open;

  fRSout := TRSConnection.Create( nil );
  fRSout.Port := outPort;
  fRSout.Baud := outBaud;
  fRSout.StopBits := 1;
  fRSout.DataBits := 8;
  fRSout.Open;
}
  fReadTimer := TTimer.Create(Self);
  fReadTimer.Interval := 100;
  fReadTimer.OnTimer := OnReadTimer;
  fReadTimer.Enabled := true;

  fStatus  := 0;
  fSign    := ' ';
  fWeight  := '';

  fTare    := 0;
  fZero    := 0;
end;

destructor TxD500BC.Destroy;
begin
  inherited Destroy;
end;

function TxD500BC.GetWeight: integer;
begin
//  Result := StrToIntDef( fWeight, cInvalidWeight );
  Result := StrToIntDef( fWeight, 0 ) - fTare - fZero;
end;

procedure TxD500BC.OnReadTimer(Sender: TObject);
var pkg: string;
begin
  if Assigned(fRSin) and (fRSin.IsOpen) and (fRSIn.InCount > 0) then
    begin
      { zero the empty loops counter }
      fEmptyLoops := 0;

      { receive the incoming data and append to the buffer }
      fBuffIn := fBuffIn + fRSIn.Read;
      repeat
        pkg := Copy(fBuffIn, 1, Pos(#13, fBuffIn));
        if Length(pkg)>0 then
          begin
            Delete(fBuffIn, 1, Length(pkg));
            DataReady(pkg);
          end;
      until Length(pkg) = 0;
    end
  else
    begin
      inc(fEmptyLoops);
      if fEmptyLoops = 10 then
        if Assigned(OnTimeout) then OnTimeout(Self);
    end;

  if Assigned(fRSout) and fRSOut.IsOpen and (fRSOut.InCount > 0) then
    begin
      { receive the incoming data and append to the buffer }
//      ShowMessage( fRSOut.Read );
    end;
end;

procedure TxD500BC.DataReady(Package: string);
begin
//  if Length(Package) <> 15 then Exit;

  fStatus := Byte(Package[1]);
  fSign   := Package[2];
  fWeight := Copy(Package, 3, 6);

//  fDigIn  := Copy(Package, 10, 2);
//  fDigOut := Copy(Package, 12, 3);

  if Assigned( OnDataReady ) then OnDataReady(Self);
end;

procedure TxD500BC.SetRSIn( Value: TRSConnection );
begin
  fRSIn := Value;
end;

procedure TxD500BC.SetRSOut( Value: TRSConnection );
begin
  fRSOut := Value;   
end;

end.
