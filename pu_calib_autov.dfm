object pop_calib_autov: Tpop_calib_autov
  Left = 537
  Top = 204
  BorderStyle = bsDialog
  Caption = 'Trac'#233' de la courbe en V'
  ClientHeight = 398
  ClientWidth = 589
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label12: TLabel
    Left = 244
    Top = 272
    Width = 121
    Height = 13
    Caption = 'Relev'#233' des manoeuvres :'
  end
  object Image1: TImage
    Left = 240
    Top = 16
    Width = 349
    Height = 253
    OnMouseMove = Image1MouseMove
  end
  object Label14: TLabel
    Left = 360
    Top = 0
    Width = 109
    Height = 13
    Caption = 'HFD (Pixels,Secondes)'
  end
  object Label15: TLabel
    Left = 452
    Top = 272
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
    Height = 89
    Caption = 'Type de courbe en V'
    TabOrder = 3
    object Label1: TLabel
      Left = 8
      Top = 20
      Width = 40
      Height = 13
      Caption = 'Vitesse :'
    end
    object Label2: TLabel
      Left = 8
      Top = 44
      Width = 83
      Height = 13
      Caption = 'Sens de marche :'
    end
    object Label13: TLabel
      Left = 8
      Top = 68
      Width = 59
      Height = 13
      Caption = 'Commande :'
    end
    object ComboBox1: TComboBox
      Left = 128
      Top = 16
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
      Top = 40
      Width = 97
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
      Text = 'Avant'
      OnChange = ComboBox2Change
      Items.Strings = (
        'Avant'
        'Arri'#232're')
    end
    object ComboBox3: TComboBox
      Left = 128
      Top = 64
      Width = 97
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
      Text = 'Corrig'#233'e'
      OnChange = ComboBox3Change
      Items.Strings = (
        'Corrig'#233'e'
        'Directe')
    end
  end
  object GroupBox2: TGroupBox
    Left = 4
    Top = 124
    Width = 235
    Height = 101
    Caption = 'Trac'#233' de la courbe en V'
    TabOrder = 4
    object Label3: TLabel
      Left = 8
      Top = 20
      Width = 135
      Height = 13
      Caption = 'Impulsion incr'#233'mentale (ms) :'
    end
    object Label4: TLabel
      Left = 8
      Top = 45
      Width = 140
      Height = 13
      Caption = 'Nombre d'#39'impulsions par pas :'
    end
    object Label5: TLabel
      Left = 8
      Top = 69
      Width = 86
      Height = 13
      Caption = 'Limite ascendante'
    end
    object Label11: TLabel
      Left = 8
      Top = 84
      Width = 121
      Height = 13
      Caption = 'en % du diam'#232'tre maximal'
    end
    object SpinEdit2: TSpinEdit
      Left = 152
      Top = 40
      Width = 73
      Height = 22
      MaxValue = 99
      MinValue = 1
      TabOrder = 0
      Value = 1
    end
    object SpinEdit3: TSpinEdit
      Left = 152
      Top = 64
      Width = 73
      Height = 22
      Increment = 5
      MaxValue = 2000
      MinValue = 0
      TabOrder = 1
      Value = 25
    end
    object NumberEdit1: TNumberEdit
      Left = 152
      Top = 16
      Width = 57
      Height = 21
      TypeValue = Float
      Text = '500'
      TabOrder = 2
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
      TabOrder = 3
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
  object GroupBox3: TGroupBox
    Left = 4
    Top = 228
    Width = 235
    Height = 141
    Caption = 'Z'#244'ne lin'#233'aire descendante'
    TabOrder = 5
    object Label6: TLabel
      Left = 8
      Top = 20
      Width = 103
      Height = 13
      Caption = 'Diam'#232'tre extr'#232'me (p) :'
    end
    object Label7: TLabel
      Left = 8
      Top = 44
      Width = 99
      Height = 13
      Caption = 'Diam'#232'tre proche (p) :'
    end
    object Label8: TLabel
      Left = 8
      Top = 68
      Width = 65
      Height = 13
      Caption = 'Vitesse (p/s) :'
    end
    object Label9: TLabel
      Left = 8
      Top = 92
      Width = 116
      Height = 13
      Caption = 'Nombre de points utiles :'
    end
    object Label10: TLabel
      Left = 8
      Top = 116
      Width = 70
      Height = 13
      Caption = 'Dispersion (p) :'
    end
    object NumberEdit2: TNumberEdit
      Left = 136
      Top = 16
      Width = 73
      Height = 21
      TypeValue = Float
      TabOrder = 0
      OnChange = NumberEdit2Change
    end
    object NumberEdit3: TNumberEdit
      Left = 136
      Top = 40
      Width = 73
      Height = 21
      TypeValue = Float
      TabOrder = 1
      OnChange = NumberEdit3Change
    end
    object Edit1: TEdit
      Left = 136
      Top = 64
      Width = 89
      Height = 21
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 2
    end
    object Edit2: TEdit
      Left = 136
      Top = 88
      Width = 89
      Height = 21
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 3
    end
    object Edit3: TEdit
      Left = 136
      Top = 112
      Width = 89
      Height = 21
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 4
    end
    object SpinButton2: TSpinButton
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
      TabOrder = 5
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
      OnDownClick = SpinButton2DownClick
      OnUpClick = SpinButton2UpClick
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
      OnDownClick = SpinButton3DownClick
      OnUpClick = SpinButton3UpClick
    end
  end
  object ListBox1: TListBox
    Left = 240
    Top = 288
    Width = 349
    Height = 109
    Color = clBtnFace
    ItemHeight = 13
    TabOrder = 6
  end
  object Button4: TButton
    Left = 4
    Top = 372
    Width = 89
    Height = 25
    Caption = 'Sauver HFD'
    TabOrder = 7
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 148
    Top = 372
    Width = 89
    Height = 25
    Caption = 'Sauver Relev'#233
    TabOrder = 8
    OnClick = Button5Click
  end
end
