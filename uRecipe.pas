unit uRecipe;

interface

uses Dialogs, Windows, SysUtils, Classes,
  Controls, Forms, Menus, Graphics, StdCtrls, ImageLib, ExtCtrls,
  CommonTypes, Math, xControls, ADODB, DB, uGlobals,ShellApi,
  ScktComp;

type
  TxRecipeStep = class (TObject)
  private
    fStep        : integer;
    fSiloNr      : integer;
    fSiloID      : integer;
    fSiloName    : string;
    fQty         : integer;
    fFineQty     : integer;
    fTolerance   : integer;
    fMaxDoseTime : integer;
    fSettlingTime: integer;
    fPreact      : integer;
    fJogOn       : integer;
    fJogOff      : integer;

    fStarted     : boolean;
    fFinished    : boolean;
    fStable      : boolean;

    fQtyOnClose  : integer;
    fQtyBeforeNext : integer;

    fInitialWeight : integer;
    fCurrWeight    : integer;

    fStableTimer   : TTimer;
    fJamTimer      : TTimer;

    fJammed        : boolean;
    fNeedsHammer   : boolean;

    constructor Create; overload;

    function GetQtyAvg: integer;
    function GetCurrQty: integer;

    procedure SetCurrWeight(AWeight: integer);

    procedure DisposeStableTimer;
    procedure DisposeJamTimer;

    procedure OnStableTimer(Sender: TObject);

  public
    property Step        : integer read fStep;
    property SiloNr      : integer read fSiloNr;
    property SiloID      : integer read fSiloID;
    property SiloName    : string  read fSiloName;
    property Qty         : integer read fQty;
    property FineQty     : integer read fFineQty;
    property Tolerance   : integer read fTolerance;
    property MaxDoseTime : integer read fMaxDoseTime;
    property SettlingTime: integer read fSettlingTime;
    property Preact      : integer read fPreact;
    property JogOn       : integer read fJogOn;
    property JogOff      : integer read fJogOff;

    property Started     : boolean read fStarted  {write fStarted};
    property Finished    : boolean read fFinished write fFinished;
    property Stable      : boolean read fStable;

    property QtyOnClose   : integer read fQtyOnClose    write fQtyOnClose;
    property QtyBeforeNext: integer read fQtyBeforeNext write fQtyBeforeNext;
    property QtyAvg       : integer read GetQtyAvg;

    property InitialWeight: integer read fInitialWeight {write fInitialWeight};
    property CurrWeight: integer read fCurrWeight write fCurrWeight;
    property CurrQty: integer read GetCurrQty;

    constructor Create( AStep: integer;
                        ASiloNr: integer;
                        ASiloID: integer;
                        ASiloName: string;
                        AQty: integer;
                        AFineQty: integer;
                        ATolerance: integer;
                        AMaxDoseTime: integer;
                        ASettlingTime: integer;
                        APreact: integer;
                        AJogOn: integer;
                        AJogOff: integer
                        ); overload;

    procedure doStart(AInitialWeight: integer);
    procedure doFinish;

    procedure Reset;
  end;

  TxRecipeStepList = class (TList)
  private
    procedure SetRecipeStep(Index: integer; Value: TxRecipeStep);
    function  GetRecipeStep(Index: integer): TxRecipeStep;

  public
    property RecipeStep[Index: integer]: TxRecipeStep read GetRecipeStep write SetRecipeStep; default;
  end;

  TxRecipe = class (TObject)
  private
    fOrderID          : integer;
    fRecipeID         : integer;

    fSteps            : TxRecipeStepList;

    fCurrStepNr       : integer;

    fWaterFlow        : real;
    fWaterQty         : real;
    fWaterTime        : real;
    fOilFlow          : real;
    fOilQty           : real;
    fOilTime          : real;

    fQtyRecipe        : integer;
    fQtyReq           : integer;
    fQtyDone          : integer;
    fQtyDose          : integer;
    fQtyLastDose      : integer;

    fDosesReq         : integer;
    fDosesDone        : integer;
    fCoef             : real;

    fWaterStartStep   : integer;
    fOilStartStep     : integer;
    fMixerStartStep   : integer;
    fDischargeAfter   : integer;

    fCapacity         : integer;

    fStarted          : boolean;
    fFinished         : boolean;
    fStepStarted      : boolean;
    fStepDone         : boolean;
    fDoseStarted      : boolean;
    fDoseDone         : boolean;
    fDischStarted     : boolean;
    fDischDone        : boolean;

    function GetStepsCount: integer;
    function GetCurrentStep: TxRecipeStep;

    function GetDoseStarted: boolean;
    function GetDoseDone: boolean;
    function GetStepStarted: boolean;
    function GetStepDone: boolean;

    { accessor methods }
    procedure SetStarted(Value: boolean);

  public
    { public properties }
    property OrderID  : integer read fOrderID;
    property RecipeID : integer read fRecipeID;

    property Capacity : integer read fCapacity write fCapacity;

    property StepCount: integer read GetStepsCount;
    property WaterQty : real    read fWaterQty;
    property WaterFlow: real    read fWaterFlow;
    property WaterTime: real    read fWaterTime;
    property OilQty   : real    read fOilQty;
    property OilFlow  : real    read fOilFlow;
    property OilTime  : real    read fOilTime;

    property QtyRecipe  : integer read fQtyRecipe;
    property QtyReq     : integer read fQtyReq;
    property QtyDone    : integer read fQtyDone;
    property QtyDose    : integer read fQtyDose;
    property QtyLastDose: integer read fQtyLastDose;

    property DosesReq : integer read fDosesReq;
    property DosesDone: integer read fDosesDone;
    property Coef     : real    read fCoef;

    property WaterStartStep: integer read fWaterStartStep;
    property OilStartStep  : integer read fOilStartStep;
    property MixerStartStep: integer read fMixerStartStep;
    property DischargeAfter: integer read fDischargeAfter;

    property CurrStepNr : integer read fCurrStepNr write fCurrStepNr;
    property CurrStep   : TxRecipeStep read GetCurrentStep;

    property Started    : boolean read fStarted{  write SetStarted};
    property Finished   : boolean read fFinished;
    property DoseStarted: boolean read GetDoseStarted;
    property DoseDone   : boolean read GetDoseDone;
    property StepStarted: boolean read GetStepStarted;
    property StepDone   : boolean read GetStepDone;
    property DischStarted: boolean read fDischStarted;
    property DischDone  : boolean read fDischDone;

    { public methods }
    constructor Create(AOwner: TObject; Data: TDataSet); virtual;
    destructor Destroy; virtual;

    function GetStepBySilo(SiloNr: integer): TxRecipeStep;
    function GetStepByNr  (StepNr: integer): TxRecipeStep;
    procedure NextStep;

    procedure doDoseStart;
    procedure doDoseDone(Qty: integer);
    procedure doDischStart;
    procedure doDischDone;
    procedure doAbortDose;

