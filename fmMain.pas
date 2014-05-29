unit fmMain;

{$define debug}
{$define noscale}

{$DEFINE LJOBO}


{IFDEF LJOBO
ДА СЕ ДОБАВИ ТОВА В grain.ini
[debug]
#40 cycles * 500 ms = 20 sec.
plc_response_timeout=40
ENDIF}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, {XPMan, }ExtCtrls,  ComCtrls,
  xControls, CLEDLbl, xMnemonics, XPStyleActnCtrls, ActnList,
  ActnMan, ToolWin, ActnCtrls, ActnMenus, ImageLib,
  Grids, DBGrids, DBCtrls, ADODB, DB, Mask, uD500BC, uDevices, uRoute, uGrainPlant, Math,
  ImgList, uGlobals, uLogger, RSConnection, RSConnection2,
  ScktComp;


{
   Новости във версия 2.21 спрямо 2.2
   --------------------------------------
   *************
   *  Програма *
   *************

   1. Заявките вече не се трият а се отбелязват като invalid=True !
   2. Нова променлива в grain.ini - plc_out_mask

   По файлове

   dmMain
   ----------------------------------------------------------------------------
   tblPendingOrders - модифициран е SQL-a нa tblPendingOrders
   dsFinishedOrders добавен е Field "Annul"
   нова функиция - ADODateTimeValueStr


   fmPivotReport
   ----------------------------------------------------------------------------
   добавен е QRLabel - lDosStatus

   fmFinishedDocs
   ----------------------------------------------------------------------------
   Оправен е TAB-ordera
   Добавено е Combo за филтър по статус на документа
   в DBGrid1 - поле за статус
   модифицирана е bQueryClick и SQL-ите на
   qFinishedOrders, spProdPeriod (параметрите също)
   bPrintClick - добавена е проверка дали има данни за печат


   fmMain
   ----------------------------------------------------------------------------
   Нова константа GRAIN_CURRENT_VERSION - версията ще се определя от тук !

   Фиксиран BUG в ReadTimerTimer, при четенето на последните данни в протокола
   ако има съвпадение с \n на данните се приемаше за край на блока - ПРИСВЕТВАНЕТО НА ХРИСТОФОР !

   rsOut - абсолютно неизползваема вече, да се махне по-нататък
   FormShow - тотално сбъгясана, завъртяни са портовете, не се задаваха бодовете

   OnDoseDone - разменени са местата на записа на количеството със съобщаването за
   приключена доза, сега първо записваме, след това съобщаваме, а не обратно както беше

   aDeleteOrderExecute e модифицирано така, че анулираните не се трият, а се
   сетват флаговете finished & invalid


   fmPreferences
   ----------------------------------------------------------------------------
   Сменят се местата на GroupBox2 с GroupBox3,  GroupBox2 се забранява и скрива
   bOKClick и FormShow - изчезват настройките за printer_xxx


   rptFinishedDoc
   ---------------------------------------------------------------------------
    - не беше зададен DataSet на рипорта и полетата,
    някой полета бяха с грешни данни
    добавен е QRLabel - lDosStatus


    ******
    * БД *
    ******
    Нови процедури - sp_prod_period и sp_silo_period



}
{
   Новости във версия 3.0 спрямо 2.2.1
   от Свилен         27.05.2014
   Добавена е връзка към SDispenser за дозиране на медикаменти.
   Имената на всички нови променливи започват с sd
   Добавения от мен код е между коментари ss-start и ss-end

   1.В aLoadOrderExecute с натискане на бутона "Зареди поръчка"  се задава името на
   рецептата в sdTag и количеството в sdBase

   2. В aStartOrderExecute с натискането на бутона "Започни доза" се вика процедурата
   sdStart. В нея се проверява дали има стартирана програма SDispenser. Ако няма , то се
   стартира с параметри за дозиране. Ако има се отваря TCP сокет.
     При свързването на сокета в sdClientSocketConnect се изпраща xml команда която
     стартира или спира процеса в зависимост от стойността на sdStartStop.
   3. За прекратяване на дозиране sdClientSocketConnect става FALSE в  aAbortExecute
   при натискане на бутона "Прекрати" и се извиква процедурата sdStop

   И sdStart и sdStop не се изпълняват ако от настройките не е чекнато "Връзка към SDispenser"
}

const
  // Актуална версия
  GRAIN_CURRENT_VERSION =  'Grain Plant v3.0, (c)2006 STIV Co.'; // 'Grain Plant v2.2, (c)2006 STIV Co.';




