object pop_hour_server: Tpop_hour_server
  Left = 703
  Top = 347
  BorderStyle = bsToolWindow
  Caption = 'Serveur d'#39'heure'
  ClientHeight = 217
  ClientWidth = 216
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 4
    Top = 12
    Width = 29
    Height = 13
    Caption = 'Date :'
  end
  object Label2: TLabel
    Left = 4
    Top = 44
    Width = 35
    Height = 13
    Caption = 'Heure :'
  end
  object Panel1: TPanel
    Left = 48
    Top = 4
    Width = 169
    Height = 29
    BevelOuter = bvLowered
    Caption = 'Panel1'
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 48
    Top = 36
    Width = 169
    Height = 29
    BevelOuter = bvLowered
    Caption = 'Panel1'
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 68
    Width = 217
    Height = 149
    ActivePage = TabSheet2
    TabIndex = 1
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'R'#233'glages'
      object GroupBox1: TGroupBox
        Left = 4
        Top = 0
        Width = 201
        Height = 69
        Caption = 'Entr'#233'e'
        TabOrder = 0
        object Label3: TLabel
          Left = 4
          Top = 16
          Width = 29
          Height = 13
          Caption = 'Date :'
        end
        object Label4: TLabel
          Left = 4
          Top = 40
          Width = 35
          Height = 13
          Caption = 'Heure :'
        end
        object MaskEdit2: TMaskEdit
          Left = 48
          Top = 36
          Width = 77
          Height = 21
          EditMask = '!90:00:00;1;_'
          MaxLength = 8
          TabOrder = 0
          Text = '  :  :  '
        end
        object MaskEdit1: TMaskEdit
          Left = 48
          Top = 12
          Width = 77
          Height = 21
          EditMask = '!99/99/0000;1;_'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
        end
        object Button1: TButton
          Left = 126
          Top = 20
          Width = 71
          Height = 25
          Caption = 'Mise '#224' jour'
          TabOrder = 2
          OnClick = Button1Click
        end
      end
      object GroupBox2: TGroupBox
        Left = 4
        Top = 69
        Width = 201
        Height = 49
        Caption = 'PC/CMOS'
        TabOrder = 1
        object Button2: TButton
          Left = 8
          Top = 16
          Width = 185
          Height = 25
          Caption = 'Mettre '#224' jour l'#39'heure du PC'
          TabOrder = 0
          OnClick = Button2Click
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Entr'#233'e'
      ImageIndex = 1
      object CheckBox1: TCheckBox
        Left = 4
        Top = 4
        Width = 137
        Height = 17
        Caption = 'Tracer les '#233'venements'
        TabOrder = 0
        OnClick = CheckBox1Click
      end
      object Memo1: TMemo
        Left = 4
        Top = 28
        Width = 201
        Height = 89
        ScrollBars = ssVertical
        TabOrder = 1
      end
      object BitBtn1: TBitBtn
        Left = 180
        Top = 0
        Width = 25
        Height = 25
        Hint = 'Sauver'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = BitBtn1Click
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
          00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
          00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
          00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
          00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
          00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
          00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
          0003737FFFFFFFFF7F7330099999999900333777777777777733}
        NumGlyphs = 2
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Sortie'
      ImageIndex = 2
      object Label5: TLabel
        Left = 4
        Top = 44
        Width = 35
        Height = 13
        Caption = 'Heure :'
      end
      object Label6: TLabel
        Left = 4
        Top = 69
        Width = 71
        Height = 13
        Caption = 'Nb de pulses : '
      end
      object Label7: TLabel
        Left = 4
        Top = 93
        Width = 49
        Height = 13
        Caption = 'Intervalle :'
      end
      object Label8: TLabel
        Left = 164
        Top = 93
        Width = 20
        Height = 13
        Caption = 'sec.'
      end
      object MaskEdit3: TMaskEdit
        Left = 80
        Top = 40
        Width = 77
        Height = 21
        EditMask = '!90:00:00;1;_'
        MaxLength = 8
        TabOrder = 0
        Text = '  :  :  '
      end
      object SpinEdit1: TSpinEdit
        Left = 80
        Top = 64
        Width = 77
        Height = 22
        MaxValue = 9999
        MinValue = 1
        TabOrder = 1
        Value = 1
      end
      object SpinEdit2: TSpinEdit
        Left = 80
        Top = 88
        Width = 77
        Height = 22
        MaxValue = 9999
        MinValue = 1
        TabOrder = 2
        Value = 1
      end
      object CheckBox2: TCheckBox
        Left = 8
        Top = 12
        Width = 61
        Height = 17
        Caption = 'Activer'
        TabOrder = 3
        OnClick = CheckBox2Click
      end
    end
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Fichiers texte (*.txt)|*.txt'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 76
    Top = 20
  end
  object HiResTimer1: THiResTimer
    Interval = 1000
    OnTimer = HiResTimer1Timer
    Left = 108
    Top = 20
  end
  object HiResTimer2: THiResTimer
    OnTimer = HiResTimer2Timer
    Left = 140
    Top = 20
  end
end
