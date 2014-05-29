unit fmSilos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, DB, ADODB, Mask, Buttons, dmMain,
  Grids, DBGrids;

type
  TSilosForm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    dbnSilos: TDBNavigator;
    dbnGrains: TDBNavigator;
    bClose: TBitBtn;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
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
  SilosForm: TSilosForm;

implementation

{$R *.dfm}

procedure TSilosForm.FormCreate(Sender: TObject);
begin
//
end;

procedure TSilosForm.FormShow(Sender: TObject);
begin
//
end;

procedure TSilosForm.FormHide(Sender: TObject);
begin
//
end;

procedure TSilosForm.FormDestroy(Sender: TObject);
begin
//
end;

procedure TSilosForm.bCloseClick(Sender: TObject);
begin
  Close;
end;

end.
