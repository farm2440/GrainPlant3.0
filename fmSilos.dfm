object SilosForm: TSilosForm
  Left = 209
  Top = 113
  BorderStyle = bsDialog
  Caption = #1057#1091#1088#1086#1074#1080#1085#1080' '#1080' '#1089#1080#1083#1086#1079#1080
  ClientHeight = 425
  ClientWidth = 697
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
    Width = 185
    Height = 377
    Caption = ' '#1057#1091#1088#1086#1074#1080#1085#1080' '
    TabOrder = 0
    object dbnGrains: TDBNavigator
      Left = 24
      Top = 344
      Width = 136
      Height = 25
      DataSource = MainData.dsGrains
      VisibleButtons = [nbInsert, nbDelete, nbPost, nbCancel]
      Flat = True
      TabOrder = 0
    end
    object DBGrid2: TDBGrid
      Left = 8
      Top = 24
      Width = 169
      Height = 313
      DataSource = MainData.dsGrains
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'name'
          Width = 134
          Visible = True
        end>
    end
  end
  object GroupBox2: TGroupBox
    Left = 200
    Top = 8
    Width = 489
    Height = 377
    Caption = ' '#1057#1080#1083#1086#1079#1080' '
    TabOrder = 1
    object dbnSilos: TDBNavigator
      Left = 176
      Top = 344
      Width = 136
      Height = 25
      DataSource = MainData.dsSilos
      VisibleButtons = [nbInsert, nbDelete, nbPost, nbCancel]
      Flat = True
      TabOrder = 0
    end
    object DBGrid1: TDBGrid
      Left = 8
      Top = 24
      Width = 473
      Height = 313
      DataSource = MainData.dsSilos
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'nr'
          Width = 24
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'name'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'grain'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'qty'
          Title.Alignment = taCenter
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'fine_qty'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'tolerance'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'max_dose_time'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'settling_time'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'preact'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jogging_on_time'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jogging_off_time'
          Visible = True
        end>
    end
  end
  object bClose: TBitBtn
    Left = 608
    Top = 392
    Width = 81
    Height = 25
    Caption = #1047#1072#1090#1074#1086#1088#1080
    TabOrder = 2
    OnClick = bCloseClick
  end
end
