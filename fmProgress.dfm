object ProgressForm: TProgressForm
  Left = 342
  Top = 179
  BorderStyle = bsDialog
  Caption = #1052#1086#1083#1103' '#1080#1079#1095#1072#1082#1072#1081#1090#1077' ...'
  ClientHeight = 145
  ClientWidth = 313
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 37
    Height = 13
    Caption = #1057#1090#1098#1087#1082#1072
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 58
    Height = 13
    Caption = #1055#1072#1088#1072#1084#1077#1090#1098#1088
  end
  object Bevel1: TBevel
    Left = 8
    Top = 96
    Width = 297
    Height = 2
  end
  object pbStep: TProgressBar
    Left = 8
    Top = 24
    Width = 297
    Height = 16
    Max = 10
    TabOrder = 0
  end
  object pbParameter: TProgressBar
    Left = 8
    Top = 64
    Width = 297
    Height = 16
    Max = 10
    TabOrder = 1
  end
  object bCancel: TBitBtn
    Left = 112
    Top = 112
    Width = 89
    Height = 25
    Caption = #1055#1088#1077#1082#1088#1072#1090#1080
    TabOrder = 2
    OnClick = bCancelClick
  end
end
