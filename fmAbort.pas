unit fmAbort;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TAbortForm = class(TForm)
    rbCancelOrder: TRadioButton;
    rbCancelDose: TRadioButton;
    Bevel1: TBevel;
    bOK: TButton;
    bCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AbortForm: TAbortForm;

implementation

{$R *.dfm}

end.
