unit uGrainPlant;

interface

uses Messages, Dialogs, Windows, SysUtils, Classes,
  Controls, Forms, Menus, Graphics, StdCtrls, ImageLib, ExtCtrls,
  CommonTypes, Math, xControls, ADODB, xMnemonics, uDevices, uRoute, uD500BC,
  uRecipe, uLogger, uGlobals, DB;

const
  cSiloCount     = 13;
  cBunkerCount   =  8;

type
  TxSiloArray = array[1..cSiloCount] of TxCommonDevice;

  TxGrainPlant = class (TComponent)
  private
    fRoute   : TxRoute;
    fDisch   : TxCommonDevice;
    fSilos   : TxSiloArray;
    fWater   : TxSwitchingDevice;
    fOil     : TxSwitchingDevice;
    fMixer   : TxCommonDevice;
    fHammer  : TxCommonDevice;

    fManual        : boolean;

    fStart         : boolean;
    fAbort         : boolean;
    fStop          : boolean;
    fDischarge     : boolean;
    fRunning       : boolean;

    fStartTimer    : TTimer;
    fDischTimer    : TTimer;

    fD500BC        : TxD500BC;

    fRecipe        : TxRecipe;

    fLog           : TxLogger;

    fStopDischTimer: TTimer;

    fDischarged    : boolean;
    fHammerOn      : boolean;

  { event handlers }
    fOnBatchComplete : TNotifyEvent;
    fOnError         : TNotifyEvent;
    fOnManualChange  : TNotifyEvent;
    fOnOrderStart    : TNotifyEvent;
    fOnOrderDone     : TNotifyEvent;
    fOnOrderReadyForNext : TNotifyEvent;
    fOnDoseStart     : TNotifyEvent;
    fOnDoseDone      : TNotifyEvent;
    fOnStepStarted   : TNotifyEvent;
    fOnStepDone      : TNotifyEvent;
    fOnStepBeforeNext: TNotifyEvent;
    fOnRunningChange : TNotifyEvent;

    fOnDataReady     : TNotifyEvent;
    fOnTimeout       : TNotifyEvent;

    fOnRecipeStatusChange : TNotifyEvent;

  { accessor methods }
    function  GetSilo(Index: integer): TxCommonDevice;
    procedure SetSilo(Index: integer; Value: TxCommonDevice);

    procedure SetManual(Value: boolean);
    procedure SetRunning(Value: boolean);

    procedure SetD500BC(Value: TxD500BC);

  { private methods }
    procedure DisposeStartTimer;
    procedure DisposeDischTimer;

    procedure StopAllSilos;

  { event handlers }
    procedure OnStartTimer(Sender: TObject);
    procedure OnDischTimer(Sender: TObject);
    procedure OnStopDischTimer(Sender: TObject);

    procedure OnBunkerOverflow(Sender: TObject);

    procedure OnD500BCDataReady(Sender: TObject);
    procedure OnD500BCTimeout(Sender: TObject);

  public
  { public properties }
    property Route: TxRoute read fRoute write fRoute;
    property Disch: TxCommonDevice read fDisch write fDisch;
    property Water: TxSwitchingDevice read fWater write fWater;
    property Oil: TxSwitchingDevice read fOil write fOil;
    property Silos[Index: Integer]: TxCommonDevice read GetSilo write SetSilo;
    property Mixer: TxCommonDevice read fMixer write fMixer;
    property Hammer: TxCommonDevice read fHammer write fHammer;

    property D500BC: TxD500BC read fD500BC write SetD500BC;

    property Log: TxLogger read fLog write fLog; 

    property Recipe: TxRecipe read fRecipe;

    property Manual       : boolean read fManual;

    property Start: boolean read fStart;
    property Stop: boolean read fStop;
    property Abort: boolean read fAbort;
    property Running: boolean read fRunning;
    property IsDischarged: boolean read fDischarged;
    property HammerOn: boolean read fHammerOn write fHammerOn;