type

  TMainForm = class(TForm)
    PageControl1: TPageControl;
    tsDetails: TTabSheet;
    ReadTimer: TTimer;
    ActionManager1: TActionManager;
    aSilos: TAction;
    aRecipes: TAction;
    aRoutes: TAction;
    aQuit: TAction;
    aStartRoute: TAction;


    ActionMainMenuBar1: TActionMainMenuBar;
    StatusBar1: TStatusBar;
    tsMnemo: TTabSheet;
    sbMnemonics: TScrollBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    ilRoulette: TImageLib;
    ilFlaps: TImageLib;
    mnFlap1: TxMnemonic;
    mnFlap2: TxMnemonic;
    DBGrid1: TDBGrid;
    aCompanies: TAction;
    aEditOrder: TAction;
    aNewOrder: TAction;
    aDeleteOrder: TAction;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    aStartOrder: TAction;
    aStopRoute: TAction;
    mnBunker7: TxMnemonic;
    mnBunker8: TxMnemonic;
    ilBunkers: TImageLib;
    ilSilos: TImageLib;
    mnAuger: TxMnemonic;
    mnElevator: TxMnemonic;
    Image1: TImage;
    Image2: TImage;
    mnDischarge: TxMnemonic;
    ilDischarge: TImageLib;
    ilAuger: TImageLib;
    Image12: TImage;
    ilElevator: TImageLib;
    Image20: TImage;
    xImage2: TxImage;
    xImage3: TxImage;
    xImage4: TxImage;
    xImage5: TxImage;
    xImage7: TxImage;
    xImage8: TxImage;
    xImage9: TxImage;
    xImage10: TxImage;
    aOpenDisch: TAction;
    aCloseDisch: TAction;
    Button2: TButton;
    mnWater: TxMnemonic;
    mnOil: TxMnemonic;
    Button1: TButton;
    aLoadOrder: TAction;
    lvRecipe: TxListView;
    Label5: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Label6: TLabel;
    Label7: TLabel;
    RSin: TRSConnection;
    RSout: TRSConnection;
    ilMixer: TImageLib;
    mnMixer: TxMnemonic;
    xLog: TxListView;
    ilHammer: TImageLib;
    mnHammer: TxMnemonic;
    BitBtn6: TBitBtn;
    Label8: TLabel;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    aHammerOn: TAction;
    aHammerOff: TAction;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    lQtyReq: TLabel;
    lDoses: TLabel;
    lQtyDose: TLabel;
    lDosesDone: TLabel;
    aSiloManual: TAction;
    GroupBox3: TGroupBox;
    Shape1: TShape;
    lRunning: TPanel;
    lDoseDone: TPanel;
    lError: TPanel;
    Label13: TLabel;
    BitBtn1: TBitBtn;
    BitBtn12: TBitBtn;
    aStartMixer: TAction;
    aStopMixer: TAction;
    aDocQuery: TAction;
    aConsQuery: TAction;
    aProdDaily: TAction;
    aAbort: TAction;
    BitBtn13: TBitBtn;
    Bevel1: TBevel;
    aPreferences: TAction;
    aDBEdit: TAction;
    aTest: TAction;
    lManual: TPanel;
    LCD: TLabel;
    mnBunker1: TxMnemonic;
    mnBunker2: TxMnemonic;
    mnBunker3: TxMnemonic;
    mnBunker4: TxMnemonic;
    mnBunker5: TxMnemonic;
    mnBunker6: TxMnemonic;
    LCD_NET: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lNet: TLabel;
    lStab: TLabel;
    aZero: TAction;
    aTare: TAction;
    BitBtn14: TBitBtn;
    BitBtn15: TBitBtn;
    lPCNet: TLabel;
    lPCZero: TLabel;
    sdClientSocket: TClientSocket;

{$IFDEF LJOBO}
    procedure PLCNotResponse;
{$ENDIF}

    procedure ReadTimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure aQuitExecute(Sender: TObject);
    procedure aSilosExecute(Sender: TObject);
    procedure aRecipesExecute(Sender: TObject);
    procedure aRoutesExecute(Sender: TObject);
    procedure aStartRouteExecute(Sender: TObject);
    procedure aEditOrderExecute(Sender: TObject);
    procedure aNewOrderExecute(Sender: TObject);
    procedure aDeleteOrderExecute(Sender: TObject);
    procedure aStartOrderExecute(Sender: TObject);
    procedure aStopRouteExecute(Sender: TObject);
    procedure aOpenDischExecute(Sender: TObject);
    procedure aCloseDischExecute(Sender: TObject);

    procedure OnRouteStateChange(Sender: TObject);
    procedure OnBatchComplete(Sender: TObject);
    procedure OnError(Sender: TObject);
    procedure OnManualChange(Sender: TObject);
    procedure OnStepStarted(Sender: TObject);
    procedure OnStepDone(Sender: TObject);
    procedure OnRunningChange(Sender: TObject);
    procedure OnMixerStateChange(Sender: TObject);
    procedure OnDischStateChange(Sender: TObject);
    procedure OnHammerStateChange(Sender: TObject);
    procedure OnOrderStart(Sender: TObject);
    procedure OnOrderDone(Sender: TObject);
    procedure OnOrderReadyForNext(Sender: TObject);
    procedure OnDoseStart(Sender: TObject);
    procedure OnDoseDone(Sender: TObject);
    procedure OnRecipeStatusChange(Sender: TObject);
    procedure OnDataReady(Sender: TObject);
    procedure OnTimeout(Sender: TObject);

    procedure aLoadOrderExecute(Sender: TObject);
    procedure lvRecipeCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure xLogCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure aHammerOnExecute(Sender: TObject);
    procedure aHammerOffExecute(Sender: TObject);
    procedure aSiloManualExecute(Sender: TObject);
    procedure Button1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure aStartMixerExecute(Sender: TObject);
    procedure aStopMixerExecute(Sender: TObject);
    procedure aDocQueryExecute(Sender: TObject);
    procedure aConsQueryExecute(Sender: TObject);
    procedure aProdDailyExecute(Sender: TObject);
    procedure aAbortExecute(Sender: TObject);
    procedure aPreferencesExecute(Sender: TObject);
    procedure aDBEditExecute(Sender: TObject);
    procedure aTestExecute(Sender: TObject);

    procedure OnHammerOnTimer(Sender: TObject);
    procedure aZeroExecute(Sender: TObject);
    procedure aTareExecute(Sender: TObject);
    procedure sdClientSocketConnect(Sender: TObject;
      Socket: TCustomWinSocket);
  private
    { Private declarations }
  public
    { Public declarations }
    route : TxRoute;
    d500bc : TxD500BC;
    plant : TxGrainPlant;
    logger : TxLogger;

    { Hammer control }
    HammerOnTimer : TTimer;
    LastWeight    : integer;

{$IFDEF LJOBO}
  rsPLC: TRSConnection2;
{$ELSE}
  rsPLC: TRSConnection;
{$ENDIF}

  end;

var
  MainForm: TMainForm;

implementation

uses fmSilos, fmRecipes, fmRoutes, dmMain, fmOrderEdit,
  fmSiloManual, fmFinishedDocs, rptFinishedDoc, fmPreferences, fmDBEdit,
  fmDeviceError, fmAbort;

{$R *.dfm}


{$IFDEF LJOBO}
const
  ANSWER_SIZE            = 7;

var
  notResponding: Integer = 0;
  NOT_RESPONDING_TIMEOUT: Integer = 0; // в цикли по 500 мсек., default = 40 цикъла. = 20 сек.


