unit fmProgress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls;

type
  TProgressForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    pbStep: TProgressBar;
    pbParameter: TProgressBar;
    bCancel: TBitBtn;
    Bevel1: TBevel;
    procedure FormShow(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Abort: boolean;
  end;

var
  ProgressForm: TProgressForm;

implementation

{$R *.dfm}

procedure TProgressForm.FormShow(Sender: TObject);
begin
  Abort := false;
end;

procedure TProgressForm.bCancelClick(Sender: TObject);
begin
  Abort := true;
end;

end.