//    property Discharge: boolean read fDischarge write fDischarge;

    property OnBatchComplete: TNotifyEvent read fOnBatchComplete write fOnBatchComplete;
    property OnError: TNotifyEvent read fOnError write fOnError;
    property OnManualChange: TNotifyEvent read fOnManualChange write fOnManualChange;
    property OnOrderStart: TNotifyEvent read fOnOrderStart write fOnOrderStart;
    property OnOrderDone: TNotifyEvent read fOnOrderDone write fOnOrderDone;
    property OnOrderReadyForNext: TNotifyEvent read fOnOrderReadyForNext write fOnOrderReadyForNext;
    property OnDoseStart: TNotifyEvent read fOnDoseStart write fOnDoseStart;
    property OnDoseDone: TNotifyEvent read fOnDoseDone write fOnDoseDone;
    property OnStepStarted: TNotifyEvent read fOnStepStarted write fOnStepStarted;
    property OnStepDone: TNotifyEvent read fOnStepDone write fOnStepDone;
    property OnStepBeforeNext: TNotifyEvent read fOnStepBeforeNext write fOnStepBeforeNext;
    property OnRunningChange: TNotifyEvent read fOnRunningChange write fOnRunningChange;
    property OnDataReady: TNotifyEvent read fOnDataReady write fOnDataReady;
    property OnTimeout: TNotifyEvent read fOnTimeout write fOnTimeout;
    property OnRecipeStatusChange: TNotifyEvent read fOnRecipeStatusChange write fOnRecipeStatusChange;

  { public methods }
    constructor Create(AOwner: TComponent);
    destructor Destroy;

  { input/output processing methods }
    procedure ProcessInput( buff: TxInBuffer ); virtual;
    procedure ModifyOutput( var buff: TxOutBuffer ); virtual;

    procedure SiloStateChange(Sender: TObject);

    procedure LoadOrder(Data: TDataSet);
    procedure StartDose;
    procedure AbortDose;
    procedure AbortOrder;

    procedure Discharged;

    procedure LogEvent(Msg: string; Note: string; EventType: TxEventType);
  end;

implementation

{
  TxGrainPlant
}

constructor TxGrainPlant.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  fManual        := false;
  fHammerOn      := false;

  fD500BC        := nil;
  fRecipe        := nil;
end;

destructor TxGrainPlant.Destroy;
begin
  if Assigned(fRecipe) then fRecipe.Free;
  if Assigned(OnRecipeStatusChange) then OnRecipeStatusChange(Self);

  inherited Destroy;
end;

function TxGrainPlant.GetSilo(Index: integer): TxCommonDevice;
begin
  if (Index >= 1) and (Index <= cSiloCount) then
    Result := fSilos[Index]
  else
    Result := nil;
end;

procedure TxGrainPlant.SetSilo(Index: integer; Value: TxCommonDevice);
begin
  if (Index >= 1) and (Index <= cSiloCount) then
    fSilos[Index] := Value;
end;

procedure TxGrainPlant.SetManual(Value: boolean);
begin
  if fManual = Value then Exit;
  fManual := Value;
  if Assigned(OnManualChange) then OnManualChange(Self);
end;

procedure TxGrainPlant.SetRunning(Value: boolean);
begin
  if fRunning = Value then Exit;
  fRunning := Value;
  if Assigned(OnRunningChange) then OnRunningChange(Self);
end;

procedure TxGrainPlant.SetD500BC(Value: TxD500BC);
begin
  fD500BC := Value;

  if Assigned(fD500BC) then
    begin
      fD500BC.OnDataReady := Self.OnD500BCDataReady;
      fD500BC.OnTimeout   := Self.OnD500BCTimeout;
    end;
end;

procedure TxGrainPlant.DisposeStartTimer;
begin
  if Assigned(fStartTimer) then
    begin
      fStartTimer.Enabled := False;
      fStartTimer.Free;
      fStartTimer := nil;
    end;
end;

procedure TxGrainPlant.DisposeDischTimer;
begin
  if Assigned(fDischTimer) then
    begin
      fDischTimer.Enabled := False;
      fDischTimer.Free;
      fDischTimer := nil;
    end;
