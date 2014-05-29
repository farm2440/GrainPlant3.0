unit uLogger;

interface
uses Dialogs, Windows, SysUtils, Classes,
  Controls, Forms, Menus, Graphics, StdCtrls, ImageLib, ExtCtrls,
  CommonTypes, Math, xControls, ADODB, DB;

type
  TxEventType = (etError, etStart, etStop, etMisc);
  TxEventSet  = set of TxEventType;

  TxLogger = class(TComponent)
  private
    fLogView       : TxListView;

    fDBLogProc     : TADOStoredProc;

    fDBLogEvents   : TxEventSet;
    fTimeFormat    : string;

  public
    property LogView     : TxListView read fLogView;
    property DBLogProc   : TADOStoredProc read fDBLogProc;

  private
    constructor Create(AOwner: TComponent); overload;
  public

    constructor Create(AOwner: TComponent; ALogView: TxListView; ADBLogProc: TADOStoredProc); overload;
    destructor Destroy; override;

    procedure LogEvent(EventMsg: string; Note: string; EventType: TxEventType);
  end;

implementation

constructor TxLogger.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

constructor TxLogger.Create(AOwner: TComponent; ALogView: TxListView; ADBLogProc: TADOStoredProc);
begin
  inherited Create(AOwner);

  fLogView     := ALogView;

  fDBLogProc   := ADBLogProc;

  fDBLogEvents := [etError, etStart, etStop, etMisc];
  fTimeFormat  := 'hh:nn'
end;

destructor TxLogger.Destroy;
begin
  inherited Destroy;
end;

procedure TxLogger.LogEvent(EventMsg: string; Note: string; EventType: TxEventType);
var col: TColor;
begin
  if Assigned(fLogView) then
    with fLogView.Items.Add do begin
      Caption := FormatDateTime(fTimeFormat, now);
      SubItems.Add(EventMsg);
      SubItems.Add(Note);
      case EventType of
        etError : col := clRed;
        etStart : col := clGreen;
        etStop  : col := clBlue;
        etMisc  : col := clBlack;
        else col := clBlack;
      end;
      Data := TxColor.Create(col);
      MakeVisible(false);
    end;

  try
    if Assigned(fDBLogProc) and (EventType in fDBLogEvents) then
      with fDBLogProc do begin
        Parameters.ParamByName('when').Value := Now;
        Parameters.ParamByName('type').Value := Integer(EventType);
        Parameters.ParamByName('event').Value := EventMsg;
        Parameters.ParamByName('note').Value := Note;

        fDBLogProc.ExecProc;
      end;
  except
    on Exception do;
  end;
end;

end.
