object pop_clock_monitor: Tpop_clock_monitor
  Left = 351
  Top = 117
  BorderStyle = bsToolWindow
  Caption = 'Moniteur d'#39'horloges'
  ClientHeight = 214
  ClientWidth = 193
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 60
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 0
    OnClick = Button1Click
  end
  object GroupBox1: TGroupBox
    Left = 4
    Top = 0
    Width = 185
    Height = 69
    Caption = 'Horloges'
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 20
      Width = 71
      Height = 13
      Caption = 'Windows TU : '
    end
    object Label2: TLabel
      Left = 8
      Top = 44
      Width = 58
      Height = 13
      Caption = 'CMOS TU : '
    end
    object Panel1: TPanel
      Left = 88
      Top = 16
      Width = 85
      Height = 21
      BevelOuter = bvLowered
      Caption = 'Panel1'
      TabOrder = 0
    end
    object Panel2: TPanel
      Left = 88
      Top = 40
      Width = 85
      Height = 21
      BevelOuter = bvLowered
      Caption = 'Panel1'
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 4
    Top = 100
    Width = 185
    Height = 77
    Caption = 'Mise '#224' jour'
    TabOrder = 2
    object Label3: TLabel
      Left = 16
      Top = 20
      Width = 53
      Height = 13
      Caption = 'Heure TU :'
    end
    object DateTimePicker1: TDateTimePicker
      Left = 84
      Top = 16
      Width = 89
      Height = 21
      CalAlignment = dtaLeft
      Date = 37121.8226998843
      Time = 37121.8226998843
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkTime
      ParseInput = False
      TabOrder = 0
    end
    object Button3: TButton
      Left = 12
      Top = 44
      Width = 157
      Height = 25
      Caption = 'Mise '#224' jour'
      TabOrder = 1
      OnClick = Button3Click
    end
  end
  object Button2: TButton
    Left = 16
    Top = 72
    Width = 157
    Height = 25
    Caption = 'Mise '#224' jour CMOS -> Windows'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 152
    Top = 184
  end
end
