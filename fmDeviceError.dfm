object DeviceErrorForm: TDeviceErrorForm
  Left = 192
  Top = 103
  BorderStyle = bsDialog
  Caption = 'DeviceErrorForm'
  ClientHeight = 138
  ClientWidth = 305
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 232
    Height = 13
    Caption = #1043#1088#1077#1096#1082#1072' '#1087#1088#1080' '#1080#1079#1087#1098#1083#1085#1077#1085#1080#1077' '#1085#1072' '#1088#1077#1094#1077#1087#1090#1072#1090#1072'!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 8
    Top = 88
    Width = 289
    Height = 2
  end
  object rbAbort: TRadioButton
    Left = 8
    Top = 32
    Width = 281
    Height = 17
    Caption = #1055#1088#1077#1082#1088#1072#1090#1080' '#1080#1079#1087#1098#1083#1085#1077#1085#1080#1077#1090#1086' '#1080' '#1080#1079#1095#1080#1089#1090#1080' '#1075#1088#1077#1096#1082#1072#1090#1072
    Checked = True
    TabOrder = 0
    TabStop = True
  end
  object rbSkip: TRadioButton
    Left = 8
    Top = 56
    Width = 281
    Height = 17
    Caption = #1044#1086#1074#1098#1088#1096#1080' '#1076#1086#1079#1072#1090#1072' '#1086#1090' '#1087#1088#1080#1073#1086#1088#1072
    TabOrder = 1
  end
  object bOK: TButton
    Left = 104
    Top = 104
    Width = 89
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
end
