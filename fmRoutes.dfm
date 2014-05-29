object RoutesForm: TRoutesForm
  Left = 192
  Top = 107
  BorderStyle = bsDialog
  Caption = #1052#1072#1088#1096#1088#1091#1090#1080
  ClientHeight = 353
  ClientWidth = 457
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 193
    Height = 297
    Caption = ' '#1052#1072#1088#1096#1088#1091#1090#1080' '
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 8
      Top = 24
      Width = 177
      Height = 233
      DataSource = MainData.dsRoutes
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'name'
          Width = 140
          Visible = True
        end>
    end
    object DBNavigator2: TDBNavigator
      Left = 15
      Top = 264
      Width = 162
      Height = 25
      DataSource = MainData.dsRoutes
      VisibleButtons = [nbInsert, nbDelete, nbRefresh]
      Flat = True
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 208
    Top = 8
    Width = 241
    Height = 297
    Caption = ' '#1054#1087#1080#1089#1072#1085#1080#1077' '#1085#1072' '#1084#1072#1088#1096#1088#1091#1090#1072' '
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 9
      Height = 13
      Caption = '1.'
    end
    object Label2: TLabel
      Left = 8
      Top = 56
      Width = 9
      Height = 13
      Caption = '2.'
    end
    object Label3: TLabel
      Left = 8
      Top = 88
      Width = 9
      Height = 13
      Caption = '3.'
    end
    object Label5: TLabel
      Left = 8
      Top = 120
      Width = 51
      Height = 13
      Caption = '4. '#1041#1091#1085#1082#1077#1088':'
    end
    object dbcbElevator: TDBCheckBox
      Left = 24
      Top = 24
      Width = 201
      Height = 17
      Caption = #1045#1083#1077#1074#1072#1090#1086#1088' - '#1074#1082#1083#1102#1095#1077#1085
      DataField = 'elevator'
      DataSource = MainData.dsRoutes
      TabOrder = 0
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object dbcbFlap1: TDBCheckBox
      Left = 24
      Top = 56
      Width = 201
      Height = 17
      Caption = #1050#1083#1072#1087#1072' 1 - '#1085#1072#1083#1103#1074#1086
      DataField = 'flap1'
      DataSource = MainData.dsRoutes
      TabOrder = 1
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      OnClick = dbcbFlap1Click
    end
    object dbcbFlap2: TDBCheckBox
      Left = 24
      Top = 88
      Width = 201
      Height = 17
      Caption = #1050#1083#1072#1087#1072' 2 - '#1085#1072#1083#1103#1074#1086
      DataField = 'flap2'
      DataSource = MainData.dsRoutes
      TabOrder = 2
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object DBNavigator1: TDBNavigator
      Left = 152
      Top = 264
      Width = 82
      Height = 25
      DataSource = MainData.dsRoutes
      VisibleButtons = [nbPost, nbCancel]
      Flat = True
      TabOrder = 3
    end
    object cbRoulette: TComboBox
      Left = 64
      Top = 120
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 4
      Text = #1048#1079#1082#1083#1102#1095#1077#1085
      OnChange = cbRouletteChange
      Items.Strings = (
        #1048#1079#1082#1083#1102#1095#1077#1085
        #1041#1091#1085#1082#1077#1088' 1'
        #1041#1091#1085#1082#1077#1088' 2'
        #1041#1091#1085#1082#1077#1088' 3'
        #1041#1091#1085#1082#1077#1088' 4'
        #1041#1091#1085#1082#1077#1088' 5'
        #1041#1091#1085#1082#1077#1088' 6')
    end
  end
  object bClose: TBitBtn
    Left = 368
    Top = 320
    Width = 81
    Height = 25
    Caption = #1047#1072#1090#1074#1086#1088#1080
    TabOrder = 2
    OnClick = bCloseClick
  end
end
