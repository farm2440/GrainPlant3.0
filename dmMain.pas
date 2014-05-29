unit dmMain;

interface

uses
  Windows, SysUtils, Classes, DB, ADODB, IniFiles, Registry,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, DBGrids, DBCtrls, Forms, DateUtils;

type
  TxShowMode = (smEdit, smInsert, smChoose);

  TMainData = class(TDataModule)
    ADOConnection: TADOConnection;
    tblGrains: TADOTable;
    tblSilos: TADOTable;
    dsGrains: TDataSource;
    dsSilos: TDataSource;
    dsRecipes: TDataSource;
    dsRecipeDetails: TDataSource;
    tblSilosid: TAutoIncField;
    tblSilosname: TWideStringField;
    tblSilosgrain_id: TIntegerField;
    tblSiloscapacity: TFloatField;
    tblSilosqty: TFloatField;
    tblSilosgrain: TStringField;
    tblGrainsid: TAutoIncField;
    tblGrainsname: TWideStringField;
    tblUsers: TADOTable;
    dsUsers: TDataSource;
    tblUsersid: TAutoIncField;
    tblUsersname: TWideStringField;
    tblUserspass: TWideStringField;
    tblUsersadmin: TBooleanField;
    tblUsersoperator: TWideStringField;
    tblUserssysop: TWideStringField;
    tblUserslast_login: TDateTimeField;
    tblRoutes: TADOTable;
    dsRoutes: TDataSource;
    tblRoutesid: TAutoIncField;
    tblRoutesname: TWideStringField;
    tblRouteselevator: TBooleanField;
    tblRoutesflap1: TBooleanField;
    tblRoutesflap2: TBooleanField;
    tblRoutesroulette: TIntegerField;
    tblRoutessilo: TIntegerField;
    tblSilosfine_qty: TFloatField;
    tblSilostolerance: TFloatField;
    tblSilosmax_dose_time: TIntegerField;
    tblSilossettling_time: TIntegerField;
    tblSilospreact: TIntegerField;
    tblSilosjogging_on_time: TIntegerField;
    tblSilosjogging_off_time: TIntegerField;
    tblRecipes: TADOTable;
    tblRecipeDetails: TADOTable;
    tblRecipesid: TAutoIncField;
    tblRecipesname: TWideStringField;
    tblRecipesqty: TFloatField;
    dsPendingOrders: TDataSource;
    spDetailedOrder: TADOStoredProc;
    dsDetailedOrder: TDataSource;
    tblRecipeDetailsrecipe_id: TIntegerField;
    tblRecipeDetailssilo_id: TIntegerField;
    tblRecipeDetailsqty: TFloatField;
    tblRecipeDetailsstp: TIntegerField;
    tblRecipeDetailssilo: TStringField;
    tblRecipeswater_flow: TFloatField;
    tblRecipeswater_qty: TFloatField;
    tblRecipesoil_flow: TFloatField;
    tblRecipesoil_qty: TFloatField;
    tblRecipeswater_time: TFloatField;
    tblRecipesoil_time: TFloatField;
    tblSilosnr: TIntegerField;
    tblRecipeDetailsgrain: TStringField;
    tblRecipesliquids_start_step: TIntegerField;
    tblRecipesmixer_start_step: TIntegerField;
    tblRecipesdischarge_after: TIntegerField;
    spSiloPeriodCons: TADOStoredProc;
    dsSiloConsPivot: TDataSource;
    spSiloPeriodConssilo_name: TWideStringField;
    spSiloPeriodConssum_qty: TFloatField;
    spSiloPeriodConsuses: TIntegerField;
    spSiloPeriodConswhen: TWideStringField;
    spProdPeriod: TADOStoredProc;
    dsProdPivot: TDataSource;
    spProdPeriodwhen: TWideStringField;
    spProdPeriodname: TWideStringField;
    spProdPeriodsum_qty: TFloatField;
    tblSiloConsPivot: TADOQuery;
    tblProdPivot: TADOQuery;
    spLog: TADOStoredProc;
    tblPendingOrders: TADOQuery;
    tblPendingOrdersid: TAutoIncField;
    tblPendingOrdersnr: TIntegerField;
    tblPendingOrderstime_entered: TDateTimeField;
    tblPendingOrderstime_done: TDateTimeField;
    tblPendingOrdersrecipe_id: TIntegerField;
    tblPendingOrdersqty_req: TIntegerField;
    tblPendingOrdersqty_done: TIntegerField;
    tblPendingOrdersfinished: TBooleanField;
    tblPendingOrdersinvalid: TBooleanField;
    tblPendingOrdersrecipe_name: TStringField;
    tblPendingOrdersrecipe_qty: TIntegerField;
    qFinishedOrders: TADOQuery;
    qFinishedOrdersSiloCons: TADOQuery;
    dsFinishedOrders: TDataSource;
    dsFinishedOrdersSiloCons: TDataSource;
    qFinishedOrdersid: TAutoIncField;
    qFinishedOrdersnr: TIntegerField;
    qFinishedOrderstime_entered: TDateTimeField;
    qFinishedOrderstime_done: TDateTimeField;
    qFinishedOrdersrecipe_id: TIntegerField;
    qFinishedOrdersqty_req: TIntegerField;
    qFinishedOrdersqty_done: TIntegerField;
    qFinishedOrdersfinished: TBooleanField;
    qFinishedOrdersinvalid: TBooleanField;
    qFinishedOrdersrecipe_name: TWideStringField;
    qFinishedOrdersSiloConsid: TAutoIncField;
    qFinishedOrdersSiloConswhen: TDateTimeField;
    qFinishedOrdersSiloConsorder_id: TIntegerField;
    qFinishedOrdersSiloConssilo_id: TIntegerField;
    qFinishedOrdersSiloConsqty: TIntegerField;
    qFinishedOrdersSiloConsuser_id: TIntegerField;
    qFinishedOrdersSiloConssilo_name: TWideStringField;
    qFinishedOrdersAnnul: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure tblRoutesAfterScroll(DataSet: TDataSet);
    procedure tblRecipeDetailsAfterInsert(DataSet: TDataSet);
    procedure tblRecipesCalcFields(DataSet: TDataSet);
    procedure tblRecipesAfterInsert(DataSet: TDataSet);

    procedure tblAfterPost(DataSet: TDataSet);
    procedure tblRecipeDetailsAfterPost(DataSet: TDataSet);
    procedure tblRecipesAfterPost(DataSet: TDataSet);
    procedure qFinishedOrdersAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddDoneQty(OrderID: integer; Qty: integer);
    procedure AddSiloQty(OrderID: integer; SiloID: integer; Qty: integer);
    procedure FinishOrder(OrderID: integer);
    procedure SetRecipeQty(RecipeID: integer);
    procedure CreateSiloConsPivot;
    procedure CreateProdPivot;
  end;

