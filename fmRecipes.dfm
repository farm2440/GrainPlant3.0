object RecipesForm: TRecipesForm
  Left = 255
  Top = 69
  Width = 561
  Height = 628
  Caption = #1056#1077#1094#1077#1087#1090#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 537
    Height = 265
    Caption = ' '#1056#1077#1094#1077#1087#1090#1091#1088#1077#1085' '#1089#1087#1080#1089#1098#1082' '
    TabOrder = 0
    object Label7: TLabel
      Left = 272
      Top = 176
      Width = 190
      Height = 13
      Caption = #1055#1091#1089#1082#1072#1085#1077' '#1085#1072' '#1074#1086#1076#1072' '#1080' '#1086#1083#1080#1086' '#1089#1083#1077#1076' '#1089#1090#1098#1087#1082#1072':'
    end
    object Label8: TLabel
      Left = 272
      Top = 200
      Width = 168
      Height = 13
      Caption = #1055#1091#1089#1082#1072#1085#1077' '#1085#1072' '#1084#1080#1082#1089#1077#1088' '#1089#1083#1077#1076' '#1089#1090#1098#1087#1082#1072':'
    end
    object Label9: TLabel
      Left = 272
      Top = 224
      Width = 102
      Height = 13
      Caption = #1056#1072#1079#1090#1086#1074#1072#1088#1074#1072#1085#1077' '#1089#1083#1077#1076':'
    end
    object DBNavigator1: TDBNavigator
      Left = 8
      Top = 232
      Width = 132
      Height = 25
      DataSource = MainData.dsRecipes
      VisibleButtons = [nbInsert, nbDelete, nbPost, nbCancel]
      Flat = True
      Hints.Strings = (
        'First record'
        'Prior record'
        'Next record'
        'Last record'
        #1044#1086#1073#1072#1074#1080' '#1085#1086#1074#1072' '#1088#1077#1094#1077#1087#1090#1072
        #1048#1079#1090#1088#1080#1081' '#1087#1086#1089#1086#1095#1077#1085#1072#1090#1072' '#1088#1077#1094#1077#1087#1090#1072
        'Edit record'
        #1055#1086#1090#1074#1098#1088#1076#1080' '#1087#1088#1086#1084#1077#1085#1080#1090#1077
        #1054#1090#1082#1072#1078#1080' '#1087#1088#1086#1084#1077#1085#1080#1090#1077
        'Refresh data')
      TabOrder = 6
    end
    object grRecipes: TDBGrid
      Left = 8
      Top = 24
      Width = 257
      Height = 201
      DataSource = MainData.dsRecipes
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
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'qty'
          ReadOnly = True
          Width = 70
          Visible = True
        end>
    end
    object GroupBox3: TGroupBox
      Left = 272
      Top = 16
      Width = 257
      Height = 73
      Caption = ' '#1042#1086#1076#1072' '
      TabOrder = 1
      object Label1: TLabel
        Left = 8
        Top = 24
        Width = 32
        Height = 13
        Caption = #1044#1077#1073#1080#1090
      end
      object Label2: TLabel
        Left = 88
        Top = 24
        Width = 67
        Height = 13
        Caption = #1047#1072#1103#1074#1077#1085#1086' '#1082#1086#1083'.'
      end
      object Label3: TLabel
        Left = 168
        Top = 24
        Width = 33
        Height = 13
        Caption = #1042#1088#1077#1084#1077
      end
      object dbeWaterTime: TDBEdit
        Left = 168
        Top = 40
        Width = 80
        Height = 21
        Color = clBtnFace
        DataField = 'water_time'
        DataSource = MainData.dsRecipes
        TabOrder = 2
      end
      object dbeWaterQty: TDBEdit
        Left = 88
        Top = 40
        Width = 80
        Height = 21
        DataField = 'water_qty'
        DataSource = MainData.dsRecipes
        TabOrder = 1
      end
      object dbeWaterFlow: TDBEdit
        Left = 8
        Top = 40
        Width = 80
        Height = 21
        DataField = 'water_flow'
        DataSource = MainData.dsRecipes
        TabOrder = 0
      end
    end
    object GroupBox4: TGroupBox
      Left = 272
      Top = 96
      Width = 257
      Height = 73
      Caption = ' '#1054#1083#1080#1086' '
      TabOrder = 2
      object Label4: TLabel
        Left = 8
        Top = 24
        Width = 32
        Height = 13
        Caption = #1044#1077#1073#1080#1090
      end
      object Label5: TLabel
        Left = 88
        Top = 24
        Width = 67
        Height = 13
        Caption = #1047#1072#1103#1074#1077#1085#1086' '#1082#1086#1083'.'
      end
      object Label6: TLabel
        Left = 168
        Top = 24
        Width = 33
        Height = 13
        Caption = #1042#1088#1077#1084#1077
      end
      object dbeOilTime: TDBEdit
        Left = 168
        Top = 40
        Width = 80
        Height = 21
        Color = clBtnFace
        DataField = 'oil_time'
        DataSource = MainData.dsRecipes
        TabOrder = 2
      end
      object dbeOilQty: TDBEdit
        Left = 88
        Top = 40
        Width = 80
        Height = 21
        DataField = 'oil_qty'
        DataSource = MainData.dsRecipes
        TabOrder = 1
      end
      object dbeOilFlow: TDBEdit
        Left = 8
        Top = 40
        Width = 80
        Height = 21
        DataField = 'oil_flow'
        DataSource = MainData.dsRecipes
        TabOrder = 0
      end
    end
    object dbeLiquidStartStep: TDBEdit
      Left = 464
      Top = 176
      Width = 57
      Height = 21
      DataField = 'liquids_start_step'
      DataSource = MainData.dsRecipes
      TabOrder = 3
    end
    object dbeMixerStartStep: TDBEdit
      Left = 464
      Top = 200
      Width = 57
      Height = 21
      DataField = 'mixer_start_step'
      DataSource = MainData.dsRecipes
      TabOrder = 4
    end
    object dbeDischargeAfter: TDBEdit
      Left = 464
      Top = 224
      Width = 57
      Height = 21
      DataField = 'discharge_after'
      DataSource = MainData.dsRecipes
      TabOrder = 5
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 280
    Width = 537
    Height = 281
    Caption = ' '#1057#1098#1076#1098#1088#1078#1072#1085#1080#1077' '#1085#1072' '#1080#1079#1073#1088#1072#1085#1072#1090#1072' '#1088#1077#1094#1077#1087#1090#1072' '
    TabOrder = 1
    object dbnSilos: TDBNavigator
      Left = 392
      Top = 248
      Width = 132
      Height = 25
      DataSource = MainData.dsRecipeDetails
      VisibleButtons = [nbInsert, nbDelete, nbPost, nbCancel]
      Flat = True
      Hints.Strings = (
        'First record'
        'Prior record'
        'Next record'
        'Last record'
        #1044#1086#1073#1072#1074#1080' '#1085#1086#1074' '#1082#1086#1084#1087#1086#1085#1077#1085#1090
        #1048#1079#1090#1088#1080#1081' '#1087#1086#1089#1086#1095#1077#1085#1080#1103#1090' '#1082#1086#1084#1087#1086#1085#1077#1085#1090
        'Edit record'
        #1055#1086#1090#1074#1098#1088#1076#1080' '#1087#1088#1086#1084#1077#1085#1080#1090#1077
        #1054#1090#1082#1072#1078#1080' '#1087#1088#1086#1084#1077#1085#1080#1090#1077
        'Refresh data')
      TabOrder = 0
    end
    object grRecipeDetails: TDBGrid
      Left = 8
      Top = 16
      Width = 521
      Height = 225
      DataSource = MainData.dsRecipeDetails
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'step'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'silo'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'grain'
          Width = 125
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
  object bClose: TBitBtn
    Left = 464
    Top = 568
    Width = 81
    Height = 25
    Caption = #1047#1072#1090#1074#1086#1088#1080
    TabOrder = 2
    OnClick = bCloseClick
  end
end
