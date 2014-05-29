object MainForm: TMainForm
  Left = 269
  Top = 94
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'GrainPlant Emulator (v)1.0, (c)2006 xOR'
  ClientHeight = 621
  ClientWidth = 809
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 153
    Height = 121
    Caption = ' PC <-> PLC '
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 19
      Height = 13
      Caption = 'Port'
    end
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 25
      Height = 13
      Caption = 'Baud'
    end
    object Bevel1: TBevel
      Left = 8
      Top = 80
      Width = 137
      Height = 2
    end
    object cbPLCConnected: TCheckBox
      Left = 8
      Top = 88
      Width = 97
      Height = 17
      Caption = 'Connected'
      TabOrder = 0
      OnClick = cbPLCConnectedClick
    end
    object cbPLCBaud: TComboBox
      Left = 40
      Top = 48
      Width = 105
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 3
      TabOrder = 1
      Text = '9600'
      Items.Strings = (
        '1200'
        '2400'
        '4800'
        '9600'
        '14400'
        '19200'
        '33600')
    end
    object cbPLCPort: TComboBox
      Left = 40
      Top = 24
      Width = 105
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
      Text = 'COM1'
      Items.Strings = (
        'COM1'
        'COM2'
        'COM3'
        'COM4'
        'COM5'
        'COM6'
        'COM7'
        'COM8'
        'COM9'
        'COM10')
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 136
    Width = 153
    Height = 121
    Caption = ' PC -> Scale '
    TabOrder = 1
    object Label3: TLabel
      Left = 8
      Top = 24
      Width = 19
      Height = 13
      Caption = 'Port'
    end
    object Label4: TLabel
      Left = 8
      Top = 48
      Width = 25
      Height = 13
      Caption = 'Baud'
    end
    object Bevel2: TBevel
      Left = 8
      Top = 80
      Width = 137
      Height = 2
    end
    object cbScaleInConnected: TCheckBox
      Left = 8
      Top = 88
      Width = 97
      Height = 17
      Caption = 'Connected'
      TabOrder = 0
      OnClick = cbScaleInConnectedClick
    end
    object cbScaleInBaud: TComboBox
      Left = 40
      Top = 48
      Width = 105
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 3
      TabOrder = 1
      Text = '9600'
      Items.Strings = (
        '1200'
        '2400'
        '4800'
        '9600'
        '14400'
        '19200'
        '33600')
    end
    object cbScaleInPort: TComboBox
      Left = 40
      Top = 24
      Width = 105
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
      Text = 'COM1'
      Items.Strings = (
        'COM1'
        'COM2'
        'COM3'
        'COM4'
        'COM5'
        'COM6'
        'COM7'
        'COM8'
        'COM9'
        'COM10')
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 264
    Width = 153
    Height = 121
    Caption = ' Scale -> PC '
    TabOrder = 2
    object Label5: TLabel
      Left = 8
      Top = 24
      Width = 19
      Height = 13
      Caption = 'Port'
    end
    object Label6: TLabel
      Left = 8
      Top = 48
      Width = 25
      Height = 13
      Caption = 'Baud'
    end
    object Bevel3: TBevel
      Left = 8
      Top = 80
      Width = 137
      Height = 2
    end
    object cbScaleOutConnected: TCheckBox
      Left = 8
      Top = 88
      Width = 97
      Height = 17
      Caption = 'Connected'
      TabOrder = 0
      OnClick = cbScaleOutConnectedClick
    end
    object cbScaleOutBaud: TComboBox
      Left = 40
      Top = 48
      Width = 105
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 3
      TabOrder = 1
      Text = '9600'
      Items.Strings = (
        '1200'
        '2400'
        '4800'
        '9600'
        '14400'
        '19200'
        '33600')
    end
    object cbScaleOutPort: TComboBox
      Left = 40
      Top = 24
      Width = 105
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
      Text = 'COM1'
      Items.Strings = (
        'COM1'
        'COM2'
        'COM3'
        'COM4'
        'COM5'
        'COM6'
        'COM7'
        'COM8'
        'COM9'
        'COM10')
    end
  end
  object GroupBox4: TGroupBox
    Left = 360
    Top = 8
    Width = 185
    Height = 481
    Caption = ' Output buffer '
    TabOrder = 3
    DesignSize = (
      185
      481)
    object cblbOutput: TCheckListBox
      Left = 8
      Top = 16
      Width = 169
      Height = 457
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 13
      Items.Strings = (
        '00- mixer'
        '01- bunker 1'
        '02- bunker 2'
        '03- bunker 3'
        '04- bunker 4'
        '05- bunker 5'
        '06- bunker 6'
        '07- silo 1'
        '08- silo 2'
        '09- silo 3'
        '10- silo 4'
        '11- silo 5'
        '12- silo 6'
        '13- silo 7'
        '14- silo 8'
        '15- silo 9'
        '16- silo 10'
        '17- silo 11'
        '18- silo 12'
        '19- silo 13'
        '20- flap1 left'
        '21- flap1 right'
        '22- flap2 left'
        '23- flap2 right'
        '24- elevator'
        '25- auger'
        '26- manual'
        '27- water'
        '28- oil'
        '29- discharge'
        '30- hammer'
        '31-'
        '32- bunker 1 overflow'
        '33- bunker 2 overflow'
        '34- bunker 3 overflow'
        '35- bunker 4 overflow'
        '36- bunker 5 overflow'
        '37- bunker 6 overflow'
        '38- bunker 7 overflow'
        '39- bunker 8 overflow'
        '40- running'
        '41- batch complete'
        '42- error'
        '43-'
        '44-'
        '45-'
        '46-'
        '47-')
      TabOrder = 0
    end
  end
  object GroupBox5: TGroupBox
    Left = 168
    Top = 8
    Width = 185
    Height = 481
    Caption = ' Input buffer '
    TabOrder = 4
    DesignSize = (
      185
      481)
    object cblbInput: TCheckListBox
      Left = 8
      Top = 16
      Width = 169
      Height = 457
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 13
      Items.Strings = (
        '00-'
        '01- start'
        '02- discharge'
        '03- abort'
        '04- stop'
        '05-'
        '06-'
        '07-'
        '08-'
        '09-'
        '10- oil'
        '11- water'
        '12- hammer'
        '13- mixer'
        '14-'
        '15-'
        '16-'
        '17- elevator'
        '18-'
        '19-'
        '20-'
        '21-'
        '22- flap1'
        '23- flap2'
        '24- bunker 1'
        '25- bunker 2'
        '26- bunker 3'
        '27- bunker 4'
        '28- bunker 5'
        '29- bunker 6'
        '30-'
        '31-'
        '32-'
        '33- silo 1'
        '34- silo 2'
        '35- silo 3'
        '36- silo 4'
        '37- silo 5'
        '38- silo 6'
        '39- silo 7'
        '40- silo 8'
        '41- silo 9'
        '42- silo 10'
        '43- silo 11'
        '44- silo 12'
        '45- silo 13'
        '46-'
        '47-')
      TabOrder = 0
    end
  end
  object GroupBox6: TGroupBox
    Left = 552
    Top = 8
    Width = 249
    Height = 481
    Caption = ' Input -> Output dependancies '
    TabOrder = 5
    DesignSize = (
      249
      481)
    object lvPairs: TListView
      Left = 8
      Top = 16
      Width = 233
      Height = 425
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = <
        item
          Caption = 'Input'
          Width = 80
        end
        item
          Caption = 'Output'
          Width = 80
        end
        item
          Caption = 'Inverted'
          Width = 52
        end>
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
    end
    object Button1: TButton
      Left = 8
      Top = 448
      Width = 73
      Height = 25
      Action = aAddPair
      Anchors = [akLeft, akBottom]
      TabOrder = 1
    end
    object Button2: TButton
      Left = 88
      Top = 448
      Width = 73
      Height = 25
      Action = aDelPair
      Anchors = [akLeft, akBottom]
      TabOrder = 2
    end
    object Button3: TButton
      Left = 168
      Top = 448
      Width = 73
      Height = 25
      Action = aClearPairs
      Anchors = [akLeft, akBottom]
      TabOrder = 3
    end
  end
  object GroupBox7: TGroupBox
    Left = 8
    Top = 392
    Width = 153
    Height = 97
    Caption = ' Scale status '
    TabOrder = 6
    object lWeight: TLabel
      Left = 8
      Top = 16
      Width = 137
      Height = 33
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'lWeight'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object tbWeight: TTrackBar
      Left = 8
      Top = 48
      Width = 137
      Height = 15
      Max = 1000
      Frequency = 100
      TabOrder = 0
      ThumbLength = 10
      OnChange = tbWeightChange
    end
    object cbNet: TCheckBox
      Left = 8
      Top = 72
      Width = 65
      Height = 17
      Caption = 'Net'
      TabOrder = 1
    end
    object cbStab: TCheckBox
      Left = 80
      Top = 72
      Width = 65
      Height = 17
      Caption = 'Stab'
      TabOrder = 2
    end
  end
  object mLog: TMemo
    Left = 8
    Top = 504
    Width = 793
    Height = 105
    TabOrder = 7
  end
  object ReadTimer: TTimer
    Interval = 50
    OnTimer = ReadTimerTimer
    Left = 288
    Top = 48
  end
  object rsPLC: TRSConnection
    ResponseTime = 0
    Baud = 9600
    Port = 1
    ShowErrors = True
    RefreshInterval = 0
    Left = 288
    Top = 112
  end
  object rsScaleIn: TRSConnection
    ResponseTime = 0
    Baud = 9600
    Port = 1
    ShowErrors = True
    RefreshInterval = 0
    Left = 288
    Top = 144
  end
  object rsScaleOut: TRSConnection
    ResponseTime = 0
    Baud = 9600
    Port = 1
    ShowErrors = True
    RefreshInterval = 0
    Left = 288
    Top = 176
  end
  object WriteTimer: TTimer
    Interval = 100
    OnTimer = WriteTimerTimer
    Left = 288
    Top = 80
  end
  object ActionManager1: TActionManager
    Left = 568
    Top = 120
    StyleName = 'XP Style'
    object aAddPair: TAction
      Category = 'Pairs'
      Caption = 'Add'
      OnExecute = aAddPairExecute
    end
    object aDelPair: TAction
      Category = 'Pairs'
      Caption = 'Remove'
      OnExecute = aDelPairExecute
    end
    object aClearPairs: TAction
      Category = 'Pairs'
      Caption = 'Clear'
      OnExecute = aClearPairsExecute
    end
  end
  object ssPLC: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    Left = 120
    Top = 96
  end
  object ssScaleOut: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    Left = 120
    Top = 352
  end
end
