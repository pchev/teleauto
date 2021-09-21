object pop_camera_suivi: Tpop_camera_suivi
  Left = 733
  Top = 110
  BorderStyle = bsToolWindow
  ClientHeight = 319
  ClientWidth = 283
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
  object Label25: TLabel
    Left = 44
    Top = 296
    Width = 30
    Height = 13
    Caption = 'Pose :'
  end
  object progress: TProgressBar
    Left = 274
    Top = 0
    Width = 9
    Height = 273
    Min = 0
    Max = 100
    Orientation = pbVertical
    TabOrder = 0
  end
  object memo_stats: TMemo
    Left = 192
    Top = 0
    Width = 81
    Height = 273
    Color = clScrollBar
    ReadOnly = True
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 192
    Top = 276
    Width = 89
    Height = 41
    TabOrder = 2
    object Label10: TLabel
      Left = 40
      Top = 2
      Width = 40
      Height = 13
      Caption = 'Images :'
    end
    object Edit6: TEdit
      Left = 40
      Top = 18
      Width = 41
      Height = 19
      Color = clBtnFace
      Ctl3D = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 0
    end
    object BitBtn1: TBitBtn
      Left = 8
      Top = 8
      Width = 25
      Height = 25
      Hint = 'Contr'#244'le WebCam'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = BitBtn1Click
      Glyph.Data = {
        7E010000424D7E01000000000000760000002800000016000000160000000100
        0400000000000801000000000000000000001000000010000000000404000A11
        150012293E00414A4F0000548D000084CC00568096008B9FA8003BBAF30087C4
        E2008EDBFF00C6CEDA00DEDEDE00EFEFEF00E7EFF700FFFFFF00FD3025555555
        555555411B00FB0255555555555544420600FB0155855555444444440300FC20
        48888555444444410B00FF70288A8554444444203C00FFD30285422121244401
        7F00FFFF3022011111021017FF00FFFFC31033633330037FFF00FFFFF7027777
        663316DFFF00FFFFB13AAAAAA96331BFFF00FFFF617A779AA977316DFF00FFFF
        13A31137AAA7630FFF00FFFF163268339AA7631FFF00FFFF16238A819AAA731F
        FF00FFFF2623A8717AAA731FFF00FFFF733168229AAA612FFF00FFFFC2631127
        AAA931BFFF00FFFFF706669AAAA613CFFF00FFFFFE30369AA9313CFFFF00FFFF
        FFF620111013FFFFFF00FFFFFFFFB71113BFFFFFFF00FFFFFFFFFFBBBCFFFFFF
        FF00}
    end
  end
  object Panel1: TPanel
    Left = 87
    Top = 288
    Width = 65
    Height = 29
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'Stop'
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnDblClick = Stop1Click
  end
  object GroupBox14: TGroupBox
    Left = 0
    Top = 80
    Width = 189
    Height = 57
    Caption = 'Fen'#234'trage'
    TabOrder = 4
    object outLabel32: TLabel
      Left = 4
      Top = 16
      Width = 19
      Height = 13
      Caption = 'X1 :'
    end
    object outLabel35: TLabel
      Left = 4
      Top = 36
      Width = 19
      Height = 13
      Caption = 'X2 :'
    end
    object outLabel36: TLabel
      Left = 84
      Top = 16
      Width = 19
      Height = 13
      Caption = 'Y1 :'
    end
    object outLabel37: TLabel
      Left = 84
      Top = 36
      Width = 19
      Height = 13
      Caption = 'Y2 :'
    end
    object SpeedButton1: TSpeedButton
      Left = 160
      Top = 24
      Width = 23
      Height = 22
      Caption = 'I'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SpeedButton1Click
    end
    object win_x1: TEdit
      Left = 28
      Top = 12
      Width = 49
      Height = 21
      TabOrder = 0
      Text = '1'
    end
    object win_x2: TEdit
      Left = 28
      Top = 32
      Width = 49
      Height = 21
      TabOrder = 1
      Text = '768'
    end
    object win_y1: TEdit
      Left = 108
      Top = 12
      Width = 49
      Height = 21
      TabOrder = 2
      Text = '1'
    end
    object win_y2: TEdit
      Left = 108
      Top = 32
      Width = 49
      Height = 21
      TabOrder = 3
      Text = '512'
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 189
    Height = 45
    Caption = 'Start'
    TabOrder = 5
    object Stop: TButton
      Left = 10
      Top = 16
      Width = 168
      Height = 25
      Caption = 'Stop'
      TabOrder = 3
      OnClick = Stop1Click
    end
    object outAcqB1: TButton
      Left = 10
      Top = 16
      Width = 56
      Height = 25
      Caption = '1x1'
      TabOrder = 0
      OnClick = outAcqB1Click
    end
    object outAcqB4: TButton
      Left = 122
      Top = 16
      Width = 56
      Height = 25
      Caption = '4x4'
      TabOrder = 1
      OnClick = outAcqB4Click
    end
    object outAcqB2: TButton
      Left = 66
      Top = 16
      Width = 56
      Height = 25
      Caption = '2x2'
      TabOrder = 2
      OnClick = outAcqB2Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 44
    Width = 189
    Height = 37
    Caption = 'Pose'
    TabOrder = 6
    object Label6: TLabel
      Left = 24
      Top = 16
      Width = 38
      Height = 13
      Caption = 'Temps :'
    end
    object Label7: TLabel
      Left = 144
      Top = 16
      Width = 22
      Height = 13
      Caption = 'Sec.'
    end
    object Edit5: TEdit
      Left = 68
      Top = 12
      Width = 49
      Height = 21
      TabOrder = 0
      Text = '1'
    end
    object SpinButton1: TSpinButton
      Left = 116
      Top = 12
      Width = 20
      Height = 21
      DownGlyph.Data = {
        DE000000424DDE00000000000000360000002800000009000000060000000100
        180000000000A800000000000000000000000000000000000000008080008080
        0080800080800080800080800080800080800080800300808000808000808000
        8080000000008080008080008080008080000080800080800080800000000000
        0000000000808000808000808000008080008080000000000000000000000000
        0000000080800080800300808000000000000000000000000000000000000000
        0000008080000080800080800080800080800080800080800080800080800080
        8003}
      TabOrder = 1
      UpGlyph.Data = {
        DE000000424DDE00000000000000360000002800000009000000060000000100
        180000000000A800000000000000000000000000000000000000008080008080
        0080800080800080800080800080800080800080800300808000000000000000
        0000000000000000000000000000008080000080800080800000000000000000
        0000000000000000808000808000008080008080008080000000000000000000
        0080800080800080800300808000808000808000808000000000808000808000
        8080008080030080800080800080800080800080800080800080800080800080
        8000}
      OnDownClick = SpinButton1DownClick
      OnUpClick = SpinButton1UpClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 136
    Width = 189
    Height = 149
    Caption = 'Guidage'
    TabOrder = 7
    object Label1: TLabel
      Left = 8
      Top = 128
      Width = 61
      Height = 13
      Caption = 'D'#233'clinaison :'
    end
    object Label2: TLabel
      Left = 124
      Top = 128
      Width = 32
      Height = 13
      Caption = 'd'#233'gr'#233's'
    end
    object btnChercher: TButton
      Left = 9
      Top = 16
      Width = 81
      Height = 21
      Hint = 'Chercher une '#233'toile de guidage'
      Caption = 'Chercher'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnChercherClick
    end
    object btn_track_stop: TButton
      Left = 99
      Top = 16
      Width = 77
      Height = 61
      Caption = 'Stop'
      TabOrder = 3
      OnClick = btn_track_stopClick
    end
    object btn_calibrer: TButton
      Left = 9
      Top = 36
      Width = 81
      Height = 21
      Hint = 'Lancer la calibration'
      Caption = 'Calibrer'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = Btn_calibrerClick
    end
    object btn_track_start: TButton
      Left = 9
      Top = 56
      Width = 81
      Height = 21
      Hint = 'Lancer le guidage'
      Caption = 'Guider'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btn_track_startClick
    end
    object Button1: TButton
      Left = 8
      Top = 80
      Width = 169
      Height = 21
      Caption = 'Prendre le noir avant'
      TabOrder = 4
      OnClick = Button1Click
    end
    object NbreEdit1: NbreEdit
      Left = 80
      Top = 124
      Width = 37
      Height = 21
      TabOrder = 5
      Text = '0'
      ValMax = 80
      ValMin = -80
      TypeData = 0
    end
    object Button2: TButton
      Left = 164
      Top = 116
      Width = 20
      Height = 20
      Hint = 'Param'#232'tres du guidage'
      Caption = '?'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = Button2Click
    end
    object CheckBox2: TCheckBox
      Left = 8
      Top = 104
      Width = 141
      Height = 17
      Caption = 'Inverser l'#39'orientation'
      TabOrder = 7
    end
  end
  object CheckBox1: TCheckBox
    Left = 196
    Top = 252
    Width = 76
    Height = 17
    Caption = 'Statistiques'
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object TimerInter1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = TimerInter1Timer
    Left = 236
    Top = 64
  end
  object TimerInter2: TTimer
    Enabled = False
    Interval = 10
    OnTimer = TimerInter2Timer
    Left = 236
    Top = 96
  end
  object TimerInter4: TTimer
    Enabled = False
    Interval = 10
    OnTimer = TimerInter4Timer
    Left = 236
    Top = 128
  end
end
