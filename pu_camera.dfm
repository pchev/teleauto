object pop_camera: Tpop_camera
  Left = 725
  Top = 174
  BorderStyle = bsToolWindow
  ClientHeight = 355
  ClientWidth = 291
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
    Left = 211
    Top = 312
    Width = 66
    Height = 13
    Caption = 'Temp'#233'rature :'
  end
  object Label25: TLabel
    Left = 96
    Top = 332
    Width = 30
    Height = 13
    Caption = 'Pose :'
  end
  object pages_ccd: TPageControl
    Left = 1
    Top = 1
    Width = 198
    Height = 320
    ActivePage = Acq
    TabIndex = 0
    TabOrder = 0
    object Acq: TTabSheet
      Caption = 'Acquisition'
      object GroupBox14: TGroupBox
        Left = 0
        Top = 228
        Width = 189
        Height = 61
        Caption = 'Fen'#234'trage'
        TabOrder = 0
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
          Left = 76
          Top = 16
          Width = 19
          Height = 13
          Caption = 'Y1 :'
        end
        object outLabel37: TLabel
          Left = 76
          Top = 36
          Width = 19
          Height = 13
          Caption = 'Y2 :'
        end
        object SpeedButton1: TSpeedButton
          Left = 156
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
          Width = 41
          Height = 21
          TabOrder = 0
          Text = '1'
        end
        object win_x2: TEdit
          Left = 28
          Top = 32
          Width = 41
          Height = 21
          TabOrder = 1
          Text = '768'
        end
        object win_y1: TEdit
          Left = 100
          Top = 12
          Width = 41
          Height = 21
          TabOrder = 2
          Text = '1'
        end
        object win_y2: TEdit
          Left = 100
          Top = 32
          Width = 41
          Height = 21
          TabOrder = 3
          Text = '512'
        end
      end
      object RadioGroup1: TRadioGroup
        Left = 128
        Top = 124
        Width = 61
        Height = 101
        Caption = 'Type'
        ItemIndex = 0
        Items.Strings = (
          'Image'
          'Offset'
          'Noir'
          'Flat')
        TabOrder = 1
        OnClick = RadioGroup1Click
      end
      object GroupBox5: TGroupBox
        Left = 0
        Top = 0
        Width = 189
        Height = 41
        Caption = 'Binning 1x1'
        TabOrder = 2
        object Label8: TLabel
          Left = 4
          Top = 18
          Width = 38
          Height = 13
          Caption = 'Temps :'
        end
        object outLabel9: TLabel
          Left = 104
          Top = 18
          Width = 22
          Height = 13
          Caption = 'Sec.'
        end
        object exp_b1: TEdit
          Left = 44
          Top = 14
          Width = 37
          Height = 21
          TabOrder = 0
          Text = '1'
        end
        object SpinButton2: TSpinButton
          Left = 80
          Top = 14
          Width = 20
          Height = 21
          DownGlyph.Data = {
            DE000000424DDE00000000000000360000002800000009000000060000000100
            180000000000A800000000000000000000000000000000000000008080008080
            0080800080800080800080800080800080800080800200808000808000808000
            8080000000008080008080008080008080000080800080800080800000000000
            0000000000808000808000808002008080008080000000000000000000000000
            000000008080008080F000808000000000000000000000000000000000000000
            0000008080020080800080800080800080800080800080800080800080800080
            8000}
          TabOrder = 1
          UpGlyph.Data = {
            DE000000424DDE00000000000000360000002800000009000000060000000100
            180000000000A800000000000000000000000000000000000000008080008080
            0080800080800080800080800080800080800080800200808000000000000000
            0000000000000000000000000000008080810080800080800000000000000000
            0000000000000000808000808000008080008080008080000000000000000000
            0080800080800080800200808000808000808000808000000000808000808000
            8080008080000080800080800080800080800080800080800080800080800080
            8081}
          OnDownClick = SpinButton2DownClick
          OnUpClick = SpinButton2UpClick
        end
        object Stop1: TButton
          Left = 128
          Top = 12
          Width = 57
          Height = 25
          Caption = 'Stop'
          TabOrder = 3
          OnClick = Stop1Click
        end
        object outAcqB1: TButton
          Left = 128
          Top = 12
          Width = 57
          Height = 25
          Caption = '&Start'
          TabOrder = 2
          OnClick = outAcqB1Click
        end
      end
      object GroupBox6: TGroupBox
        Left = 0
        Top = 41
        Width = 189
        Height = 41
        Caption = 'Binning 2x2'
        TabOrder = 3
        object Label18: TLabel
          Left = 4
          Top = 18
          Width = 38
          Height = 13
          Caption = 'Temps :'
        end
        object outLabel20: TLabel
          Left = 104
          Top = 18
          Width = 22
          Height = 13
          Caption = 'Sec.'
        end
        object exp_b2: TEdit
          Left = 44
          Top = 14
          Width = 37
          Height = 21
          TabOrder = 1
          Text = '1'
        end
        object SpinButton3: TSpinButton
          Left = 80
          Top = 14
          Width = 20
          Height = 21
          DownGlyph.Data = {
            DE000000424DDE00000000000000360000002800000009000000060000000100
            180000000000A800000000000000000000000000000000000000008080008080
            0080800080800080800080800080800080800080800200808000808000808000
            8080000000008080008080008080008080020080800080800080800000000000
            0000000000808000808000808001008080008080000000000000000000000000
            0000000080800080800000808000000000000000000000000000000000000000
            0000008080810080800080800080800080800080800080800080800080800080
            8000}
          TabOrder = 2
          UpGlyph.Data = {
            DE000000424DDE00000000000000360000002800000009000000060000000100
            180000000000A800000000000000000000000000000000000000008080008080
            0080800080800080800080800080800080800080800200808000000000000000
            0000000000000000000000000000008080020080800080800000000000000000
            0000000000000000808000808001008080008080008080000000000000000000
            0080800080800080800000808000808000808000808000000000808000808000
            8080008080030080800080800080800080800080800080800080800080800080
            8000}
          OnDownClick = SpinButton3DownClick
          OnUpClick = SpinButton3UpClick
        end
        object Stop2: TButton
          Left = 128
          Top = 12
          Width = 57
          Height = 25
          Caption = 'Stop'
          TabOrder = 3
          OnClick = Stop1Click
        end
        object outAcqB2: TButton
          Left = 128
          Top = 12
          Width = 57
          Height = 25
          Caption = 'S&tart'
          TabOrder = 0
          OnClick = outAcqB2Click
        end
      end
      object GroupBox7: TGroupBox
        Left = 0
        Top = 82
        Width = 189
        Height = 41
        Caption = 'Binning 4x4'
        TabOrder = 4
        object Label19: TLabel
          Left = 4
          Top = 18
          Width = 38
          Height = 13
          Caption = 'Temps :'
        end
        object outLabel21: TLabel
          Left = 104
          Top = 18
          Width = 22
          Height = 13
          Caption = 'Sec.'
        end
        object exp_b4: TEdit
          Left = 44
          Top = 14
          Width = 37
          Height = 21
          TabOrder = 1
          Text = '1'
        end
        object SpinButton4: TSpinButton
          Left = 80
          Top = 14
          Width = 20
          Height = 21
          DownGlyph.Data = {
            DE000000424DDE00000000000000360000002800000009000000060000000100
            180000000000A800000000000000000000000000000000000000008080008080
            0080800080800080800080800080800080800080800000808000808000808000
            8080000000008080008080008080008080000080800080800080800000000000
            0000000000808000808000808000008080008080000000000000000000000000
            0000000080800080800000808000000000000000000000000000000000000000
            0000008080000080800080800080800080800080800080800080800080800080
            8001}
          TabOrder = 2
          UpGlyph.Data = {
            DE000000424DDE00000000000000360000002800000009000000060000000100
            180000000000A800000000000000000000000000000000000000008080008080
            0080800080800080800080800080800080800080800000808000000000000000
            0000000000000000000000000000008080000080800080800000000000000000
            0000000000000000808000808000008080008080008080000000000000000000
            0080800080800080800000808000808000808000808000000000808000808000
            8080008080000080800080800080800080800080800080800080800080800080
            8081}
          OnDownClick = SpinButton4DownClick
          OnUpClick = SpinButton4UpClick
        end
        object Stop4: TButton
          Left = 128
          Top = 12
          Width = 57
          Height = 25
          Caption = 'Stop'
          TabOrder = 3
          OnClick = Stop1Click
        end
        object outAcqB4: TButton
          Left = 128
          Top = 12
          Width = 57
          Height = 25
          Caption = 'St&art'
          TabOrder = 0
          OnClick = outAcqB4Click
        end
      end
      object GroupBox8: TGroupBox
        Left = 0
        Top = 124
        Width = 125
        Height = 101
        Caption = 'S'#233'rie'
        TabOrder = 5
        object Label16: TLabel
          Left = 4
          Top = 40
          Width = 32
          Height = 13
          Caption = 'Index :'
        end
        object Label13: TLabel
          Left = 4
          Top = 80
          Width = 28
          Height = 13
          Caption = 'Nom :'
        end
        object cb_bouclage: TCheckBox
          Left = 4
          Top = 14
          Width = 73
          Height = 17
          Caption = 'Bouclage :'
          TabOrder = 0
        end
        object nb_bouclage: TSpinEdit
          Left = 76
          Top = 11
          Width = 45
          Height = 22
          MaxValue = 999999
          MinValue = 0
          TabOrder = 1
          Value = 15
        end
        object cb_autosave: TCheckBox
          Left = 4
          Top = 58
          Width = 113
          Height = 17
          Caption = 'Sauvegarde Auto'
          TabOrder = 2
        end
        object index: TSpinEdit
          Left = 40
          Top = 35
          Width = 81
          Height = 22
          MaxValue = 99999
          MinValue = 1
          TabOrder = 3
          Value = 1
        end
        object img_name: TEdit
          Left = 36
          Top = 76
          Width = 85
          Height = 21
          TabOrder = 4
          OnChange = img_nameChange
        end
      end
    end
    object PageFiltres: TTabSheet
      Caption = 'CFW8'
      ImageIndex = 2
      object GroupBox13: TGroupBox
        Left = 31
        Top = 28
        Width = 125
        Height = 129
        Caption = 'Filtres'
        TabOrder = 0
        object RadioButton1: TRadioButton
          Left = 8
          Top = 20
          Width = 113
          Height = 17
          Caption = 'Filtre 1'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = RadioButton1Click
        end
        object RadioButton2: TRadioButton
          Left = 8
          Top = 41
          Width = 113
          Height = 17
          Caption = 'Filtre 2'
          TabOrder = 1
          OnClick = RadioButton2Click
        end
        object RadioButton3: TRadioButton
          Left = 8
          Top = 62
          Width = 113
          Height = 17
          Caption = 'Filtre 3'
          TabOrder = 2
          OnClick = RadioButton3Click
        end
        object RadioButton4: TRadioButton
          Left = 8
          Top = 83
          Width = 113
          Height = 17
          Caption = 'Filtre 4'
          TabOrder = 3
          OnClick = RadioButton4Click
        end
        object RadioButton5: TRadioButton
          Left = 8
          Top = 104
          Width = 113
          Height = 17
          Caption = 'Filtre 5'
          TabOrder = 4
          OnClick = RadioButton5Click
        end
      end
      object CheckBox2: TCheckBox
        Left = 8
        Top = 8
        Width = 177
        Height = 17
        Caption = 'Utiliser la roue '#224' filtres'
        TabOrder = 1
        OnClick = CheckBox2Click
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Surveillance'
      ImageIndex = 2
      object Label12: TLabel
        Left = 4
        Top = 8
        Width = 167
        Height = 13
        Caption = 'Cette fonction enregistre les images'
      end
      object Label14: TLabel
        Left = 4
        Top = 24
        Width = 141
        Height = 13
        Caption = 'o'#249' un mouvement est d'#233'tect'#233
      end
      object Button2: TButton
        Left = 58
        Top = 52
        Width = 75
        Height = 25
        Caption = 'Stop'
        TabOrder = 1
        OnClick = Button2Click
      end
      object Button1: TButton
        Left = 58
        Top = 52
        Width = 75
        Height = 25
        Caption = 'Start'
        TabOrder = 0
        OnClick = Button1Click
      end
      object GroupBox1: TGroupBox
        Left = 2
        Top = 188
        Width = 185
        Height = 93
        Caption = 'R'#233'glages'
        TabOrder = 2
        object Label5: TLabel
          Left = 4
          Top = 20
          Width = 103
          Height = 13
          Caption = 'Attente entre images :'
          OnClick = BitBtn1Click
        end
        object Label6: TLabel
          Left = 159
          Top = 20
          Width = 22
          Height = 13
          Caption = 'Sec.'
        end
        object Label7: TLabel
          Left = 4
          Top = 44
          Width = 87
          Height = 13
          Caption = 'Nombre d'#39'images :'
        end
        object Label9: TLabel
          Left = 4
          Top = 68
          Width = 108
          Height = 13
          Caption = 'Diff'#233'rence d'#233'marrage :'
        end
        object Label11: TLabel
          Left = 164
          Top = 68
          Width = 8
          Height = 13
          Caption = '%'
        end
        object NbreEdit1: NbreEdit
          Left = 116
          Top = 16
          Width = 41
          Height = 21
          TabOrder = 0
          Text = '0'
          ValMin = 1000
          TypeData = 0
        end
        object SpinEdit1: TSpinEdit
          Left = 116
          Top = 39
          Width = 41
          Height = 22
          MaxValue = 99
          MinValue = 1
          TabOrder = 1
          Value = 1
        end
        object SpinEdit2: TSpinEdit
          Left = 116
          Top = 63
          Width = 41
          Height = 22
          MaxValue = 99
          MinValue = 1
          TabOrder = 2
          Value = 50
        end
      end
      object GroupBox2: TGroupBox
        Left = 2
        Top = 92
        Width = 185
        Height = 85
        Caption = 'Etat'
        TabOrder = 3
        object Label2: TLabel
          Left = 8
          Top = 20
          Width = 32
          Height = 13
          Caption = 'Label2'
        end
        object Label3: TLabel
          Left = 8
          Top = 40
          Width = 32
          Height = 13
          Caption = 'Label3'
        end
        object Label4: TLabel
          Left = 8
          Top = 60
          Width = 32
          Height = 13
          Caption = 'Label4'
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Visu'
      ImageIndex = 3
      object RadioGroup12: TRadioGroup
        Left = 4
        Top = 8
        Width = 181
        Height = 57
        Caption = 'Visualisation '#224' la prise de vue'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Stellaire'
          'Plan'#233'taire'
          'Maximum'
          'Seuil Fixe')
        TabOrder = 0
        OnClick = RadioGroup12Click
      end
      object Panel3: TPanel
        Left = 5
        Top = 72
        Width = 180
        Height = 53
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        Visible = False
        object Label169: TLabel
          Left = 8
          Top = 8
          Width = 49
          Height = 13
          Caption = 'Seuil bas :'
        end
        object Label170: TLabel
          Left = 8
          Top = 32
          Width = 53
          Height = 13
          Caption = 'Seuil haut :'
        end
        object SpeedButton2: TSpeedButton
          Left = 144
          Top = 16
          Width = 23
          Height = 22
          Caption = 'I'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton2Click
        end
        object NbreEdit24: NbreEdit
          Left = 72
          Top = 4
          Width = 57
          Height = 21
          TabOrder = 0
          Text = '0'
          OnChange = NbreEdit24Change
          ValMax = 999999
          ValMin = -999999
          TypeData = 2
        end
        object NbreEdit25: NbreEdit
          Left = 72
          Top = 28
          Width = 57
          Height = 21
          TabOrder = 1
          Text = '255'
          OnChange = NbreEdit25Change
          ValMax = 999999
          ValMin = -999999
          TypeData = 2
        end
      end
    end
  end
  object progress: TProgressBar
    Left = 282
    Top = 0
    Width = 9
    Height = 309
    Min = 0
    Max = 100
    Orientation = pbVertical
    TabOrder = 1
  end
  object memo_stats: TMemo
    Left = 200
    Top = 0
    Width = 81
    Height = 313
    Color = clScrollBar
    ReadOnly = True
    TabOrder = 2
  end
  object Panel6: TPanel
    Left = 200
    Top = 328
    Width = 89
    Height = 25
    BevelOuter = bvLowered
    Caption = 'Inconnue'
    TabOrder = 3
  end
  object Panel2: TPanel
    Left = 1
    Top = 321
    Width = 89
    Height = 34
    BevelOuter = bvNone
    TabOrder = 4
    object Label10: TLabel
      Left = 40
      Top = 2
      Width = 40
      Height = 13
      Caption = 'Images :'
    end
    object Edit6: TEdit
      Left = 40
      Top = 15
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
      Top = 7
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
    Left = 131
    Top = 324
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
    TabOrder = 5
    OnDblClick = Stop1Click
  end
  object CheckBox1: TCheckBox
    Left = 204
    Top = 292
    Width = 76
    Height = 17
    Caption = 'Statistiques'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object TimerInter4: TTimer
    Enabled = False
    Interval = 10
    OnTimer = TimerInter4Timer
    Left = 244
    Top = 160
  end
  object TimerInter1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = TimerInter1Timer
    Left = 244
    Top = 96
  end
  object TimerInter2: TTimer
    Enabled = False
    Interval = 10
    OnTimer = TimerInter2Timer
    Left = 244
    Top = 128
  end
  object TimerTemp: TTimer
    Enabled = False
    OnTimer = TimerTempTimer
    Left = 228
    Top = 236
  end
  object TimerInter: TTimer
    Enabled = False
    Interval = 10
    OnTimer = TimerInterTimer
    Left = 244
    Top = 56
  end
end
