object pop_scope: Tpop_scope
  Left = 959
  Top = 459
  BorderStyle = bsToolWindow
  Caption = 'T'#233'lescope'
  ClientHeight = 382
  ClientWidth = 198
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
  object outLabel30: TLabel
    Left = 0
    Top = 226
    Width = 33
    Height = 13
    Caption = 'Alpha :'
  end
  object outLabel31: TLabel
    Left = 2
    Top = 246
    Width = 31
    Height = 13
    Caption = 'Delta :'
  end
  object Label4: TLabel
    Left = 0
    Top = 306
    Width = 64
    Height = 13
    Caption = 'Angle Horaire'
  end
  object Label5: TLabel
    Left = 2
    Top = 326
    Width = 20
    Height = 13
    Caption = 'TSL'
  end
  object Label6: TLabel
    Left = -1
    Top = 346
    Width = 53
    Height = 13
    Caption = 'Masse d'#39'air'
  end
  object Label9: TLabel
    Left = 0
    Top = 266
    Width = 37
    Height = 13
    Caption = 'Azimuth'
  end
  object Label10: TLabel
    Left = 0
    Top = 286
    Width = 38
    Height = 13
    Caption = 'Hauteur'
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 197
    Height = 221
    ActivePage = pointage
    TabIndex = 1
    TabOrder = 0
    object pad: TTabSheet
      Caption = 'Raquette'
      object img_last_command: TImage
        Left = 149
        Top = 1
        Width = 40
        Height = 40
      end
      object Label2: TLabel
        Left = 72
        Top = 24
        Width = 22
        Height = 13
        Caption = 'Sec.'
      end
      object GroupBoxDeplacement: TGroupBox
        Left = 2
        Top = 44
        Width = 55
        Height = 117
        Caption = ' Vitesse '
        TabOrder = 0
        object btnSpeed1: TSpeedButton
          Left = 3
          Top = 16
          Width = 49
          Height = 25
          GroupIndex = 1
          Caption = 'Pointer'
          OnClick = btnSpeed1Click
        end
        object btnSpeed2: TSpeedButton
          Left = 3
          Top = 40
          Width = 49
          Height = 25
          GroupIndex = 1
          Down = True
          Caption = 'Chercher'
          OnClick = btnSpeed2Click
        end
        object btnSpeed3: TSpeedButton
          Left = 3
          Top = 64
          Width = 49
          Height = 25
          GroupIndex = 1
          Caption = 'Centrer'
          OnClick = btnSpeed3Click
        end
        object btnSpeed4: TSpeedButton
          Left = 3
          Top = 88
          Width = 49
          Height = 25
          GroupIndex = 1
          Caption = 'Guider'
          OnClick = btnSpeed4Click
        end
      end
      object GroupBoxInversion: TGroupBox
        Left = 0
        Top = 161
        Width = 189
        Height = 33
        Caption = ' Inversion '
        TabOrder = 1
        object cb_inversionNS: TCheckBox
          Left = 8
          Top = 13
          Width = 85
          Height = 15
          TabStop = False
          Caption = 'Nord/Sud '
          TabOrder = 0
          OnClick = cb_inversionNSClick
        end
        object cb_InversionEO: TCheckBox
          Left = 96
          Top = 13
          Width = 73
          Height = 15
          TabStop = False
          Caption = 'Est/Ouest'
          TabOrder = 1
          OnClick = cb_InversionEOClick
        end
      end
      object BitBtn1: TBitBtn
        Left = 106
        Top = 26
        Width = 40
        Height = 40
        TabOrder = 2
        OnMouseDown = BitBtn1MouseDown
        OnMouseUp = BitBtn1MouseUp
        Glyph.Data = {
          76020000424D7602000000000000760000002800000020000000200000000100
          04000000000000020000110B0000110B00001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777000
          0000000000077777777777777777700000000000000777777777777777777006
          6666666660077777777777777777700666666666600777777777777777777006
          6666666660077777777777777777700600666600600777777777777777777006
          0066600060077777777777777777700600660000600777777777777777777006
          0066000060077777777777777777700600600600600777777777777777777006
          0060060060077777777777777777700600006600600777777777777777777006
          0000660060077777777777777777700600066600600777777777777777777006
          0066660060077777777777777777700666666666600777777777700000000006
          6666666660000000000770000000000666666666600000000007770006666666
          6666666666666660007777700066666666666666666666000777777700066666
          6666666666666000777777777000666666666666666600077777777777000666
          6666666666600077777777777770006666666666660007777777777777770006
          6666666660007777777777777777700066666666000777777777777777777700
          0666666000777777777777777777777000666600077777777777777777777777
          0006600077777777777777777777777770000007777777777777777777777777
          7700007777777777777777777777777777700777777777777777}
      end
      object BitBtn2: TBitBtn
        Left = 106
        Top = 110
        Width = 40
        Height = 40
        TabOrder = 3
        OnMouseDown = BitBtn2MouseDown
        OnMouseUp = BitBtn2MouseUp
        Glyph.Data = {
          76020000424D7602000000000000760000002800000020000000200000000100
          04000000000000020000110B0000110B00001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7770077777777777777777777777777777000077777777777777777777777777
          7000000777777777777777777777777700066000777777777777777777777770
          0066660007777777777777777777770006666660007777777777777777777000
          6666666600077777777777777777000666666666600077777777777777700066
          6666666666000777777777777700066666666666666000777777777770006666
          6666666666660007777777770006666666666666666660007777777000666666
          6666666666666600077777000666666666666666666666600077700000000006
          6666666660000000000770000000000666666666600000000007777777777006
          6600006660077777777777777777700660000006600777777777777777777006
          0066660060077777777777777777700600666600600777777777777777777006
          6666600060077777777777777777700666000006600777777777777777777006
          6000066660077777777777777777700600666666600777777777777F77777006
          0066660060077777777777777777700600666600600777777777777777777006
          6000000660077777777777777777700666000066600777777777777777777006
          6666666660077777777777777777700666666666600777777777777777777000
          0000000000077777777777777777700000000000000777777777}
      end
      object BitBtn3: TBitBtn
        Left = 64
        Top = 68
        Width = 40
        Height = 40
        TabOrder = 4
        OnMouseDown = BitBtn3MouseDown
        OnMouseUp = BitBtn3MouseUp
        Glyph.Data = {
          76020000424D7602000000000000760000002800000020000000200000000100
          04000000000000020000110B0000110B00001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777777777777777777777777777777777007777777777777777777777777777
          7000777777777777777777777777777700007777777777777777777777777770
          0000777777777777777777777777770006007777777777777777777777777000
          6600777777777777777777777777000666007777777777777777777777700066
          6600777777777777777777777700066666000000000000000000777770006666
          6600000000000000000077770006666666666666666666666600777000666666
          6666660666660666660077000666666666666000666000666600700066666666
          6666600066600066660000066666666666660060060060066600000666666666
          6666006006006006660070006666666666660060060060066600770006666666
          6660066600066600660077700066666666600666000666006600777700066666
          6666666666666666660077777000666666000000000000000000777777000666
          6600000000000000000077777770006666007777777777777777777777770006
          6600777777777777777777777777700066007777777777777777777777777700
          0600777777777777777777777777777000007777777777777777777777777777
          0000777777777777777777777777777770007777777777777777777777777777
          7700777777777777777777777777777777777777777777777777}
      end
      object BitBtn4: TBitBtn
        Left = 148
        Top = 68
        Width = 40
        Height = 40
        TabOrder = 5
        OnMouseDown = BitBtn4MouseDown
        OnMouseUp = BitBtn4MouseUp
        Glyph.Data = {
          76020000424D7602000000000000760000002800000020000000200000000100
          04000000000000020000110B0000110B00001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777777777777777777777777777777777770077777777777777777777777777
          7777000777777777777777777777777777770000777777777777777777777777
          7777000007777777777777777777777777770060007777777777777777777777
          7777006600077777777777777777777777770066600077777777777777777777
          7777006666000777777700000000000000000066666000777777000000000000
          0000006666660007777700666666666666666666666660007777006666600000
          0666666666666600077700666660000006666666666666600077006666600666
          6666666666666666000700666660000006666666666666666000006666600000
          0666666666666666600000666660066666666666666666660007006666600000
          0666666666666660007700666660000006666666666666000777006666666666
          6666666666666000777700000000000000000066666600077777000000000000
          0000006666600077777777777777777777770066660007777777777777777777
          7777006660007777777777777777777777770066000777777777777777777777
          7777006000777777777777777777777777770000077777777777777777777777
          7777000077777777777777777777777777770007777777777777777777777777
          7777007777777777777777777777777777777777777777777777}
      end
      object CheckBox1: TCheckBox
        Left = 4
        Top = 0
        Width = 97
        Height = 17
        Caption = 'Par impulsions'
        TabOrder = 6
      end
      object NbreEdit1: NbreEdit
        Left = 4
        Top = 20
        Width = 61
        Height = 21
        TabOrder = 7
        Text = '1'
        ValMax = 99
        ValMin = 0.1
        TypeData = 0
      end
      object BitBtn5: TBitBtn
        Left = 106
        Top = 68
        Width = 40
        Height = 40
        Caption = 'Stop'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 8
        OnClick = BitBtn5Click
      end
    end
    object pointage: TTabSheet
      Caption = 'Pointage'
      ImageIndex = 1
      object Label8: TLabel
        Left = 148
        Top = 156
        Width = 36
        Height = 13
        Caption = 'Marque'
      end
      object GroupBox11: TGroupBox
        Left = 0
        Top = 0
        Width = 189
        Height = 61
        Caption = 'Objet -  Ex M#, Vega...'
        TabOrder = 0
        object id: TEdit
          Left = 4
          Top = 24
          Width = 105
          Height = 21
          TabOrder = 0
        end
        object btn_pointer_objet: TButton
          Left = 112
          Top = 12
          Width = 73
          Height = 21
          Hint = 'Pointe sur cet objet'
          Caption = 'Pointer'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = btn_pointer_objetClick
        end
        object btn_realigner_objet: TButton
          Left = 112
          Top = 36
          Width = 73
          Height = 21
          Hint = 'Utilise cet objet comme reference'
          Caption = 'Synchroniser'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = btn_realigner_objetClick
        end
      end
      object GroupBox10: TGroupBox
        Left = 0
        Top = 61
        Width = 189
        Height = 76
        Caption = 'Coordonn'#233'es'
        TabOrder = 1
        object outLabel17: TLabel
          Left = 4
          Top = 31
          Width = 33
          Height = 13
          Caption = 'Alpha :'
        end
        object outLabel22: TLabel
          Left = 4
          Top = 53
          Width = 31
          Height = 13
          Caption = 'Delta :'
        end
        object mask_alpha: TMaskEdit
          Left = 40
          Top = 28
          Width = 69
          Height = 21
          EditMask = '!90:00:00;1;_'
          MaxLength = 8
          TabOrder = 0
          Text = '  :  :  '
        end
        object Mask_delta: TMaskEdit
          Left = 40
          Top = 51
          Width = 69
          Height = 21
          EditMask = '!#90'#176'00'#39'00";1;_'
          MaxLength = 10
          TabOrder = 1
          Text = '   '#176'  '#39'  "'
        end
        object btn_pointer: TButton
          Left = 112
          Top = 28
          Width = 68
          Height = 21
          Hint = 'Pointe sur ces coordonnees'
          Caption = 'Pointer'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = btn_pointerClick
        end
        object btn_realigner: TButton
          Left = 111
          Top = 53
          Width = 69
          Height = 20
          Hint = 'Utilise ces coordonnees comme reference'
          Caption = 'Synchroniser'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = btn_realignerClick
        end
        object CheckBox4: TCheckBox
          Left = 108
          Top = 8
          Width = 53
          Height = 17
          Caption = 'Altaz.'
          TabOrder = 4
          OnClick = CheckBox4Click
        end
      end
      object Button7: TButton
        Left = 68
        Top = 140
        Width = 57
        Height = 25
        Hint = 'Recentre l objet'
        Caption = 'Centrer G'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = Button7Click
      end
      object btn_RecenterStar: TButton
        Left = 0
        Top = 140
        Width = 65
        Height = 25
        Hint = 'Recentre l objet'
        Caption = 'Centrer P'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = btn_RecenterStarClick
      end
      object CheckBox3: TCheckBox
        Left = 128
        Top = 140
        Width = 97
        Height = 17
        Caption = 'Centrer'
        TabOrder = 4
      end
      object BitBtn7: TBitBtn
        Left = 2
        Top = 172
        Width = 183
        Height = 20
        Caption = 'Stop'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        OnClick = BitBtn5Click
      end
    end
    object outPark_tab: TTabSheet
      Caption = 'Park'
      ImageIndex = 2
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 185
        Height = 65
        Caption = 'Park'
        TabOrder = 0
        object outButton2: TButton
          Left = 4
          Top = 16
          Width = 85
          Height = 25
          Caption = 'Park'
          TabOrder = 0
          OnClick = outButton2Click
        end
        object cb_physique: TCheckBox
          Left = 4
          Top = 44
          Width = 97
          Height = 17
          Caption = 'Physique'
          TabOrder = 1
        end
        object outButton3: TButton
          Left = 92
          Top = 16
          Width = 85
          Height = 25
          Caption = 'UnPark'
          TabOrder = 2
          OnClick = outButton3Click
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 68
        Width = 185
        Height = 45
        Caption = 'Vitesse de pointage'
        TabOrder = 1
        object Label1: TLabel
          Left = 148
          Top = 21
          Width = 14
          Height = 13
          Caption = #176'/s'
        end
        object SpinEdit1: TSpinEdit
          Left = 8
          Top = 16
          Width = 125
          Height = 22
          MaxValue = 8
          MinValue = 2
          TabOrder = 0
          Value = 8
          OnChange = SpinEdit1Change
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Mod'#232'le'
      ImageIndex = 4
      object Button4: TButton
        Left = 4
        Top = 12
        Width = 181
        Height = 25
        Caption = 'Calibration Manuelle'
        TabOrder = 0
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 4
        Top = 40
        Width = 181
        Height = 25
        Caption = 'Calcul et analyse du mod'#232'le'
        TabOrder = 1
        OnClick = Button5Click
      end
      object CheckBox2: TCheckBox
        Left = 12
        Top = 68
        Width = 97
        Height = 17
        Caption = 'Utiliser le mod'#232'le'
        TabOrder = 2
        OnClick = CheckBox2Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Recentrage'
      ImageIndex = 5
      object Label75: TLabel
        Left = 4
        Top = 8
        Width = 104
        Height = 13
        Caption = 'Temps de calibration :'
      end
      object Label86: TLabel
        Left = 161
        Top = 8
        Width = 22
        Height = 13
        Caption = 'Sec.'
      end
      object Label7: TLabel
        Left = 8
        Top = 96
        Width = 96
        Height = 13
        Caption = 'Nombre d'#39'it'#233'rations :'
        OnClick = BitBtn5Click
      end
      object Edit44: TEdit
        Left = 116
        Top = 4
        Width = 37
        Height = 21
        TabOrder = 0
        Text = '0.5'
        OnChange = Edit44Change
      end
      object Button6: TButton
        Left = 8
        Top = 32
        Width = 129
        Height = 25
        Caption = 'Calibrer CCD Principal'
        TabOrder = 1
        OnClick = Button6Click
      end
      object SpinEdit2: TSpinEdit
        Left = 108
        Top = 92
        Width = 45
        Height = 22
        MaxValue = 99
        MinValue = 1
        TabOrder = 2
        Value = 1
        OnChange = SpinEdit2Change
      end
      object Button1: TButton
        Left = 8
        Top = 60
        Width = 129
        Height = 25
        Caption = 'Calibrer CCD guidage'
        TabOrder = 3
        OnClick = Button1Click
      end
    end
  end
  object PnlAlpha: TPanel
    Left = 75
    Top = 223
    Width = 120
    Height = 18
    BevelOuter = bvLowered
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object PnlDelta: TPanel
    Left = 75
    Top = 243
    Width = 120
    Height = 18
    BevelOuter = bvLowered
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object HourAngle: TPanel
    Left = 75
    Top = 303
    Width = 120
    Height = 18
    BevelOuter = bvLowered
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object LST: TPanel
    Left = 75
    Top = 323
    Width = 120
    Height = 18
    BevelOuter = bvLowered
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object PanelAirmass: TPanel
    Left = 75
    Top = 343
    Width = 120
    Height = 18
    BevelOuter = bvLowered
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object Panel1: TPanel
    Left = 75
    Top = 263
    Width = 120
    Height = 18
    BevelOuter = bvLowered
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object Panel2: TPanel
    Left = 75
    Top = 283
    Width = 120
    Height = 18
    BevelOuter = bvLowered
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object BitBtn6: TBitBtn
    Left = 0
    Top = 364
    Width = 197
    Height = 17
    TabOrder = 8
    OnClick = BitBtn6Click
    Glyph.Data = {
      C6000000424DC60000000000000076000000280000000A0000000A0000000100
      0400000000005000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888800
      0000888888888800000000000000000000008000000008000000880000008800
      0000888000088800000088880088880000008888888888000000888888888800
      00008888888888000000}
    Layout = blGlyphTop
  end
  object BitBtn8: TBitBtn
    Left = 0
    Top = 263
    Width = 197
    Height = 16
    TabOrder = 9
    OnClick = BitBtn8Click
    Glyph.Data = {
      C6000000424DC60000000000000076000000280000000A0000000A0000000100
      0400000000005000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888800
      0000888888888800000088888888880000008888008888000000888000088800
      0000880000008800000080000000080000000000000000000000888888888800
      00008888888888000000}
    Layout = blGlyphTop
  end
  object OpenDialog: TOpenDialog
    Filter = 'Fichiers Pic Cpa|*.pic;*.cpa'
    Options = []
    Left = 512
    Top = 113
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer2Timer
    Left = 140
    Top = 248
  end
end
