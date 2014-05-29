program grain;

{$define debug}

{%ToDo 'grain.todo'}

uses
  Forms,
  dmMain in 'dmMain.pas' {MainData: TDataModule},
  fmMain in 'fmMain.pas' {MainForm},
  fmSilos in 'fmSilos.pas' {SilosForm},
  fmRecipes in 'fmRecipes.pas' {RecipesForm},
  fmPreferences in 'fmPreferences.pas' {PreferencesForm},
  fmRoutes in 'fmRoutes.pas' {RoutesForm},
  fmOrderEdit in 'fmOrderEdit.pas' {OrderEditForm},
  uGrainPlant in 'uGrainPlant.pas',
  fmProgress in 'fmProgress.pas' {ProgressForm},
  uRecipe in 'uRecipe.pas',
  fmSiloManual in 'fmSiloManual.pas' {SiloManualForm},
  uGlobals in 'uGlobals.pas',
  uLogger in 'uLogger.pas',
  fmFinishedDocs in 'fmFinishedDocs.pas' {FinishedDocsForm},
  rptFinishedDoc in 'rptFinishedDoc.pas' {FinishedDocReportForm},
  uRoute in 'uRoute.pas',
  fmSiloPeriodCons in 'fmSiloPeriodCons.pas' {SiloPeriodConsForm},
  fmPivotReport in 'fmPivotReport.pas' {PivotReportForm},
  fmDBEdit in 'fmDBEdit.pas' {DBEditForm},
  fmLiquidsManual in 'fmLiquidsManual.pas' {LiquidsManualForm},
  fmDeviceError in 'fmDeviceError.pas' {DeviceErrorForm},
  fmAbort in 'fmAbort.pas' {AbortForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainData, MainData);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSilosForm, SilosForm);
  Application.CreateForm(TRecipesForm, RecipesForm);
  Application.CreateForm(TPreferencesForm, PreferencesForm);
  Application.CreateForm(TRoutesForm, RoutesForm);
  Application.CreateForm(TOrderEditForm, OrderEditForm);
  Application.CreateForm(TProgressForm, ProgressForm);
  Application.CreateForm(TSiloManualForm, SiloManualForm);
  Application.CreateForm(TFinishedDocsForm, FinishedDocsForm);
  Application.CreateForm(TFinishedDocReportForm, FinishedDocReportForm);
  Application.CreateForm(TSiloPeriodConsForm, SiloPeriodConsForm);
  Application.CreateForm(TPivotReportForm, PivotReportForm);
  Application.CreateForm(TDBEditForm, DBEditForm);
  Application.CreateForm(TLiquidsManualForm, LiquidsManualForm);
  Application.CreateForm(TDeviceErrorForm, DeviceErrorForm);
  Application.CreateForm(TAbortForm, AbortForm);
  Application.Run;
end.