end;

procedure TxGrainPlant.StopAllSilos;
var i: integer;
begin
  for i:=1 to cSiloCount do Silos[i].ContactorOut := False;
end;

procedure TxGrainPlant.OnStartTimer(Sender: TObject);
begin
  DisposeStartTimer;
  fStart := false;
end;

procedure TxGrainPlant.OnDischTimer(Sender: TObject);
begin
  DisposeDischTimer;

  { check the route state }
  fRoute.CheckUp;

  if fRoute.Active then
    begin
      fDisch.ContactorOut := true;
      LogEvent('>> Discharging.', '', etMisc);
    end
  else
    begin
      fDisch.ContactorOut := false;
      ShowMessage('Не е пуснат маршрут!');
    end;
end;

procedure TxGrainPlant.OnStopDischTimer(Sender: TObject);
begin
  if Assigned(fStopDischTimer) then
    begin
      fStopDischTimer.Enabled := False;
      fStopDischTimer.Free;
      fStopDischTimer := nil;
    end;

  { close discharge flap }
  fDisch.ContactorOut := false;

  { stop the mixer }
  fMixer.ContactorOut := False;

  { check-up the route }
//  fRoute.CheckUp;

  LogEvent( 'Затваряне на разтоварваща клапа.', '', etStop );

  if fRecipe.DoseStarted and fRecipe.DoseDone and fRecipe.DischStarted then
    begin
      fRecipe.doDischDone;
      if Assigned(OnRecipeStatusChange) then OnRecipeStatusChange(Self);
      if Assigned(OnDoseDone) then OnDoseDone(Self);

      if fRecipe.Finished then
        begin
          if Assigned(OnOrderDone) then OnOrderDone(Self);

          fRecipe.Free;
          fRecipe := nil;
          if Assigned(OnRecipeStatusChange) then OnRecipeStatusChange(Self);

          if Assigned(OnOrderReadyForNext) then OnOrderReadyForNext(Self);
        end
      else
        { start next dose }
        if uGlobals.autostart_next_dose then Self.StartDose;
    end;
end;

procedure TxGrainPlant.OnBunkerOverflow(Sender: TObject);
begin
//  fRoute.StopChain;
end;

procedure TxGrainPlant.OnD500BCDataReady(Sender: TObject);
begin
  { call an externel event handler if assigned }
  if Assigned(OnDataReady) then OnDataReady(Self);

  { if no recipe is loaded, exit }
  if not Assigned(fRecipe) then Exit;

