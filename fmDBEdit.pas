unit fmDBEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dmMain, StdCtrls, ExtCtrls, DBCtrls, Grids, DBGrids, DB, ADODB;

type
  TDBEditForm = class(TForm)
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    cbTableName: TComboBox;
    tblTable: TADOTable;
    dsTable: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure cbTableNameChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DBEditForm: TDBEditForm;

implementation

{$R *.dfm}

procedure TDBEditForm.FormCreate(Sender: TObject);
begin
  MainData.ADOConnection.GetTableNames( cbTableName.Items, false );
  cbTableName.Tag := 1;  
end;

procedure TDBEditForm.FormShow(Sender: TObject);
begin
  cbTableName.ItemIndex := -1;
end;

procedure TDBEditForm.FormHide(Sender: TObject);
begin
  tblTable.Close;
end;

procedure TDBEditForm.cbTableNameChange(Sender: TObject);
begin
  if cbTableName.Tag = 0 then Exit;

  tblTable.Close;
  if cbTableName.ItemIndex >= 0 then
    begin
      tblTable.TableName := cbTableName.Text;
      tblTable.Open;
    end;
end;

end.
