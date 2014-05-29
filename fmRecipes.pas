unit fmRecipes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, Grids, DBGrids, StdCtrls, Buttons, dmMain,
  DB, ADODB, ComCtrls, xControls, Mask, dbcgrids;

type
  TRecipesForm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    dbnSilos: TDBNavigator;
    DBNavigator1: TDBNavigator;
    grRecipes: TDBGrid;
    bClose: TBitBtn;
    grRecipeDetails: TDBGrid;
    GroupBox3: TGroupBox;
    dbeWaterTime: TDBEdit;
    dbeWaterQty: TDBEdit;
    dbeWaterFlow: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    GroupBox4: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    dbeOilTime: TDBEdit;
    dbeOilQty: TDBEdit;
    dbeOilFlow: TDBEdit;
    Label7: TLabel;
    dbeLiquidStartStep: TDBEdit;
    Label8: TLabel;
    dbeMixerStartStep: TDBEdit;
    Label9: TLabel;
    dbeDischargeAfter: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RecipesForm: TRecipesForm;

implementation

{$R *.dfm}

procedure TRecipesForm.FormCreate(Sender: TObject);
begin
//  qRecipes.SQL.Text := 'SELECT * FROM recipes';
end;

procedure TRecipesForm.FormShow(Sender: TObject);
begin
//
end;

procedure TRecipesForm.FormHide(Sender: TObject);
begin
//
end;

procedure TRecipesForm.FormDestroy(Sender: TObject);
begin
//
end;

procedure TRecipesForm.bCloseClick(Sender: TObject);
begin
  Close;
end;

end.
