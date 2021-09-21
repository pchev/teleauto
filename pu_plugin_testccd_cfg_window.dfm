object pop_plugin_testccd_cfg_window: Tpop_plugin_testccd_cfg_window
  Left = 324
  Top = 156
  Width = 329
  Height = 128
  Caption = 'Camera Plugin configuration'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 305
    Height = 13
    Caption = 'This is the configuration window of the exemple of Camera plugin'
  end
  object Label2: TLabel
    Left = 12
    Top = 40
    Width = 62
    Height = 13
    Caption = 'CAN Speed :'
  end
  object Label3: TLabel
    Left = 168
    Top = 40
    Width = 68
    Height = 13
    Caption = 'MicroSeconds'
  end
  object BitBtn1: TBitBtn
    Left = 41
    Top = 72
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkCancel
  end
  object BitBtn2: TBitBtn
    Left = 197
    Top = 72
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object Edit1: TEdit
    Left = 84
    Top = 36
    Width = 69
    Height = 21
    TabOrder = 2
    Text = '15'
    OnExit = Edit1Exit
  end
end
