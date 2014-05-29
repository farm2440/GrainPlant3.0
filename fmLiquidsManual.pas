unit fmLiquidsManual;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uGlobals;

type
  TLiquidsManualForm = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    eWaterFlow: TEdit;
    Label2: TLabel;
    eWaterQty: TEdit;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    eOilFlow: TEdit;
    eOilQty: TEdit;
    bOK: TButton;
    bCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bOKClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    water_time : integer;
    oil_time   : integer;
  end;

var
  LiquidsManualForm: TLiquidsManualForm;

implementation

{$R *.dfm}

procedure TLiquidsManualForm.FormCreate(Sender: TObject);
begin
//
end;

procedure TLiquidsManualForm.FormDestroy(Sender: TObject);
begin
//
end;

procedure TLiquidsManualForm.FormShow(Sender: TObject);
begin
//
  eWaterFlow.Text := FloatToStrF( uGlobals.water_flow, ffFixed, 8, 2 );
  eWaterQty .Text := FloatToStrF( uGlobals.water_qty,  ffFixed, 8, 2 );
  eOilFlow  .Text := FloatToStrF( uGlobals.oil_flow,   ffFixed, 8, 2 );
  eOilQty   .Text := FloatToStrF( uGlobals.oil_qty,    ffFixed, 8, 2 );
end;

procedure TLiquidsManualForm.bOKClick(Sender: TObject);
begin
  uGlobals.water_qty  := StrToFloatDef( eWaterQty.Text,  1 );
  uGlobals.water_flow := StrToFloatDef( eWaterFlow.Text, 1 );
  uGlobals.oil_qty    := StrToFloatDef( eOilQty.Text,  1 );
  uGlobals.oil_flow   := StrToFloatDef( eOilFlow.Text, 1 );

  water_time := Round(uGlobals.water_qty / uGlobals.water_flow);
  oil_time   := Round(uGlobals.oil_qty / uGlobals.oil_flow);
end;

procedure TLiquidsManualForm.bCancelClick(Sender: TObject);
begin
//
end;

end.