var
  MainData: TMainData;
  UserID    : integer;
  UserName  : string;
  UserSysOp : boolean;
  UserAdmin : boolean;
  UserHidden: boolean;
  UserAcc   : integer;

const
  clActive      = $00DDEEDD;
  clNormal      = $00EEEEEE;

  clPanelActive = $00CCDDCC;
  clPanelNormal = $00DDDDDD;

  IniFileName   = '.\grain.ini';
  OwnerDataFile = '.\owndata.ini';
  RootKey       = HKEY_LOCAL_MACHINE;
  KeyPath       = '\Software\STIV\Grain\';
  DatabaseName  = 'grain.mdb';

const
  clDisabled = $00CCCCCC;
  clEnabled  = $00EEEEEE;
  clError    = $00CCCCEE;
  clEdit     = $00CCEECC;


// Преобразува TDateTime в стринг ПРИЕМЛИВ за Access
function ADODateTimeValueStr( DT: TDateTime ): String;


function ReplaceInvalidChars(s: string): string;

procedure FieldToStrings( Data: TDataSet; FieldName: string; List: TStrings; Append: boolean );
procedure DistinctFieldToStrings( TableName: string; FieldName: string; List: TStrings; NoMatterItem: boolean );

procedure FieldsToCombo   ( FieldName : string;  Data : TADOQuery; var Combo : TComboBox );
procedure FieldsToListBox ( FieldName : string;  Data : TADOQuery; var List  : TListBox );
procedure FieldsToListView( FieldName : string;  Data : TADOQuery; var List  : TListView );
procedure OnEnterEvent    ( Sender : TObject; var PrevActive : TComponent );
function  NumToStr        ( num : integer ) : string;

procedure SaveTableStatus( KeyName : string; var Table : TDBGrid ); far;
procedure LoadTableStatus( KeyName : string; var Table : TDBGrid ); far;
procedure SaveFormStatus( var Form : TForm ); far;
procedure LoadFormStatus( var Form : TForm ); far;
procedure SaveListViewStatus( var List : TListView ); far;
procedure LoadListViewStatus( var List : TListView ); far;

