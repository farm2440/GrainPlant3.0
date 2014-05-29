object AbortForm: TAbortForm
  Left = 192
  Top = 103
  BorderStyle = bsDialog
  Caption = 'AbortForm'
  ClientHeight = 126
  ClientWidth = 281
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
  object Bevel1: TBevel
    Left = 8
    Top = 72
    Width = 265
    Height = 2
  end
  object rbCancelOrder: TRadioButton
    Left = 16
    Top = 16
    Width = 249
    Height = 17
    Caption = #1055#1088#1077#1082#1088#1072#1090#1080' '#1080#1079#1087#1098#1083#1085#1077#1085#1080#1090#1086' '#1085#1072' '#1094#1103#1083#1072#1090#1072' '#1087#1086#1088#1098#1095#1082#1072
    TabOrder = 0
  end
  object rbCancelDose: TRadioButton
    Left = 16
    Top = 40
    Width = 249
    Height = 17
    Caption = #1055#1088#1077#1082#1088#1072#1090#1080' '#1080#1079#1087#1098#1083#1085#1077#1085#1080#1090#1086' '#1085#1072' '#1090#1077#1082#1091#1097#1072#1090#1072' '#1076#1086#1079#1072
    Checked = True
    TabOrder = 1
    TabStop = True
  end
  object bOK: TButton
    Left = 56
    Top = 88
    Width = 81
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object bCancel: TButton
    Left = 144
    Top = 88
    Width = 81
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
