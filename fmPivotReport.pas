unit fmPivotReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dmMain, QuickRpt, QRCtrls, ExtCtrls, DB, ADODB, StdCtrls;

type
  TPivotReportForm = class(TForm)
    PivotReport: TQuickRep;
    bdHeader: TQRBand;
    bdDetail: TQRBand;
    bdColumnHeader: TQRBand;
    bdSummary: TQRBand;
    lTitle: TQRLabel;
    lPeriod: TQRLabel;
    lDocStatus: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    { Private declarations }
    LabelList : TList;
    DataList  : TList;

  public
    { Public declarations }

    procedure PrepareSiloConsReport(Preview: boolean);
    procedure PrepareProdReport(Preview: boolean);

    procedure ClearLists;
  end;

var
  PivotReportForm: TPivotReportForm;

implementation

{$R *.dfm}

procedure TPivotReportForm.FormCreate(Sender: TObject);
begin
  LabelList := TList.Create;
  DataList  := TList.Create;
end;

procedure TPivotReportForm.FormDestroy(Sender: TObject);
begin
  ClearLists;
  LabelList.Free;
  DataList.Free;
end;

procedure TPivotReportForm.PrepareSiloConsReport(Preview: boolean);
var date_from, date_to: TDateTime;
    i : integer;
    lbl : TQRLabel;
    dat : TQRDBText;
    wid : integer;
begin
  ClearLists;

  lTitle.Caption := 'Дневни изразходени количества';

  date_from := MainData.spSiloPeriodCons.Parameters.ParamByName('from_date').Value;
  date_to   := MainData.spSiloPeriodCons.Parameters.ParamByName('to_date').Value;

  lPeriod.Caption := Format('за периода от %s до %s', [
                                  FormatDateTime( 'dd/mm/yyy', date_from ),
                                  FormatDateTime( 'dd/mm/yyy', date_to )
                                ]
                           );

  wid := Round(bdHeader.Width / MainData.tblSiloConsPivot.FieldCount);

  with MainData.tblSiloConsPivot do
    begin
      for i:=0 to FieldCount-1 do
        begin
          lbl            := TQRLabel.Create(bdColumnHeader);
          lbl.Parent     := bdColumnHeader;
          lbl.Font.Style := [fsBold];
          lbl.Caption    := Fields[i].DisplayLabel;
          lbl.Left       := i * wid;
          lbl.Width      := wid;
          lbl.Top        := 3;

          LabelList.Add(lbl);
        end;

      for i:=0 to FieldCount-1 do
        begin
          dat            := TQRDBText.Create(bdDetail);
          dat.Parent     := bdDetail;
          dat.Font.Style := [];
          dat.DataField  := Fields[i].FieldName;
          dat.DataSet    := MainData.tblSiloConsPivot;
          dat.Left       := i * wid;
          dat.Width      := wid;
          dat.Top        := 3;
        end;
    end;

  PivotReport.DataSet := MainData.tblSiloConsPivot;
  if Preview then
    PivotReport.Preview
  else
    PivotReport.Print;
end;

procedure TPivotReportForm.PrepareProdReport(Preview: boolean);
var date_from, date_to: TDateTime;
    i : integer;
    lbl : TQRLabel;
    dat : TQRDBText;
    wid : integer;
begin
  ClearLists;

  lTitle.Caption := 'Дневни произведени количества';

  date_from := MainData.spProdPeriod.Parameters.ParamByName('from_date').Value;
  date_to   := MainData.spProdPeriod.Parameters.ParamByName('to_date').Value;

  lPeriod.Caption := Format('за периода от %s до %s', [
                                  FormatDateTime( 'dd/mm/yyy', date_from ),
                                  FormatDateTime( 'dd/mm/yyy', date_to )
                                ]
                           );

  wid := Round(bdHeader.Width / MainData.tblProdPivot.FieldCount);

  with MainData.tblProdPivot do
    begin
      for i:=0 to FieldCount-1 do
        begin
          lbl            := TQRLabel.Create(bdColumnHeader);
          lbl.Parent     := bdColumnHeader;
          lbl.Font.Style := [fsBold];
          lbl.Caption    := Fields[i].DisplayLabel;
          lbl.Left       := i * wid;
          lbl.Width      := wid;
          lbl.Top        := 3;

          LabelList.Add(lbl);
        end;

      for i:=0 to FieldCount-1 do
        begin
          dat            := TQRDBText.Create(bdDetail);
          dat.Parent     := bdDetail;
          dat.Font.Style := [];
          dat.DataField  := Fields[i].FieldName;
          dat.DataSet    := MainData.tblProdPivot;
          dat.Left       := i * wid;
          dat.Width      := wid;
          dat.Top        := 3;
        end;
    end;

  PivotReport.DataSet := MainData.tblProdPivot;
  if Preview then
    PivotReport.Preview
  else
    PivotReport.Print;
end;

procedure TPivotReportForm.ClearLists;
begin
  while LabelList.Count > 0 do
    if Assigned(LabelList.Items[0]) then
      begin
        TQRLabel(LabelList.Items[0]).Free;
        LabelList.Delete(0);
      end;

  while DataList.Count > 0 do
    if Assigned(DataList.Items[0]) then
      begin
        TQRDBText(DataList.Items[0]).Free;
        DataList.Delete(0);
      end;
end;

end.
