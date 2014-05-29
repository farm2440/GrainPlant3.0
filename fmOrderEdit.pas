unit fmOrderEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, dmMain, DBCtrls, ExtCtrls, Grids, DBGrids,
  Mask, ADODB, DB;

type
  TOrderEditForm = class(TForm)
    bOK: TBitBtn;
    bCancel: TBitBtn;
    cbRecipe: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure bOKClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    OrderID : integer;
  end;


  var
  OrderEditForm: TOrderEditForm;

implementation

{$R *.dfm}

procedure TOrderEditForm.FormCreate(Sender: TObject);
begin
  OrderID := -1;
end;

procedure TOrderEditForm.FormShow(Sender: TObject);
begin
  if OrderID < 0 then
    begin
      MainData.tblPendingOrders.Insert;
      MainData.tblPendingOrders.FieldByName( 'time_entered' ).AsDateTime := Now;
    end
  else
    begin
      if not MainData.tblPendingOrders.Locate( 'id', OrderID, [] ) then
        ModalResult := mrCancel
      else
        MainData.tblPendingOrders.Edit;
    end;
end;

procedure TOrderEditForm.FormHide(Sender: TObject);
begin
//
end;

procedure TOrderEditForm.bOKClick(Sender: TObject);
begin
  if MainData.tblPendingOrders.State in [dsEdit, dsInsert] then MainData.tblPendingOrders.Post;
  ModalResult := mrOK;

  MainData.tblPendingOrders.Requery;
end;

procedure TOrderEditForm.bCancelClick(Sender: TObject);
begin
  if MainData.tblPendingOrders.State in [dsEdit, dsInsert] then MainData.tblPendingOrders.Cancel;
  ModalResult := mrCancel;
end;

end.
