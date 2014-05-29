program gemu;

uses
  Forms,
  fmMain in 'fmMain.pas' {MainForm},
  fmAddPair in 'fmAddPair.pas' {AddPairForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAddPairForm, AddPairForm);
  Application.Run;
end.
