unit fmSiloManual;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uGrainPlant, StdCtrls;

type
  TSiloManualForm = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure OnButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OnButtonMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OnButtonKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OnButtonKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure OnLiquidsClick(Sender: TObject);  
    procedure OnDoseDoneClick(Sender: TObject);  
  private
    { Private declarations }
  public
    { Public declarations }
    Buttons  : TList;
    bLiquids : TButton;
    bDoseDone: TButton;
    bHammerOn: TButton;
    bHammerOff: TButton;
    plant    : TxGrainPlant;

    procedure FlushButtons;
  end;

var
  SiloManualForm: TSiloManualForm;

implementation

uses fmLiquidsManual, fmMain;

{$R *.dfm}

procedure TSiloManualForm.FormCreate(Sender: TObject);
begin
  Buttons := TList.Create;
end;

procedure TSiloManualForm.FormShow(Sender: TObject);
var i: integer;
begin
  if not Assigned(plant) then Exit;

  for i:=1 to cSiloCount do
    begin
      Buttons.Add( TButton.Create(Self) );
      with TButton(Buttons.Last) do
        begin
          Left  := 0;
          Width := 100;
          Caption := plant.Silos[i].Caption;
          Top   := (i-1)*(Height);
          Parent:= Self;
          Tag   := 0;
          OnKeyDown   := OnButtonKeyDown;
          OnKeyUp     := OnButtonKeyUp;
          OnMouseDown := OnButtonMouseDown;
          OnMouseUp   := OnButtonMouseUp;


          Enabled := not Assigned(plant.Recipe) or
                     ( (plant.Recipe.StepCount <= 0) or
                       (plant.Recipe.GetStepBySilo(i) <> nil) );
        end;
    end;

  bLiquids := TButton.Create(Self);
  with bLiquids do
    begin
      Left  := 0;
      Width := 100;
      Caption := 'Вода и олио';
      Top   := (Buttons.Count)*Height;
      Parent:= Self;
      Tag   := 0;
      OnClick := OnLiquidsClick;

      Enabled := not Assigned(plant.Recipe) or not plant.Recipe.DoseStarted;
    end;

  bDoseDone := TButton.Create(Self);
  with bDoseDone do
    begin
      Left  := 0;
      Width := 100;
      Caption := 'Приключи доза';
      Top   := (Buttons.Count+1)*Height;
      Parent:= Self;
      Tag   := 0;
      OnClick := OnDoseDoneClick;

      Enabled := not Assigned(plant.Recipe) or (plant.Recipe.StepCount > 0);
    end;

  bHammerOn := TButton.Create(Self);
  with bHammerOn do
    begin
      Left  := 0;
      Width := 100;
      Action := MainForm.aHammerOn;
      Top   := (Buttons.Count+2)*Height;
      Parent:= Self;
      Tag   := 0;
    end;

  bHammerOff := TButton.Create(Self);
  with bHammerOff do
    begin
      Left  := 0;
      Width := 100;
      Action := MainForm.aHammerOff;
      Top   := (Buttons.Count+3)*Height;
      Parent:= Self;
      Tag   := 0;
    end;

  ClientWidth := 100;
  ClientHeight := (cSiloCount + 4) * TButton(Buttons.Last).Height;
  Left := Screen.Width - Width - 10;
  Top  := 100;
end;

procedure TSiloManualForm.FormHide(Sender: TObject);
begin
  FlushButtons;
end;

procedure TSiloManualForm.FlushButtons;
begin
  while Buttons.Count > 0 do
    begin
      if Assigned(Buttons[0]) then TButton(Buttons[0]).Free;
      Buttons[0] := nil;
      Buttons.Delete(0);
    end;

  if Assigned(bLiquids) then bLiquids.Free;
  bLiquids := nil;
  if Assigned(bDoseDone) then bDoseDone.Free;
  bDoseDone := nil;
  if Assigned(bHammerOn) then bHammerOn.Free;
  bHammerOn := nil;
  if Assigned(bHammerOff) then bHammerOff.Free;
  bHammerOff := nil;
end;

procedure TSiloManualForm.FormDestroy(Sender: TObject);
begin
  FlushButtons;
  Buttons.Free;
end;

procedure TSiloManualForm.OnButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
begin
  TButton(Sender).Tag := 1;
end;

procedure TSiloManualForm.OnButtonMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
begin
  TButton(Sender).Tag := 0;
end;

procedure TSiloManualForm.OnButtonKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
begin
  TButton(Sender).Tag := 1;
end;

procedure TSiloManualForm.OnButtonKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
begin
  TButton(Sender).Tag := 0;
end;

procedure TSiloManualForm.OnLiquidsClick(Sender: TObject);
begin
  if LiquidsManualForm.ShowModal = mrOK then
    begin
      plant.Water.Switch(true, LiquidsManualForm.water_time * 1000);
      plant.Oil  .Switch(true, LiquidsManualForm.oil_time   * 1000);
    end;
    
//  plant.doStartLiquids;
end;

procedure TSiloManualForm.OnDoseDoneClick(Sender: TObject);
begin
  if not Assigned(plant.Recipe) then Exit;

{
  if plant.Recipe.DoseStarted and
     not plant.Recipe.DoseDone then plant.doDoseDone;
}     
end;
  
end.
