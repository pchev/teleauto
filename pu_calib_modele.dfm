object pop_calib_modele: Tpop_calib_modele
  Left = 605
  Top = 179
  BorderStyle = bsDialog
  Caption = 'Calibration manuelle du mod'#232'le de pointage'
  ClientHeight = 159
  ClientWidth = 347
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
  object Label1: TLabel
    Left = 8
    Top = 24
    Width = 32
    Height = 13
    Caption = 'Etoile :'
  end
  object Label2: TLabel
    Left = 8
    Top = 4
    Width = 107
    Height = 13
    Caption = '1 ) Trouver une '#233'toile :'
  end
  object Label3: TLabel
    Left = 8
    Top = 76
    Width = 143
    Height = 13
    Caption = '3 ) Centrer l'#39#233'toile dans le CCD'
  end
  object Label4: TLabel
    Left = 168
    Top = 4
    Width = 90
    Height = 13
    Caption = 'Liste des mesures :'
  end
  object id: TEdit
    Left = 52
    Top = 20
    Width = 105
    Height = 21
    TabOrder = 0
  end
  object btn_pointer_objet: TButton
    Left = 8
    Top = 48
    Width = 149
    Height = 21
    Hint = 'Pointe sur cet objet'
    Caption = '2 ) Pointer'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btn_pointer_objetClick
  end
  object Button1: TButton
    Left = 8
    Top = 96
    Width = 149
    Height = 21
    Caption = '4 ) Mesurer'
    TabOrder = 2
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 164
    Top = 20
    Width = 177
    Height = 133
    ItemHeight = 13
    TabOrder = 3
  end
end
