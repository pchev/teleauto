object pop_pretraite_lot: Tpop_pretraite_lot
  Left = 569
  Top = 223
  BorderStyle = bsDialog
  Caption = 'Pr'#233'traiter un lot'
  ClientHeight = 168
  ClientWidth = 231
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 153
    Top = 140
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 4
    Top = 140
    Width = 75
    Height = 25
    TabOrder = 1
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
  object Panel1: TPanel
    Left = 4
    Top = 4
    Width = 225
    Height = 133
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 12
      Width = 74
      Height = 13
      Caption = 'Image d'#39'Offset :'
    end
    object Label2: TLabel
      Left = 8
      Top = 36
      Width = 72
      Height = 13
      Caption = 'Image de Noir :'
    end
    object Label3: TLabel
      Left = 8
      Top = 84
      Width = 70
      Height = 13
      Caption = 'Image de Flat :'
    end
    object Label4: TLabel
      Left = 8
      Top = 108
      Width = 95
      Height = 13
      Caption = 'Fichier Cosm'#233'tique :'
    end
    object Edit4: TEdit
      Left = 107
      Top = 104
      Width = 86
      Height = 21
      TabOrder = 0
    end
    object Edit3: TEdit
      Left = 107
      Top = 80
      Width = 86
      Height = 21
      TabOrder = 1
    end
    object Edit2: TEdit
      Left = 108
      Top = 32
      Width = 85
      Height = 21
      TabOrder = 2
    end
    object Edit1: TEdit
      Left = 108
      Top = 8
      Width = 85
      Height = 21
      TabOrder = 3
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 60
      Width = 157
      Height = 17
      Caption = 'Optimisation du noir'
      TabOrder = 4
    end
    object Button1: TButton
      Left = 196
      Top = 8
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 5
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 196
      Top = 32
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 6
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 196
      Top = 80
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 7
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 196
      Top = 104
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 8
      OnClick = Button4Click
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 96
    Top = 140
  end
end
