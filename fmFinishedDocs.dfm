object FinishedDocsForm: TFinishedDocsForm
  Left = 301
  Top = 491
  Width = 800
  Height = 220
  Caption = #1057#1087#1088#1072#1074#1082#1080
  Color = clBtnFace
  Constraints.MinHeight = 220
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnShow = FormShow
  DesignSize = (
    792
    193)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 12
    Width = 55
    Height = 13
    Caption = #1042' '#1087#1077#1088#1080#1086#1076#1072':'
  end
  object Label2: TLabel
    Left = 168
    Top = 8
    Width = 12
    Height = 13
    Alignment = taCenter
    Caption = #1076#1086
  end
  object Label3: TLabel
    Left = 288
    Top = 12
    Width = 34
    Height = 13
    Caption = #1057#1090#1072#1090#1091#1089
  end
  object dtpFrom: TDateTimePicker
    Left = 72
    Top = 8
    Width = 89
    Height = 21
    Date = 38998.558840775460000000
    Time = 38998.558840775460000000
    TabOrder = 0
  end
  object dtpTo: TDateTimePicker
    Left = 192
    Top = 8
    Width = 89
    Height = 21
    Date = 38998.558840775460000000
    Time = 38998.558840775460000000
    TabOrder = 1
  end
  object bQuery: TBitBtn
    Left = 550
    Top = 8
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1055#1086#1082#1072#1078#1080
    TabOrder = 3
    OnClick = bQueryClick
  end
  object bClose: TBitBtn
    Left = 710
    Top = 8
    Width = 81
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1090#1074#1086#1088#1080
    TabOrder = 5
    OnClick = bCloseClick
  end
  object bPrint: TBitBtn
    Left = 630
    Top = 8
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1054#1090#1087#1077#1095#1072#1090#1072#1081
    TabOrder = 4
    OnClick = bPrintClick
  end
  object PageControl: TPageControl
    Left = 8
    Top = 40
    Width = 775
    Height = 138
    ActivePage = tsDocs
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 6
    OnChange = PageControlChange
    object tsDocs: TTabSheet
      Caption = #1048#1079#1087#1098#1083#1085#1077#1085#1080' '#1087#1086#1088#1098#1095#1082#1080
      OnHide = tsDocsHide
      OnShow = tsDocsShow
      DesignSize = (
        767
        110)
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 471
        Height = 90
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = ' '#1047#1072#1103#1074#1082#1080' '
        TabOrder = 0
        DesignSize = (
          471
          90)
        object DBGrid1: TDBGrid
          Left = 8
          Top = 24
          Width = 455
          Height = 58
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = MainData.dsFinishedOrders
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'nr'
              Width = 30
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'time_done'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'recipe_name'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'qty_req'
              Width = 75
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'qty_done'
              Width = 75
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Annul'
              Title.Caption = #1057#1090#1072#1090#1091#1089
              Visible = True
            end>
        end
      end
      object GroupBox2: TGroupBox
        Left = 486
        Top = 8
        Width = 273
        Height = 90
        Anchors = [akTop, akRight, akBottom]
        Caption = ' '#1056#1072#1079#1093#1086#1076#1080' '#1079#1072' '#1079#1072#1103#1074#1082#1072#1090#1072' '
        TabOrder = 1
        DesignSize = (
          273
          90)
        object DBGrid2: TDBGrid
          Left = 8
          Top = 24
          Width = 257
          Height = 58
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = MainData.dsFinishedOrdersSiloCons
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'when'
              Width = 40
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'silo_name'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'qty'
              Width = 75
              Visible = True
            end>
        end
      end
    end
    object tsCons: TTabSheet
      Caption = #1044#1085#1077#1074#1085#1080' '#1088#1072#1079#1093#1086#1076#1080
      ImageIndex = 1
      OnHide = tsConsHide
      OnShow = tsConsShow
      DesignSize = (
        767
        110)
      object DBGrid3: TDBGrid
        Left = 8
        Top = 8
        Width = 751
        Height = 90
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = MainData.dsSiloConsPivot
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
    object tsProd: TTabSheet
      Caption = #1044#1085#1077#1074#1085#1080' '#1087#1088#1086#1080#1079#1074#1077#1076#1077#1085#1080' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1072
      ImageIndex = 2
      OnHide = tsProdHide
      OnShow = tsProdShow
      DesignSize = (
        767
        110)
      object DBGrid4: TDBGrid
        Left = 8
        Top = 8
        Width = 751
        Height = 90
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = MainData.dsProdPivot
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
  end
  object cbStatus: TComboBox
    Left = 328
    Top = 8
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 2
    TabOrder = 2
    Text = #1074#1072#1083#1080#1076#1085#1080' '#1080' '#1072#1085#1091#1083#1080#1088#1072#1085#1080
    Items.Strings = (
      #1074#1072#1083#1080#1076#1085#1080' '#1076#1086#1082#1091#1084#1077#1085#1090#1080
      #1072#1085#1091#1083#1080#1088#1072#1085#1080' '#1076#1086#1082#1091#1084#1077#1085#1090#1080
      #1074#1072#1083#1080#1076#1085#1080' '#1080' '#1072#1085#1091#1083#1080#1088#1072#1085#1080)
  end
end