procedure TMainForm.PLCNotResponse;
begin
  if not rsPLC.IsOpen then
    Exit;

  Inc( notResponding );

  if NOT_RESPONDING_TIMEOUT = 0 then
    begin
      NOT_RESPONDING_TIMEOUT := GetPrivateProfileInt( 'debug','plc_response_timeout',40, cConfigFileName );
    end;

  if ( notResponding >= NOT_RESPONDING_TIMEOUT ) then
    begin
      ReadTimer.Enabled := False;
      rsPLC.Close;
      logger.LogEvent( 'PLC device not responding. Closed.', 'ERROR', etError);

      MessageDlg( 'PLC устройството не кореспондира, или са натрупани твърде много хардуерни грешки! Порта беше затворен.', mtError, [mbOk], 0 );

      repeat

        if MessageDlg( 'Опит за повторно свързване?' ,
          mtConfirmation,
          [mbYes,mbNo],
          0 ) = mrNo then
          begin
             MessageDlg( 'Няма връзка с PLC. За да продължите е необходимо да рестартирате приложението.', mtWarning, [mbOk], 0 );
             Exit;
          end;

        rsPLC.Open;

      until rsPLC.IsOpen;

      logger.LogEvent( 'PLC device reopened.', '', etMisc);
      notResponding := 0;
      ReadTimer.Enabled := True;

    end;
end;


procedure TMainForm.ReadTimerTimer(Sender: TObject);
label
  reset_com;

var buff: string;
    plc_in_buff: TxInBuffer;
    plc_out_buff: TxOutBuffer;
    i : integer;
    hex_buff: string;
    byte_nr, bit_nr: integer;

    dwAvailBytes,
    dwErrors,
    cbReaded,
    dwAlign      : DWORD;
    statPort     : TCOMSTAT;

    posCRLF      : Integer;

begin

  if not rsPLC.IsOpen then
    Exit;
  dwErrors := CE_IOE;
  statPort.cbInQue := 0;
  ClearCommError(rsPLC.Handle, dwErrors, @statPort);
  if dwErrors <> 0 then
    begin
      logger.LogEvent( Format( 'COM errors %Xh!', [dwErrors] ), 'ERROR', etError);

