object AddPairForm: TAddPairForm
  Left = 254
  Top = 228
  BorderStyle = bsDialog
  Caption = 'Add pair'
  ClientHeight = 169
  ClientWidth = 217
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
    Top = 16
    Width = 38
    Height = 13
    Caption = 'Input bit'
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 46
    Height = 13
    Caption = 'Output bit'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 112
    Width = 201
    Height = 2
  end
  object cbBitIn: TComboBox
    Left = 64
    Top = 16
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
  end
  object cbBitOut: TComboBox
    Left = 64
    Top = 48
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
  end
  object cbInverted: TCheckBox
    Left = 64
    Top = 80
    Width = 97
    Height = 17
    Caption = 'Inverted'
    TabOrder = 2
  end
  object bOK: TButton
    Left = 24
    Top = 128
    Width = 81
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object bCancel: TButton
    Left = 112
    Top = 128
    Width = 81
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
end
