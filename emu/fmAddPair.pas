unit fmAddPair;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TxBitPair = class(TObject)
  public
    BitIn    : integer;
    BitOut   : integer;
    Inverted : boolean;

    constructor Create(ABitIn: integer; ABitOut: integer; AInverted: boolean); overload;
  end;

  TAddPairForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    cbBitIn: TComboBox;
    cbBitOut: TComboBox;
    cbInverted: TCheckBox;
    bOK: TButton;
    bCancel: TButton;
    Bevel1: TBevel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddPairForm: TAddPairForm;

implementation

{$R *.dfm}

constructor TxBitPair.Create(ABitIn: integer; ABitOut: integer; AInverted: boolean); 
begin
  inherited Create;
  BitIn    := ABitIn;
  BitOut   := ABitOut;
  Inverted := AInverted;
end;

end.
