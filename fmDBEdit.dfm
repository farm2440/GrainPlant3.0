object DBEditForm: TDBEditForm
  Left = 240
  Top = 149
  Width = 713
  Height = 621
  Caption = 'DBEditForm'
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
  DesignSize = (
    705
    594)
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 40
    Width = 705
    Height = 553
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsTable
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 0
    Top = 8
    Width = 270
    Height = 25
    DataSource = dsTable
    TabOrder = 1
  end
  object cbTableName: TComboBox
    Left = 552
    Top = 8
    Width = 153
    Height = 21
    Style = csDropDownList
    Anchors = [akTop, akRight]
    ItemHeight = 13
    TabOrder = 2
    OnChange = cbTableNameChange
  end
  object tblTable: TADOTable
    Connection = MainData.ADOConnection
    Left = 8
    Top = 88
  end
  object dsTable: TDataSource
    DataSet = tblTable
    Left = 40
    Top = 88
  end
end
