unit fmFinishedDocs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dmMain, StdCtrls, Buttons, ComCtrls, Grids, DBGrids, DateUtils, DB, ADODB,
  ToolWin;

type
  TFinishedDocsForm = class(TForm)
    Label1: TLabel;
    dtpFrom: TDateTimePicker;
    dtpTo: TDateTimePicker;
    Label2: TLabel;
    bQuery: TBitBtn;
    bClose: TBitBtn;
    bPrint: TBitBtn;
    PageControl: TPageControl;
    tsDocs: TTabSheet;
    tsCons: TTabSheet;
    tsProd: TTabSheet;
    DBGrid3: TDBGrid;
    DBGrid4: TDBGrid;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    GroupBox2: TGroupBox;
    DBGrid2: TDBGrid;
    cbStatus: TComboBox;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure bQueryClick(Sender: TObject);
    procedure bCloseClick(Sender: TObject);
    procedure bPrintClick(Sender: TObject);
    procedure tsDocsShow(Sender: TObject);
    procedure tsDocsHide(Sender: TObject);
    procedure tsConsShow(Sender: TObject);
    procedure tsConsHide(Sender: TObject);
    procedure tsProdShow(Sender: TObject);
    procedure tsProdHide(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FinishedDocsForm: TFinishedDocsForm;

implementation

uses rptFinishedDoc, fmPivotReport;

{$R *.dfm}

procedure TFinishedDocsForm.FormCreate(Sender: TObject);
begin
  dtpFrom.DateTime := Now;
  dtpTo.DateTime   := Now;
end;

procedure TFinishedDocsForm.FormDestroy(Sender: TObject);
begin
//
end;

procedure TFinishedDocsForm.FormShow(Sender: TObject);
begin
//
end;

procedure TFinishedDocsForm.FormHide(Sender: TObject);
begin
//
end;

procedure TFinishedDocsForm.bQueryClick(Sender: TObject);
const
  SQL_FINISHED_ORDERS =
       'SELECT orders.*,' +
       'IIf(orders.invalid,"АНУЛИРАНА","валидна") AS Annul,' +
       'recipes.name AS recipe_name' +
       ' FROM recipes INNER JOIN orders ON orders.recipe_id = recipes.id' +
       ' WHERE (orders.finished = True) AND (orders.time_done BETWEEN :from_time AND :to_time) %s' +
       ' ORDER BY orders.nr';

var
  s, sAnnuled: String;
begin
  if cbStatus.ItemIndex = 1 then
    sAnnuled := 'True'
  else if cbStatus.ItemIndex = 0 then
    sAnnuled := 'False';

  case PageControl.ActivePageIndex of
    0: begin
         MainData.qFinishedOrders.Close;
         MainData.qFinishedOrdersSiloCons.Close;

         if cbStatus.ItemIndex = 2 then
           s := ''
         else
           s := Format( 'AND (invalid = %s)', [sAnnuled] );

       
         MainData.qFinishedOrders.SQL.Text := Format( SQL_FINISHED_ORDERS, [s] );


         with MainData.qFinishedOrders.Parameters do begin
           Clear;

           CreateParameter('from_date', ftDate, pdInput, 0, StartOfTheDay( dtpFrom.DateTime ));
           CreateParameter('to_date'  , ftDate, pdInput, 0, EndOfTheDay( dtpTo.DateTime ));
         end;

         try
           MainData.qFinishedOrders.Open;
         except
           on Exception do ;
         end;
       end; {case 0}
    1: begin
         MainData.spSiloPeriodCons.Close;
         MainData.tblSiloConsPivot.Close;

         with MainData.spSiloPeriodCons.Parameters do begin
           Clear;

           if cbStatus.ItemIndex = 2 then
             MainData.spSiloPeriodCons.ProcedureName := 'qry_silo_period'
           else
             MainData.spSiloPeriodCons.ProcedureName := 'sp_silo_period';

           CreateParameter('date_format', ftString, pdInput, 15, 'dd/mm/yyyy');
           CreateParameter('from_date', ftDate, pdInput, 0, StartOfTheDay( dtpFrom.DateTime ));
           CreateParameter('to_date'  , ftDate, pdInput, 0, EndOfTheDay( dtpTo.DateTime ));

           if cbStatus.ItemIndex <> 2 then
             CreateParameter('annuled', ftString, pdInput, 10, sAnnuled);

         end;

         try
           MainData.spSiloPeriodCons.Open;
           MainData.CreateSiloConsPivot;
         except
           on Exception do ;
         end;
       end; {case 1}
    2: begin
         MainData.spProdPeriod.Close;
         MainData.tblProdPivot.Close;

         with MainData.spProdPeriod.Parameters do begin
           Clear;

           if cbStatus.ItemIndex = 2 then
             MainData.spProdPeriod.ProcedureName := 'qry_prod_period'
           else
             MainData.spProdPeriod.ProcedureName := 'sp_prod_period';

           CreateParameter('date_format', ftString, pdInput, 15, 'dd/mm/yyyy');
           CreateParameter('from_date', ftDate, pdInput, 0, StartOfTheDay( dtpFrom.DateTime ));
           CreateParameter('to_date'  , ftDate, pdInput, 0, EndOfTheDay( dtpTo.DateTime ));

           if cbStatus.ItemIndex <> 2 then
             CreateParameter('annuled', ftString, pdInput, 10, sAnnuled);

         end;

         try
           MainData.spProdPeriod.Open;
           MainData.CreateProdPivot;
         except
           on Exception do ;
         end;
       end; {case 2}
  end; {case}
end;

procedure TFinishedDocsForm.bCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFinishedDocsForm.bPrintClick(Sender: TObject);
var
  sDocStatus: String;
begin
   if (-1 <> cbStatus.ItemIndex ) then
      sDocStatus := cbStatus.Items[cbStatus.ItemIndex]
    else
      sDocStatus := '';


  if (0 <> PageControl.ActivePageIndex) then
    PivotReportForm.lDocStatus.Caption := sDocStatus
  else
    FinishedDocReportForm.lDocStatus.Caption := sDocStatus;
   

  case PageControl.ActivePageIndex of
    0: {2.21} if not MainData.qFinishedOrders.IsEmpty then
      FinishedDocReportForm.DocReport.Preview;
    1: {2.21} if not MainData.tblSiloConsPivot.IsEmpty then
      PivotReportForm.PrepareSiloConsReport(true);
    2: {2.21} if not MainData.tblProdPivot.IsEmpty then
      PivotReportForm.PrepareProdReport(true);
  end;

  {2.21 Ако липсва проверката форсира Floating point division by zero } 
end;

procedure TFinishedDocsForm.tsDocsShow(Sender: TObject);
begin
//
end;

procedure TFinishedDocsForm.tsDocsHide(Sender: TObject);
begin
//
end;

procedure TFinishedDocsForm.tsConsShow(Sender: TObject);
begin
//
end;

procedure TFinishedDocsForm.tsConsHide(Sender: TObject);
begin
//
end;

procedure TFinishedDocsForm.tsProdShow(Sender: TObject);
begin
//
end;

procedure TFinishedDocsForm.tsProdHide(Sender: TObject);
begin
//
end;

procedure TFinishedDocsForm.PageControlChange(Sender: TObject);
begin
  MainData.qFinishedOrdersSiloCons.Close;
  MainData.qFinishedOrders.Close;
  MainData.spSiloPeriodCons.Close;
  MainData.spProdPeriod.Close;
  MainData.tblSiloConsPivot.Close;
  MainData.tblProdPivot.Close;
end;

procedure TFinishedDocsForm.FormActivate(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

end.