reset_com:
      rsPLC.Flush;
      PLCNotResponse;
      Exit;
    end;

  dwAvailBytes := statPort.cbInQue;
  if ( dwAvailBytes < ANSWER_SIZE ) then
    begin
      PLCNotResponse;
      Exit;
    end;




 // закръгляване до размера на блока 6 + 1 байта
 dwAlign := dwAvailBytes mod (ANSWER_SIZE);
 dwAvailBytes := dwAvailBytes - dwAlign;




 SetLength( buff, (dwAvailBytes + 1) );

 FillChar( buff[1], (dwAvailBytes + 1), 0 );

 if not ReadFile( rsPLC.Handle, PChar(buff)^, dwAvailBytes, cbReaded, nil ) or (dwAvailBytes <> cbReaded) then
   begin
     logger.LogEvent( Format( 'ReadFile() error %d!', [GetLastError] ), 'ERROR', etError);
     goto reset_com;
   end;



 // Протокола е 6 байта данни \r, без \n
 if (buff[cbReaded] <> #13) or // Проверка за \r в края на блока
    ((cbReaded > (ANSWER_SIZE)) and (buff[cbReaded - (ANSWER_SIZE)] <> #13)) // и в края на предния, ако има такъв
 then
  begin
    logger.LogEvent( 'CRC error in data.', 'ERROR', etError);
    goto reset_com;
    //PLCNotResponse;
    //Exit;
  end;

 posCRLF := cbReaded - (ANSWER_SIZE);
 notResponding := 0;


 {
 posCRLF := -1;


 for i := dwAvailBytes downto ANSWER_SIZE do
   if buff[i] = #13 then
     begin
       posCRLF := i;
       break;
     end;


 if (posCRLF < (ANSWER_SIZE - 1)) then
   begin
      PLCNotResponse;
      Exit;
   end;

 notResponding := 0;


 Dec(posCRLF,ANSWER_SIZE);
 }



 plc_in_buff[0] := byte( buff[posCRLF + 2] );
 plc_in_buff[1] := byte( buff[posCRLF + 1] );
 plc_in_buff[2] := byte( buff[posCRLF + 4] );
 plc_in_buff[3] := byte( buff[posCRLF + 3] );
 plc_in_buff[4] := byte( buff[posCRLF + 6] );
 plc_in_buff[5] := byte( buff[posCRLF + 5] );



      hex_buff := '';
      for i:=1 to length(buff) do
        hex_buff := hex_buff + IntToHex(Byte(buff[i]), 2) + ' ';

      plant.ProcessInput( plc_in_buff );

     // FillChar( plc_out_buff, SizeOf(plc_out_buff), $00 );
     FillChar( plc_out_buff, SizeOf(plc_out_buff), plc_out_mask );


      plant.ModifyOutput( plc_out_buff );

      { if the silo manual control form is shown, then modify the output }
      if SiloManualForm.Showing then
        for i:=0 to SiloManualForm.Buttons.Count-1 do
          begin
            byte_nr := (33+i) div 8;
            bit_nr  := (33+i) mod 8;

            if TButton(SiloManualForm.Buttons[i]).Tag <> 0 then
              plc_out_buff[byte_nr] := plc_out_buff[byte_nr] or round(power(2, bit_nr))
            else
              plc_out_buff[byte_nr] := plc_out_buff[byte_nr] and not round(power(2, bit_nr));
          end;

      buff := char( plc_out_buff[1] ) +
              char( plc_out_buff[0] ) +
              char( plc_out_buff[3] ) +
              char( plc_out_buff[2] ) +
              char( plc_out_buff[5] ) +
              char( plc_out_buff[4] ) +
              #10;

      rsPLC.Write( buff );






end;
{$ELSE}
procedure TMainForm.ReadTimerTimer(Sender: TObject);
var buff: string;
    plc_in_buff: TxInBuffer;
    plc_out_buff: TxOutBuffer;
    i : integer;
    hex_buff: string;
    byte_nr, bit_nr: integer;
begin

  if rsPLC.IsOpen and (rsPLC.InCount > 0) then
    begin
      buff := rsPLC.Read;

      // BUG - ако прочетените данни са по-малко от 6 байта
      // част от plc_in_buff са случайни числа !!!

      plc_in_buff[0] := byte( buff[2] );
      plc_in_buff[1] := byte( buff[1] );
      plc_in_buff[2] := byte( buff[4] );
      plc_in_buff[3] := byte( buff[3] );
      plc_in_buff[4] := byte( buff[6] );
      plc_in_buff[5] := byte( buff[5] );



      hex_buff := '';
      for i:=1 to length(buff) do
        hex_buff := hex_buff + IntToHex(Byte(buff[i]), 2) + ' ';

      plant.ProcessInput( plc_in_buff );

      FillChar( plc_out_buff, SizeOf(plc_out_buff), $00 );

      plant.ModifyOutput( plc_out_buff );

      { if the silo manual control form is shown, then modify the output }
      if SiloManualForm.Showing then
        for i:=0 to SiloManualForm.Buttons.Count-1 do
          begin
            byte_nr := (33+i) div 8;
            bit_nr  := (33+i) mod 8;

            if TButton(SiloManualForm.Buttons[i]).Tag <> 0 then
              plc_out_buff[byte_nr] := plc_out_buff[byte_nr] or round(power(2, bit_nr))
            else
              plc_out_buff[byte_nr] := plc_out_buff[byte_nr] and not round(power(2, bit_nr));
          end;

      buff := char( plc_out_buff[1] ) +
              char( plc_out_buff[0] ) +
              char( plc_out_buff[3] ) +
              char( plc_out_buff[2] ) +
              char( plc_out_buff[5] ) +
              char( plc_out_buff[4] ) +
              #10;

      rsPLC.Write( buff );
    end;
end;
{$ENDIF}

procedure TMainForm.FormCreate(Sender: TObject);
var i: integer;
begin
//ss-start
  uGlobals.sdSocket := sdClientSocket;
//ss-end
  { Create logger object }
{$IFDEF LJOBO}
  Caption := GRAIN_CURRENT_VERSION;  //'Grain Plant v2.2b, (c)2006 STIV Co.'; //'Grain Plant v2.1, (c)2006 STIV Co. FOR DEBUG PURPOSE ONLY';
  rsPLC := TRSConnection2.Create(Self);
{$ELSE}
  rsPLC := TRSConnection.Create(Self);
{$ENDIF}

  logger := TxLogger.Create(Self, xLog, MainData.spLog);

  HammerOnTimer := nil;

  { D500BC control signals }

  { Load the image libraries }
  ilRoulette.LoadFromFile( 'roulette.sil' );
  ilFlaps.LoadFromFile( 'flaps.sil' );
  ilBunkers.LoadFromFile( 'silo-big.sil' );
  ilSilos.LoadFromFile( 'silo.sil' );
  ilDischarge.LoadFromFile( 'disch.sil' );
  ilAuger.LoadFromFile( 'auger.sil' );
  ilElevator.LoadFromFile( 'elevator.sil' );
  ilMixer.LoadFromFile( 'mixer.sil' );
  ilHammer.LoadFromFile( 'hammer.sil' );

  mnFlap1.StaticImageIndex    := 0;
  mnFlap2.StaticImageIndex    := 0;
  mnBunker1.StaticImageIndex  := 0;
  mnBunker2.StaticImageIndex  := 0;
  mnBunker3.StaticImageIndex  := 0;
  mnBunker4.StaticImageIndex  := 0;
  mnBunker5.StaticImageIndex  := 0;
  mnBunker6.StaticImageIndex  := 0;
  mnBunker7.StaticImageIndex  := 0;
  mnBunker8.StaticImageIndex  := 0;
  mnMixer.StaticImageIndex    := 0;
  mnElevator.StaticImageIndex := 0;
  mnAuger.StaticImageIndex    := 0;
  mnHammer.StaticImageIndex   := 0;

  mnDischarge.StaticImageIndex := 0;

  { Create a route object }
  route := TxRoute.Create(Self);
  route.Log := logger;
  route.DBConnection := MainData.ADOConnection;
  route.Name := 'route';
  route.OnStateChange := OnRouteStateChange;

  route.Flap1.Mnemonic := mnFlap1;
  route.Flap2.Mnemonic := mnFlap2;
  route.Auger.Mnemonic := mnAuger;
  route.Elevator.Mnemonic := mnElevator;

  { Create a D500BC object }
  d500bc := TxD500BC.Create( Self, 1, 9600, 4, 1200 );
  d500bc.RSin := RSin;
//  d500bc.RSout := RSout;

  { Create a plant object }
  plant := TxGrainPlant.Create(Self);
  plant.Route := route;
  plant.D500BC := d500bc;
  plant.OnBatchComplete := Self.OnBatchComplete;
  plant.OnError         := Self.OnError;
  plant.OnManualChange  := Self.OnManualChange;
  plant.OnStepStarted   := Self.OnStepStarted;
  plant.OnStepDone      := Self.OnStepDone;
  plant.OnRunningChange := Self.OnRunningChange;
  plant.OnOrderStart    := Self.OnOrderStart;
  plant.OnOrderDone     := Self.OnOrderDone;
  plant.OnOrderReadyForNext := Self.OnOrderReadyForNext;
  plant.OnDoseStart     := Self.OnDoseStart;
  plant.OnDoseDone      := Self.OnDoseDone;
  plant.OnDataReady     := Self.OnDataReady;
  plant.OnTimeout       := Self.OnTimeout;
  plant.OnRecipeStatusChange := Self.OnRecipeStatusChange;

  plant.Log             := logger;

  with plant do begin
    route.Bunkers[1].Mnemonic := mnBunker1;
    route.Bunkers[2].Mnemonic := mnBunker2;
    route.Bunkers[3].Mnemonic := mnBunker3;
    route.Bunkers[4].Mnemonic := mnBunker4;
    route.Bunkers[5].Mnemonic := mnBunker5;
    route.Bunkers[6].Mnemonic := mnBunker6;
    route.Bunkers[7].Mnemonic := mnBunker7;
    route.Bunkers[8].Mnemonic := mnBunker8;

    Water := TxSwitchingDevice.Create(plant);
    Water.Name := 'water';
    Water.Mnemonic := mnWater;
    Water.BitIn := 27;
    Water.BitOut := 11;

    Oil := TxSwitchingDevice.Create(plant);
    Oil.Name := 'oil';
    Oil.Mnemonic := mnOil;
    Oil.BitIn := 28;
    Oil.BitOut := 10;

    Disch := TxCommonDevice.Create(plant);
    Disch.Name := 'discharge';
    Disch.Mnemonic := mnDischarge;
    Disch.BitIn := 29;
    Disch.BitOut := 2;
    Disch.Log := Log;
    Disch.OnStateChange := Self.OnDischStateChange;

    Mixer := TxCommonDevice.Create(plant);
    Mixer.Name := 'mixer';
    Mixer.Mnemonic := mnMixer;
    Mixer.BitIn := 0;
    Mixer.BitOut := 13;
    Mixer.OnStateChange := Self.OnMixerStateChange;

    Hammer := TxCommonDevice.Create(plant);
    Hammer.Name := 'hammer';
    Hammer.Mnemonic := mnHammer;
    Hammer.BitIn := 30;
    Hammer.BitOut := 12;
    Hammer.OnStateChange := Self.OnHammerStateChange;
    Disch.Log := Log;

    for i:=1 to cSiloCount do
      begin
        Silos[i] := TxCommonDevice.Create( Self );
        Silos[i].Name := 'silo' + IntToStr(i);
        Silos[i].Mnemonic := TxMnemonic.Create( sbMnemonics );

        if MainData.tblSilos.Locate('nr', i, []) then
          Silos[i].Caption := MainData.tblSilos.FieldByName('name').AsString
        else
          Silos[i].Caption := 'Силоз ' + IntToStr(i);

        Silos[i].BitIn := 7 + i - 1;
        Silos[i].BitOut := 33 + i - 1;
        Silos[i].DeviceID := i;
        Silos[i].OnStateChange := plant.SiloStateChange;
//        Silos[i].Tag := i;

        with Silos[i].Mnemonic do
          begin
            ShowCaption := True;

            Width := 45;
            Height := 70;
{
            if i<=6 then
              begin
                Left := 1 + (i-1)*35;
                Top  := 1 + (i-1)*15;
              end
            else
              begin
                Left := 211 + (13-i)*35;
                Top  := 1 + (i-1-6)*15;
              end;
}
            Left := 10 + ((i-1) div 7)*25 + ((i-1) mod 7)*50;
            Top  := 25 + ((i-1) div 7)*75;

            Parent := sbMnemonics;
            ImageLib := ilSilos;
            StaticImageIndex := 0;
            Transparent := True;

            Canvas.Font.Height := 6;
          end;
      end;
  end;

  lvRecipe.Items.Clear;
  lQtyReq.Caption := '-';
  lDoses.Caption := '-';
  lQtyDose.Caption := '- kg';
  lDosesDone.Caption := '-';

  aDBEdit.Visible := debug_mode;
  aTest.Visible   := debug_mode;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
(*
  rsPrinter.Port := 1;
  rsPrinter.Baud := 9600;
  rsPrinter.DataBits := 8;
  rsPrinter.StopBits := 1;
  rsPrinter.Open;
  if rsPrinter.IsOpen then
    Log.Write( 'Printer port opened.' )
  else
    Log.Write( 'Printer port not opened.' );

  rsCurr.Port := 4;
  rsCurr.Baud := 1200;
  rsCurr.DataBits := 8;
  rsCurr.StopBits := 1;
  rsCurr.Open;
  if rsCurr.IsOpen then
    Log.Write( 'Current loop port opened.' )
  else
    Log.Write( 'Current loop port not opened.' );
*)
{
  rsPLC.Port := 4;
  rsPLC.Baud := 19200;
  rsPLC.DataBits := 8;
  rsPLC.StopBits := 1;
}

{
  // BUG - не се задаваше
  RSin.Baud := printer_baud;
  // BUG ЗАВЪРТЯНИ СА  printer_xxx с  scale_xxx
  RSin.Port := printer_port;
}

  RSin.Baud := scale_baud;
  RSin.Port := scale_port;

  RSin.Open;
  if RSin.IsOpen then
    logger.LogEvent('RSin port opened.', '', etMisc)
  else
    logger.LogEvent('RSin port not opened.', '', etError);

{
  // BUG - не се задаваше
  RSout.Baud := scale_baud;
  // BUG ЗАВЪРТЯНИ СА  printer_xxx с  scale_xxx
  RSout.Port := scale_port;
}

{
  RSout.Open;
  if RSout.IsOpen then
    logger.LogEvent('RSout port opened.', '', etMisc)
  else
    logger.LogEvent('RSout port not opened.', '', etError);
}




  // BUG - не се задаваше
  rsPLC.Baud := plc_baud;

  rsPLC.Port := plc_port;
  rsPLC.Open;
  if rsPLC.IsOpen then
    logger.LogEvent('PLC port opened.', '', etMisc)
  else
    logger.LogEvent('PLC port not opened.', '', etError);

  Self.WindowState := wsMaximized;

  SiloManualForm.plant := plant;
end;

procedure TMainForm.FormHide(Sender: TObject);
begin
//
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  plant.Free;
  route.Free;
  d500bc.Free;
{
  rsPrinter.Close;
  rsCurr.Close;
}
end;

procedure TMainForm.aQuitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.aSilosExecute(Sender: TObject);
begin
  SilosForm.ShowModal;
end;

procedure TMainForm.aRecipesExecute(Sender: TObject);
begin
  RecipesForm.ShowModal;
end;

procedure TMainForm.aRoutesExecute(Sender: TObject);
begin
  RoutesForm.ShowModal;
end;

procedure TMainForm.aStartRouteExecute(Sender: TObject);
begin
  if uGlobals.manual then
    begin
      MessageDlg( 'Системата е в ръчен режим на управление!', mtWarning, [mbOK], 0 );
      Exit;
    end;

  route.StartChain( MainData.tblRoutes.FieldByName( 'id' ).AsInteger );
end;

procedure TMainForm.aEditOrderExecute(Sender: TObject);
begin
  OrderEditForm.OrderID := MainData.tblPendingOrders.FieldByName( 'id' ).AsInteger;
  OrderEditForm.ShowModal;
end;

procedure TMainForm.aNewOrderExecute(Sender: TObject);
begin
  OrderEditForm.OrderID := -1;
  OrderEditForm.ShowModal;
end;

procedure TMainForm.aDeleteOrderExecute(Sender: TObject);
begin
  if MessageDlg( 'Сигурни ли сте, че искате да откажете поръчката? ' +
                 IntToStr(MainData.tblPendingOrders.FieldByName( 'id' ).Value),
                 mtConfirmation, [mbYes, mbNo], 0 ) = mrYes then
    with MainData do begin

     // отпада от 2.21 нататък
     // tblPendingOrders.Delete;

      tblPendingOrders.Edit;
      tblPendingOrders.FieldByName('finished').AsBoolean := True;
      tblPendingOrders.FieldByName('invalid').AsBoolean  := True;
      tblPendingOrders.FieldByName('time_done').AsString := ADODateTimeValueStr(Now);

      tblPendingOrders.Post;

      tblPendingOrders.Requery;
    end;
end;

procedure TMainForm.aStartOrderExecute(Sender: TObject);
begin
  if uGlobals.manual then
    begin
      MessageDlg( 'Системата е в ръчен режим на управление!', mtWarning, [mbOK], 0 );
      Exit;
    end;

  try
    plant.StartDose;
  except
    on e: Exception do MessageDlg( e.Message , mtWarning, [mbOK], 0 );
  end;
end;

procedure TMainForm.aStopRouteExecute(Sender: TObject);
begin
  route.StopChain;
end;

procedure TMainForm.aOpenDischExecute(Sender: TObject);
begin
  if uGlobals.manual then
    begin
      MessageDlg( 'Системата е в ръчен режим на управление!', mtWarning, [mbOK], 0 );
      Exit;
    end;

  if plant.Route.Active then
    plant.Disch.ContactorOut := true
  else
    MessageDlg('Няма активен маршрут! Отварянето на клапата е забранено!', mtWarning, [mbOK], 0);
end;

procedure TMainForm.aCloseDischExecute(Sender: TObject);
begin
  plant.Disch.ContactorOut := false;
end;

procedure TMainForm.OnRouteStateChange(Sender: TObject);
begin
  aStartRoute.Enabled := not route.Active;
  aStopRoute.Enabled := route.Active;

  if not route.Active then
    begin
      plant.Disch.ContactorOut := false;
    end;

//  aOpenDisch.Enabled := not plant.Disch.ContactorOut and route.Active;
//  aCloseDisch.Enabled := plant.Disch.ContactorOut and route.Active;
end;

procedure TMainForm.OnBatchComplete(Sender: TObject);
begin
//  ShowMessage('Batch complete!');
end;

procedure TMainForm.OnError(Sender: TObject);
begin
  DeviceErrorForm.ShowModal;
end;

procedure TMainForm.OnManualChange(Sender: TObject);
begin
  if plant.Manual then
    lManual.Color := clYellow
  else
    lManual.Color := clGray;

  uGlobals.manual := plant.Manual;
//  ShowMessage('Manual!');
end;

procedure TMainForm.OnStepStarted(Sender: TObject);
begin
  TxColor(lvRecipe.Items[plant.Recipe.CurrStepNr-1].Data).Color := clBlue;
  lvRecipe.Repaint;
end;

procedure TMainForm.OnStepDone(Sender: TObject);
begin
  TxColor(lvRecipe.Items[plant.Recipe.CurrStepNr-1].Data).Color := clGreen;

  { Show the qty done }
  lvRecipe.Items[plant.Recipe.CurrStepNr-1].SubItems[2] :=
    Format('%d kg', [plant.Recipe.CurrStep.CurrQty]);


//  MainData.AddDoneQty(plant.Recipe.OrderID, plant.Recipe.CurrStep.CurrQty);

  MainData.AddSiloQty( plant.Recipe.OrderID,
                       plant.Recipe.CurrStep.SiloID,
                       plant.Recipe.CurrStep.CurrQty
                     );

  lvRecipe.Repaint;
end;

procedure TMainForm.OnRunningChange(Sender: TObject);
begin
//  ShowMessage('Running!');
  if plant.Running and SiloManualForm.Showing then SiloManualForm.Close;
  aSiloManual.Enabled := not plant.Running;
end;

procedure TMainForm.OnMixerStateChange(Sender: TObject);
begin
  aStartMixer.Enabled  := not plant.Mixer.ContactorIn;
  aStopMixer .Enabled  := plant.Mixer.ContactorIn;
end;

procedure TMainForm.OnDischStateChange(Sender: TObject);
begin
  aOpenDisch .Enabled  := not plant.Disch.ContactorIn;
  aCloseDisch.Enabled  := plant.Disch.ContactorIn;
end;

procedure TMainForm.OnHammerStateChange(Sender: TObject);
begin
  aHammerOn .Enabled  := not plant.Hammer.ContactorIn;
  aHammerOff.Enabled  := plant.Hammer.ContactorIn;
end;

procedure TMainForm.OnOrderStart(Sender: TObject);
begin
//  ShowMessage('Starting order!');
end;

procedure TMainForm.OnOrderDone(Sender: TObject);
begin
  lvRecipe.Items.Clear;
  lQtyReq.Caption := '-';
  lDoses.Caption := '-';
  lQtyDose.Caption := '- kg';
  lDosesDone.Caption := '-';

  MainData.FinishOrder(plant.Recipe.OrderID);

  if uGlobals.alert_order_done then
    ShowMessage('Поръчката е изпълнена!');
{
  if MainData.CloseDoc(plant.Recipe.DocNr) then
    if MessageDlg('Всички поръчки по документа са приключени. Отпечатване на документ?',
                  mtConfirmation, [mbYes, mbNo], 0)=mrYes then
      begin
        FinishedDocReportForm.PreveiwDocument( plant.Recipe.DocNr );
      end;
}
end;

procedure TMainForm.OnOrderReadyForNext(Sender: TObject);
begin
  { autostart next order }
  if uGlobals.autostart_next_order then
    if not MainData.tblPendingOrders.IsEmpty then begin
      MainData.tblPendingOrders.First;

      aLoadOrderExecute(aLoadOrder);
      aStartOrderExecute(aStartOrder);
    end;
end;

procedure TMainForm.OnDoseStart(Sender: TObject);
begin
//  ShowMessage('Starting dose!');
end;

procedure TMainForm.OnDoseDone(Sender: TObject);
var i: integer;
begin
{
  if uGlobals.alert_dose_done then
    ShowMessage('Дозата е изпълнена!');
  lDosesDone.Caption := IntToStr(plant.Recipe.DosesDone);

//  MainData.AddDoneQty(plant.Recipe.OrderID, plant.Recipe.QtyDose);
(********************************************************************)
  MainData.AddDoneQty(plant.Recipe.OrderID, plant.Recipe.QtyLastDose);
(********************************************************************)
}

  // ПЪРВО ЗАПИСВАМЕ, ПОСЛЕ СЪОБЩАВАМЕ !
  MainData.AddDoneQty(plant.Recipe.OrderID, plant.Recipe.QtyLastDose);

  if uGlobals.alert_dose_done then
    ShowMessage('Дозата е изпълнена!');
  lDosesDone.Caption := IntToStr(plant.Recipe.DosesDone);


  for i:=0 to lvRecipe.Items.Count-3 do
    begin
      TxColor( lvRecipe.Items[i].Data ).Color := clBlack;
      lvRecipe.Items[i].SubItems[2] := '-';
    end;

  lvRecipe.Repaint;
end;

procedure TMainForm.OnRecipeStatusChange(Sender: TObject);
var i  : integer;
begin
  { if the recipe was cleared /finished, canceleed .../ }
  if not Assigned(plant.Recipe) then
    begin
      lvRecipe.Clear;
      lvRecipe.Tag := -1;

      lQtyReq   .Caption := '-';
      lDoses    .Caption := '-';
      lQtyDose  .Caption := '-';
      lDosesDone.Caption := '-';
    end
  else
  { if the recipe was just loaded }
  if plant.Recipe.RecipeID <> lvRecipe.Tag then
    begin
      lvRecipe.Tag := plant.Recipe.RecipeID;
      lvRecipe.Clear;

      for i:=1 to plant.Recipe.StepCount do
        with lvRecipe.Items.Add do
          begin
            Caption := IntToStr(i);
            SubItems.Add(plant.Recipe.GetStepByNr(i).SiloName);
            SubItems.Add(Format('%d kg', [plant.Recipe.GetStepByNr(i).Qty]));
            SubItems.Add('-');
            Data := TxColor.Create(clBlack);
          end;

      with plant.Recipe, lvRecipe.Items.Add do
        begin
          Caption := '-';
          SubItems.Add( 'Вода' );
          SubItems.Add( Format('%.1f s', [WaterTime]) );
          Data    := TxColor.Create(clBlack);
        end;

      with plant.Recipe, lvRecipe.Items.Add do
        begin
          Caption := '-';
          SubItems.Add( 'Олио' );
          SubItems.Add( Format('%.1f s', [OilTime]) );
          Data    := TxColor.Create(clBlack);
        end;

      lQtyReq   .Caption := Format('%d kg', [plant.Recipe.QtyReq]);
      lDoses    .Caption := Format('%d',    [plant.Recipe.DosesReq]);
      lQtyDose  .Caption := Format('%d kg', [plant.Recipe.QtyDose]);
      lDosesDone.Caption := Format('%d', [plant.Recipe.DosesDone]);
    end
  else ;

  if Assigned(plant.Recipe) then
    begin
      if plant.Recipe.DoseStarted then lRunning.Color := clLime
      else lRunning.Color := clGray;

      if plant.Recipe.DoseDone then lDoseDone.Color := clSkyBlue
      else lDoseDone.Color := clGray;
    end;

  aLoadOrder.Enabled := not Assigned(plant.Recipe);
  aStartOrder.Enabled := Assigned(plant.Recipe) and (not plant.Recipe.DoseStarted);
  aSiloManual.Enabled := not Assigned(plant.Recipe) or
                         (Assigned(plant.Recipe) and not plant.Recipe.DoseStarted);
  aAbort.Enabled     := Assigned(plant.Recipe);
end;

procedure TMainForm.OnDataReady(Sender: TObject);
var w: string;
begin
  { update the weight indicator }
  w := d500bc.Sign + IntToStr(d500bc.Weight);
  if Copy(LCD.Caption,2,6) <> w then LCD.Caption := w;

  { update the current step weight indicator }
  if Assigned(plant.Recipe) and Assigned(plant.Recipe.CurrStep) then
    w := IntToStr(plant.Recipe.CurrStep.CurrQty)
  else
    w := '-';
  if LCD_NET.Caption <> w then LCD_NET.Caption := w;

  { update the status indicators }
  if d500bc.Status and 2 <> 0 then
    lNet.Font.Color := $007777FF
  else
    lNet.Font.Color := $00000066;

  if d500bc.Status and 16 <> 0 then
    lStab.Font.Color := $007777FF
  else
    lStab.Font.Color := $00000066;

  { update the PC status indicators }
  if d500bc.Tare <> 0 then
    lPCNet.Font.Color := $0077FF77
  else
    lPCNet.Font.Color := $00006600;

  if d500bc.Zero <> 0 then
    lPCZero.Font.Color := $0077FF77
  else
    lPCZero.Font.Color := $00006600;
end;

procedure TMainForm.OnTimeout(Sender: TObject);
begin
  LCD.Caption := '-------';
  LCD_NET.Caption := '-';

  lNet.Font.Color := $00000066;
  lStab.Font.Color := $00000066;
end;

procedure TMainForm.aLoadOrderExecute(Sender: TObject);
var order_id : integer;

begin
  if uGlobals.manual then
    begin
      MessageDlg( 'Системата е в ръчен режим на управление!', mtWarning, [mbOK], 0 );
      Exit;
    end;

  order_id := MainData.tblPendingOrders.FieldByName( 'id' ).AsInteger;
//ss-start
  uGlobals.sdTag := MainData.tblPendingOrders.Fields[5].AsString;
//  sdBase := MainData.tblPendingOrders.Fields[7].AsString;
//ss-end

  with MainData do try
    spDetailedOrder.Close;

    spDetailedOrder.Parameters.Clear;
    spDetailedOrder.Parameters.CreateParameter( 'order_id', ftInteger, pdInput, 0, order_id );

    spDetailedOrder.Open;

    plant.LoadOrder(spDetailedOrder);

    spDetailedOrder.Close;
  except
    on e: Exception do ;
  end;

  aLoadOrder.Enabled := False;
  aStartOrder.Enabled := (plant.Recipe.StepCount > 0);
end;

procedure TMainForm.lvRecipeCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
//
end;

procedure TMainForm.xLogCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
//
end;

procedure TMainForm.aHammerOnExecute(Sender: TObject);
begin
  if uGlobals.manual then
    begin
      MessageDlg( 'Системата е в ръчен режим на управление!', mtWarning, [mbOK], 0 );
      Exit;
    end;

  plant.Hammer.ContactorOut := True;
end;

procedure TMainForm.aHammerOffExecute(Sender: TObject);
begin
  plant.HammerOn := false;
  plant.Hammer.ContactorOut := False;
end;

procedure TMainForm.aSiloManualExecute(Sender: TObject);
begin
  if uGlobals.manual then
    begin
      MessageDlg( 'Системата е в ръчен режим на управление!', mtWarning, [mbOK], 0 );
      Exit;
    end;

  if not plant.Running then
    SiloManualForm.Show
  else
    MessageDlg('Не е позволено ръчно управление, докато се изпълнява автоматично дозиране!',
               mtWarning, [mbOK], 0);
end;

procedure TMainForm.Button1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  logger.LogEvent('Mouse down', '', etMisc);
end;

procedure TMainForm.Button1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  logger.LogEvent('Mouse up', '', etMisc);
end;

procedure TMainForm.aStartMixerExecute(Sender: TObject);
begin
  if uGlobals.manual then
    begin
      MessageDlg( 'Системата е в ръчен режим на управление!', mtWarning, [mbOK], 0 );
      Exit;
    end;

  plant.Mixer.ContactorOut := True;
end;

procedure TMainForm.aStopMixerExecute(Sender: TObject);
begin
  plant.Mixer.ContactorOut := False;
end;

procedure TMainForm.aDocQueryExecute(Sender: TObject);
begin
  FinishedDocsForm.PageControl.ActivePageIndex := 0;
  FinishedDocsForm.ShowModal;//
end;

procedure TMainForm.aConsQueryExecute(Sender: TObject);
begin
  FinishedDocsForm.PageControl.ActivePageIndex := 1;
  FinishedDocsForm.ShowModal;//
end;

procedure TMainForm.aProdDailyExecute(Sender: TObject);
begin
  FinishedDocsForm.PageControl.ActivePageIndex := 2;
  FinishedDocsForm.ShowModal;//
end;

procedure TMainForm.aAbortExecute(Sender: TObject);
begin
  if uGlobals.manual then
    begin
      MessageDlg( 'Системата е в ръчен режим на управление!', mtWarning, [mbOK], 0 );
      Exit;
    end;

  try
    if AbortForm.ShowModal = mrOK then
      if AbortForm.rbCancelOrder.Checked then
        plant.AbortOrder
      else
      if AbortForm.rbCancelDose.Checked then
        plant.AbortDose
      else;
  except
    on e: Exception do MessageDlg(e.Message, mtWarning, [mbOK], 0);
  end;
end;

procedure TMainForm.aPreferencesExecute(Sender: TObject);
begin
  PreferencesForm.ShowModal;
end;

procedure TMainForm.aDBEditExecute(Sender: TObject);
begin
  DBEditForm.ShowModal;
end;

procedure TMainForm.aTestExecute(Sender: TObject);
begin
  MainData.AddSiloQty( Random(10), 18 + Random(5), Random(200) );
end;

procedure TMainForm.OnHammerOnTimer(Sender: TObject);
begin
  HammerOnTimer.Enabled := false;
  HammerOnTimer.Free;
  HammerOnTimer := nil;

  plant.HammerOn := true;
end;

procedure TMainForm.aZeroExecute(Sender: TObject);
begin
  d500bc.Tare := 0;
  d500bc.Zero := 0;
  d500bc.Zero := d500bc.Weight;
end;

procedure TMainForm.aTareExecute(Sender: TObject);
begin
  if d500bc.Weight = 0 then
    begin
      d500bc.Tare := 0
    end
  else
    begin
      d500bc.Tare := 0;
      d500bc.Tare := d500bc.Weight;
    end;
end;

procedure TMainForm.sdClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  xml : String;
begin
  xml := '<SlClient>' +
            '<base>' + uGlobals.sdBase + '</base>' +
            '<tag>' + uGlobals.sdTag + '</tag>';

  if sdStartStop then xml := xml + '<cmd>START</cmd>'
  else xml := xml + '<cmd>STOP</cmd>';

  xml := xml + '</SlClient>';
  sdClientSocket.Socket.SendText(xml);
  sdClientSocket.Active := FALSE;
end;

end.