(** phase 1 - dosing **)
  { the dose is started and not done yet }
  if fRecipe.DoseStarted and not fRecipe.DoseDone then
    if Assigned(fRecipe.CurrStep) then
      with fRecipe do begin
        { if a next step is assigned but not started }
        if not CurrStep.Started then
          begin
            CurrStep.doStart(fD500BC.Weight);
            if Assigned(OnStepStarted) then OnStepStarted(Self);
          end
        else
        { if the step is started but not finished yet }
        if not CurrStep.Finished then
          begin
            CurrStep.CurrWeight := fD500BC.Weight;
            if CurrStep.CurrQty > CurrStep.Qty - CurrStep.Preact then
              begin
                CurrStep.doFinish;
              end;
          end
        else
        { if the step is finished and the stabilization time has passed }
        if CurrStep.Stable then
          begin
            if Assigned(OnStepDone) then OnStepDone(Self);

            { check if it's time to start the liquids }
            if CurrStepNr = fRecipe.WaterStartStep-1 then
              fWater.Switch(True, Round(fRecipe.WaterTime * 1000));
            if CurrStepNr = fRecipe.OilStartStep-1 then
              fOil.Switch(True, Round(fRecipe.OilTime * 1000));

            { check if it's time to start the mixer }
            if CurrStepNr = fRecipe.MixerStartStep-1 then
              fMixer.ContactorOut := True;

            { move to the next step }
            NextStep;
          end
        else
        { at this point the step is finished but not stable yet, so just update the weight }
          CurrStep.CurrWeight := fD500BC.Weight;

        { if the current step still exists }
        if Assigned(CurrStep) then
          Silos[CurrStep.SiloNr].ContactorOut := CurrStep.Started and not CurrStep.Finished
        else
        { otherwise, NextStep has lead to the end of the recipe }
          begin
            fRecipe.doDoseDone(fD500BC.Weight);
            if Assigned(OnRecipeStatusChange) then OnRecipeStatusChange(Self);
          end;
      end
    { else (CurrStep is null), so try to start the first step }  
    else
      begin
        { if the discharge flap is closed, start the first step }
        if not fDisch.ContactorIn then fRecipe.NextStep;
      end
  else
(** phase 2 - start discharging **)
  { if the recipe is started and done, but the discharging is not started yet }
  if fRecipe.DoseStarted and fRecipe.DoseDone and not fRecipe.DischStarted
  { and the water and oil are not leaking }
     and (not fWater.ContactorOut and not fOil.ContactorOut) then
    begin
      fRecipe.doDischStart;
      if Assigned(OnRecipeStatusChange) then OnRecipeStatusChange(Self);

      { if the discharge flap sequence is not started }
      if not Assigned(fDischTimer) then
        begin
          fDischTimer := TTimer.Create(Self);
          fDischTimer.Interval := fRecipe.DischargeAfter * 1000;
          fDischTimer.OnTimer  := Self.OnDischTimer;
          fDischTimer.Enabled  := true;

          LogEvent(Format('>> Discharging after %d seconds.', [Recipe.DischargeAfter]), '', etMisc);
        end;
     end
  else
(** phase 3 - discharging progress **)
  { if the recipe is started and done, but the discharging is not started yet }
  if fRecipe.DoseStarted and fRecipe.DoseDone and fRecipe.DischStarted then
    begin
      if Abs(fD500BC.Weight) < uGlobals.zero_tolerance then
        if not Assigned(fStopDischTimer) then begin
          {the weight is zero, but wait for a while, so the auger can empty}
          fStopDischTimer := TTimer.Create(Self);
          fStopDischTimer.Interval := uGlobals.disch_time * 1000;
          fStopDischTimer.OnTimer := Self.OnStopDischTimer;
          fStopDischTimer.Enabled := True;

          LogEvent(Format('>> Closing discharge flap after %d seconds.', [uGlobals.disch_time]), '', etMisc);
        end;
    end;
end;

procedure TxGrainPlant.OnD500BCTimeout(Sender: TObject);
begin
  if Assigned(OnTimeout) then OnTimeout(Self);

  StopAllSilos;
end;

procedure TxGrainPlant.ProcessInput( buff: TxInBuffer );
var i: integer;
begin
  if Assigned(fRoute)   then fRoute.ProcessInput(buff);
  if Assigned(fDisch)   then fDisch.ProcessInput(buff);
  if Assigned(fWater)   then fWater.ProcessInput(buff);
  if Assigned(fOil)     then fOil.ProcessInput(buff);
  if Assigned(fMixer)   then fMixer.ProcessInput(buff);
  if Assigned(fHammer)  then fHammer.ProcessInput(buff);

  for i:=1 to cSiloCount do
    if Assigned(fSilos[i]) then fSilos[i].ProcessInput(buff);

  SetManual       ( not (buff[3] and byte(round(power(2, 2))) <> 0) );
  SetRunning      ( buff[5] and byte(round(power(2, 0))) <> 0 );
end;

procedure TxGrainPlant.ModifyOutput( var buff: TxOutBuffer );
var i: integer;
begin
  if Assigned(fRoute)   then fRoute.ModifyOutput(buff);
  if Assigned(fDisch)   then fDisch.ModifyOutput(buff);
  if Assigned(fWater)   then fWater.ModifyOutput(buff);
  if Assigned(fOil)     then fOil.ModifyOutput(buff);
  if Assigned(fMixer)   then fMixer.ModifyOutput(buff);
  if Assigned(fHammer)  then fHammer.ModifyOutput(buff);

  for i:=1 to cSiloCount do
    if Assigned(fSilos[i]) then fSilos[i].ModifyOutput(buff);

  if Start then
    buff[0] := buff[0] or round(power(2, 1))
  else
    buff[0] := buff[0] and not round(power(2, 1));

  if Abort then
    buff[0] := buff[0] or round(power(2, 3))
  else
    buff[0] := buff[0] and not round(power(2, 3));

  if Stop then
    buff[0] := buff[0] or round(power(2, 4))
  else
    buff[0] := buff[0] and not round(power(2, 4));

{
  if HammerOn then
    buff[1] := buff[1] or round(power(2, 4))
  else
    buff[1] := buff[1] and not round(power(2, 4));
}    
end;

procedure TxGrainPlant.SiloStateChange(Sender: TObject);
begin

end;

procedure TxGrainPlant.LoadOrder( Data: TDataSet );
begin
  if Assigned(fRecipe) then
    raise Exception.Create('Вече е заредена рецепта. За да заредите нова рецепта, е нужно да окажете вече заредената или да я изпълните.');

  fRecipe := TxRecipe.Create(Self, Data);

  if Assigned(OnRecipeStatusChange) then OnRecipeStatusChange(Self);
end;

procedure TxGrainPlant.StartDose;
begin
  if uGlobals.manual then
    raise Exception.Create('Системата е в ръчен режим на управление!');

  if not Assigned(fRecipe) then
    raise Exception.Create('Не е заредена рецепта');

  if fRecipe.DoseStarted then
    raise Exception.Create('В момента се изпълнява доза.');

  if not fRoute.CheckUp then
    raise Exception.Create('Започването на нова доза не е възможно, тъй като няма активен маршрут.'#13 +
                           'Стартирайте маршрут и опитайте отново!');

  StopAllSilos;

  { try to start the dose }
  fRecipe.doDoseStart;

  { if order is finished /was already finished upon starting/ }
  if fRecipe.Finished then
    begin
      if Assigned(OnOrderDone) then OnOrderDone(Self);

      fRecipe.Free;
      fRecipe := nil;
    end;

  if Assigned(OnRecipeStatusChange) then OnRecipeStatusChange(Self);
end;

procedure TxGrainPlant.AbortDose;
begin
  if not Assigned(fRecipe) then
    raise Exception.Create('Не е заредена рецепта');

  fRecipe.doAbortDose;
  if Assigned(OnRecipeStatusChange) then OnRecipeStatusChange(Self);
  fHammerOn := false;

  StopAllSilos;
end;

procedure TxGrainPlant.AbortOrder;
begin
  if not Assigned(fRecipe) then
    raise Exception.Create('Не е заредена рецепта');

  fRecipe.doAbortDose;
  fRecipe.Free;
  fRecipe := nil;
  if Assigned(OnRecipeStatusChange) then OnRecipeStatusChange(Self);

  fHammerOn := false;

  StopAllSilos;
end;

procedure TxGrainPlant.Discharged;
begin
  if fDischarged then Exit;

  {}
  fDischarged := true;
  fHammerOn := false;

  { stop mixer }
  fMixer.ContactorOut := false;

  { if the last dose is done, leave the auger on for 30 seconds }
  if Recipe.DosesDone = Recipe.DosesReq - 1 then
    begin
      {  }
      LogEvent( 'Изачкване 30 sec, преди затваряне на разтоварващата клапа...', '', etStop );

      { start discharge stop timer }
      fStopDischTimer := TTimer.Create(Self);
      fStopDischTimer.Interval := 30 * 1000;
      fStopDischTimer.OnTimer  := OnStopDischTimer;
      fStopDischTimer.Enabled  := True;
    end
  else
    OnStopDischTimer(nil);  
end;

procedure TxGrainPlant.LogEvent(Msg: string; Note: string; EventType: TxEventType);
begin
  if Assigned(Log) then Log.LogEvent(Msg, Note, EventType);
end;


end.
