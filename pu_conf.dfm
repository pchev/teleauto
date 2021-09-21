object pop_conf: Tpop_conf
  Left = 282
  Top = 206
  BorderStyle = bsToolWindow
  Caption = 'Configuration'
  ClientHeight = 500
  ClientWidth = 512
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn2: TBitBtn
    Left = 152
    Top = 473
    Width = 75
    Height = 25
    Caption = '&Annuler'
    TabOrder = 0
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
  object BitBtn1: TBitBtn
    Left = 288
    Top = 473
    Width = 75
    Height = 25
    Caption = '&OK'
    TabOrder = 1
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object outPageControl1: TPageControl
    Left = 200
    Top = 0
    Width = 311
    Height = 441
    ActivePage = outTabSheet18
    MultiLine = True
    TabIndex = 14
    TabOrder = 2
    Visible = False
    object outTabSheet13: TTabSheet
      Caption = 'Sys'
      ImageIndex = 12
      object btn_load: TBitBtn
        Left = 8
        Top = 48
        Width = 137
        Height = 25
        Caption = '&Charger une configuration'
        TabOrder = 0
        OnClick = btn_loadClick
      end
      object btn_save: TBitBtn
        Left = 160
        Top = 48
        Width = 137
        Height = 25
        Caption = 'Sauver la configuration'
        TabOrder = 1
        OnClick = btn_saveClick
      end
      object GroupBox24: TGroupBox
        Left = 24
        Top = 112
        Width = 257
        Height = 77
        Caption = 'Interfaces d'#39'entr'#233'e des coordonn'#233'es'
        TabOrder = 2
        OnClick = BitBtn1Click
        object LabelAlphaSep: TLabel
          Left = 12
          Top = 24
          Width = 84
          Height = 13
          Caption = 'Ascension droite :'
        end
        object LabelDeltaSep: TLabel
          Left = 12
          Top = 48
          Width = 61
          Height = 13
          Caption = 'D'#233'clinaison :'
        end
        object ComboBoxAlphaSep: TComboBox
          Left = 100
          Top = 20
          Width = 145
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          Text = '16h05m15s'
          Items.Strings = (
            '16h05m15s'
            '16h05m15'
            '16:05:15')
        end
        object ComboBoxDeltaSep: TComboBox
          Left = 100
          Top = 44
          Width = 145
          Height = 21
          ItemHeight = 13
          TabOrder = 1
          Text = '75d45m02s'
          Items.Strings = (
            '75d45m02s'
            '75d45m02'
            '75'#176'45'#39'02"'
            '75'#176'45'#39'02')
        end
      end
      object CheckBoxCloseQuery: TCheckBox
        Left = 24
        Top = 208
        Width = 197
        Height = 17
        Caption = 'Confirmer la fermeture de TeleAuto'
        TabOrder = 3
      end
      object CheckBox20: TCheckBox
        Left = 24
        Top = 232
        Width = 253
        Height = 17
        Caption = 'Afficher les messages d'#233'taill'#233's dans le spy'
        TabOrder = 4
      end
    end
    object outTabSheet14: TTabSheet
      Caption = 'Rim'
      ImageIndex = 13
      object Label21: TLabel
        Left = 0
        Top = 32
        Width = 301
        Height = 13
        Caption = 'Sauvegarde des images acquises dans les repertoires suivants :'
      end
      object GroupBox4: TGroupBox
        Left = 4
        Top = 68
        Width = 297
        Height = 129
        Caption = 'Types d'#39'image'
        TabOrder = 0
        object Label41: TLabel
          Left = 12
          Top = 44
          Width = 40
          Height = 13
          Caption = 'Images :'
        end
        object Label42: TLabel
          Left = 12
          Top = 64
          Width = 39
          Height = 13
          Caption = 'Offsets :'
        end
        object Label43: TLabel
          Left = 20
          Top = 84
          Width = 30
          Height = 13
          Caption = 'Noirs :'
        end
        object Label44: TLabel
          Left = 24
          Top = 104
          Width = 26
          Height = 13
          Caption = 'Plus :'
        end
        object outPanel1: TPanel
          Left = 60
          Top = 40
          Width = 193
          Height = 21
          Alignment = taLeftJustify
          BevelOuter = bvLowered
          Caption = 'outPanel1'
          TabOrder = 8
        end
        object outPanel2: TPanel
          Left = 60
          Top = 60
          Width = 193
          Height = 21
          Alignment = taLeftJustify
          BevelOuter = bvLowered
          Caption = 'outPanel2'
          TabOrder = 7
        end
        object outPanel3: TPanel
          Left = 60
          Top = 80
          Width = 193
          Height = 21
          Alignment = taLeftJustify
          BevelOuter = bvLowered
          Caption = 'outPanel3'
          TabOrder = 6
        end
        object outPanel4: TPanel
          Left = 60
          Top = 100
          Width = 193
          Height = 21
          Alignment = taLeftJustify
          BevelOuter = bvLowered
          Caption = 'outPanel4'
          TabOrder = 5
        end
        object Button5: TButton
          Left = 12
          Top = 16
          Width = 269
          Height = 21
          Caption = 'Tous comme Images'
          TabOrder = 0
          OnClick = Button5Click
        end
        object Button1: TButton
          Left = 260
          Top = 40
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 1
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 260
          Top = 60
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 2
          OnClick = Button2Click
        end
        object Button3: TButton
          Left = 260
          Top = 80
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 3
          OnClick = Button3Click
        end
        object Button4: TButton
          Left = 260
          Top = 100
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 4
          OnClick = Button4Click
        end
      end
    end
    object outTabSheet7: TTabSheet
      Caption = 'Rcat'
      ImageIndex = 6
      object GroupBox5: TGroupBox
        Left = 4
        Top = 4
        Width = 297
        Height = 285
        Caption = 'Catalogues'
        TabOrder = 0
        object Label65: TLabel
          Left = 24
          Top = 68
          Width = 28
          Height = 13
          Caption = 'GSC :'
        end
        object Label37: TLabel
          Left = 16
          Top = 88
          Width = 37
          Height = 13
          Caption = 'USNO :'
        end
        object Label78: TLabel
          Left = 8
          Top = 48
          Width = 45
          Height = 13
          Caption = 'Tycho 2 :'
        end
        object Label79: TLabel
          Left = 24
          Top = 28
          Width = 30
          Height = 13
          Caption = 'Base :'
        end
        object Label80: TLabel
          Left = 8
          Top = 108
          Width = 47
          Height = 13
          Caption = 'Microcat :'
        end
        object Label98: TLabel
          Left = 8
          Top = 196
          Width = 53
          Height = 13
          Caption = 'Catalogues'
        end
        object Label103: TLabel
          Left = 8
          Top = 216
          Width = 62
          Height = 13
          Caption = 'correctement'
        end
        object Label104: TLabel
          Left = 8
          Top = 236
          Width = 43
          Height = 13
          Caption = 'install'#233's :'
        end
        object Button8: TButton
          Left = 264
          Top = 24
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 5
          OnClick = Button8Click
        end
        object Button10: TButton
          Left = 264
          Top = 44
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 7
          OnClick = Button10Click
        end
        object outPanel8: TPanel
          Left = 64
          Top = 24
          Width = 193
          Height = 21
          Alignment = taLeftJustify
          BevelOuter = bvLowered
          Caption = 'outPanel8'
          TabOrder = 0
        end
        object outPanel9: TPanel
          Left = 64
          Top = 44
          Width = 193
          Height = 21
          Alignment = taLeftJustify
          BevelOuter = bvLowered
          Caption = 'outPanel9'
          TabOrder = 1
        end
        object outPanel7: TPanel
          Left = 64
          Top = 64
          Width = 193
          Height = 21
          Alignment = taLeftJustify
          BevelOuter = bvLowered
          Caption = 'outPanel7'
          TabOrder = 3
        end
        object outPanel10: TPanel
          Left = 64
          Top = 84
          Width = 193
          Height = 21
          Alignment = taLeftJustify
          BevelOuter = bvLowered
          Caption = 'outPanel10'
          TabOrder = 2
        end
        object outPanel11: TPanel
          Left = 64
          Top = 104
          Width = 193
          Height = 21
          Alignment = taLeftJustify
          BevelOuter = bvLowered
          Caption = 'outPanel11'
          TabOrder = 8
        end
        object Button7: TButton
          Left = 264
          Top = 64
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 4
          OnClick = Button7Click
        end
        object Button9: TButton
          Left = 264
          Top = 84
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 6
          OnClick = Button9Click
        end
        object Button11: TButton
          Left = 264
          Top = 104
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 9
          OnClick = Button11Click
        end
        object ListBox1: TListBox
          Left = 80
          Top = 176
          Width = 205
          Height = 97
          ItemHeight = 13
          TabOrder = 10
        end
        object RadioGroup5: TRadioGroup
          Left = 8
          Top = 132
          Width = 278
          Height = 38
          Caption = 'Version du catalogue GSC'
          Columns = 2
          Items.Strings = (
            'compact CDS'
            'standard FITS')
          TabOrder = 11
          OnClick = RadioGroup5Click
        end
      end
    end
    object outTabSheet5: TTabSheet
      Caption = 'FocV'
      ImageIndex = 4
      object GroupBox25: TGroupBox
        Left = 3
        Top = 0
        Width = 297
        Height = 129
        Caption = 'Courbe en V'
        TabOrder = 0
        object Label36: TLabel
          Left = 8
          Top = 20
          Width = 88
          Height = 13
          Caption = 'Diam'#232'tre extr'#232'me :'
        end
        object Label50: TLabel
          Left = 8
          Top = 40
          Width = 84
          Height = 13
          Caption = 'Diam'#232'tre proche :'
        end
        object Label84: TLabel
          Left = 8
          Top = 60
          Width = 91
          Height = 13
          Caption = 'Marge de s'#233'curit'#233' :'
        end
        object Label85: TLabel
          Left = 8
          Top = 80
          Width = 92
          Height = 13
          Caption = 'Dur'#233'e d'#39'extraction :'
        end
        object Label179: TLabel
          Left = 264
          Top = 20
          Width = 13
          Height = 13
          Caption = 'pix'
        end
        object Label180: TLabel
          Left = 264
          Top = 40
          Width = 13
          Height = 13
          Caption = 'pix'
        end
        object Label181: TLabel
          Left = 264
          Top = 60
          Width = 13
          Height = 13
          Caption = 'pix'
        end
        object Label182: TLabel
          Left = 264
          Top = 80
          Width = 26
          Height = 13
          Caption = '% de '
        end
        object Label185: TLabel
          Left = 184
          Top = 96
          Width = 96
          Height = 13
          Caption = 'la largeur parafocale'
        end
        object NbreEdit30: NbreEdit
          Left = 180
          Top = 16
          Width = 80
          Height = 21
          TabOrder = 0
          Text = '22'
          ValMax = 999
          TypeData = 2
        end
        object NbreEdit31: NbreEdit
          Left = 180
          Top = 36
          Width = 80
          Height = 21
          TabOrder = 1
          Text = '5'
          ValMax = 999
          TypeData = 2
        end
        object NbreEdit32: NbreEdit
          Left = 180
          Top = 56
          Width = 80
          Height = 21
          TabOrder = 2
          Text = '1,3'
          ValMax = 999
          TypeData = 2
        end
        object NbreEdit33: NbreEdit
          Left = 180
          Top = 76
          Width = 80
          Height = 21
          TabOrder = 3
          Text = '60'
          ValMax = 999
          TypeData = 2
        end
        object CheckBox2: TCheckBox
          Left = 12
          Top = 104
          Width = 145
          Height = 17
          Caption = 'Utiliser la vitesse rapide'
          TabOrder = 4
        end
      end
      object GroupBox26: TGroupBox
        Left = 3
        Top = 132
        Width = 297
        Height = 69
        Caption = 'Vitesse Rapide'
        TabOrder = 1
        object Label89: TLabel
          Left = 12
          Top = 20
          Width = 72
          Height = 13
          Caption = 'Vitesse rapide :'
        end
        object Label178: TLabel
          Left = 264
          Top = 20
          Width = 23
          Height = 13
          Caption = 'pix/s'
        end
        object NbreEdit34: NbreEdit
          Left = 180
          Top = 16
          Width = 80
          Height = 21
          TabOrder = 0
          Text = '21,8'
          ValMax = 999
          TypeData = 2
        end
        object CheckBox4: TCheckBox
          Left = 12
          Top = 44
          Width = 173
          Height = 17
          Caption = 'Utiliser la commande corrig'#233'e'
          TabOrder = 1
        end
      end
      object GroupBox27: TGroupBox
        Left = 3
        Top = 204
        Width = 297
        Height = 109
        Caption = 'Vitesse lente'
        TabOrder = 2
        object Label90: TLabel
          Left = 12
          Top = 20
          Width = 66
          Height = 13
          Caption = 'Vitesse lente :'
        end
        object Label93: TLabel
          Left = 12
          Top = 40
          Width = 163
          Height = 13
          Caption = 'Dur'#233'e de l'#39'impulsion incrementale :'
        end
        object Label147: TLabel
          Left = 12
          Top = 60
          Width = 152
          Height = 13
          Caption = 'Dur'#233'e maximale de manoeuvre :'
        end
        object Label148: TLabel
          Left = 264
          Top = 20
          Width = 23
          Height = 13
          Caption = 'pix/s'
        end
        object Label159: TLabel
          Left = 264
          Top = 40
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label160: TLabel
          Left = 264
          Top = 60
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object NbreEdit35: NbreEdit
          Left = 180
          Top = 16
          Width = 80
          Height = 21
          TabOrder = 0
          Text = '2,85'
          ValMax = 999
          TypeData = 2
        end
        object NbreEdit36: NbreEdit
          Left = 180
          Top = 36
          Width = 80
          Height = 21
          TabOrder = 1
          Text = '500'
          ValMax = 9999
          TypeData = 2
        end
        object NbreEdit37: NbreEdit
          Left = 180
          Top = 56
          Width = 80
          Height = 21
          TabOrder = 2
          Text = '2000'
          ValMax = 9999
          TypeData = 2
        end
        object CheckBox5: TCheckBox
          Left = 12
          Top = 84
          Width = 173
          Height = 17
          Caption = 'Utiliser la commande corrig'#233'e'
          TabOrder = 3
        end
      end
    end
    object outTabSheet8: TTabSheet
      Caption = 'Photom'
      ImageIndex = 7
      object Label18: TLabel
        Left = 8
        Top = 8
        Width = 179
        Height = 13
        Caption = 'Param'#232'tres utilis'#233's pour les fonctions :'
      end
      object Label26: TLabel
        Left = 8
        Top = 24
        Width = 195
        Height = 13
        Caption = 'Analyse / Photom'#233'trie / Ajouter un '#233'talon'
      end
      object Label151: TLabel
        Left = 8
        Top = 40
        Width = 150
        Height = 13
        Caption = 'Analyse / Photom'#233'trie / Mesure'
      end
      object Label152: TLabel
        Left = 8
        Top = 56
        Width = 139
        Height = 13
        Caption = 'Analyse / Mod'#233'lise une '#233'toile'
      end
      object RadioGroup8: TRadioGroup
        Left = 4
        Top = 76
        Width = 145
        Height = 89
        Caption = 'Type'
        Items.Strings = (
          'Gaussienne circulaire'
          'Gaussienne ellipso'#239'dale'
          'Moffat'
          'Ouverture')
        TabOrder = 0
      end
      object GroupBox23: TGroupBox
        Left = 152
        Top = 76
        Width = 145
        Height = 89
        Caption = 'Mesure multi-'#233'talons'
        TabOrder = 1
        object CheckBox3: TCheckBox
          Left = 8
          Top = 16
          Width = 97
          Height = 21
          Caption = 'par super '#233'toile'
          TabOrder = 0
        end
        object CheckBox11: TCheckBox
          Left = 8
          Top = 40
          Width = 133
          Height = 17
          Caption = 'par calcul de r'#233'f'#233'rence'
          TabOrder = 1
        end
        object CheckBox12: TCheckBox
          Left = 8
          Top = 64
          Width = 129
          Height = 17
          Caption = 'par r'#233'gression lin'#233'aire'
          TabOrder = 2
        end
      end
      object GroupBox17: TGroupBox
        Left = 4
        Top = 172
        Width = 293
        Height = 69
        Caption = 'Mod'#233'lisation'
        TabOrder = 2
        object Label10: TLabel
          Left = 8
          Top = 21
          Width = 208
          Height = 13
          Caption = 'Degr'#233' du polynome de mod'#233'lisation du ciel :'
        end
        object Label153: TLabel
          Left = 8
          Top = 43
          Width = 203
          Height = 13
          Caption = 'Demi-largeur de la fen'#234'tre de mod'#233'lisation :'
        end
        object SpinEdit5: TSpinEdit
          Left = 224
          Top = 16
          Width = 61
          Height = 22
          MaxValue = 2
          MinValue = 0
          TabOrder = 0
          Value = 1
        end
        object SpinEdit8: TSpinEdit
          Left = 224
          Top = 38
          Width = 61
          Height = 22
          MaxValue = 35
          MinValue = 5
          TabOrder = 1
          Value = 9
        end
      end
      object GroupBox18: TGroupBox
        Left = 4
        Top = 248
        Width = 293
        Height = 89
        Caption = 'Ouverture'
        TabOrder = 3
        object Label192: TLabel
          Left = 8
          Top = 17
          Width = 77
          Height = 13
          Caption = 'Rayon int'#233'rieur :'
        end
        object Label193: TLabel
          Left = 8
          Top = 65
          Width = 80
          Height = 13
          Caption = 'Rayon ext'#233'rieur :'
        end
        object Label212: TLabel
          Left = 8
          Top = 41
          Width = 80
          Height = 13
          Caption = 'Rayon ext'#233'rieur :'
        end
        object SpinEdit12: TSpinEdit
          Left = 224
          Top = 12
          Width = 61
          Height = 22
          MaxValue = 100
          MinValue = 1
          TabOrder = 0
          Value = 10
        end
        object SpinEdit13: TSpinEdit
          Left = 224
          Top = 60
          Width = 61
          Height = 22
          MaxValue = 100
          MinValue = 2
          TabOrder = 1
          Value = 20
        end
        object SpinEdit14: TSpinEdit
          Left = 224
          Top = 36
          Width = 61
          Height = 22
          MaxValue = 100
          MinValue = 2
          TabOrder = 2
          Value = 15
        end
      end
    end
    object outTabSheet3: TTabSheet
      Caption = 'Lieu'
      ImageIndex = 2
      object Label71: TLabel
        Left = 16
        Top = 64
        Width = 66
        Height = 13
        Caption = 'Observatoire :'
      end
      object Label9: TLabel
        Left = 16
        Top = 88
        Width = 64
        Height = 13
        Caption = 'Observateur :'
      end
      object Label12: TLabel
        Left = 16
        Top = 127
        Width = 44
        Height = 13
        Caption = 'Latitude :'
      end
      object Label13: TLabel
        Left = 16
        Top = 151
        Width = 53
        Height = 13
        Caption = 'Longitude :'
      end
      object Label40: TLabel
        Left = 116
        Top = 168
        Width = 87
        Height = 13
        Caption = 'N'#233'gative vers l'#39'est'
      end
      object Label96: TLabel
        Left = 16
        Top = 232
        Width = 33
        Height = 13
        Caption = 'Seing :'
      end
      object Label97: TLabel
        Left = 244
        Top = 232
        Width = 38
        Height = 13
        Caption = 'ArcSec.'
      end
      object Edit35: TEdit
        Left = 116
        Top = 60
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object Edit9: TEdit
        Left = 116
        Top = 84
        Width = 121
        Height = 21
        TabOrder = 1
      end
      object NbreEdit3: NbreEdit
        Left = 116
        Top = 228
        Width = 121
        Height = 21
        TabOrder = 2
        Text = '0'
        ValMax = 100
        TypeData = 2
      end
      object MaskLong: TMaskEdit
        Left = 116
        Top = 147
        Width = 121
        Height = 21
        EditMask = '!#90'#176'00'#39'00";1;_'
        MaxLength = 10
        TabOrder = 3
        Text = '+90'#176'00'#39'00"'
      end
      object MaskLat: TMaskEdit
        Left = 116
        Top = 123
        Width = 121
        Height = 21
        EditMask = '!#90'#176'00'#39'00";1;_'
        MaxLength = 10
        TabOrder = 4
        Text = '+90'#176'00'#39'00"'
      end
    end
    object outTabSheet11: TTabSheet
      Caption = 'save'
      ImageIndex = 11
      object RadioGroup3: TRadioGroup
        Left = 0
        Top = 0
        Width = 173
        Height = 101
        Caption = 'Sauver les images enti'#233'res sous :'
        ItemIndex = 0
        Items.Strings = (
          'Fits'
          'Cpa Version 3'
          'Pic'
          'Bmp'
          'Jpeg'
          'Cpa Version 4d')
        TabOrder = 0
      end
      object RadioGroup4: TRadioGroup
        Left = 0
        Top = 104
        Width = 301
        Height = 45
        Caption = 'Enregistrement des images couleurs FITS et CPA'
        ItemIndex = 1
        Items.Strings = (
          'Un fichier par couleur'
          'Toutes les couleurs dans le m'#234'me fichier')
        TabOrder = 1
      end
      object GroupBox11: TGroupBox
        Left = 176
        Top = 0
        Width = 125
        Height = 101
        Caption = 'Format Jpeg'
        TabOrder = 2
        object Label102: TLabel
          Left = 8
          Top = 20
          Width = 59
          Height = 13
          Caption = 'Qualit'#233' de la'
        end
        object Label146: TLabel
          Left = 8
          Top = 40
          Width = 91
          Height = 13
          Caption = 'compression Jpeg :'
        end
        object SpinEdit7: TSpinEdit
          Left = 8
          Top = 63
          Width = 85
          Height = 22
          MaxValue = 100
          MinValue = 1
          TabOrder = 0
          Value = 80
        end
      end
      object GroupBox12: TGroupBox
        Left = 0
        Top = 152
        Width = 301
        Height = 0
        Caption = 'Nom g'#233'n'#233'rique des fichiers'
        TabOrder = 3
        object Label141: TLabel
          Left = 8
          Top = 20
          Width = 82
          Height = 13
          Caption = 'Nom des offsets :'
        end
        object Label142: TLabel
          Left = 156
          Top = 20
          Width = 73
          Height = 13
          Caption = 'Nom des noirs :'
        end
        object Label144: TLabel
          Left = 156
          Top = 40
          Width = 70
          Height = 13
          Caption = 'Nom des flats :'
        end
        object Label143: TLabel
          Left = 8
          Top = 40
          Width = 75
          Height = 13
          Caption = 'Nom noirs flats :'
        end
        object Label1: TLabel
          Left = 8
          Top = 60
          Width = 66
          Height = 13
          Caption = 'Cosmetiques :'
        end
        object Edit29: TEdit
          Left = 0
          Top = 16
          Width = 53
          Height = 21
          TabOrder = 0
        end
        object Edit28: TEdit
          Left = 236
          Top = 16
          Width = 53
          Height = 21
          TabOrder = 1
        end
        object Edit23: TEdit
          Left = 236
          Top = 36
          Width = 53
          Height = 21
          TabOrder = 2
        end
        object Edit27: TEdit
          Left = 96
          Top = 36
          Width = 53
          Height = 21
          TabOrder = 3
        end
        object EditCosmetic: TEdit
          Left = 96
          Top = 56
          Width = 89
          Height = 21
          TabOrder = 4
        end
        object Button6: TButton
          Left = 188
          Top = 56
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 5
          OnClick = Button6Click
        end
      end
      object RadioGroup13: TRadioGroup
        Left = 0
        Top = 240
        Width = 301
        Height = 45
        Caption = 'Sauvegarde des FITS en virgule flottante'
        Items.Strings = (
          'Dans un fichier au format en virgule flottante'
          'Dans un fichier au format entier')
        TabOrder = 4
      end
    end
    object outTabSheet16: TTabSheet
      Caption = 'Seuils'
      ImageIndex = 15
      object GroupBox3: TGroupBox
        Left = 8
        Top = 56
        Width = 285
        Height = 61
        Caption = 'R'#233'glage par analyse de l'#39'histogramme'
        TabOrder = 0
        object Label48: TLabel
          Left = 12
          Top = 20
          Width = 49
          Height = 13
          Caption = 'Seuil bas :'
        end
        object Label62: TLabel
          Left = 12
          Top = 40
          Width = 53
          Height = 13
          Caption = 'Seuil haut :'
        end
        object Label66: TLabel
          Left = 148
          Top = 20
          Width = 126
          Height = 13
          Caption = '% de l'#39'histogramme cumul'#233
        end
        object Label67: TLabel
          Left = 148
          Top = 40
          Width = 126
          Height = 13
          Caption = '% de l'#39'histogramme cumul'#233
        end
        object NbreEdit4: NbreEdit
          Left = 72
          Top = 16
          Width = 69
          Height = 21
          TabOrder = 0
          Text = '0,5'
          ValMax = 200
          ValMin = -100
          TypeData = 2
        end
        object NbreEdit5: NbreEdit
          Left = 72
          Top = 36
          Width = 69
          Height = 21
          TabOrder = 1
          Text = '99,5'
          ValMax = 200
          ValMin = -100
          TypeData = 2
        end
      end
      object RadioGroup12: TRadioGroup
        Left = 8
        Top = 188
        Width = 285
        Height = 37
        Caption = 'Visualisation '#224' la prise de vue'
        Columns = 4
        ItemIndex = 0
        Items.Strings = (
          'Stellaire'
          'Plan'#233'taire'
          'Maximum'
          'Seuil Fixe')
        TabOrder = 1
        OnClick = RadioGroup12Click
      end
      object Panel1: TPanel
        Left = 8
        Top = 228
        Width = 285
        Height = 41
        TabOrder = 2
        Visible = False
        object Label169: TLabel
          Left = 16
          Top = 14
          Width = 49
          Height = 13
          Caption = 'Seuil bas :'
        end
        object Label170: TLabel
          Left = 144
          Top = 14
          Width = 53
          Height = 13
          Caption = 'Seuil haut :'
        end
        object NbreEdit24: NbreEdit
          Left = 72
          Top = 12
          Width = 57
          Height = 21
          TabOrder = 0
          Text = '0'
          ValMax = 32767
          ValMin = -32768
          TypeData = 1
        end
        object NbreEdit25: NbreEdit
          Left = 208
          Top = 12
          Width = 57
          Height = 21
          TabOrder = 1
          Text = '255'
          ValMax = 32767
          ValMin = -32768
          TypeData = 1
        end
      end
      object RadioGroup1: TRadioGroup
        Left = 8
        Top = 4
        Width = 285
        Height = 49
        Caption = 'Type de r'#233'glage stellaire'
        Items.Strings = (
          'Analyse de l'#39'histogramme'
          'Statistique')
        TabOrder = 3
      end
      object GroupBox14: TGroupBox
        Left = 8
        Top = 120
        Width = 285
        Height = 57
        Caption = 'R'#233'glage statistique'
        TabOrder = 4
        object Label173: TLabel
          Left = 8
          Top = 16
          Width = 106
          Height = 13
          Caption = 'Seuil Bas = Mediane +'
        end
        object Label174: TLabel
          Left = 8
          Top = 36
          Width = 111
          Height = 13
          Caption = 'Seuil Haut = Mediane +'
        end
        object Label175: TLabel
          Left = 200
          Top = 16
          Width = 55
          Height = 13
          Caption = 'x '#233'cart-type'
        end
        object Label202: TLabel
          Left = 200
          Top = 36
          Width = 55
          Height = 13
          Caption = 'x '#233'cart-type'
        end
        object NbreEdit26: NbreEdit
          Left = 124
          Top = 32
          Width = 69
          Height = 21
          TabOrder = 0
          Text = '2'
          ValMax = 200
          ValMin = -100
          TypeData = 2
        end
        object NbreEdit41: NbreEdit
          Left = 124
          Top = 12
          Width = 69
          Height = 21
          TabOrder = 1
          Text = '-0.25'
          ValMax = 200
          ValMin = -100
          TypeData = 2
        end
      end
    end
    object outTabSheet15: TTabSheet
      Caption = 'PortS'#233'rieT'
      ImageIndex = 14
      object Label115: TLabel
        Left = 8
        Top = 176
        Width = 214
        Height = 13
        Caption = 'Augmentez ces valeurs pour '#233'viter les erreurs'
      end
      object Label116: TLabel
        Left = 8
        Top = 192
        Width = 86
        Height = 13
        Caption = 'de communication'
      end
      object Label117: TLabel
        Left = 8
        Top = 208
        Width = 268
        Height = 13
        Caption = 'Diminuez ces valeurs pour accellerer les communications'
      end
      object Label118: TLabel
        Left = 8
        Top = 160
        Width = 45
        Height = 13
        Caption = 'Conseils :'
      end
      object GroupBox6: TGroupBox
        Left = 4
        Top = 12
        Width = 293
        Height = 141
        Caption = 'Timeouts du port s'#233'rie du t'#233'l'#233'scope'
        TabOrder = 0
        object Label105: TLabel
          Left = 12
          Top = 28
          Width = 145
          Height = 13
          Caption = 'Intervalle entre caract'#232'res lus :'
        end
        object Label106: TLabel
          Left = 12
          Top = 48
          Width = 126
          Height = 13
          Caption = 'Intervalle par caract'#232're lu :'
        end
        object Label107: TLabel
          Left = 12
          Top = 68
          Width = 132
          Height = 13
          Caption = 'Intervalle  pour une lecture :'
        end
        object Label108: TLabel
          Left = 12
          Top = 88
          Width = 138
          Height = 13
          Caption = 'Intervalle par caract'#232're '#233'crit :'
        end
        object Label109: TLabel
          Left = 12
          Top = 108
          Width = 135
          Height = 13
          Caption = 'Intervalle  pour une '#233'criture :'
        end
        object Label110: TLabel
          Left = 260
          Top = 28
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label111: TLabel
          Left = 260
          Top = 48
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label112: TLabel
          Left = 260
          Top = 68
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label113: TLabel
          Left = 260
          Top = 88
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label114: TLabel
          Left = 260
          Top = 108
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object NbreEdit6: NbreEdit
          Left = 160
          Top = 24
          Width = 93
          Height = 21
          TabOrder = 0
          Text = '0'
          ValMax = 10000
          TypeData = 1
        end
        object NbreEdit7: NbreEdit
          Left = 160
          Top = 44
          Width = 93
          Height = 21
          TabOrder = 1
          Text = '0'
          ValMax = 10000
          TypeData = 1
        end
        object NbreEdit8: NbreEdit
          Left = 160
          Top = 64
          Width = 93
          Height = 21
          TabOrder = 2
          Text = '0'
          ValMax = 10000
          TypeData = 1
        end
        object NbreEdit9: NbreEdit
          Left = 160
          Top = 84
          Width = 93
          Height = 21
          TabOrder = 3
          Text = '0'
          ValMax = 10000
          TypeData = 1
        end
        object NbreEdit10: NbreEdit
          Left = 160
          Top = 104
          Width = 93
          Height = 21
          TabOrder = 4
          Text = '0'
          ValMax = 10000
          TypeData = 1
        end
      end
    end
    object outTabSheet17: TTabSheet
      Caption = 'PortS'#233'rieM'
      ImageIndex = 16
      object Label136: TLabel
        Left = 8
        Top = 160
        Width = 45
        Height = 13
        Caption = 'Conseils :'
      end
      object Label137: TLabel
        Left = 8
        Top = 176
        Width = 214
        Height = 13
        Caption = 'Augmentez ces valeurs pour '#233'viter les erreurs'
      end
      object Label138: TLabel
        Left = 8
        Top = 192
        Width = 86
        Height = 13
        Caption = 'de communication'
      end
      object Label139: TLabel
        Left = 8
        Top = 208
        Width = 268
        Height = 13
        Caption = 'Diminuez ces valeurs pour accellerer les communications'
      end
      object GroupBox8: TGroupBox
        Left = 4
        Top = 12
        Width = 293
        Height = 141
        Caption = 'Timeouts du port s'#233'rie de la mise au point'
        TabOrder = 0
        object Label126: TLabel
          Left = 12
          Top = 28
          Width = 145
          Height = 13
          Caption = 'Intervalle entre caract'#232'res lus :'
        end
        object Label127: TLabel
          Left = 12
          Top = 48
          Width = 126
          Height = 13
          Caption = 'Intervalle par caract'#232're lu :'
        end
        object Label128: TLabel
          Left = 12
          Top = 68
          Width = 132
          Height = 13
          Caption = 'Intervalle  pour une lecture :'
        end
        object Label129: TLabel
          Left = 12
          Top = 88
          Width = 138
          Height = 13
          Caption = 'Intervalle par caract'#232're '#233'crit :'
        end
        object Label130: TLabel
          Left = 12
          Top = 108
          Width = 135
          Height = 13
          Caption = 'Intervalle  pour une '#233'criture :'
        end
        object Label131: TLabel
          Left = 260
          Top = 28
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label132: TLabel
          Left = 260
          Top = 48
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label133: TLabel
          Left = 260
          Top = 68
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label134: TLabel
          Left = 260
          Top = 88
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label135: TLabel
          Left = 260
          Top = 108
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object NbreEdit13: NbreEdit
          Left = 160
          Top = 24
          Width = 93
          Height = 21
          TabOrder = 0
          Text = '0'
          ValMax = 10000
          TypeData = 1
        end
        object NbreEdit14: NbreEdit
          Left = 160
          Top = 44
          Width = 93
          Height = 21
          TabOrder = 1
          Text = '0'
          ValMax = 10000
          TypeData = 1
        end
        object NbreEdit15: NbreEdit
          Left = 160
          Top = 64
          Width = 93
          Height = 21
          TabOrder = 2
          Text = '0'
          ValMax = 10000
          TypeData = 1
        end
        object NbreEdit16: NbreEdit
          Left = 160
          Top = 84
          Width = 93
          Height = 21
          TabOrder = 3
          Text = '0'
          ValMax = 10000
          TypeData = 1
        end
        object NbreEdit17: NbreEdit
          Left = 160
          Top = 104
          Width = 93
          Height = 21
          TabOrder = 4
          Text = '0'
          ValMax = 10000
          TypeData = 1
        end
      end
    end
    object outTabSheet1: TTabSheet
      Caption = 'tel'
      object Label3: TLabel
        Left = 164
        Top = 60
        Width = 38
        Height = 13
        Caption = 'Focale :'
      end
      object Label6: TLabel
        Left = 12
        Top = 175
        Width = 99
        Height = 13
        Caption = 'Vitesse de pointage :'
      end
      object Label11: TLabel
        Left = 156
        Top = 13
        Width = 52
        Height = 13
        Caption = 'Port COM :'
      end
      object Label22: TLabel
        Left = 196
        Top = 175
        Width = 31
        Height = 13
        Caption = #176'/Sec.'
      end
      object Label19: TLabel
        Left = 280
        Top = 60
        Width = 16
        Height = 13
        Caption = 'mm'
      end
      object Label49: TLabel
        Left = 152
        Top = 82
        Width = 48
        Height = 13
        Caption = 'Diam'#232'tre :'
      end
      object Label60: TLabel
        Left = 280
        Top = 82
        Width = 16
        Height = 13
        Caption = 'mm'
      end
      object LabelAdressCom: TLabel
        Left = 156
        Top = 36
        Width = 44
        Height = 13
        Caption = 'Adresse :'
        OnClick = BitBtn1Click
      end
      object Edit3: TEdit
        Left = 212
        Top = 56
        Width = 57
        Height = 21
        TabOrder = 0
        Text = '0.825'
      end
      object outComboBox1: TComboBox
        Left = 220
        Top = 9
        Width = 69
        Height = 21
        DropDownCount = 4
        ItemHeight = 13
        TabOrder = 1
        Text = 'COM1'
        Items.Strings = (
          'COM1'
          'COM2'
          'COM3'
          'COM4')
      end
      object Edit34: TEdit
        Left = 212
        Top = 78
        Width = 57
        Height = 21
        TabOrder = 2
        Text = '254'
      end
      object GroupBox7: TGroupBox
        Left = 8
        Top = 204
        Width = 293
        Height = 73
        Caption = 'Tol'#233'rance sur le pointage en plus ou en moins'
        TabOrder = 3
        object Label119: TLabel
          Left = 12
          Top = 20
          Width = 33
          Height = 13
          Caption = 'Alpha :'
        end
        object Label120: TLabel
          Left = 12
          Top = 48
          Width = 31
          Height = 13
          Caption = 'Delta :'
        end
        object Label121: TLabel
          Left = 112
          Top = 20
          Width = 20
          Height = 13
          Caption = 'sec.'
        end
        object Label122: TLabel
          Left = 112
          Top = 48
          Width = 35
          Height = 13
          Caption = 'arcsec.'
        end
        object Label123: TLabel
          Left = 156
          Top = 16
          Width = 120
          Height = 13
          Caption = 'Augmentez ces valeurs si'
        end
        object Label124: TLabel
          Left = 156
          Top = 28
          Width = 123
          Height = 13
          Caption = 'le t'#233'lescope est consid'#233'r'#233
        end
        object Label125: TLabel
          Left = 156
          Top = 40
          Width = 103
          Height = 13
          Caption = 'comme bloqu'#233' '#224' la fin'
        end
        object Label176: TLabel
          Left = 156
          Top = 52
          Width = 66
          Height = 13
          Caption = 'des pointages'
        end
        object NbreEdit11: NbreEdit
          Left = 48
          Top = 16
          Width = 57
          Height = 21
          TabOrder = 0
          Text = '6'
          ValMax = 10000
          TypeData = 2
        end
        object NbreEdit12: NbreEdit
          Left = 48
          Top = 44
          Width = 57
          Height = 21
          TabOrder = 1
          Text = '60'
          ValMax = 10000
          TypeData = 2
        end
      end
      object SpinEdit9: TSpinEdit
        Left = 120
        Top = 170
        Width = 69
        Height = 22
        MaxValue = 8
        MinValue = 2
        TabOrder = 4
        Value = 8
      end
      object RadioGroup10: TRadioGroup
        Left = 12
        Top = 4
        Width = 133
        Height = 137
        Caption = 'Type :'
        Items.Strings = (
          'Aucun'
          'LX200'
          'Coordinate III'
          'Virtuel (D'#233'mo/Tests)'
          'AstroPhysics GTO'
          'Interface Pisco'
          'Aucun'
          'Autostar')
        TabOrder = 5
        OnClick = RadioGroup10Click
      end
      object CheckBox13: TCheckBox
        Left = 164
        Top = 124
        Width = 125
        Height = 17
        Caption = 'Utiliser le format long'
        TabOrder = 6
      end
      object outComboBoxAdressCom: TComboBox
        Left = 220
        Top = 32
        Width = 69
        Height = 21
        ItemHeight = 13
        TabOrder = 7
        Text = '3F8'
        Items.Strings = (
          '3F8'
          '2F8'
          '3E8'
          '2E8')
      end
      object CheckBox18: TCheckBox
        Left = 164
        Top = 104
        Width = 129
        Height = 17
        Caption = 'Monture allemande'
        TabOrder = 8
      end
      object CheckBox21: TCheckBox
        Left = 12
        Top = 148
        Width = 221
        Height = 17
        Caption = 'Lecture p'#233'riodique des coordonn'#233'es'
        TabOrder = 9
      end
    end
    object outTabSheet4: TTabSheet
      Caption = 'Point'
      ImageIndex = 3
      object Label23: TLabel
        Left = 236
        Top = 66
        Width = 34
        Height = 13
        Caption = 'Degr'#233's'
      end
      object Label7: TLabel
        Left = 52
        Top = 67
        Width = 56
        Height = 13
        Caption = 'Delta Maxi :'
      end
      object Label14: TLabel
        Left = 23
        Top = 93
        Width = 88
        Height = 13
        Caption = 'Hauteur Minimum :'
      end
      object Label29: TLabel
        Left = 239
        Top = 93
        Width = 34
        Height = 13
        Caption = 'Degr'#233's'
      end
      object Label15: TLabel
        Left = 46
        Top = 134
        Width = 63
        Height = 13
        Caption = 'Fichier Profil :'
      end
      object Label16: TLabel
        Left = 6
        Top = 160
        Width = 103
        Height = 13
        Caption = 'D'#233'lai apr'#232's pointage :'
      end
      object Label30: TLabel
        Left = 238
        Top = 144
        Width = 63
        Height = 13
        Caption = 'Millisecondes'
      end
      object Edit7: TEdit
        Left = 112
        Top = 62
        Width = 121
        Height = 21
        TabOrder = 0
        Text = '65'
      end
      object Edit14: TEdit
        Left = 112
        Top = 89
        Width = 121
        Height = 21
        TabOrder = 1
        Text = '10'
      end
      object Edit15: TEdit
        Left = 112
        Top = 130
        Width = 121
        Height = 21
        TabOrder = 2
        Text = 'Profil.prf'
      end
      object Edit16: TEdit
        Left = 112
        Top = 156
        Width = 121
        Height = 21
        TabOrder = 3
        Text = '500'
      end
      object CheckBox22: TCheckBox
        Left = 112
        Top = 112
        Width = 97
        Height = 17
        Caption = 'Utiliser le profil'
        TabOrder = 4
      end
    end
    object outTabSheet10: TTabSheet
      Caption = 'Guid'
      ImageIndex = 10
      object CheckBox15: TCheckBox
        Left = 12
        Top = 8
        Width = 201
        Height = 17
        Caption = 'Commander le t'#233'lescope directement'
        TabOrder = 0
        OnClick = CheckBox15Click
      end
      object GroupBox15: TGroupBox
        Left = 4
        Top = 28
        Width = 293
        Height = 169
        Caption = 'Calibration'
        TabOrder = 1
        object Label196: TLabel
          Left = 8
          Top = 36
          Width = 154
          Height = 13
          Caption = 'Temps de rattrapage Nord/Sud :'
        end
        object Label75: TLabel
          Left = 8
          Top = 16
          Width = 104
          Height = 13
          Caption = 'Temps de calibration :'
        end
        object Label86: TLabel
          Left = 228
          Top = 16
          Width = 48
          Height = 13
          Caption = 'Secondes'
        end
        object Label197: TLabel
          Left = 228
          Top = 36
          Width = 48
          Height = 13
          Caption = 'Secondes'
        end
        object Label203: TLabel
          Left = 8
          Top = 56
          Width = 198
          Height = 13
          Caption = 'Pour d'#233'clarer la calibration r'#233'ussie, il faut :'
        end
        object Label204: TLabel
          Left = 8
          Top = 72
          Width = 273
          Height = 13
          Caption = '- Que l'#39'erreur sur la position de retour N/S et E/O soit < '#224' :'
        end
        object Label205: TLabel
          Left = 144
          Top = 92
          Width = 26
          Height = 13
          Caption = 'pixels'
        end
        object Label206: TLabel
          Left = 8
          Top = 112
          Width = 175
          Height = 13
          Caption = '- Que l'#39'erreur d'#39'orthogonalit'#233' soit < '#224' :'
        end
        object Label207: TLabel
          Left = 144
          Top = 132
          Width = 32
          Height = 13
          Caption = 'degr'#233's'
        end
        object Edit1: TEdit
          Left = 184
          Top = 32
          Width = 37
          Height = 21
          TabOrder = 0
          Text = '3'
        end
        object Edit44: TEdit
          Left = 184
          Top = 12
          Width = 37
          Height = 21
          TabOrder = 1
          Text = '10'
        end
        object NbreEdit42: NbreEdit
          Left = 64
          Top = 88
          Width = 73
          Height = 21
          TabOrder = 2
          Text = '2'
          ValMax = 999
          TypeData = 2
        end
        object NbreEdit43: NbreEdit
          Left = 64
          Top = 128
          Width = 73
          Height = 21
          TabOrder = 3
          Text = '10'
          ValMax = 90
          TypeData = 2
        end
        object CheckBox14: TCheckBox
          Left = 8
          Top = 148
          Width = 213
          Height = 17
          Caption = 'Confirmer le lancement de la calibration'
          TabOrder = 4
        end
      end
      object GroupBox16: TGroupBox
        Left = 4
        Top = 208
        Width = 293
        Height = 121
        Caption = 'Guidage'
        TabOrder = 2
        object Label99: TLabel
          Left = 8
          Top = 16
          Width = 112
          Height = 13
          Caption = 'Facteur de mod'#233'ration :'
        end
        object Label33: TLabel
          Left = 8
          Top = 36
          Width = 217
          Height = 13
          Caption = 'Avant de commencer une pose, attendre que '
        end
        object Label34: TLabel
          Left = 8
          Top = 52
          Width = 167
          Height = 13
          Caption = 'l'#39'erreur de guidage soit inf'#233'rieure '#224' :'
        end
        object Label35: TLabel
          Left = 232
          Top = 52
          Width = 26
          Height = 13
          Caption = 'pixels'
        end
        object NbreEdit1: NbreEdit
          Left = 184
          Top = 12
          Width = 37
          Height = 21
          TabOrder = 0
          Text = '0,5'
          ValMax = 1.001
          ValMin = 0.1
          TypeData = 2
        end
        object NbreEdit29: NbreEdit
          Left = 184
          Top = 48
          Width = 45
          Height = 21
          TabOrder = 1
          Text = '0,5'
          ValMax = 10
          TypeData = 2
        end
        object CheckBox16: TCheckBox
          Left = 8
          Top = 68
          Width = 97
          Height = 17
          Caption = 'Avec d'#233'calages'
          TabOrder = 2
          OnClick = CheckBox16Click
        end
        object Button12: TButton
          Left = 25
          Top = 88
          Width = 245
          Height = 25
          Caption = 'Entrer les d'#233'calages de guidage'
          TabOrder = 3
          OnClick = Button12Click
        end
      end
    end
    object outTabSheet19: TTabSheet
      Caption = 'park'
      ImageIndex = 18
      object Label100: TLabel
        Left = 88
        Top = 121
        Width = 37
        Height = 13
        Caption = 'Azimuth'
      end
      object Label101: TLabel
        Left = 88
        Top = 146
        Width = 38
        Height = 13
        Caption = 'Hauteur'
      end
      object cb_park_real: TCheckBox
        Left = 90
        Top = 90
        Width = 97
        Height = 17
        Caption = 'Physique'
        TabOrder = 0
      end
      object park_meridian: TEdit
        Left = 152
        Top = 117
        Width = 65
        Height = 21
        TabOrder = 1
        Text = '0'
      end
      object dec_park: TEdit
        Left = 152
        Top = 144
        Width = 65
        Height = 21
        TabOrder = 2
        Text = '0'
      end
    end
    object outTabSheet18: TTabSheet
      Caption = 'map'
      ImageIndex = 25
      object LabelInvFoc1: TLabel
        Left = 12
        Top = 232
        Width = 260
        Height = 13
        Caption = 'Cocher cette option si le focuseur se d'#233'place en arri'#232're'
      end
      object LabelInvFoc2: TLabel
        Left = 12
        Top = 244
        Width = 287
        Height = 13
        Caption = 'quand on appuie sur une des fleches "Avant" de la raquette.'
      end
      object LabelInvFoc3: TLabel
        Left = 12
        Top = 256
        Width = 282
        Height = 13
        Caption = 'Le d'#233'placement avant est celui qui lutte contre la pesanteur'
      end
      object LabelInvFoc4: TLabel
        Left = 12
        Top = 268
        Width = 253
        Height = 13
        Caption = 'dans le cas d'#39'une cr'#233'maillere ou qui serre des ressorts'
      end
      object LabelInvFoc5: TLabel
        Left = 12
        Top = 280
        Width = 176
        Height = 13
        Caption = 'dans le cas d'#39'un Schmidt-Cassegrain.'
      end
      object Label194: TLabel
        Left = 8
        Top = 124
        Width = 74
        Height = 13
        Caption = 'Nom du plugin :'
      end
      object Label191: TLabel
        Left = 24
        Top = 188
        Width = 154
        Height = 13
        Caption = 'que si le t'#233'lescope l'#39'a '#233't'#233' avant"'
      end
      object Label140: TLabel
        Left = 120
        Top = 17
        Width = 52
        Height = 13
        Caption = 'Port COM :'
      end
      object Label186: TLabel
        Left = 120
        Top = 44
        Width = 53
        Height = 13
        Caption = 'Pos. Max. :'
      end
      object RadioGroup6: TRadioGroup
        Left = 8
        Top = 0
        Width = 93
        Height = 113
        Caption = 'Type :'
        ItemIndex = 0
        Items.Strings = (
          'Aucun'
          'LX200'
          'RoboFocus'
          'Virtuel'
          'LX200 GPS'
          'Plugin')
        TabOrder = 0
        OnClick = RadioGroup6Click
      end
      object CheckBoxInvFoc: TCheckBox
        Left = 8
        Top = 216
        Width = 229
        Height = 17
        Caption = 'Inversion du sens de rotation du moteur'
        TabOrder = 1
        OnClick = CheckBoxInvFocClick
      end
      object Edit5: TEdit
        Left = 88
        Top = 120
        Width = 113
        Height = 21
        TabOrder = 2
        Text = 'PluginTestFocuser.dll'
      end
      object CheckBox17: TCheckBox
        Left = 8
        Top = 172
        Width = 293
        Height = 17
        Caption = 'Afficher le message "Le focuseur ne peut '#234'tre connect'#233
        TabOrder = 3
      end
      object outComboBox2: TComboBox
        Left = 192
        Top = 13
        Width = 73
        Height = 21
        DropDownCount = 4
        ItemHeight = 13
        TabOrder = 4
        Text = 'COM1'
        Items.Strings = (
          'COM1'
          'COM2'
          'COM3'
          'COM4')
      end
      object SpinEdit11: TSpinEdit
        Left = 192
        Top = 40
        Width = 73
        Height = 22
        MaxValue = 65535
        MinValue = 0
        TabOrder = 5
        Value = 65500
      end
    end
    object TabSheet24: TTabSheet
      Caption = 'dome'
      ImageIndex = 23
      object Label155: TLabel
        Left = 100
        Top = 32
        Width = 74
        Height = 13
        Caption = 'Nom du plugin :'
      end
      object Label195: TLabel
        Left = 136
        Top = 92
        Width = 48
        Height = 13
        Caption = 'Secondes'
        Enabled = False
      end
      object RadioGroup9: TRadioGroup
        Left = 8
        Top = 8
        Width = 81
        Height = 53
        Caption = 'Type :'
        ItemIndex = 0
        Items.Strings = (
          'Aucun'
          'Plugin')
        TabOrder = 0
        OnClick = RadioGroup9Click
      end
      object Edit6: TEdit
        Left = 180
        Top = 28
        Width = 113
        Height = 21
        TabOrder = 1
        Text = 'PluginTestDome.dll'
      end
      object NbreEdit38: NbreEdit
        Left = 8
        Top = 88
        Width = 121
        Height = 21
        Enabled = False
        TabOrder = 2
        Text = '10'
        ValMax = 60
        TypeData = 2
      end
      object CheckBox19: TCheckBox
        Left = 8
        Top = 68
        Width = 265
        Height = 17
        Caption = 'Envoyer les coordonn'#233'es au t'#233'lescope toutes les :'
        TabOrder = 3
        OnClick = CheckBox19Click
      end
    end
    object outTabSheet22: TTabSheet
      Caption = 'mapcor'
      ImageIndex = 21
      object LabelVitRap: TLabel
        Left = 168
        Top = 12
        Width = 66
        Height = 13
        Caption = 'Vitesse rapide'
      end
      object LabelVitLent: TLabel
        Left = 240
        Top = 12
        Width = 60
        Height = 13
        Caption = 'Vitesse lente'
      end
      object LabelImpArr: TLabel
        Left = 4
        Top = 36
        Width = 169
        Height = 13
        Caption = 'Impulsion de correction arri'#232're (ms) :'
      end
      object LabelTpsStab: TLabel
        Left = 4
        Top = 60
        Width = 132
        Height = 13
        Caption = 'Temps de stabilisation (ms) :'
      end
      object LabelImpAv: TLabel
        Left = 4
        Top = 84
        Width = 167
        Height = 13
        Caption = 'Impulsion de correction avant (ms) :'
      end
      object LabelSurArr: TLabel
        Left = 4
        Top = 108
        Width = 104
        Height = 13
        Caption = 'Survitesse arriere (%) :'
      end
      object NbreEditImpArrRap: NbreEdit
        Left = 176
        Top = 32
        Width = 57
        Height = 21
        TabOrder = 0
        Text = '200'
        ValMax = 10000
        TypeData = 2
      end
      object NbreEditImpArrLent: NbreEdit
        Left = 240
        Top = 32
        Width = 57
        Height = 21
        TabOrder = 1
        Text = '300'
        ValMax = 10000
        TypeData = 2
      end
      object NbreEditStabRap: NbreEdit
        Left = 176
        Top = 56
        Width = 57
        Height = 21
        TabOrder = 2
        Text = '300'
        ValMax = 10000
        TypeData = 2
      end
      object NbreEditStabLent: NbreEdit
        Left = 240
        Top = 56
        Width = 57
        Height = 21
        TabOrder = 3
        Text = '300'
        ValMax = 10000
        TypeData = 2
      end
      object NbreEditImpAvRap: NbreEdit
        Left = 176
        Top = 80
        Width = 57
        Height = 21
        TabOrder = 4
        Text = '200'
        ValMax = 10000
        TypeData = 2
      end
      object NbreEditImpAvLent: NbreEdit
        Left = 240
        Top = 80
        Width = 57
        Height = 21
        TabOrder = 5
        Text = '300'
        ValMax = 10000
        TypeData = 2
      end
      object NbreEditSurRap: NbreEdit
        Left = 176
        Top = 104
        Width = 57
        Height = 21
        TabOrder = 6
        Text = '0'
        ValMax = 100
        ValMin = -100
        TypeData = 2
      end
      object NbreEditSurLent: NbreEdit
        Left = 240
        Top = 104
        Width = 57
        Height = 21
        TabOrder = 7
        Text = '0'
        ValMax = 100
        ValMin = -100
        TypeData = 2
      end
    end
    object outTabSheet23: TTabSheet
      Caption = 'PortS'#233'rieHS'
      ImageIndex = 22
      object Label11HS: TLabel
        Left = 8
        Top = 160
        Width = 45
        Height = 13
        Caption = 'Conseils :'
      end
      object Label12HS: TLabel
        Left = 8
        Top = 176
        Width = 214
        Height = 13
        Caption = 'Augmentez ces valeurs pour '#233'viter les erreurs'
      end
      object Label13HS: TLabel
        Left = 8
        Top = 192
        Width = 86
        Height = 13
        Caption = 'de communication'
      end
      object Label14HS: TLabel
        Left = 8
        Top = 208
        Width = 268
        Height = 13
        Caption = 'Diminuez ces valeurs pour accellerer les communications'
      end
      object GroupBoxPortHS: TGroupBox
        Left = 4
        Top = 12
        Width = 293
        Height = 141
        Caption = 'Timeouts du port s'#233'rie du serveur d'#39'heure'
        TabOrder = 0
        object Label1HS: TLabel
          Left = 12
          Top = 28
          Width = 145
          Height = 13
          Caption = 'Intervalle entre caract'#232'res lus :'
        end
        object Label2HS: TLabel
          Left = 12
          Top = 48
          Width = 126
          Height = 13
          Caption = 'Intervalle par caract'#232're lu :'
        end
        object Label3HS: TLabel
          Left = 12
          Top = 68
          Width = 132
          Height = 13
          Caption = 'Intervalle  pour une lecture :'
        end
        object Label4HS: TLabel
          Left = 12
          Top = 88
          Width = 138
          Height = 13
          Caption = 'Intervalle par caract'#232're '#233'crit :'
        end
        object Label5HS: TLabel
          Left = 12
          Top = 108
          Width = 135
          Height = 13
          Caption = 'Intervalle  pour une '#233'criture :'
        end
        object Label6HS: TLabel
          Left = 260
          Top = 28
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label7HS: TLabel
          Left = 260
          Top = 48
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label8HS: TLabel
          Left = 260
          Top = 68
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label9HS: TLabel
          Left = 260
          Top = 88
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label10HS: TLabel
          Left = 260
          Top = 108
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object NbreEdit1HS: NbreEdit
          Left = 160
          Top = 24
          Width = 93
          Height = 21
          TabOrder = 0
          Text = '0'
          ValMax = 10000
          TypeData = 1
        end
        object NbreEdit2HS: NbreEdit
          Left = 160
          Top = 44
          Width = 93
          Height = 21
          TabOrder = 1
          Text = '0'
          ValMax = 10000
          TypeData = 1
        end
        object NbreEdit3HS: NbreEdit
          Left = 160
          Top = 64
          Width = 93
          Height = 21
          TabOrder = 2
          Text = '0'
          ValMax = 10000
          TypeData = 1
        end
        object NbreEdit4HS: NbreEdit
          Left = 160
          Top = 84
          Width = 93
          Height = 21
          TabOrder = 3
          Text = '0'
          ValMax = 10000
          TypeData = 1
        end
        object NbreEdit5HS: NbreEdit
          Left = 160
          Top = 104
          Width = 93
          Height = 21
          TabOrder = 4
          Text = '0'
          ValMax = 10000
          TypeData = 1
        end
      end
    end
    object outTabSheet20: TTabSheet
      Caption = 'HourServ'
      ImageIndex = 19
      object LabelPortHS: TLabel
        Left = 148
        Top = 49
        Width = 52
        Height = 13
        Caption = 'Port COM :'
      end
      object Label38: TLabel
        Left = 16
        Top = 120
        Width = 90
        Height = 13
        Caption = 'Diff'#233'rence PC-TU :'
      end
      object Label39: TLabel
        Left = 244
        Top = 120
        Width = 34
        Height = 13
        Caption = 'Heures'
      end
      object RadioGroupHS: TRadioGroup
        Left = 8
        Top = 8
        Width = 125
        Height = 93
        Caption = 'Type :'
        ItemIndex = 0
        Items.Strings = (
          'CMOS Int $02 $04'
          'CMOS Int $00 $04'
          'Windows'
          'Event Marker')
        TabOrder = 0
        OnClick = RadioGroupHSClick
      end
      object outComboBoxPortHS: TComboBox
        Left = 212
        Top = 45
        Width = 69
        Height = 21
        DropDownCount = 4
        ItemHeight = 13
        TabOrder = 1
        Text = 'COM1'
        Items.Strings = (
          'COM1'
          'COM2'
          'COM3'
          'COM4')
      end
      object SpinEdit1: TSpinEdit
        Left = 116
        Top = 115
        Width = 121
        Height = 22
        MaxValue = 12
        MinValue = -12
        TabOrder = 2
        Value = 0
      end
    end
    object outTabSheet21: TTabSheet
      Caption = 'Optim'
      ImageIndex = 20
      object Label27: TLabel
        Left = 16
        Top = 20
        Width = 125
        Height = 13
        Caption = 'Temps de maneuvre (ms) :'
      end
      object Label208: TLabel
        Left = 272
        Top = 20
        Width = 13
        Height = 13
        Caption = 'ms'
      end
      object Label209: TLabel
        Left = 16
        Top = 44
        Width = 147
        Height = 13
        Caption = 'Tol'#233'rance sur la FWHM finale :'
      end
      object Label210: TLabel
        Left = 272
        Top = 44
        Width = 8
        Height = 13
        Caption = '%'
      end
      object Label211: TLabel
        Left = 16
        Top = 68
        Width = 162
        Height = 13
        Caption = 'Facteur d'#39'inflation de la tol'#233'rance :'
      end
      object CheckBox23: TCheckBox
        Left = 20
        Top = 96
        Width = 169
        Height = 17
        Caption = 'Utiliser la commande corrig'#233'e'
        TabOrder = 0
      end
      object Edit13: TEdit
        Left = 180
        Top = 16
        Width = 85
        Height = 21
        TabOrder = 1
        Text = '100'
      end
      object Edit19: TEdit
        Left = 180
        Top = 40
        Width = 85
        Height = 21
        TabOrder = 2
        Text = '1'
      end
      object Edit22: TEdit
        Left = 180
        Top = 64
        Width = 85
        Height = 21
        TabOrder = 3
        Text = '1.5'
      end
    end
    object outTabSheet2: TTabSheet
      Caption = 'cam'
      ImageIndex = 1
      object Label8: TLabel
        Left = 148
        Top = 31
        Width = 28
        Height = 13
        Caption = 'Filtre :'
      end
      object Label2: TLabel
        Left = 148
        Top = 8
        Width = 38
        Height = 13
        Caption = 'Port // :'
      end
      object Label94: TLabel
        Left = 148
        Top = 56
        Width = 32
        Height = 13
        Caption = 'Nord '#224
      end
      object Label95: TLabel
        Left = 236
        Top = 52
        Width = 47
        Height = 13
        Caption = 'degr'#233's du'
      end
      object Label177: TLabel
        Left = 236
        Top = 64
        Width = 65
        Height = 13
        Caption = '1/2 axe des y'
      end
      object Label76: TLabel
        Left = 148
        Top = 123
        Width = 64
        Height = 13
        Caption = 'Temp. vis'#233'e :'
      end
      object Label77: TLabel
        Left = 252
        Top = 123
        Width = 44
        Height = 13
        Caption = 'Degr'#233's C'
      end
      object Label149: TLabel
        Left = 152
        Top = 148
        Width = 80
        Height = 13
        Caption = 'D'#233'lai de vidage :'
      end
      object Label150: TLabel
        Left = 276
        Top = 148
        Width = 8
        Height = 13
        Caption = 's.'
      end
      object Label31: TLabel
        Left = 152
        Top = 172
        Width = 69
        Height = 13
        Caption = 'D'#233'lai Lecture :'
      end
      object Label82: TLabel
        Left = 256
        Top = 172
        Width = 31
        Height = 13
        Caption = 'Cycles'
      end
      object Label83: TLabel
        Left = 152
        Top = 196
        Width = 83
        Height = 13
        Caption = 'D'#233'lai ferm. obtu. :'
      end
      object Label81: TLabel
        Left = 276
        Top = 196
        Width = 8
        Height = 13
        Caption = 's.'
      end
      object Label167: TLabel
        Left = 152
        Top = 220
        Width = 70
        Height = 13
        Caption = 'Taille pixels X :'
      end
      object Label168: TLabel
        Left = 152
        Top = 240
        Width = 70
        Height = 13
        Caption = 'Taille pixels Y :'
      end
      object Label154: TLabel
        Left = 268
        Top = 220
        Width = 14
        Height = 13
        Caption = 'um'
      end
      object Label187: TLabel
        Left = 268
        Top = 240
        Width = 14
        Height = 13
        Caption = 'um'
      end
      object Label188: TLabel
        Left = 152
        Top = 264
        Width = 74
        Height = 13
        Caption = 'Nom du plugin :'
      end
      object CheckBox7: TCheckBox
        Left = 220
        Top = 80
        Width = 61
        Height = 17
        Caption = 'Miroir Y'
        TabOrder = 0
      end
      object CheckBox6: TCheckBox
        Left = 148
        Top = 80
        Width = 61
        Height = 17
        Caption = 'Miroir X'
        TabOrder = 1
      end
      object Edit8: TEdit
        Left = 216
        Top = 28
        Width = 41
        Height = 21
        TabOrder = 2
        Text = 'Aucun'
      end
      object RadioGroup2: TRadioGroup
        Left = 4
        Top = 0
        Width = 141
        Height = 293
        Caption = 'Type :'
        ItemIndex = 0
        Items.Strings = (
          'Aucune'
          'Hisis 22 14 Bits'
          'Hisis 22 12 Bits'
          'Audine400 sans Obtu'
          'ST7-CCD Principal'
          'ST8-CCD Principal'
          'Webcam'
          'Plugin'
          'Audine400 Obtu David'
          'ST7/8-CCD Guidage'
          'Virtuelle (D'#233'mo/Tests)'
          'Audine3200 sans Obtu'
          'Audine3200 Obtu David'
          'Audine1600 sans Obtu'
          'Audine1600 Obtu David'
          'ST9-CCD Principal'
          'ST10-CCD Principal')
        TabOrder = 3
        OnClick = RadioGroup2Click
      end
      object NbreEdit2: NbreEdit
        Left = 184
        Top = 52
        Width = 49
        Height = 21
        TabOrder = 4
        Text = '0'
        OnChange = NbreEdit2Change
        ValMax = 360
        ValMin = -360
        TypeData = 2
      end
      object outComboBox3: TComboBox
        Left = 192
        Top = 4
        Width = 89
        Height = 21
        ItemHeight = 13
        TabOrder = 5
        Text = 'LPT1 ($378)'
        Items.Strings = (
          'LPT1 ($378)'
          'LPT2 ($278)'
          'LPT3 ($3BC)')
      end
      object cb_coupe_ampli: TCheckBox
        Left = 148
        Top = 100
        Width = 141
        Height = 17
        Caption = 'Coupure ampli logicielle'
        Checked = True
        State = cbChecked
        TabOrder = 6
      end
      object Edit41: TEdit
        Left = 216
        Top = 120
        Width = 33
        Height = 21
        TabOrder = 7
        Text = '-20'
      end
      object NbreEdit18: NbreEdit
        Left = 236
        Top = 144
        Width = 33
        Height = 21
        TabOrder = 8
        Text = '0,7'
        ValMax = 10
        TypeData = 0
      end
      object Edit11: TEdit
        Left = 232
        Top = 168
        Width = 21
        Height = 21
        TabOrder = 9
        Text = '3'
      end
      object audine_obtu_text: TEdit
        Left = 244
        Top = 192
        Width = 25
        Height = 21
        TabOrder = 10
        Text = '0.5'
      end
      object NbreEdit22: NbreEdit
        Left = 228
        Top = 216
        Width = 33
        Height = 21
        TabOrder = 11
        Text = '10'
        OnChange = NbreEdit22Change
        ValMax = 100
        TypeData = 2
      end
      object NbreEdit23: NbreEdit
        Left = 228
        Top = 236
        Width = 33
        Height = 21
        TabOrder = 12
        Text = '10'
        OnChange = NbreEdit23Change
        ValMax = 100
        TypeData = 2
      end
      object Edit2: TEdit
        Left = 228
        Top = 260
        Width = 61
        Height = 21
        TabOrder = 13
        Text = 'plugin.dll'
        OnChange = Edit2Change
      end
      object Button13: TButton
        Left = 160
        Top = 284
        Width = 129
        Height = 25
        Caption = 'Configuration'
        TabOrder = 14
        OnClick = Button13Click
      end
    end
    object outTabSheet12: TTabSheet
      Caption = 'camtrack'
      ImageIndex = 11
      object Label164: TLabel
        Left = 148
        Top = 8
        Width = 38
        Height = 13
        Caption = 'Port // :'
      end
      object Label183: TLabel
        Left = 144
        Top = 32
        Width = 32
        Height = 13
        Caption = 'Nord '#224
      end
      object Label184: TLabel
        Left = 232
        Top = 24
        Width = 67
        Height = 13
        Caption = 'degr'#233's du 1/2'
      end
      object Label17: TLabel
        Left = 232
        Top = 36
        Width = 45
        Height = 13
        Caption = 'axe des y'
      end
      object Label157: TLabel
        Left = 148
        Top = 100
        Width = 80
        Height = 13
        Caption = 'D'#233'lai de vidage :'
      end
      object Label158: TLabel
        Left = 264
        Top = 100
        Width = 8
        Height = 13
        Caption = 's.'
      end
      object Label70: TLabel
        Left = 148
        Top = 124
        Width = 69
        Height = 13
        Caption = 'D'#233'lai Lecture :'
      end
      object Label156: TLabel
        Left = 252
        Top = 124
        Width = 31
        Height = 13
        Caption = 'Cycles'
      end
      object Label162: TLabel
        Left = 148
        Top = 148
        Width = 83
        Height = 13
        Caption = 'D'#233'lai ferm. obtu. :'
      end
      object Label163: TLabel
        Left = 268
        Top = 148
        Width = 8
        Height = 13
        Caption = 's.'
      end
      object Label165: TLabel
        Left = 148
        Top = 172
        Width = 71
        Height = 13
        Caption = 'Taille Pixels X :'
      end
      object Label166: TLabel
        Left = 148
        Top = 196
        Width = 71
        Height = 13
        Caption = 'Taille Pixels Y :'
      end
      object Label161: TLabel
        Left = 148
        Top = 220
        Width = 74
        Height = 13
        Caption = 'Nom du plugin :'
      end
      object Label189: TLabel
        Left = 268
        Top = 172
        Width = 14
        Height = 13
        Caption = 'um'
      end
      object Label190: TLabel
        Left = 268
        Top = 196
        Width = 14
        Height = 13
        Caption = 'um'
      end
      object RadioGroup11: TRadioGroup
        Left = 4
        Top = 0
        Width = 137
        Height = 293
        Caption = 'Type :'
        ItemIndex = 0
        Items.Strings = (
          'Aucune'
          'Hisis 22 14 Bits'
          'Hisis 22 12 Bits'
          'Audine400 sans Obtu.'
          'ST7-CCD Principal'
          'ST8-CCD Principal'
          'Webcam'
          'Plugin'
          'Audine400 Obtu David'
          'ST7/8-CCD Guidage'
          'Virtuelle (D'#233'mo/Tests)'
          'Audine3200 sans Obtu'
          'Audine3200 Obtu David'
          'Audine1600 sans Obtu'
          'Audine1600 Obtu David'
          'ST9-CCD Principal'
          'ST10-CCD Principal')
        TabOrder = 0
        OnClick = RadioGroup11Click
      end
      object outComboBox4: TComboBox
        Left = 192
        Top = 4
        Width = 89
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        Text = 'LPT1 ($378)'
        Items.Strings = (
          'LPT1 ($378)'
          'LPT2 ($278)'
          'LPT3 ($3BC)')
      end
      object CheckBox1: TCheckBox
        Left = 148
        Top = 52
        Width = 61
        Height = 17
        Caption = 'Miroir X'
        TabOrder = 2
      end
      object CheckBox8: TCheckBox
        Left = 216
        Top = 52
        Width = 61
        Height = 17
        Caption = 'Miroir Y'
        TabOrder = 3
      end
      object CheckBox9: TCheckBox
        Left = 148
        Top = 76
        Width = 177
        Height = 17
        Caption = 'Coupure ampli logicielle'
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
      object NbreEdit27: NbreEdit
        Left = 180
        Top = 28
        Width = 49
        Height = 21
        TabOrder = 5
        Text = '0'
        OnChange = NbreEdit27Change
        ValMax = 360
        ValMin = -360
        TypeData = 2
      end
      object NbreEdit19: NbreEdit
        Left = 232
        Top = 96
        Width = 29
        Height = 21
        TabOrder = 6
        Text = '0,7'
        ValMax = 10
        TypeData = 0
      end
      object Edit10: TEdit
        Left = 220
        Top = 120
        Width = 29
        Height = 21
        TabOrder = 7
        Text = '3'
      end
      object Edit47: TEdit
        Left = 236
        Top = 144
        Width = 29
        Height = 21
        TabOrder = 8
        Text = '0.5'
      end
      object NbreEdit20: NbreEdit
        Left = 232
        Top = 168
        Width = 33
        Height = 21
        TabOrder = 9
        Text = '10'
        OnChange = NbreEdit20Change
        ValMax = 100
        TypeData = 2
      end
      object NbreEdit21: NbreEdit
        Left = 232
        Top = 192
        Width = 33
        Height = 21
        TabOrder = 10
        Text = '10'
        OnChange = NbreEdit21Change
        ValMax = 100
        TypeData = 2
      end
      object Edit46: TEdit
        Left = 232
        Top = 216
        Width = 69
        Height = 21
        TabOrder = 11
        Text = 'plugin.dll'
        OnChange = Edit46Change
      end
    end
    object outTabSheet26: TTabSheet
      Caption = 'Mesures'
      ImageIndex = 25
      object GroupBox9: TGroupBox
        Left = 7
        Top = 8
        Width = 289
        Height = 101
        Caption = 'Mesure '#233'lementaire'
        TabOrder = 0
        object Label53: TLabel
          Left = 12
          Top = 21
          Width = 180
          Height = 13
          Caption = 'Largeur de la fen'#234'tre de mod'#233'lisation :'
        end
        object Label145: TLabel
          Left = 12
          Top = 32
          Width = 184
          Height = 13
          Caption = 'A augmenter si l'#39#233'toile sort de la fen'#234'tre'
        end
        object Label46: TLabel
          Left = 12
          Top = 76
          Width = 192
          Height = 13
          Caption = 'Nombre maxi. d'#39#233'checs de mod'#233'lisation :'
        end
        object LabelModel: TLabel
          Left = 12
          Top = 48
          Width = 106
          Height = 13
          Caption = 'Type de mod'#233'lisation :'
        end
        object SpinEdit6: TSpinEdit
          Left = 208
          Top = 16
          Width = 73
          Height = 22
          MaxValue = 201
          MinValue = 19
          TabOrder = 0
          Value = 31
        end
        object SpinEdit2: TSpinEdit
          Left = 208
          Top = 71
          Width = 73
          Height = 22
          MaxValue = 999
          MinValue = 3
          TabOrder = 1
          Value = 20
        end
        object ComboBoxModel: TComboBox
          Left = 208
          Top = 44
          Width = 73
          Height = 21
          ItemHeight = 13
          TabOrder = 2
          Text = 'FWHM'
          OnChange = ComboBoxModelChange
          Items.Strings = (
            'FWHM'
            'HFD')
        end
      end
      object GroupBox13: TGroupBox
        Left = 7
        Top = 124
        Width = 289
        Height = 97
        Caption = 'S'#233'rie de mesures'
        TabOrder = 1
        object Label47: TLabel
          Left = 8
          Top = 16
          Width = 129
          Height = 13
          Caption = 'Nombre de mesures r'#233'duit :'
        end
        object Label28: TLabel
          Left = 8
          Top = 44
          Width = 134
          Height = 13
          Caption = 'Nombre de mesures normal :'
        end
        object Label32: TLabel
          Left = 8
          Top = 71
          Width = 124
          Height = 13
          Caption = 'Valeur typique de la s'#233'rie :'
        end
        object SpinEdit3: TSpinEdit
          Left = 208
          Top = 11
          Width = 73
          Height = 22
          MaxValue = 100
          MinValue = 1
          TabOrder = 0
          Value = 5
        end
        object SpinEdit10: TSpinEdit
          Left = 208
          Top = 39
          Width = 73
          Height = 22
          MaxValue = 100
          MinValue = 1
          TabOrder = 1
          Value = 5
        end
        object ComboBox1: TComboBox
          Left = 208
          Top = 67
          Width = 73
          Height = 21
          ItemHeight = 13
          TabOrder = 2
          Text = 'Minimale'
          Items.Strings = (
            'Minimale'
            'Moyenne')
        end
      end
    end
    object outTabSheet25: TTabSheet
      Caption = 'pose'
      ImageIndex = 24
      object Label56: TLabel
        Left = 76
        Top = 62
        Width = 50
        Height = 13
        Caption = 'Pose 1x1 :'
      end
      object Label58: TLabel
        Left = 76
        Top = 114
        Width = 50
        Height = 13
        Caption = 'Pose 4x4 :'
      end
      object Label54: TLabel
        Left = 184
        Top = 64
        Width = 48
        Height = 13
        Caption = 'Secondes'
      end
      object Label55: TLabel
        Left = 184
        Top = 114
        Width = 48
        Height = 13
        Caption = 'Secondes'
      end
      object Label45: TLabel
        Left = 76
        Top = 87
        Width = 50
        Height = 13
        Caption = 'Pose 2x2 :'
      end
      object Label69: TLabel
        Left = 80
        Top = 234
        Width = 51
        Height = 13
        Caption = 'Bouclage :'
      end
      object Label4: TLabel
        Left = 72
        Top = 159
        Width = 52
        Height = 13
        Caption = 'Pose Mini :'
      end
      object Label20: TLabel
        Left = 184
        Top = 159
        Width = 48
        Height = 13
        Caption = 'Secondes'
      end
      object Label57: TLabel
        Left = 184
        Top = 88
        Width = 48
        Height = 13
        Caption = 'Secondes'
      end
      object Label5: TLabel
        Left = 188
        Top = 234
        Width = 34
        Height = 13
        Caption = 'Images'
      end
      object Edit21: TEdit
        Left = 132
        Top = 110
        Width = 45
        Height = 21
        TabOrder = 0
        Text = '0.1'
      end
      object Edit20: TEdit
        Left = 132
        Top = 58
        Width = 45
        Height = 21
        TabOrder = 1
        Text = '60'
      end
      object Edit26: TEdit
        Left = 132
        Top = 83
        Width = 45
        Height = 21
        TabOrder = 2
        Text = '60'
      end
      object SpinEdit4: TSpinEdit
        Left = 136
        Top = 229
        Width = 45
        Height = 22
        MaxValue = 999
        MinValue = 1
        TabOrder = 3
        Value = 15
      end
      object Edit4: TEdit
        Left = 132
        Top = 156
        Width = 45
        Height = 21
        TabOrder = 4
        Text = '0.03'
      end
    end
    object outTabSheet9: TTabSheet
      Caption = 'Filt'
      ImageIndex = 8
      object Label24: TLabel
        Left = 56
        Top = 68
        Width = 37
        Height = 13
        Caption = 'Filtre 1 :'
      end
      object Label25: TLabel
        Left = 56
        Top = 96
        Width = 37
        Height = 13
        Caption = 'Filtre 2 :'
      end
      object Label72: TLabel
        Left = 56
        Top = 124
        Width = 37
        Height = 13
        Caption = 'Filtre 3 :'
      end
      object Label73: TLabel
        Left = 56
        Top = 152
        Width = 37
        Height = 13
        Caption = 'Filtre 4 :'
      end
      object Label74: TLabel
        Left = 56
        Top = 180
        Width = 37
        Height = 13
        Caption = 'Filtre 5 :'
      end
      object Edit36: TEdit
        Left = 112
        Top = 64
        Width = 121
        Height = 21
        TabOrder = 0
        Text = 'Edit36'
      end
      object Edit37: TEdit
        Left = 112
        Top = 92
        Width = 121
        Height = 21
        TabOrder = 1
        Text = 'Edit37'
      end
      object Edit38: TEdit
        Left = 112
        Top = 120
        Width = 121
        Height = 21
        TabOrder = 2
        Text = 'Edit38'
      end
      object Edit39: TEdit
        Left = 112
        Top = 148
        Width = 121
        Height = 21
        TabOrder = 3
        Text = 'Edit39'
      end
      object Edit40: TEdit
        Left = 112
        Top = 176
        Width = 121
        Height = 21
        TabOrder = 4
        Text = 'Edit40'
      end
    end
    object outTabSheet6: TTabSheet
      Caption = 'AutoA'
      ImageIndex = 5
      object GroupBox2: TGroupBox
        Left = 12
        Top = 24
        Width = 281
        Height = 117
        Caption = 'Vitesse Rapide'
        TabOrder = 0
        object Label51: TLabel
          Left = 8
          Top = 20
          Width = 135
          Height = 13
          Caption = 'Temps de manoeuvre initial :'
        end
        object Label59: TLabel
          Left = 8
          Top = 60
          Width = 100
          Height = 13
          Caption = 'FWHM de transition :'
        end
        object Label61: TLabel
          Left = 8
          Top = 40
          Width = 131
          Height = 13
          Caption = 'Temps de manoeuvre final :'
        end
        object Label87: TLabel
          Left = 248
          Top = 20
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label91: TLabel
          Left = 248
          Top = 40
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label92: TLabel
          Left = 248
          Top = 60
          Width = 27
          Height = 13
          Caption = 'Pixels'
        end
        object LabelFwhm1: TLabel
          Left = 8
          Top = 80
          Width = 106
          Height = 13
          Caption = 'FWHM de transition = '
        end
        object Edit24: TEdit
          Left = 148
          Top = 16
          Width = 93
          Height = 21
          TabOrder = 0
          Text = '128'
        end
        object Edit32: TEdit
          Left = 148
          Top = 36
          Width = 93
          Height = 21
          TabOrder = 2
          Text = '8'
        end
        object Edit25: TEdit
          Left = 148
          Top = 56
          Width = 93
          Height = 21
          TabOrder = 1
          Text = '3'
          OnChange = Edit25Change
        end
        object CheckBoxCorFast: TCheckBox
          Left = 8
          Top = 96
          Width = 233
          Height = 17
          Caption = 'Utiliser la commande corrig'#233'e'
          TabOrder = 3
          OnClick = CheckBoxCorFastClick
        end
      end
      object GroupBox1: TGroupBox
        Left = 12
        Top = 144
        Width = 281
        Height = 117
        Caption = 'Vitesse Lente'
        TabOrder = 1
        object Label63: TLabel
          Left = 8
          Top = 16
          Width = 135
          Height = 13
          Caption = 'Temps de manoeuvre initial :'
        end
        object Label64: TLabel
          Left = 8
          Top = 56
          Width = 72
          Height = 13
          Caption = 'FWHM d'#39'arr'#234't :'
        end
        object Label68: TLabel
          Left = 8
          Top = 36
          Width = 131
          Height = 13
          Caption = 'Temps de manoeuvre final :'
        end
        object Label52: TLabel
          Left = 248
          Top = 16
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label88: TLabel
          Left = 248
          Top = 36
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Pixels: TLabel
          Left = 248
          Top = 56
          Width = 27
          Height = 13
          Caption = 'Pixels'
        end
        object LabelFwhm2: TLabel
          Left = 8
          Top = 76
          Width = 75
          Height = 13
          Caption = 'FWHM d'#39'arr'#234't ='
        end
        object Edit30: TEdit
          Left = 148
          Top = 12
          Width = 89
          Height = 21
          TabOrder = 0
          Text = '256'
        end
        object Edit33: TEdit
          Left = 148
          Top = 32
          Width = 89
          Height = 21
          TabOrder = 2
          Text = '32'
        end
        object Edit31: TEdit
          Left = 148
          Top = 52
          Width = 89
          Height = 21
          TabOrder = 1
          Text = '2'
          OnChange = Edit31Change
        end
        object CheckBoxCorSlow: TCheckBox
          Left = 8
          Top = 92
          Width = 233
          Height = 17
          Caption = 'Utiliser la commande corrig'#233'e'
          TabOrder = 3
          OnClick = CheckBoxCorSlowClick
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'MySQL'
      ImageIndex = 26
      object Label171: TLabel
        Left = 32
        Top = 16
        Width = 53
        Height = 13
        Caption = 'MySQL Bin'
      end
      object Label172: TLabel
        Left = 32
        Top = 60
        Width = 33
        Height = 13
        Caption = 'Engine'
      end
      object l_mysql_status: TLabel
        Left = 224
        Top = 36
        Width = 30
        Height = 13
        Caption = 'Online'
      end
      object Label198: TLabel
        Left = 32
        Top = 104
        Width = 23
        Height = 13
        Caption = 'H'#244'te'
      end
      object Label199: TLabel
        Left = 32
        Top = 148
        Width = 25
        Height = 13
        Caption = 'Port :'
      end
      object Label200: TLabel
        Left = 32
        Top = 192
        Width = 80
        Height = 13
        Caption = 'Nom d'#39'utilisateur '
      end
      object Label201: TLabel
        Left = 32
        Top = 264
        Width = 64
        Height = 13
        Caption = 'Mot de passe'
        Enabled = False
      end
      object e_mysql_bin: TEdit
        Left = 32
        Top = 32
        Width = 121
        Height = 21
        TabOrder = 0
        Text = 'c:\mysql\bin'
      end
      object e_mysql_engine: TEdit
        Left = 32
        Top = 76
        Width = 121
        Height = 21
        TabOrder = 1
        Text = 'mysqld-opt.exe'
      end
      object mysql_led: TEdit
        Left = 203
        Top = 36
        Width = 12
        Height = 12
        AutoSize = False
        BorderStyle = bsNone
        Color = clLime
        TabOrder = 2
      end
      object Edit12: TEdit
        Left = 32
        Top = 120
        Width = 121
        Height = 21
        TabOrder = 3
        Text = 'localhost'
      end
      object Edit17: TEdit
        Left = 32
        Top = 208
        Width = 121
        Height = 21
        TabOrder = 4
      end
      object Edit18: TEdit
        Left = 32
        Top = 280
        Width = 121
        Height = 21
        Enabled = False
        PasswordChar = '*'
        TabOrder = 5
      end
      object NbreEdit40: NbreEdit
        Left = 32
        Top = 164
        Width = 121
        Height = 21
        TabOrder = 6
        Text = '3306'
        ValMax = 9999
        TypeData = 1
      end
      object CheckBox10: TCheckBox
        Left = 32
        Top = 244
        Width = 225
        Height = 17
        Caption = 'Demander le mot de passe '#224' la connexion'
        Checked = True
        State = cbChecked
        TabOrder = 7
        OnClick = CheckBox10Click
      end
    end
  end
  object TreeView1: TTreeView
    Left = 0
    Top = 0
    Width = 201
    Height = 373
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    HotTrack = True
    Indent = 19
    ParentFont = False
    ReadOnly = True
    ShowLines = False
    TabOrder = 3
    OnClick = TreeView1Click
    Items.Data = {
      08000000200000000000000000000000FFFFFFFFFFFFFFFF0000000007000000
      0753797374E86D651D0000000000000000000000FFFFFFFFFFFFFFFF00000000
      00000000044C6965752F0000000000000000000000FFFFFFFFFFFFFFFF000000
      00000000001652E9706572746F6972657320436174616C6F677565732B000000
      0000000000000000FFFFFFFFFFFFFFFF00000000000000001252E9706572746F
      6972657320496D616765732E0000000000000000000000FFFFFFFFFFFFFFFF00
      0000000000000015536175766567617264652064657320696D61676573260000
      000000000000000000FFFFFFFFFFFFFFFF00000000000000000D56697375616C
      69736174696F6E240000000000000000000000FFFFFFFFFFFFFFFF0000000000
      0000000B50686F746F6DE9747269651E0000000000000000000000FFFFFFFFFF
      FFFFFF0000000000000000054D7953514C280000000600000006000000FFFFFF
      FFFFFFFFFF00000000010000000F536572766575722064276865757265330000
      000600000006000000FFFFFFFFFFFFFFFF00000000000000001A506F72742053
      E972696520536572766575722064274865757265220000000100000001000000
      FFFFFFFFFFFFFFFF00000000030000000954E96C6573636F7065210000000100
      000001000000FFFFFFFFFFFFFFFF000000000000000008506F696E746167651D
      0000000100000001000000FFFFFFFFFFFFFFFF0000000000000000045061726B
      2D0000000100000001000000FFFFFFFFFFFFFFFF000000000000000014506F72
      742073E97269652074E96C6573636F70651D0000000400000004000000FFFFFF
      FFFFFFFFFF000000000000000004446F6D652A0000000200000002000000FFFF
      FFFFFFFFFFFF00000000020000001143616DE97261205072696E636970616C65
      1D0000000200000002000000FFFFFFFFFFFFFFFF000000000000000004506F73
      651D0000000200000002000000FFFFFFFFFFFFFFFF0000000000000000044346
      57382A0000000500000005000000FFFFFFFFFFFFFFFF00000000000000001143
      616DE972612064652047756964616765260000000300000003000000FFFFFFFF
      FFFFFFFF00000000060000000D4D69736520617520506F696E74200000000300
      000003000000FFFFFFFFFFFFFFFF0000000000000000074D6573757265732A00
      00000300000003000000FFFFFFFFFFFFFFFF000000000000000011436F6D6D61
      6E646520636F72726967E965240000000300000003000000FFFFFFFFFFFFFFFF
      00000000000000000B4175746F666F6375732041240000000300000003000000
      FFFFFFFFFFFFFFFF00000000000000000B4175746F666F637573205625000000
      0300000003000000FFFFFFFFFFFFFFFF00000000000000000C4F7074696D6973
      6174696F6E270000000300000003000000FFFFFFFFFFFFFFFF00000000000000
      000E506F72742073E9726965206D6170200000000100000001000000FFFFFFFF
      FFFFFFFF00000000000000000747756964616765}
  end
  object load_config: TOpenDialog
    Filter = 'Fichier Initialisation (*.ini)|*.ini'
    Left = 32
    Top = 468
  end
  object save_config: TSaveDialog
    Filter = 'Fichiers Initialisation (*.ini)|*.ini'
    Options = [ofOverwritePrompt]
    Left = 64
    Top = 468
  end
  object PBFolderDialog1: TPBFolderDialog
    Flags = [ShowPath, NewDialogStyle, ShowShared]
    Left = 96
    Top = 468
  end
end
