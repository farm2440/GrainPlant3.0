object OrderEditForm: TOrderEditForm
  Left = 249
  Top = 142
  Width = 345
  Height = 212
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1072#1085#1077' '#1085#1072' '#1087#1086#1088#1098#1095#1082#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 42
    Height = 13
    Caption = #1056#1077#1094#1077#1087#1090#1072
  end
  object Label2: TLabel
    Left = 16
    Top = 64
    Width = 118
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086' '#1088#1077#1094#1077#1087#1090#1072
  end
  object Label3: TLabel
    Left = 176
    Top = 64
    Width = 104
    Height = 13
    Caption = #1047#1072#1103#1074#1077#1085#1086' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086
  end
  object Bevel1: TBevel
    Left = 16
    Top = 120
    Width = 305
    Height = 2
  end
  object bOK: TBitBtn
    Left = 80
    Top = 136
    Width = 81
    Height = 25
    Caption = #1055#1086#1090#1074#1098#1088#1076#1080
    Default = True
    TabOrder = 0
    OnClick = bOKClick
  end
  object bCancel: TBitBtn
    Left = 176
    Top = 136
    Width = 81
    Height = 25
    Caption = #1054#1090#1082#1072#1078#1080
    TabOrder = 1
    OnClick = bCancelClick
  end
  object cbRecipe: TDBLookupComboBox
    Left = 16
    Top = 32
    Width = 305
    Height = 21
    DataField = 'recipe_id'
    DataSource = MainData.dsPendingOrders
    KeyField = 'id'
    ListField = 'name'
    ListSource = MainData.dsRecipes
    TabOrder = 2
  end
  object DBEdit1: TDBEdit
    Left = 16
    Top = 80
    Width = 145
    Height = 21
    Color = clBtnFace
    DataField = 'recipe_qty'
    DataSource = MainData.dsPendingOrders
    ReadOnly = True
    TabOrder = 3
  end
  object DBEdit2: TDBEdit
    Left = 176
    Top = 80
    Width = 145
    Height = 21
    DataField = 'qty_req'
    DataSource = MainData.dsPendingOrders
    TabOrder = 4
  end
end
