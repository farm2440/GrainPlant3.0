object MainData: TMainData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 172
  Top = 232
  Height = 580
  Width = 771
  object ADOConnection: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=.\gra' +
      'in.mdb;Mode=Share Deny None;Extended Properties="";Persist Secur' +
      'ity Info=False;Jet OLEDB:System database="";Jet OLEDB:Registry P' +
      'ath="";Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=5;Je' +
      't OLEDB:Database Locking Mode=1;Jet OLEDB:Global Partial Bulk Op' +
      's=2;Jet OLEDB:Global Bulk Transactions=1;Jet OLEDB:New Database ' +
      'Password="";Jet OLEDB:Create System Database=False;Jet OLEDB:Enc' +
      'rypt Database=False;Jet OLEDB:Don'#39't Copy Locale on Compact=False' +
      ';Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=Fa' +
      'lse'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 40
    Top = 16
  end
  object tblGrains: TADOTable
    Connection = ADOConnection
    CursorType = ctStatic
    AfterPost = tblAfterPost
    TableName = 'grains'
    Left = 40
    Top = 96
    object tblGrainsid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object tblGrainsname: TWideStringField
      DisplayLabel = #1057#1091#1088#1086#1074#1080#1085#1072
      FieldName = 'name'
      Size = 50
    end
  end
  object tblSilos: TADOTable
    Connection = ADOConnection
    CursorType = ctStatic
    AfterPost = tblAfterPost
    TableName = 'silos'
    Left = 40
    Top = 152
    object tblSilosid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object tblSilosnr: TIntegerField
      DisplayLabel = #8470
      FieldName = 'nr'
    end
    object tblSilosname: TWideStringField
      DisplayLabel = #1057#1080#1083#1086#1079
      FieldName = 'name'
      Size = 50
    end
    object tblSilosgrain: TStringField
      DisplayLabel = #1057#1091#1088#1086#1074#1080#1085#1072
      FieldKind = fkLookup
      FieldName = 'grain'
      LookupDataSet = tblGrains
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'grain_id'
      Lookup = True
    end
    object tblSilosgrain_id: TIntegerField
      FieldName = 'grain_id'
    end
    object tblSiloscapacity: TFloatField
      DisplayLabel = #1050#1072#1087#1072#1094#1080#1090#1077#1090
      FieldName = 'capacity'
      DisplayFormat = '0 kg'
      EditFormat = '0'
    end
    object tblSilosqty: TFloatField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
      FieldName = 'qty'
      DisplayFormat = '0 kg'
      EditFormat = '0'
    end
    object tblSilosfine_qty: TFloatField
      DisplayLabel = #1060#1080#1085#1086' '#1082#1086#1083'.'
      FieldName = 'fine_qty'
      DisplayFormat = '0 kg'
      EditFormat = '0'
    end
    object tblSilostolerance: TFloatField
      DisplayLabel = #1058#1086#1083#1077#1088#1072#1085#1089
      FieldName = 'tolerance'
      DisplayFormat = '0 kg'
      EditFormat = '0'
    end
    object tblSilosmax_dose_time: TIntegerField
      DisplayLabel = #1052#1072#1082#1089'. '#1074#1088#1077#1084#1077' '#1079#1072' '#1076#1086#1079#1080#1088#1072#1085#1077
      FieldName = 'max_dose_time'
      DisplayFormat = '0 sec'
      EditFormat = '0'
    end
    object tblSilossettling_time: TIntegerField
      DisplayLabel = #1042#1088#1077#1084#1077' '#1079#1072' '#1091#1089#1090#1072#1085#1086#1074#1103#1074#1072#1085#1077
      FieldName = 'settling_time'
      DisplayFormat = '0 sec'
      EditFormat = '0'
    end
    object tblSilospreact: TIntegerField
      DisplayLabel = #1055#1088#1077#1076#1074#1072#1088#1077#1085#1080#1077
      FieldName = 'preact'
      DisplayFormat = '0 kg'
      EditFormat = '0'
    end
    object tblSilosjogging_on_time: TIntegerField
      DisplayLabel = 'Jog '#1074#1082#1083'.'
      FieldName = 'jogging_on_time'
      DisplayFormat = '0 sec'
      EditFormat = '0'
    end
    object tblSilosjogging_off_time: TIntegerField
      DisplayLabel = 'Jog '#1080#1079#1082#1083'.'
      FieldName = 'jogging_off_time'
      DisplayFormat = '0 sec'
      EditFormat = '0'
    end
  end
  object dsGrains: TDataSource
    DataSet = tblGrains
    Left = 136
    Top = 96
  end
  object dsSilos: TDataSource
    DataSet = tblSilos
    Left = 136
    Top = 152
  end
  object dsRecipes: TDataSource
    DataSet = tblRecipes
    Left = 136
    Top = 232
  end
  object dsRecipeDetails: TDataSource
    DataSet = tblRecipeDetails
    Left = 136
    Top = 288
  end
  object tblUsers: TADOTable
    Connection = ADOConnection
    CursorType = ctStatic
    AfterPost = tblAfterPost
    TableName = 'users'
    Left = 592
    Top = 160
    object tblUsersid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object tblUsersname: TWideStringField
      DisplayLabel = #1055#1086#1090#1088#1077#1073#1080#1090#1077#1083
      FieldName = 'name'
      Size = 50
    end
    object tblUserspass: TWideStringField
      DisplayLabel = #1055#1072#1088#1086#1083#1072
      FieldName = 'pass'
      Size = 50
    end
    object tblUsersadmin: TBooleanField
      FieldName = 'admin'
    end
    object tblUsersoperator: TWideStringField
      FieldName = 'operator'
      Size = 50
    end
    object tblUserssysop: TWideStringField
      FieldName = 'sysop'
      Size = 50
    end
    object tblUserslast_login: TDateTimeField
      DisplayLabel = #1055#1086#1089#1083#1077#1076#1085#1086' '#1074#1083#1080#1079#1072#1085#1077
      FieldName = 'last_login'
    end
  end
  object dsUsers: TDataSource
    DataSet = tblUsers
    Left = 688
    Top = 160
  end
  object tblRoutes: TADOTable
    Connection = ADOConnection
    AfterPost = tblAfterPost
    AfterScroll = tblRoutesAfterScroll
    TableName = 'routes'
    Left = 320
    Top = 88
    object tblRoutesid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
      Visible = False
    end
    object tblRoutesname: TWideStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldName = 'name'
      Size = 50
    end
    object tblRouteselevator: TBooleanField
      DisplayLabel = #1045#1083#1077#1074#1072#1090#1086#1088
      FieldName = 'elevator'
    end
    object tblRoutesflap1: TBooleanField
      DisplayLabel = #1050#1083#1072#1087#1072' 1'
      FieldName = 'flap1'
    end
    object tblRoutesflap2: TBooleanField
      DisplayLabel = #1050#1083#1072#1087#1072' 2'
      FieldName = 'flap2'
    end
    object tblRoutesroulette: TIntegerField
      DisplayLabel = #1056#1091#1083#1077#1090#1082#1072
      FieldName = 'roulette'
    end
    object tblRoutessilo: TIntegerField
      DisplayLabel = #1057#1080#1083#1086#1079
      FieldName = 'silo'
    end
  end
  object dsRoutes: TDataSource
    DataSet = tblRoutes
    Left = 416
    Top = 88
  end
  object tblRecipes: TADOTable
    Connection = ADOConnection
    CursorType = ctStatic
    AfterInsert = tblRecipesAfterInsert
    AfterPost = tblRecipesAfterPost
    OnCalcFields = tblRecipesCalcFields
    TableDirect = True
    TableName = 'recipes'
    Left = 40
    Top = 232
    object tblRecipesid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object tblRecipesname: TWideStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldName = 'name'
      Size = 50
    end
    object tblRecipeswater_flow: TFloatField
      DisplayLabel = #1044#1077#1073#1080#1090' '#1074#1086#1076#1072
      FieldName = 'water_flow'
      DisplayFormat = '0.00 l/s'
    end
    object tblRecipeswater_qty: TFloatField
      DisplayLabel = #1050#1086#1083'. '#1074#1086#1076#1072
      FieldName = 'water_qty'
      DisplayFormat = '0.0 l'
      EditFormat = '0.0'
    end
    object tblRecipesoil_flow: TFloatField
      DisplayLabel = #1044#1077#1073#1080#1090' '#1086#1083#1080#1086
      FieldName = 'oil_flow'
      DisplayFormat = '0.00 l/s'
    end
    object tblRecipesoil_qty: TFloatField
      DisplayLabel = #1050#1086#1083'. '#1086#1083#1080#1086
      FieldName = 'oil_qty'
      DisplayFormat = '0.0 l'
      EditFormat = '0.0'
    end
    object tblRecipesqty: TFloatField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
      FieldName = 'qty'
      DisplayFormat = '0.0 kg'
    end
    object tblRecipeswater_time: TFloatField
      DisplayLabel = #1042#1088#1077#1084#1077' '#1074#1086#1076#1072
      FieldKind = fkCalculated
      FieldName = 'water_time'
      DisplayFormat = '0.0 s'
      Calculated = True
    end
    object tblRecipesoil_time: TFloatField
      DisplayLabel = #1042#1088#1077#1084#1077' '#1086#1083#1080#1086
      FieldKind = fkCalculated
      FieldName = 'oil_time'
      DisplayFormat = '0.0 s'
      Calculated = True
    end
    object tblRecipesliquids_start_step: TIntegerField
      FieldName = 'liquids_start_step'
    end
    object tblRecipesmixer_start_step: TIntegerField
      FieldName = 'mixer_start_step'
    end
    object tblRecipesdischarge_after: TIntegerField
      DisplayLabel = #1056#1072#1079#1090#1086#1074#1072#1088#1074#1072#1085#1077' '#1089#1083#1077#1076
      FieldName = 'discharge_after'
      DisplayFormat = '0 s'
    end
  end
  object tblRecipeDetails: TADOTable
    Connection = ADOConnection
    CursorType = ctStatic
    AfterInsert = tblRecipeDetailsAfterInsert
    AfterPost = tblRecipeDetailsAfterPost
    IndexFieldNames = 'recipe_id'
    MasterFields = 'id'
    MasterSource = dsRecipes
    TableDirect = True
    TableName = 'recipe_details'
    Left = 40
    Top = 288
    object tblRecipeDetailsrecipe_id: TIntegerField
      FieldName = 'recipe_id'
    end
    object tblRecipeDetailsstp: TIntegerField
      DisplayLabel = #1057#1090#1098#1087#1082#1072
      FieldName = 'step'
    end
    object tblRecipeDetailssilo_id: TIntegerField
      FieldName = 'silo_id'
    end
    object tblRecipeDetailssilo: TStringField
      DisplayLabel = #1057#1080#1083#1086#1079
      FieldKind = fkLookup
      FieldName = 'silo'
      LookupDataSet = tblSilos
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'silo_id'
      Lookup = True
    end
    object tblRecipeDetailsgrain: TStringField
      DisplayLabel = #1057#1091#1088#1086#1074#1080#1085#1072
      FieldKind = fkLookup
      FieldName = 'grain'
      LookupDataSet = tblSilos
      LookupKeyFields = 'id'
      LookupResultField = 'grain'
      KeyFields = 'silo_id'
      ReadOnly = True
      Lookup = True
    end
    object tblRecipeDetailsqty: TFloatField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
      FieldName = 'qty'
      DisplayFormat = '0 kg'
      EditFormat = '0'
    end
  end
  object dsPendingOrders: TDataSource
    DataSet = tblPendingOrders
    Left = 688
    Top = 336
  end
  object spDetailedOrder: TADOStoredProc
    Connection = ADOConnection
    CursorType = ctStatic
    ProcedureName = 'qry_detailed_order'
    Parameters = <
      item
        Name = 'doc_nr'
        DataType = ftInteger
        Value = Null
      end
      item
        Name = 'doc_sub_nr'
        DataType = ftInteger
        Value = Null
      end>
    Left = 40
    Top = 488
  end
  object dsDetailedOrder: TDataSource
    DataSet = spDetailedOrder
    Left = 136
    Top = 488
  end
  object spSiloPeriodCons: TADOStoredProc
    Connection = ADOConnection
    CursorType = ctStatic
    ProcedureName = 'qry_silo_period'
    Parameters = <
      item
        Name = 'date_format'
        DataType = ftString
        Size = 10
        Value = 'dd/mm/yyyy'
      end
      item
        Name = 'from_date'
        DataType = ftDateTime
        Value = 38718d
      end
      item
        Name = 'to_date'
        DataType = ftDateTime
        Value = 39082d
      end>
    Left = 288
    Top = 320
    object spSiloPeriodConswhen: TWideStringField
      DisplayLabel = #1044#1072#1090#1072
      FieldName = 'when'
      Size = 255
    end
    object spSiloPeriodConssilo_name: TWideStringField
      DisplayLabel = #1057#1080#1083#1086#1079
      FieldName = 'silo_name'
      Size = 50
    end
    object spSiloPeriodConssum_qty: TFloatField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
      FieldName = 'sum_qty'
    end
    object spSiloPeriodConsuses: TIntegerField
      FieldName = 'uses'
    end
  end
  object dsSiloConsPivot: TDataSource
    AutoEdit = False
    DataSet = tblSiloConsPivot
    Left = 448
    Top = 320
  end
  object spProdPeriod: TADOStoredProc
    Connection = ADOConnection
    CursorType = ctStatic
    ProcedureName = 'qry_prod_period'
    Parameters = <
      item
        Name = 'date_format'
        DataType = ftString
        Size = 10
        Value = 'dd mm yyyy'
      end
      item
        Name = 'from_date'
        DataType = ftDateTime
        Value = 38718d
      end
      item
        Name = 'to_date'
        DataType = ftDateTime
        Size = 8
        Value = 39083d
      end>
    Left = 288
    Top = 384
    object spProdPeriodwhen: TWideStringField
      DisplayLabel = #1044#1072#1090#1072
      FieldName = 'when'
      Size = 255
    end
    object spProdPeriodname: TWideStringField
      DisplayLabel = #1056#1077#1094#1077#1087#1090#1072
      FieldName = 'name'
      Size = 50
    end
    object spProdPeriodsum_qty: TFloatField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
      FieldName = 'sum_qty'
      DisplayFormat = '0 kg'
    end
  end
  object dsProdPivot: TDataSource
    DataSet = tblProdPivot
    Left = 440
    Top = 384
  end
  object tblSiloConsPivot: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM silo_cons_pivot')
    Left = 368
    Top = 320
  end
  object tblProdPivot: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM prod_pivot')
    Left = 368
    Top = 384
  end
  object spLog: TADOStoredProc
    Connection = ADOConnection
    ProcedureName = 'qry_log_event'
    Parameters = <
      item
        Name = 'when'
        DataType = ftDateTime
        Value = 38718d
      end
      item
        Name = 'type'
        DataType = ftInteger
        Size = 1
        Value = 0
      end
      item
        Name = 'event'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'note'
        DataType = ftString
        Size = -1
        Value = ''
      end>
    Left = 368
    Top = 480
  end
  object tblPendingOrders: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    SQL.Strings = (
      'SELECT * '
      'FROM orders'
      'WHERE (orders.finished = False) AND (orders.invalid = False)')
    Left = 592
    Top = 336
    object tblPendingOrdersid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object tblPendingOrdersnr: TIntegerField
      DisplayLabel = #8470
      FieldName = 'nr'
    end
    object tblPendingOrderstime_entered: TDateTimeField
      DisplayLabel = #1042#1087#1080#1089#1072#1085#1072' '#1085#1072
      FieldName = 'time_entered'
    end
    object tblPendingOrderstime_done: TDateTimeField
      DisplayLabel = #1048#1079#1087#1098#1083#1085#1077#1085#1072' '#1085#1072
      FieldName = 'time_done'
    end
    object tblPendingOrdersrecipe_id: TIntegerField
      FieldName = 'recipe_id'
    end
    object tblPendingOrdersrecipe_name: TStringField
      DisplayLabel = #1056#1077#1094#1077#1087#1090#1072
      FieldKind = fkLookup
      FieldName = 'recipe_name'
      LookupDataSet = tblRecipes
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'recipe_id'
      Lookup = True
    end
    object tblPendingOrdersrecipe_qty: TIntegerField
      FieldKind = fkLookup
      FieldName = 'recipe_qty'
      LookupDataSet = tblRecipes
      LookupKeyFields = 'id'
      LookupResultField = 'qty'
      KeyFields = 'recipe_id'
      DisplayFormat = '0 kg'
      Lookup = True
    end
    object tblPendingOrdersqty_req: TIntegerField
      DisplayLabel = #1047#1072#1103#1074#1077#1085#1086' '#1082#1086#1083'.'
      FieldName = 'qty_req'
      DisplayFormat = '0 kg'
    end
    object tblPendingOrdersqty_done: TIntegerField
      DisplayLabel = #1054#1090#1088#1072#1073'. '#1082#1086#1083'.'
      FieldName = 'qty_done'
      DisplayFormat = '0 kg'
    end
    object tblPendingOrdersfinished: TBooleanField
      DisplayLabel = #1055#1088#1080#1082#1083#1102#1095#1077#1085#1072
      FieldName = 'finished'
    end
    object tblPendingOrdersinvalid: TBooleanField
      DisplayLabel = #1053#1077#1074#1072#1083#1080#1076#1085#1072
      FieldName = 'invalid'
    end
  end
  object qFinishedOrders: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    AfterScroll = qFinishedOrdersAfterScroll
    Parameters = <
      item
        Name = 'from_time'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'to_time'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT orders.*,'
      '       IIf(orders.invalid,"'#1040#1053#1059#1051#1048#1056#1040#1053#1040'","'#1074#1072#1083#1080#1076#1085#1072'") AS Annul, '
      '       recipes.name AS recipe_name'
      'FROM recipes INNER JOIN orders ON orders.recipe_id = recipes.id'
      
        'WHERE (orders.finished = True) AND (orders.time_done BETWEEN :fr' +
        'om_time AND :to_time)'
      'ORDER BY orders.nr')
    Left = 296
    Top = 184
    object qFinishedOrdersid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object qFinishedOrderstime_entered: TDateTimeField
      DisplayLabel = #1042#1098#1074#1077#1076#1077#1085#1072
      FieldName = 'time_entered'
    end
    object qFinishedOrdersnr: TIntegerField
      DisplayLabel = #8470
      FieldName = 'nr'
    end
    object qFinishedOrderstime_done: TDateTimeField
      DisplayLabel = #1055#1088#1080#1082#1083#1102#1095#1077#1085#1072
      FieldName = 'time_done'
    end
    object qFinishedOrdersqty_req: TIntegerField
      DisplayLabel = #1047#1072#1103#1074#1077#1085#1086' '#1082#1086#1083'.'
      FieldName = 'qty_req'
      DisplayFormat = '0 kg'
    end
    object qFinishedOrdersrecipe_name: TWideStringField
      DisplayLabel = #1056#1077#1094#1077#1087#1090#1072
      FieldName = 'recipe_name'
      Size = 50
    end
    object qFinishedOrdersrecipe_id: TIntegerField
      FieldName = 'recipe_id'
    end
    object qFinishedOrdersqty_done: TIntegerField
      DisplayLabel = #1054#1090#1088#1072#1073'. '#1082#1086#1083'.'
      FieldName = 'qty_done'
      DisplayFormat = '0 kg'
    end
    object qFinishedOrdersfinished: TBooleanField
      FieldName = 'finished'
    end
    object qFinishedOrdersinvalid: TBooleanField
      FieldName = 'invalid'
    end
    object qFinishedOrdersAnnul: TWideStringField
      FieldName = 'Annul'
      ReadOnly = True
      Size = 255
    end
  end
  object qFinishedOrdersSiloCons: TADOQuery
    Connection = ADOConnection
    Parameters = <
      item
        Name = 'order_id'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT silo_cons.*, silos.name AS silo_name'
      'FROM silos INNER JOIN silo_cons ON silo_cons.silo_id = silos.id'
      'WHERE silo_cons.order_id = :order_id'
      'ORDER BY silo_cons.[when]')
    Left = 296
    Top = 240
    object qFinishedOrdersSiloConsid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object qFinishedOrdersSiloConswhen: TDateTimeField
      DisplayLabel = #1063#1072#1089
      FieldName = 'when'
      DisplayFormat = 'hh:nn'
    end
    object qFinishedOrdersSiloConsorder_id: TIntegerField
      FieldName = 'order_id'
    end
    object qFinishedOrdersSiloConssilo_id: TIntegerField
      FieldName = 'silo_id'
    end
    object qFinishedOrdersSiloConssilo_name: TWideStringField
      DisplayLabel = #1057#1080#1083#1086#1079
      FieldName = 'silo_name'
      Size = 50
    end
    object qFinishedOrdersSiloConsqty: TIntegerField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
      FieldName = 'qty'
      DisplayFormat = '0 kg'
    end
    object qFinishedOrdersSiloConsuser_id: TIntegerField
      FieldName = 'user_id'
    end
  end
  object dsFinishedOrders: TDataSource
    AutoEdit = False
    DataSet = qFinishedOrders
    Left = 440
    Top = 184
  end
  object dsFinishedOrdersSiloCons: TDataSource
    DataSet = qFinishedOrdersSiloCons
    Left = 440
    Top = 240
  end
end