//ss-start
    procedure sdStart;
    procedure sdStop;
//ss-end

  private
    procedure Load(Data: TDataSet);

  end;

implementation

{
  TxRecipeStep
}

constructor TxRecipeStep.Create;
begin
  inherited Create;
end;

constructor TxRecipeStep.Create( AStep: integer; ASiloNr: integer; ASiloID: integer; ASiloName: string; AQty: integer;
  AFineQty: integer; ATolerance: integer; AMaxDoseTime: integer; ASettlingTime: integer;
  APreact: integer; AJogOn: integer; AJogOff: integer );
begin
  inherited Create;

  fStep        := AStep;
  fSiloNr      := ASiloNr;
  fSiloID      := ASiloID;
  fSiloName    := ASiloName;
  fQty         := AQty;
  fFineQty     := AFineQty;
  fTolerance   := ATolerance;
  fMaxDoseTime := AMaxDoseTime;
  fSettlingTime:= ASettlingTime;
  fPreact      := APreact;
  fJogOn       := AJogOn;
  fJogOff      := AJogOff;

  Reset;
end;

function TxRecipeStep.GetQtyAvg: integer;
begin
  Result := Round( (fQtyOnClose + fQtyBeforeNext) / 2 );
end;

function TxRecipeStep.GetCurrQty: integer;
begin
  Result := fCurrWeight - fInitialWeight;
end;

