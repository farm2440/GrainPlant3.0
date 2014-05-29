unit fmRoutes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dmMain, StdCtrls, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons, DB,
  ADODB;

type
  TRoutesForm = class(TForm)
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    GroupBox2: TGroupBox;
    dbcbElevator: TDBCheckBox;
    dbcbFlap1: TDBCheckBox;
    dbcbFlap2: TDBCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    cbRoulette: TComboBox;
    bClose: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure bCloseClick(Sender: TObject);
    procedure cbRouletteChange(Sender: TObject);
    procedure dbcbFlap1Click(Sender: TObject);
  private
    { Private declarations }

    procedure OnRoutesAfterScroll(DataSet: TDataSet);


  public
    { Public declarations }
  end;

var
  RoutesForm: TRoutesForm;

implementation

{$R *.dfm}

procedure TRoutesForm.OnRoutesAfterScroll(DataSet: TDataSet);
begin
  cbRoulette.ItemIndex := MainData.tblRoutes.FieldByName( 'roulette' ).AsInteger;
end;

procedure TRoutesForm.FormShow(Sender: TObject);
begin
  MainData.tblRoutes.AfterScroll := Self.OnRoutesAfterScroll;
end;

procedure TRoutesForm.FormHide(Sender: TObject);
begin
  MainData.tblRoutes.AfterScroll := nil;
end;

procedure TRoutesForm.bCloseClick(Sender: TObject);
begin
  if MainData.tblRoutes.Active and
    (MainData.tblRoutes.State in [dsInsert, dsEdit]) then
    MainData.tblRoutes.Cancel;
    
  Close;
end;

procedure TRoutesForm.cbRouletteChange(Sender: TObject);
begin
  if not (MainData.tblRoutes.State in [dsEdit, dsInsert]) then
    if not MainData.tblRoutes.Eof then MainData.tblRoutes.Edit;

  if MainData.tblRoutes.State in [dsEdit, dsInsert] then
    MainData.tblRoutes.FieldByName('roulette').AsInteger := cbRoulette.ItemIndex;
end;

procedure TRoutesForm.dbcbFlap1Click(Sender: TObject);
begin
  cbRoulette.Enabled := not dbcbFlap1.Checked;
  dbcbFlap2.Enabled := dbcbFlap1.Checked;
{
  if not cbRoulette.Enabled and (cbRoulette.ItemIndex <> 0) then
    begin
      cbRoulette.ItemIndex := 0;
      cbRouletteChange( cbRoulette );
    end;
}    
end;

end.
