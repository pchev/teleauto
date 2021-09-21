object pop_cmde_corr: Tpop_cmde_corr
  Left = 452
  Top = 581
  BorderStyle = bsDialog
  Caption = 'Etalonnage de la commande corrig'#233'e'
  ClientHeight = 372
  ClientWidth = 592
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label12: TLabel
    Left = 244
    Top = 264
    Width = 121
    Height = 13
    Caption = 'Relev'#233' des manoeuvres :'
  end
  object Image1: TImage
    Left = 240
    Top = 16
    Width = 349
    Height = 245
    OnMouseMove = Image1MouseMove
  end
  object Label14: TLabel
    Left = 360
    Top = 0
    Width = 124
    Height = 13
    Caption = 'HFD (Pixels,Millisecondes)'
  end
  object Label13: TLabel
    Left = 460
    Top = 264
    Width = 3
    Height = 13
  end
  object Button1: TButton
    Left = 4
    Top = 4
    Width = 75
    Height = 25
    Caption = 'D'#233'marrer'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 84
    Top = 4
    Width = 75
    Height = 25
    Caption = 'Arr'#234'ter'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 164
    Top = 4
    Width = 75
    Height = 25
    Caption = 'Appliquer'
    TabOrder = 2
    OnClick = Button3Click
  end
  object GroupBox1: TGroupBox
    Left = 4
    Top = 32
    Width = 235
    Height = 73
    Caption = 'Type d'#39#233'talonnage'
    TabOrder = 3
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 40
      Height = 13
      Caption = 'Vitesse :'
    end
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 54
      Height = 13
      Caption = 'Param'#232'tre :'
    end
    object ComboBox1: TComboBox
      Left = 128
      Top = 20
      Width = 97
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'Lente'
      OnChange = ComboBox1Change
      Items.Strings = (
        'Lente'
        'Rapide')
    end
    object ComboBox2: TComboBox
      Left = 128
      Top = 44
      Width = 97
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
      Text = 'Correction AV'
      OnChange = ComboBox2Change
      Items.Strings = (
        'Correction AV'
        'Survitesse AR')
    end
  end
  object GroupBox3: TGroupBox
    Left = 4
    Top = 228
    Width = 235
    Height = 109
    Caption = 'Calcul du param'#232'tre'
    TabOrder = 4
    object Label8: TLabel
      Left = 8
      Top = 24
      Width = 93
      Height = 13
      Caption = 'Correction AV (ms) :'
    end
    object Label9: TLabel
      Left = 8
      Top = 52
      Width = 116
      Height = 13
      Caption = 'Nombre de points utiles :'
    end
    object Label10: TLabel
      Left = 8
      Top = 80
      Width = 70
      Height = 13
      Caption = 'Dispersion (p) :'
    end
    object Edit1: TEdit
      Left = 136
      Top = 20
      Width = 89
      Height = 21
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 136
      Top = 48
      Width = 89
      Height = 21
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 1
    end
    object Edit3: TEdit
      Left = 136
      Top = 76
      Width = 89
      Height = 21
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 2
    end
  end
  object ListBox1: TListBox
    Left = 240
    Top = 280
    Width = 349
    Height = 89
    Color = clBtnFace
    ItemHeight = 13
    TabOrder = 5
  end
  object GroupBox4: TGroupBox
    Left = 4
    Top = 108
    Width = 233
    Height = 117
    Caption = 'Trac'#233' de la droite'
    TabOrder = 6
    object Label5: TLabel
      Left = 8
      Top = 21
      Width = 142
      Height = 13
      Caption = 'Nombre d'#39'impulsions de 0 ms :'
    end
    object Label6: TLabel
      Left = 8
      Top = 44
      Width = 75
      Height = 13
      Caption = 'Incr'#233'ment (ms) :'
    end
    object Label7: TLabel
      Left = 8
      Top = 68
      Width = 101
      Height = 13
      Caption = 'Valeur minimale (ms) :'
    end
    object Label11: TLabel
      Left = 8
      Top = 92
      Width = 104
      Height = 13
      Caption = 'Valeur maximale (ms) :'
    end
    object SpinEdit1: TSpinEdit
      Left = 152
      Top = 16
      Width = 73
      Height = 22
      MaxValue = 99
      MinValue = 1
      TabOrder = 0
      Value = 10
    end
    object NumberEdit3: TNumberEdit
      Left = 152
      Top = 40
      Width = 57
      Height = 21
      TypeValue = Float
      Text = '100'
      TabOrder = 1
    end
    object SpinButton3: TSpinButton
      Left = 208
      Top = 41
      Width = 15
      Height = 18
      DownGlyph.Data = {
        0E010000424D0E01000000000000360000002800000009000000060000000100
        200000000000D800000000000000000000000000000000000000008080000080
        8000008080000080800000808000008080000080800000808000008080000080
        8000008080000080800000808000000000000080800000808000008080000080
        8000008080000080800000808000000000000000000000000000008080000080
        8000008080000080800000808000000000000000000000000000000000000000
        0000008080000080800000808000000000000000000000000000000000000000
        0000000000000000000000808000008080000080800000808000008080000080
        800000808000008080000080800000808000}
      TabOrder = 2
      UpGlyph.Data = {
        0E010000424D0E01000000000000360000002800000009000000060000000100
        200000000000D800000000000000000000000000000000000000008080000080
        8000008080000080800000808000008080000080800000808000008080000080
        8000000000000000000000000000000000000000000000000000000000000080
        8000008080000080800000000000000000000000000000000000000000000080
        8000008080000080800000808000008080000000000000000000000000000080
        8000008080000080800000808000008080000080800000808000000000000080
        8000008080000080800000808000008080000080800000808000008080000080
        800000808000008080000080800000808000}
      OnDownClick = SpinButton3DownClick
      OnUpClick = SpinButton3UpClick
    end
    object NumberEdit4: TNumberEdit
      Left = 152
      Top = 64
      Width = 57
      Height = 21
      TypeValue = Float
      Text = '100'
      TabOrder = 3
    end
    object SpinButton4: TSpinButton
      Left = 208
      Top = 65
      Width = 15
      Height = 18
      DownGlyph.Data = {
        0E010000424D0E01000000000000360000002800000009000000060000000100
        200000000000D800000000000000000000000000000000000000008080000080
        8000008080000080800000808000008080000080800000808000008080000080
        8000008080000080800000808000000000000080800000808000008080000080
        8000008080000080800000808000000000000000000000000000008080000080
        8000008080000080800000808000000000000000000000000000000000000000
        0000008080000080800000808000000000000000000000000000000000000000
        0000000000000000000000808000008080000080800000808000008080000080
        800000808000008080000080800000808000}
      TabOrder = 4
      UpGlyph.Data = {
        0E010000424D0E01000000000000360000002800000009000000060000000100
        200000000000D800000000000000000000000000000000000000008080000080
        8000008080000080800000808000008080000080800000808000008080000080
        8000000000000000000000000000000000000000000000000000000000000080
        8000008080000080800000000000000000000000000000000000000000000080
        8000008080000080800000808000008080000000000000000000000000000080
        8000008080000080800000808000008080000080800000808000000000000080
        8000008080000080800000808000008080000080800000808000008080000080
        800000808000008080000080800000808000}
      OnDownClick = SpinButton4DownClick
      OnUpClick = SpinButton4UpClick
    end
    object NumberEdit5: TNumberEdit
      Left = 152
      Top = 88
      Width = 57
      Height = 21
      TypeValue = Float
      Text = '800'
      TabOrder = 5
    end
    object SpinButton5: TSpinButton
      Left = 208
      Top = 89
      Width = 15
      Height = 18
      DownGlyph.Data = {
        0E010000424D0E01000000000000360000002800000009000000060000000100
        200000000000D800000000000000000000000000000000000000008080000080
        8000008080000080800000808000008080000080800000808000008080000080
        8000008080000080800000808000000000000080800000808000008080000080
        8000008080000080800000808000000000000000000000000000008080000080
        8000008080000080800000808000000000000000000000000000000000000000
        0000008080000080800000808000000000000000000000000000000000000000
        0000000000000000000000808000008080000080800000808000008080000080
        800000808000008080000080800000808000}
      TabOrder = 6
      UpGlyph.Data = {
        0E010000424D0E01000000000000360000002800000009000000060000000100
        200000000000D800000000000000000000000000000000000000008080000080
        8000008080000080800000808000008080000080800000808000008080000080
        8000000000000000000000000000000000000000000000000000000000000080
        8000008080000080800000000000000000000000000000000000000000000080
        8000008080000080800000808000008080000000000000000000000000000080
        8000008080000080800000808000008080000080800000808000000000000080
        8000008080000080800000808000008080000080800000808000008080000080
        800000808000008080000080800000808000}
      OnDownClick = SpinButton5DownClick
      OnUpClick = SpinButton5UpClick
    end
    object NumberEdit1: TNumberEdit
      Left = 152
      Top = 16
      Width = 57
      Height = 21
      TypeValue = Float
      Text = '3000'
      TabOrder = 7
    end
    object SpinButton1: TSpinButton
      Left = 208
      Top = 17
      Width = 15
      Height = 18
      DownGlyph.Data = {
        0E010000424D0E01000000000000360000002800000009000000060000000100
        200000000000D800000000000000000000000000000000000000008080000080
        8000008080000080800000808000008080000080800000808000008080000080
        8000008080000080800000808000000000000080800000808000008080000080
        8000008080000080800000808000000000000000000000000000008080000080
        8000008080000080800000808000000000000000000000000000000000000000
        0000008080000080800000808000000000000000000000000000000000000000
        0000000000000000000000808000008080000080800000808000008080000080
        800000808000008080000080800000808000}
      TabOrder = 8
      UpGlyph.Data = {
        0E010000424D0E01000000000000360000002800000009000000060000000100
        200000000000D800000000000000000000000000000000000000008080000080
        8000008080000080800000808000008080000080800000808000008080000080
        8000000000000000000000000000000000000000000000000000000000000080
        8000008080000080800000000000000000000000000000000000000000000080
        8000008080000080800000808000008080000000000000000000000000000080
        8000008080000080800000808000008080000080800000808000000000000080
        8000008080000080800000808000008080000080800000808000008080000080
        800000808000008080000080800000808000}
      OnDownClick = SpinButton1DownClick
      OnUpClick = SpinButton1UpClick
    end
  end
  object Button4: TButton
    Left = 4
    Top = 344
    Width = 89
    Height = 25
    Caption = 'Sauver HFD'
    TabOrder = 7
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 148
    Top = 344
    Width = 89
    Height = 25
    Caption = 'Sauver Relev'#233
    TabOrder = 8
    OnClick = Button5Click
  end
end