procedure TxRecipeStep.SetCurrWeight(AWeight: integer);
begin
//@@ todo: implement material-jam detection
  if AWeight - fCurrWeight < fTolerance then
    begin

    end;

  fCurrWeight := AWeight;  
end;

procedure TxRecipeStep.DisposeStableTimer;
begin
  if Assigned(fStableTimer) then
    begin
      fStableTimer.Enabled := false;
      fStableTimer.Free;
      fStableTimer := nil;
    end;
end;

procedure TxRecipeStep.DisposeJamTimer;
begin
  if Assigned(fJamTimer) then
    begin
      fJamTimer.Enabled := false;
      fJamTimer.Free;
      fJamTimer := nil;
    end;
end;

procedure TxRecipeStep.OnStableTimer(Sender: TObject);
begin
  DisposeStableTimer;
  fStable := true;
end;

procedure TxRecipeStep.doStart(AInitialWeight: integer);
begin
  fInitialWeight := AInitialWeight;
  fStarted := True;
end;

procedure TxRecipeStep.doFinish;
begin
  fFinished := True;

  fStableTimer := TTimer.Create(nil);
  fStableTimer.Interval := fSettlingTime * 1000;
  fStableTimer.OnTimer := OnStableTimer;
  fStableTimer.Enabled := True;
end;

procedure TxRecipeStep.Reset;
begin
  DisposeStableTimer;
  DisposeJamTimer;

  fQtyOnClose    := 0;
  fQtyBeforeNext := 0;

  fInitialWeight := 0;
  fCurrWeight    := 0;

  fJammed        := false;
  fNeedsHammer   := false;

  fStarted       := false;
  fFinished      := false;
  fStable        := false;
end;

{
  TxRecipeStepList
}

procedure TxRecipeStepList.SetRecipeStep(Index: integer; Value: TxRecipeStep);
begin
  Put(Index, Value);
end;

function  TxRecipeStepList.GetRecipeStep(Index: integer): TxRecipeStep;
begin
  Result := TxRecipeStep(Get(Index));
end;

{
  TxRecipe
}

constructor TxRecipe.Create(AOwner: TObject; Data: TDataSet);
begin
  fCapacity  := 1000; { mixer capacity - 1000 kg /maximum dose weight/ }

  fSteps := TxRecipeStepList.Create;

  fCurrStepNr:= 0;

  fWaterFlow := 1;
  fWaterQty  := 1;
  fWaterTime := 1;
  fOilFlow   := 1;
  fOilQty    := 1;
  fOilTime   := 1;

  fWaterStartStep   := -1;
  fOilStartStep     := -1;
  fMixerStartStep   := -1;

  fStarted          := false;
  fFinished         := false;
  fStepStarted      := false;
  fStepDone         := false;
  fDischStarted     := false;
  fDischDone        := false;

  fDosesReq         := 0;
  fDosesDone        := 0;

  Load(Data);
end;

destructor TxRecipe.Destroy;
begin
  while fSteps.Count > 0 do
    begin
      fSteps[0].Free;
      fSteps.Delete(0);
    end;

  fSteps.Free;
end;

function TxRecipe.GetStepsCount: integer;
begin
  Result := fSteps.Count;
end;

function TxRecipe.GetCurrentStep: TxRecipeStep;
begin
  Result := GetStepByNr(fCurrStepNr);
end;

function TxRecipe.GetDoseStarted: boolean;
begin
  Result := fDoseStarted;
end;

function TxRecipe.GetDoseDone: boolean;
begin
  Result := fDoseDone;
end;

function TxRecipe.GetStepStarted: boolean;
begin
  Result := false;
  if Assigned(CurrStep) then Result := CurrStep.Started;
end;

function TxRecipe.GetStepDone: boolean;
begin
  Result := false;
  if Assigned(CurrStep) then Result := CurrStep.Finished;
end;

procedure TxRecipe.SetStarted(Value: boolean);
begin
  fStarted := Value;
  fFinished := false;

  fStepStarted := false;
  fStepDone    := false;
  fDischStarted:= false;
  fDischDone   := false;
end;