implementation

{$R *.dfm}

procedure TMainData.DataModuleCreate(Sender: TObject);
var IniFile  : TIniFile;
    DataPath : string;
begin
  IniFile := TIniFile.Create( IniFileName );

  DataPath := IniFile.ReadString( 'Data', 'DataPath', '.\' );

  IniFile.Free;

  if ADOConnection.Connected then ADOConnection.Close;

  ADOConnection.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;' +
    'Data Source=' + DataPath + DatabaseName + ';'+
//    'Jet OLEDB:Database Password=xwyt;'+
    'Mode=ReadWrite|Share Deny None;Persist Security Info=False';

  try
    ADOConnection.Open;

    { Open grains table }
    tblGrains.Open;
    tblGrains.Sort := 'name ASC';

    { Open silos table }
    tblSilos.Open;
    tblSilos.Sort := 'nr ASC';

    { Open recipes master-table }
    tblRecipes.Open;
    tblRecipes.Sort := 'name ASC';

    { Open recipes details-table }
    tblRecipeDetails.Open;
    tblRecipeDetails.Sort := 'recipe_id, step ASC';

    { Open orders table }
{
    tblOrders.Open;
    tblOrders.Sort := 'id ASC';
}
    tblPendingOrders.Open;

    { Open routes table }
    tblRoutes.Open;
    tblRoutes.Sort := 'name ASC';

(********************************************)
//    Self.AddDoneQty(111, 10);
(********************************************)

  except
    on exception do
      MessageDlg( 'Cannot open database!', mtError, [mbOK], 0 );
  end;

end;

procedure TMainData.DataModuleDestroy(Sender: TObject);
begin
{
  tblOrders.Close;
}  
  tblRecipeDetails.Close;
  tblRecipes.Close;
  tblSilos.Close;
  tblGrains.Close;
  tblRoutes.Close;

  tblPendingOrders.Close;

  ADOConnection.Close;
end;

function ReplaceInvalidChars(s: string): string;
var i: integer;
begin
  Result := '';
  for i:=1 to Length(s) do
    case s[i] of
      '.' : Result := Result + '_';
      '!' : Result := Result + '|';
      '[' : Result := Result + '(';
      ']' : Result := Result + ')';
      else Result := Result + s[i];
    end;
{
    if s[i] in ['''', '!', '[', ']'] then
      Result := Result + '_'
    else
      Result := Result + s[i];
}
end;

procedure FieldToStrings( Data: TDataSet; FieldName: string; List: TStrings; Append: boolean );
begin
  if not Append then List.Clear;
  Data.First;
  while not Data.Eof do
    begin
      List.Add( Data.FieldByName( FieldName ).AsString );
      Data.Next;
    end;
end;

procedure DistinctFieldToStrings( TableName: string; FieldName: string; List: TStrings; NoMatterItem: boolean );
var q: TADOQuery;
begin
  q := TADOQuery.Create( MainData );
  q.Connection := MainData.ADOConnection;

  q.SQL.SetText(
    PChar(
      Format( 'select distinct([%s]) from [%s]', [FieldName, TableName] )
    )
  );

  q.Open;

  List.Clear;
  if NoMatterItem then List.Add( '::без значение::' );
  FieldToStrings( q, FieldName, List, true );

  q.Close;

  q.Free;
end;

procedure FieldsToCombo;
begin
  Combo.Clear;

  Data.First;
  while not Data.Eof do
    begin
      Combo.Items.Add( Data.FieldByName( FieldName ).AsString );
      Data.Next;
    end;

  Data.First;
  Combo.Text := '';
//  Combo.ItemIndex := -1;
end;

procedure FieldsToListBox;
begin
  List.Clear;

  Data.First;
  while not Data.Eof do
    begin
      List.Items.Add( Data.FieldByName( FieldName ).AsString );
      Data.Next;
    end;

  Data.First;
//  List.ItemIndex := -1;
end;

procedure FieldsToListView;
var Item : TListItem;
begin
  List.Clear;

  Data.First;
  while not Data.Eof do
    begin
      Item := List.Items.Add;
      Item.Caption := Data.FieldByName( FieldName ).AsString;
      Data.Next;
    end;

  Data.First;
//  List.ItemIndex := 0;
end;

procedure OnEnterEvent( Sender : TObject; var PrevActive : TComponent );
begin
  if Assigned( PrevActive ) then
    if PrevActive is TComboBox then
      with PrevActive as TComboBox do Color := clNormal else
    if PrevActive is TEdit then
      with PrevActive as TEdit do Color := clNormal else
    if PrevActive is TDBEdit then
      with PrevActive as TDBEdit do Color := clNormal else
    if PrevActive is TDateTimePicker then
      with PrevActive as TDateTimePicker do Color := clNormal else
    if PrevActive is TListView then
      with PrevActive as TListView do Color := clNormal else
    if PrevActive is TPanel then
      with PrevActive as TPanel do
        if Tag = 1 then Color := clPanelNormal else Color := clNormal;

  if TComponent( Sender ).Tag >= 1 then PrevActive := TComponent( Sender )
  else PrevActive := nil;

  if Assigned( PrevActive ) then
    if PrevActive is TComboBox then
      with PrevActive as TComboBox do Color := clActive else
    if PrevActive is TEdit then
      with PrevActive as TEdit do Color := clActive else
    if PrevActive is TDBEdit then
      with PrevActive as TDBEdit do Color := clActive else
    if PrevActive is TDateTimePicker then
      with PrevActive as TDateTimePicker do Color := clActive else
    if PrevActive is TListView then
      with PrevActive as TListView do Color := clActive else
    if PrevActive is TPanel then
      with PrevActive as TPanel do
        if Tag = 1 then Color := clPanelActive else Color := clActive;
end;

function NumToStr( num : integer ) : string;
const
  a : array[1..2, 0..10] of string = (
    ( 'нула', 'един' , 'два' , 'три'  , 'четири', 'пет',
      'шест', 'седем', 'осем', 'девет', 'десет' ),
    ( 'нула', 'една' , 'две' , 'три'  , 'четири', 'пет',
      'шест', 'седем', 'осем', 'девет', 'десет' )
  );

  b : array[1..4,1..10] of string = (
    ( 'единадесет', 'дванадесет' , 'тринадесет'  , 'четиринадесет',
      'петнадесет', 'шестнадесет', 'седемнадесет', 'осемнадесет'  , 'деветнадесет', 'двадесет' ),
    ( 'десет'     , 'двадесет'   , 'тридесет'    , 'четиридесет'  ,
      'петдесет'  , 'шестдесет'  , 'седемдесет'  , 'осемдесет'    , 'деветдесет'  , 'сто'   ),
    ( 'сто'       , 'двеста'     , 'триста'      , 'четири стотин',
      'пет стотин', 'шест стотин', 'седем стотин', 'осем стотин'  , 'девет стотин', 'хиляда' ),
    ( 'хиляда'    , 'две хиляди' , 'три хиляди'  , 'четири хиляди',
      'пет хиляди', 'шест хиляди', 'седем хиляди', 'осем хиляди'  , 'девет хиляди', 'десет хиляди' )
  );
var
  i, j : integer;
  r    : string;
begin
  j := num;
  i := num;
  r := '';

  i := i mod 100;
  if i > 0 then begin
    if i < 10  then
      if j > 100 then r := 'и ' + a[1,i]
      else r := a[1,i]
    else
    if i < 20  then
      if j > 100 then r := 'и ' + b[1, i mod 10]
      else r := b[1, i mod 10]
    else
    if i < 100 then
      if i mod 10 <> 0 then
        r := b[2, ( i div 10 ) mod 10] + ' и ' + a[1, i mod 10 ]
      else
        if j > 100 then r := 'и ' + b[2, ( i div 10 ) mod 10]
        else r := b[2, ( i div 10 ) mod 10];
  end;

  if ( j div 100 ) mod 10 > 0 then
    r := b[3, ( j div 100 ) mod 10] + ' ' + r;

  i := ( j div 1000 ) mod 100;
  if i > 0 then begin
    if i < 10  then r := b[4, i] + ' ' + r else
    if i < 20  then r := b[1, i mod 10] + ' хиляди ' + r else
    if i < 100 then
      if i mod 10 <> 0 then
        r := b[2, ( i div 10 ) mod 10] + ' и ' + a[2, i mod 10 ] + ' хиляди ' + r
      else
        r := b[2, ( i div 10 ) mod 10] + ' хиляди ' + r;
  end
  else
    if j > 100000 then r := ' хиляди ' + r;

  if ( j div 100000 ) mod 10 > 0 then
    r := b[3, ( j div 100 ) mod 10] + ' и ' + r;

  Result := r;
end;

procedure SaveTableStatus( KeyName : string; var Table : TDBGrid ); far;
var Reg    : TRegistry;
    Widths : array[ 0..63 ] of integer;
    Status : array[ 0..63 ] of boolean;
    i      : byte;
begin
  Reg := TRegistry.Create;

  try
    Reg.RootKey := RootKey;
    Reg.OpenKey( KeyPath + KeyName, True );

    FillChar( Widths, SizeOf( Widths ), 0 );
    FillChar( Status, SizeOf( Status ), 0 );

    for i := 0 to Table.Columns.Count - 1 do
      begin
        Widths[i] := Table.Columns[i].Width;
        Status[i] := Table.Columns[i].Color <> clDisabled;
      end;

    Reg.WriteBinaryData( 'WID', Widths, SizeOf( Widths ) );
    Reg.WriteBinaryData( 'STA', Status, SizeOf( Status ) );

  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

procedure LoadTableStatus( KeyName : string; var Table : TDBGrid ); far;
var i      : integer;
    Reg    : TRegistry;
    Widths : array[ 0..63 ] of integer;
    Status : array[ 0..63 ] of boolean;
begin
  Reg := TRegistry.Create;

  try
    Reg.RootKey := RootKey;
    if Reg.KeyExists( KeyPath ) then
      begin
        Reg.OpenKey( KeyPath + KeyName, True );

        for i := 0 to Table.Columns.Count - 1 do begin
          Widths[i] := Table.Columns[i].Width;
          Status[i] := True;
        end;

        Reg.ReadBinaryData( 'WID', Widths, SizeOf( Widths ) );
        Reg.ReadBinaryData( 'STA', Status, SizeOf( Status ) );

        for i := 0 to Table.Columns.Count - 1 do
          begin
//            Table.Columns[i].Width := Widths[i];
            if Status[i] then Table.Columns[i].Color := clEnabled
            else Table.Columns[i].Color := clDisabled;
          end;
      end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

procedure SaveFormStatus( var Form : TForm );
var reg: TRegistry;
begin
  reg := TRegistry.Create;

  reg.RootKey := RootKey;
  reg.OpenKey( KeyPath + Form.Name, True );

  reg.WriteInteger( 'Left',   Form.Left );
  reg.WriteInteger( 'Top',    Form.Top );
  reg.WriteInteger( 'Width',  Form.Width );
  reg.WriteInteger( 'Height', Form.Height );
  reg.WriteInteger( 'WindowState', integer( Form.WindowState ) );

  reg.Free;
end;

procedure LoadFormStatus( var Form : TForm );
var reg: TRegistry;
begin
  reg := TRegistry.Create;

  reg.RootKey := RootKey;
  if reg.OpenKey( KeyPath + Form.Name, False ) then
    begin
      if reg.ValueExists( 'Left'        ) then
        Form.Left := reg.ReadInteger( 'Left' );
      if reg.ValueExists( 'Top'         ) then
        Form.Top := reg.ReadInteger( 'Top' );
      if reg.ValueExists( 'Width'       ) then
        Form.Width := reg.ReadInteger( 'Width' );
      if reg.ValueExists( 'Height'      ) then
        Form.Height := reg.ReadInteger( 'Height' );
      if reg.ValueExists( 'WindowState' ) then
        Form.WindowState := TWindowState( reg.ReadInteger( 'WindowState' ) );

      Form.Repaint;
    end;

  reg.Free;
end;

procedure SaveListViewStatus( var List : TListView );
var reg: TRegistry;
    i  : integer;
begin
  reg := TRegistry.Create;

  reg.RootKey := RootKey;

  for i := 0 to List.Columns.Count-1 do
    begin
      reg.OpenKey( KeyPath + List.Name + '\' + List.Columns[i].Caption, True );
      reg.WriteInteger( 'Width', List.Columns[i].Width );
      reg.WriteBool( 'Enabled', List.Columns[i].ImageIndex = -1 );
    end;

  reg.Free;
end;

procedure LoadListViewStatus( var List : TListView );
var reg: TRegistry;
    i  : integer;
begin
  reg := TRegistry.Create;

  reg.RootKey := RootKey;
{
  List.Enabled := False;
  List.Visible := False;
}
  for i := 0 to List.Columns.Count-1 do
    if reg.OpenKey( KeyPath + List.Name + '\' + List.Columns[i].Caption, False ) then begin
      if reg.ValueExists( 'Width' ) then
        List.Columns[i].Width := reg.ReadInteger( 'Width' );
      if reg.ValueExists( 'Enabled' ) then
        if reg.ReadBool( 'Enabled' ) then
          List.Columns[i].ImageIndex := -1
        else
          List.Columns[i].ImageIndex := 2;
    end;
{
  List.Enabled := True;
  List.Visible := True;
}
  reg.Free;
end;

procedure TMainData.tblRoutesAfterScroll(DataSet: TDataSet);
begin
//
end;

procedure TMainData.tblRecipeDetailsAfterInsert(DataSet: TDataSet);
var q: TADOQuery;
    step: integer;
begin
  if tblRecipeDetails.State = dsInsert then begin
    q := TADOQuery.Create(Self);

    q.Connection := MainData.ADOConnection;
    q.SQL.Text := 'SELECT MAX(step) AS max_step FROM recipe_details WHERE recipe_id = :recipe_id';
    q.Parameters.ParamByName( 'recipe_id' ).Value :=
      tblRecipes.FieldByName( 'id' ).Value;

    try
      q.Open;

      if q.IsEmpty then step := 1
      else step := q.FieldByName( 'max_step' ).AsInteger + 1;

      tblRecipeDetails.FieldByName( 'step' ).AsInteger := step;

      q.Close;
    except
      on Exception do;
    end;

    q.Free;
  end;
end;

procedure TMainData.tblRecipesCalcFields(DataSet: TDataSet);
begin
  if tblRecipeswater_flow.AsFloat <> 0 then
    tblRecipeswater_time.AsFloat := tblRecipeswater_qty.AsFloat / tblRecipeswater_flow.AsFloat
  else
    tblRecipeswater_time.AsFloat := 0;

  if tblRecipesoil_flow.AsFloat <> 0 then
    tblRecipesoil_time.AsFloat := tblRecipesoil_qty.AsFloat / tblRecipesoil_flow.AsFloat
  else
    tblRecipesoil_time.AsFloat := 0;
end;

procedure TMainData.tblRecipesAfterInsert(DataSet: TDataSet);
begin
{
  tblRecipeswater_flow.AsFloat := 1;
  tblRecipeswater_qty.AsFloat := 1;
  tblRecipesoil_flow.AsFloat := 1;
  tblRecipesoil_qty.AsFloat := 1;
}
{
  tblRecipes.FieldByName( 'water_flow' ).AsFloat := 1;
  tblRecipes.FieldByName( 'water_qty'  ).AsFloat := 1;
  tblRecipes.FieldByName( 'oil_flow'   ).AsFloat := 1;
  tblRecipes.FieldByName( 'oil_qty'    ).AsFloat := 1;
}
end;

procedure TMainData.tblAfterPost(DataSet: TDataSet);
begin
  DataSet.Refresh;
end;

procedure TMainData.tblRecipeDetailsAfterPost(DataSet: TDataSet);
begin
//  DataSet.Refresh;
  SetRecipeQty( tblRecipes.FieldByName('id').AsInteger );
end;

procedure TMainData.AddDoneQty(OrderID: integer; Qty: integer);
begin
  if tblPendingOrders.Locate('id', OrderID, []) then
    begin
      tblPendingOrders.Edit;
      tblPendingOrders.FieldByName('qty_done').AsInteger :=
        tblPendingOrders.FieldByName('qty_done').AsInteger + Qty;
      tblPendingOrders.Post;
    end;
end;

procedure TMainData.AddSiloQty(OrderID: integer; SiloID: integer; Qty: integer);
var q: TADOQuery;
begin
  q := TADOQuery.Create( Self );
  q.Connection := Self.ADOConnection;

  try
    q.SQL.Text := 'INSERT INTO silo_cons ' +
                  '  ([when], [order_id], [silo_id], [qty], [user_id]) ' +
                  'VALUES ' +
                  '  (:when, :order_id, :silo_id, :qty, :user_id)';

    q.Parameters.ParamByName( 'when'     ).Value := Now;
    q.Parameters.ParamByName( 'order_id' ).Value := OrderID;
    q.Parameters.ParamByName( 'silo_id'  ).Value := SiloID;
    q.Parameters.ParamByName( 'qty'      ).Value := Qty;
    q.Parameters.ParamByName( 'user_id'  ).Value := 0;

    try
      q.ExecSQL;
    except
      on Exception do ;
    end;

  except
    on Exception do ;
  end;

  q.Free;
end;

procedure TMainData.FinishOrder(OrderID: integer);
var q: TADOQuery;
    doc_nr: integer;
begin
  if not tblPendingOrders.Locate('id', OrderID, []) then Exit;

  q := TADOQuery.Create(Self);
  q.Connection := Self.ADOConnection;
  q.SQL.Text := 'SELECT MAX(orders.nr) AS last_nr ' +
                'FROM orders ' +
                'WHERE orders.finished = True';

  try
    q.Open;
    doc_nr := q.FieldByName('last_nr').AsInteger + 1;
  except
    on Exception do doc_nr := -1;
  end;

  q.Free;

  tblPendingOrders.Edit;
  tblPendingOrders.FieldByName('finished').AsBoolean := True;
  tblPendingOrders.FieldByName('time_done').AsDateTime := Now;
  tblPendingOrders.FieldByName('nr').AsInteger := doc_nr;
  tblPendingOrders.Post;

  tblPendingOrders.Requery;
end;

procedure TMainData.SetRecipeQty(RecipeID: integer);
var q: TADOQuery;
    sum: double;
begin
  if tblRecipes.Tag <> 0 then Exit;

  {Lock table}
  tblRecipes.Tag := 1;

  q := TADOQuery.Create(Self);
  q.Connection := Self.ADOConnection;

  try
    q.SQL.Text := 'SELECT SUM(qty) AS sum_qty ' +
                  'FROM recipe_details ' +
                  'WHERE recipe_id = :recipe_id ';

    q.Parameters.ParamByName('recipe_id').Value := RecipeID;

    q.Open;

    if not q.IsEmpty then
      sum := q.FieldByName( 'sum_qty' ).AsFloat
    else
      sum := 0;

    if tblRecipes.Locate('id', RecipeID, []) then
      begin
        tblRecipes.Edit;

        tblRecipes.FieldByName('qty').AsFloat :=
          sum +
          tblRecipes.FieldByName('water_qty').AsFloat +
          tblRecipes.FieldByName('oil_qty').AsFloat;

        tblRecipes.Post;
      end;

    q.Close;
  except
    on Exception do ;
  end;

  q.Free;

  {Unlock table}
  tblRecipes.Tag := 0;
end;

procedure TMainData.tblRecipesAfterPost(DataSet: TDataSet);
begin
  DataSet.Refresh;
  SetRecipeQty( tblRecipes.FieldByName('id').AsInteger );
end;

procedure TMainData.CreateSiloConsPivot;
var i: integer;
    q: TADOQuery;
    s: string;
begin
  tblSiloConsPivot.Close;

  q := TADOQuery.Create(Self);
  q.Connection := Self.ADOConnection;

  try
    { drop the "silo_cons_pivot" table if exists }
    q.SQL.Text := 'DROP TABLE silo_cons_pivot';
    q.ExecSQL;
  except
    on Exception do;
  end;

  try
    { get the names of the silos, used during the specified period }
    q.SQL.Text := 'SELECT DISTINCT silos.[name] ' +
                  'FROM silo_cons INNER JOIN silos ON silos.[id] = silo_cons.[silo_id] ' +
                  'WHERE silo_cons.[when] BETWEEN :from_date AND :to_date ' +
                  'ORDER BY silos.[name]';

    q.Parameters.ParamByName('from_date').Value :=
      StartOfTheDay(spSiloPeriodCons.Parameters.ParamByName('from_date').Value);

    q.Parameters.ParamByName('to_date').Value :=
      EndOfTheDay(spSiloPeriodCons.Parameters.ParamByName('to_date').Value);

    q.Open;

    s := '';
    while not q.Eof do begin
      s := s + Format(', [%s] INTEGER', [ReplaceInvalidChars(q.FieldByName('name').AsString)]);
      q.Next;
    end;

    q.Close;

    { and create a new "silo_cons_pivot" table }
    q.SQL.Text := 'CREATE TABLE silo_cons_pivot ( ' +
                  '  [when] VARCHAR(20) ' +
                  s +
                  ')'
                  ;

    q.ExecSQL;

    { open it }
    tblSiloConsPivot.Open;

    { now fill the pivot }
    spSiloPeriodCons.First;

    s := '';
    while not spSiloPeriodCons.Eof do begin
      if s <> spSiloPeriodCons.FieldByName('when').AsString then
        begin
          s := spSiloPeriodCons.FieldByName('when').AsString;
          tblSiloConsPivot.Insert;
          tblSiloConsPivot.FieldByName('when').AsString := s
        end
      else
        tblSiloConsPivot.Edit;

      tblSiloConsPivot.FieldByName(ReplaceInvalidChars(spSiloPeriodCons.FieldByName('silo_name').AsString)).Value :=
        spSiloPeriodCons.FieldByName('sum_qty').AsInteger;
      tblSiloConsPivot.Post;

      spSiloPeriodCons.Next;
    end;

    tblSiloConsPivot.FieldByName('when').DisplayLabel := 'Дата';

    for i:=1 to tblSiloConsPivot.FieldCount-1 do
      TFloatField( tblSiloConsPivot.Fields[i] ).DisplayFormat := '0 kg';

  except
    on exception do;
  end;

  q.Free;
end;

procedure TMainData.CreateProdPivot;
var i: integer;
    q: TADOQuery;
    s: string;
begin
  tblProdPivot.Close;

  q := TADOQuery.Create(Self);
  q.Connection := Self.ADOConnection;

  try
    { drop the "prod_pivot" table if exists }
    q.SQL.Text := 'DROP TABLE prod_pivot';
    q.ExecSQL;
  except
    on Exception do;
  end;

  try
    { get the names of the recipes, used during the specified period }
    q.SQL.Text :=
               'SELECT DISTINCT recipes.[name] ' +
               'FROM recipes INNER JOIN orders  ' +
               '     ON recipes.[id] = orders.[recipe_id] ' +
               'WHERE (orders.[finished] = true) AND ' +
               '      (orders.[time_done] BETWEEN :from_date AND :to_date) ' +
               'ORDER BY recipes.[name] ';

    q.Parameters.ParamByName('from_date').Value :=
      StartOfTheDay(spProdPeriod.Parameters.ParamByName('from_date').Value);

    q.Parameters.ParamByName('to_date').Value :=
      EndOfTheDay(spProdPeriod.Parameters.ParamByName('to_date').Value);

    q.Open;

    s := '';
    while not q.Eof do begin
      s := s + Format(', [%s] INTEGER', [ReplaceInvalidChars(q.FieldByName('name').AsString)]);
      q.Next;
    end;

    q.Close;

    { and create a new "prod_pivot" table }
    q.SQL.Text := 'CREATE TABLE prod_pivot ( ' +
                  '  [when] VARCHAR(20) ' +
                  s +
                  ')'
                  ;

    q.ExecSQL;

    { open it }
    tblProdPivot.Open;

    { now fill the pivot }
    spProdPeriod.First;

    s := '';
    while not spProdPeriod.Eof do begin
      if s <> spProdPeriod.FieldByName('when').AsString then
        begin
          s := spProdPeriod.FieldByName('when').AsString;
          tblProdPivot.Insert;
          tblProdPivot.FieldByName('when').AsString := s
        end
      else
        tblProdPivot.Edit;

      tblProdPivot.FieldByName(ReplaceInvalidChars(spProdPeriod.FieldByName('name').AsString)).Value :=
        spProdPeriod.FieldByName('sum_qty').AsInteger;
      tblProdPivot.Post;

      spProdPeriod.Next;
    end;

    tblProdPivot.FieldByName('when').DisplayLabel := 'Дата';

    for i:=1 to tblProdPivot.FieldCount-1 do
      TFloatField( tblProdPivot.Fields[i] ).DisplayFormat := '0 kg';

  except
    on exception do;
  end;

  q.Free;
end;

procedure TMainData.qFinishedOrdersAfterScroll(DataSet: TDataSet);
begin
  qFinishedOrdersSiloCons.Close;


  qFinishedOrdersSiloCons.Parameters.ParamByName('order_id').Value :=
    qFinishedOrders.FieldByName('id').Value;

{
  with qFinishedOrdersSiloCons.Parameters do begin
    Clear;

    CreateParameter('order_id', ftInteger, pdInput, 0, qFinishedOrders.FieldByName('id').AsInteger);
  end;
}
  try
    qFinishedOrdersSiloCons.Open;
  except
    on Exception do;
  end;
end;


// Преобразува TDateTime в стринг ПРИЕМЛИВ за Access
function ADODateTimeValueStr( DT: TDateTime ): String;
var
  fmt: String;
begin
  fmt := 'dd' + DateSeparator +
         'mm' + DateSeparator +
         'yyyy ' +
         'hh' + TimeSeparator +
         'nn' + TimeSeparator +
         'ss';
  Result := FormatDateTime( fmt, DT );
end;

end.
