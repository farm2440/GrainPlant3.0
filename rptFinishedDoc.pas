unit rptFinishedDoc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, dmMain, QRCtrls, DB, ADODB, DateUtils;

type
  TFinishedDocReportForm = class(TForm)
    DocReport: TQuickRep;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRLabel1: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRLabel8: TQRLabel;
    QRDBText8: TQRDBText;
    lDocStatus: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }

    procedure PreveiwDocument(DocNr: integer);
  end;

var
  FinishedDocReportForm: TFinishedDocReportForm;

implementation

{$R *.dfm}

procedure TFinishedDocReportForm.PreveiwDocument(DocNr: integer);
begin
//
end;

end.