function TxRecipe.GetStepBySilo(SiloNr: integer): TxRecipeStep;
var i: integer;
begin
  Result := nil;
  for i:=0 to fSteps.Count-1 do
    if Assigned(fSteps[i]) and (fSteps[i].SiloNr = SiloNr) then
      begin
        Result := fSteps[i];
        Break;
      end;
end;

function TxRecipe.GetStepByNr(StepNr: integer): TxRecipeStep;
begin
  if (StepNr > 0) and (StepNr <= fSteps.Count) then
    Result := fSteps[StepNr-1]
  else
    Result := nil;
end;

procedure TxRecipe.NextStep;
begin
  fCurrStepNr := fCurrStepNr + 1;
  if (fCurrStepNr > 0) and (fCurrStepNr <= fSteps.Count) then
    begin

    end
  else
    begin
      fCurrStepNr := fSteps.Count+1;
    end;
end;

procedure TxRecipe.doDoseStart;
var i: integer;
begin
  { if the loaded order is finished /all doses done/ but, not marked in the database }
  if fDosesReq = fDosesDone then
    begin
      fFinished := true;
      Exit;
    end;

//ss-start
    sdStart;
//ss-end

  fStarted     := true;
  fDoseStarted := true;
  fDoseDone    := false;
  fDischStarted:= false;
  fDischDone   := false;

  fStepStarted := false;
  fStepDone    := false;

  fCurrStepNr  := 0;

  fQtyLastDose := 0;

  for i:=0 to fSteps.Count-1 do fSteps[i].Reset;

//  ShowMessage('TxRecipe.doDoseStart');
end;

procedure TxRecipe.doDoseDone(Qty: integer);
begin
  if fDoseStarted and not fDoseDone then begin
    inc(fDosesDone);
    fQtyLastDose := Qty;
    fQtyDone := fQtyDone + Qty;
    fDoseDone := true;
  end;
//  ShowMessage('TxRecipe.doDoseDone');
end;

procedure TxRecipe.doDischStart;
begin
  if fDoseStarted and fDoseDone then
    begin
      fDischStarted := True;
      fDischDone    := False;
    end;
end;

procedure TxRecipe.doDischDone;
begin
  if fDoseStarted and fDoseDone then begin
    fDoseStarted := false;
    fDoseDone    := false;
    fDischStarted:= false;
    fDischDone   := false;

    fStepStarted := false;
    fStepDone    := false;
    fDischStarted:= false;
    fDischDone   := false;

    fCurrStepNr  := 0;

    fFinished := fDosesDone = fDosesReq;
  end;
end;

procedure TxRecipe.doAbortDose;
begin
  fDoseStarted := false;
  fDoseDone    := false;
  fDischStarted:= false;
  fDischDone   := false;

  fStepStarted := false;
  fStepDone    := false;
  fDischStarted:= false;
  fDischDone   := false;

  fCurrStepNr  := 0;

  fQtyLastDose := 0;

  sdStop;
end;

procedure TxRecipe.Load(Data: TDataSet);
var st: TxRecipeStep;
begin
  if uGlobals.manual then
    raise Exception.Create('Системата е в ръчен режим на управление!');

  if not Assigned(data) then
    raise Exception.Create('No dataset provided!');

  if data.Eof then
    raise Exception.Create('The provided dataset is empty!');

  data.First;

  fOrderID   := data.FieldByName('id').AsInteger;
  fRecipeID  := data.FieldByName('recipe_id').AsInteger;

  fQtyRecipe := data.FieldByName('qty_recipe').AsInteger;
  fQtyReq    := data.FieldByName('qty_req').AsInteger;
  fQtyDone   := data.FieldByName('qty_done').AsInteger;

  fDosesReq  := (fQtyReq div fCapacity);
  if (fQtyReq mod fCapacity) > 0 then inc(fDosesReq);
  fQtyDose   := round(fQtyReq/fDosesReq);
  fCoef      := fQtyDose/fQtyRecipe;
//ss-start
  uGlobals.sdBase := IntToStr(fQtyDose);
