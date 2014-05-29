object LiquidsManualForm: TLiquidsManualForm
  Left = 192
  Top = 106
  BorderStyle = bsDialog
  Caption = #1058#1077#1095#1085#1080' '#1076#1086#1073#1072#1074#1082#1080
  ClientHeight = 211
  ClientWidth = 216
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 201
    Height = 73
    Caption = ' '#1042#1086#1076#1072' '
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 32
      Height = 13
      Caption = #1044#1077#1073#1080#1090
    end
    object Label2: TLabel
      Left = 104
      Top = 24
      Width = 67
      Height = 13
      Caption = #1047#1072#1103#1074#1077#1085#1086' '#1082#1086#1083'.'
    end
    object eWaterFlow: TEdit
      Left = 8
      Top = 40
      Width = 89
      Height = 21
      TabOrder = 0
      Text = 'eWaterFlow'
    end
    object eWaterQty: TEdit
      Left = 104
      Top = 40
      Width = 89
      Height = 21
      TabOrder = 1
      Text = 'Edit1'
    end
  end
  object GroupBox2: TGroupBox
    Left = 7
    Top = 88
    Width = 201
    Height = 73
    Caption = ' '#1054#1083#1080#1086' '
    TabOrder = 1
    object Label3: TLabel
      Left = 8
      Top = 24
      Width = 32
      Height = 13
      Caption = #1044#1077#1073#1080#1090
    end
    object Label4: TLabel
      Left = 104
      Top = 24
      Width = 67
      Height = 13
      Caption = #1047#1072#1103#1074#1077#1085#1086' '#1082#1086#1083'.'
    end
    object eOilFlow: TEdit
      Left = 8
      Top = 40
      Width = 89
      Height = 21
      TabOrder = 0
      Text = 'eOilFlow'
    end
    object eOilQty: TEdit
      Left = 104
      Top = 40
      Width = 89
      Height = 21
      TabOrder = 1
      Text = 'eOilQty'
    end
  end
  object bOK: TButton
    Left = 24
    Top = 176
    Width = 81
    Height = 25
    Caption = #1055#1091#1089#1085#1080
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = bOKClick
  end
  object bCancel: TButton
    Left = 112
    Top = 176
    Width = 81
    Height = 25
    Caption = #1054#1090#1082#1072#1078#1080
    ModalResult = 2
    TabOrder = 3
    OnClick = bCancelClick
  end
end
