unit fmPreferences;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, uGlobals;

type
  TPreferencesForm = class(TForm)
    PageControl1: TPageControl;
    bOK: TBitBtn;
    bCancel: TBitBtn;
    tsSerial: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    cbPort1: TComboBox;
    cbBaud1: TComboBox;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    cbPort2: TComboBox;
    cbBaud2: TComboBox;
    cbPort3: TComboBox;
    cbBaud3: TComboBox;
    tsAutomation: TTabSheet;
    cbAskForNextDose: TCheckBox;
    cbAskForNextOrder: TCheckBox;
    cbAlertDoseDone: TCheckBox;
    cbAlertOrderDone: TCheckBox;
    Label7: TLabel;
    Label8: TLabel;
    cbSDispenserConnection: TCheckBox;
    procedure bOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PreferencesForm: TPreferencesForm;

implementation

{$R *.dfm}

procedure TPreferencesForm.bOKClick(Sender: TObject);
begin
  { store serial port settings }
  uGlobals.scale_port := cbPort1.ItemIndex + 1;
  uGlobals.scale_baud := StrToIntDef( cbBaud1.Text, 1200 );

//  uGlobals.printer_port := cbPort2.ItemIndex + 1;
//  uGlobals.printer_baud := StrToIntDef( cbBaud2.Text, 9600 );

  uGlobals.plc_port := cbPort3.ItemIndex + 1;
  uGlobals.plc_baud := StrToIntDef( cbBaud3.Text, 19200 );

  { store automation settings }
  uGlobals.alert_dose_done      := cbAlertDoseDone.Checked;
  uGlobals.autostart_next_dose  := cbAskForNextDose.Checked;
  uGlobals.alert_order_done     := cbAlertOrderDone.Checked;
  uGlobals.autostart_next_order := cbAskForNextOrder.Checked;

  {SDispenser}
  uGlobals.sdSDispenserConnection := cbSDispenserConnection.Checked;
end;

procedure TPreferencesForm.FormShow(Sender: TObject);
begin
  { load serial port settings }
  cbPort1.ItemIndex := uGlobals.scale_port - 1;
  cbBaud1.ItemIndex := cbBaud1.Items.IndexOf(IntToStr(uGlobals.scale_baud));

//  cbPort2.ItemIndex := uGlobals.printer_port - 1;
//  cbBaud2.ItemIndex := cbBaud2.Items.IndexOf(IntToStr(uGlobals.printer_baud));

  cbPort3.ItemIndex := uGlobals.plc_port - 1;
  cbBaud3.ItemIndex := cbBaud3.Items.IndexOf(IntToStr(uGlobals.plc_baud));

  { load automation settings }
  cbAlertDoseDone.Checked   := uGlobals.alert_dose_done;
  cbAskForNextDose.Checked  := uGlobals.autostart_next_dose;
  cbAlertOrderDone.Checked  := uGlobals.alert_order_done;
  cbAskForNextOrder.Checked := uGlobals.autostart_next_order;

  {SDispenser}
  cbSDispenserConnection.Checked := uGlobals.sdSDispenserConnection;
end;

end.
