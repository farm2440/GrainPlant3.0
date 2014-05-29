unit fmDeviceError;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TDeviceErrorForm = class(TForm)
    Label1: TLabel;
    rbAbort: TRadioButton;
    rbSkip: TRadioButton;
    bOK: TButton;
    Bevel1: TBevel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DeviceErrorForm: TDeviceErrorForm;

implementation

{$R *.dfm}

end.