//ss-stop
  fDosesDone := Round(fQtyDone/fQtyDose);

  fWaterQty  := data.FieldByName('water_qty').AsFloat * fCoef;
  fWaterFlow := data.FieldByName('water_flow').AsFloat;
  fWaterTime := fWaterQty / fWaterFlow;

  fOilQty  := data.FieldByName('oil_qty').AsFloat * fCoef;
  fOilFlow := data.FieldByName('oil_flow').AsFloat;
  fOilTime := fOilQty / fOilFlow;

  fWaterStartStep := data.FieldByName('liquids_start_step').AsInteger + 1;
  fOilStartStep   := data.FieldByName('liquids_start_step').AsInteger + 1;
  fMixerStartStep := data.FieldByName('mixer_start_step'  ).AsInteger + 1;

  fDischargeAfter := data.FieldByName('discharge_after'   ).AsInteger;
  {set mixing time to atleast one second}
  if fDischargeAfter < 1 then fDischargeAfter := 1;

  while not data.Eof do begin
    st := TxRecipeStep.Create( fSteps.Count+1,
                               data.FieldByName('silo_nr').AsInteger,
                               data.FieldByName('silo_id').AsInteger,
                               data.FieldByName('silo_name').AsString,
                               round( data.FieldByName('qty_comp_recipe').AsInteger * fCoef ),
                               data.FieldByName('fine_qty').AsInteger,
                               data.FieldByName('tolerance').AsInteger,
                               data.FieldByName('max_dose_time').AsInteger,
                               data.FieldByName('settling_time').AsInteger,
                               data.FieldByName('preact').AsInteger,
                               data.FieldByName('jogging_on_time').AsInteger,
                               data.FieldByName('jogging_off_time').AsInteger );
    fSteps.Add(st);

    data.Next;
  end;
end;
//--------------------------------------------------------------
//ss-start
procedure TxRecipe.sdStop;
var
  AppHandle : HWND;
begin
  if not uGlobals.sdSDispenserConnection then Exit;
  uGlobals.sdStartStop := FALSE;

//Проверка дали SDispenser е стартиран
  AppHandle:=FindWindow(nil, 'SDispenser v.1.2');
  if AppHandle<>0 then
  begin
//SDispenser е бил стартиран. ССледва опит за свързване с SDispenser по TCP.
    try
      uGlobals.sdSocket.Active := TRUE;
    except
    end;
  end;
end;


procedure TxRecipe.sdStart;
var
  AppHandle : HWND;
  params : PAnsiChar;

  sdFile : TextFile;
  sdCommand : PAnsiChar; //Пълен път и името на ехе-то на SDispenser
  sdRunDir : PAnsiChar;  //Работна директория на SDispenser
  str : String;

begin
  if not uGlobals.sdSDispenserConnection then Exit;

   uGlobals.sdStartStop := TRUE;      //ползва се от сокета за да определи каква команда да прати

//Проверка дали SDispenser е стартиран
  AppHandle:=FindWindow(nil, 'SDispenser v.1.2');
  if AppHandle<>0 then
  begin
//SDispenser е бил стартиран. ССледва опит за свързване с SDispenser по TCP.
    try
      uGlobals.sdSocket.Active := TRUE;
    except
    end;

  end
  else
  begin

//Прочита се от текстов файл пътя до SDispenser
    AssignFile(sdFile,'path2sdispenser.txt');
    Reset(sdFile);
    if not Eof(sdFile) then ReadLn(sdFile, str);
    sdRunDir := PChar(str);
    sdCommand := PChar(str + 'SDispenser.exe');

//Стартира се SDispenser с параметри за дозиране - база и етикет
    uGlobals.sdBase := IntToStr(fQtyDose);
    params := PChar(uGlobals.sdBase + ' ' + uGlobals.sdTag);
    ShellExecute(Application.Handle,
               'open',
               sdCommand,
               params,       //Параметри - база етикет
               sdRunDir, SW_SHOWNORMAL) ;
  end;
end;

{
procedure TxRecipe.sdClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  xml : String;
begin
  xml := '<SlClient>' +
            '<base>' + sdBase + '</base>' +
            '<tag>' + sdTag + '</tag>';

  if sdStartStop then xml := xml + '<cmd>START</cmd>'
  else xml := xml + '<cmd>STOP</cmd>';

  xml := xml + '</SlClient>';
  sdClientSocket.Socket.SendText(xml);
  sdClientSocket.Active := FALSE;
end;
 }
//ss-end------------------------------------------------------------------------

end.
