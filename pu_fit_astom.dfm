object pop_fit_astrom: Tpop_fit_astrom
  Left = 478
  Top = 102
  BorderStyle = bsDialog
  Caption = 'R'#233'glage de la calibration'
  ClientHeight = 488
  ClientWidth = 444
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 4
    Top = 281
    Width = 35
    Height = 13
    Caption = 'Degr'#233' :'
  end
  object Label2: TLabel
    Left = 100
    Top = 280
    Width = 68
    Height = 13
    Caption = 'R'#233'sidu alpha :'
  end
  object Label3: TLabel
    Left = 276
    Top = 280
    Width = 65
    Height = 13
    Caption = 'R'#233'sidu delta :'
  end
  object Label4: TLabel
    Left = 8
    Top = 4
    Width = 95
    Height = 13
    Caption = 'R'#233'sidus des points :'
  end
  object Label5: TLabel
    Left = 4
    Top = 300
    Width = 155
    Height = 13
    Caption = 'Polyn'#244'me de passage en Alpha :'
  end
  object Label6: TLabel
    Left = 224
    Top = 300
    Width = 153
    Height = 13
    Caption = 'Polyn'#244'me de passage en Delta :'
  end
  object Label7: TLabel
    Left = 224
    Top = 280
    Width = 32
    Height = 13
    Caption = 'arcsec'
  end
  object Label8: TLabel
    Left = 408
    Top = 280
    Width = 32
    Height = 13
    Caption = 'arcsec'
  end
  object Label10: TLabel
    Left = 4
    Top = 444
    Width = 84
    Height = 13
    Caption = 'Nb total d'#39#233'toiles :'
  end
  object Label11: TLabel
    Left = 4
    Top = 468
    Width = 55
    Height = 13
    Caption = 'Nb d'#39#233'toiles'
  end
  object Label12: TLabel
    Left = 160
    Top = 444
    Width = 38
    Height = 13
    Caption = 'Focale :'
  end
  object Label13: TLabel
    Left = 286
    Top = 444
    Width = 16
    Height = 13
    Caption = 'mm'
  end
  object Label14: TLabel
    Left = 160
    Top = 468
    Width = 57
    Height = 13
    Caption = 'Orientation :'
  end
  object Label15: TLabel
    Left = 288
    Top = 468
    Width = 23
    Height = 13
    Caption = 'Deg.'
  end
  object Label16: TLabel
    Left = 328
    Top = 4
    Width = 111
    Height = 13
    Caption = 'X / Y / R'#233'sidu ( Pixels )'
  end
  object CheckListBox1: TCheckListBox
    Left = 4
    Top = 20
    Width = 437
    Height = 229
    Columns = 2
    ItemHeight = 13
    TabOrder = 0
    OnClick = CheckListBox1Click
  end
  object SpinEdit1: TSpinEdit
    Left = 44
    Top = 276
    Width = 45
    Height = 22
    MaxValue = 5
    MinValue = 1
    TabOrder = 1
    Value = 1
    OnChange = SpinEdit1Change
  end
  object Panel1: TPanel
    Left = 168
    Top = 276
    Width = 49
    Height = 21
    BevelOuter = bvLowered
    Caption = 'Panel1'
    Color = clInfoBk
    TabOrder = 2
  end
  object Panel2: TPanel
    Left = 348
    Top = 276
    Width = 53
    Height = 21
    BevelOuter = bvLowered
    Caption = 'Panel1'
    Color = clInfoBk
    TabOrder = 3
  end
  object BitBtn2: TBitBtn
    Left = 344
    Top = 452
    Width = 75
    Height = 25
    TabOrder = 4
    Kind = bkOK
  end
  object Panel3: TPanel
    Left = 92
    Top = 440
    Width = 61
    Height = 21
    BevelOuter = bvLowered
    Caption = 'Panel1'
    Color = clInfoBk
    TabOrder = 5
  end
  object Panel4: TPanel
    Left = 92
    Top = 464
    Width = 61
    Height = 21
    BevelOuter = bvLowered
    Caption = 'Panel1'
    Color = clInfoBk
    TabOrder = 6
  end
  object Panel5: TPanel
    Left = 220
    Top = 440
    Width = 61
    Height = 21
    BevelOuter = bvLowered
    Caption = 'Panel1'
    Color = clInfoBk
    TabOrder = 7
  end
  object Panel6: TPanel
    Left = 220
    Top = 464
    Width = 61
    Height = 21
    BevelOuter = bvLowered
    Caption = 'Panel1'
    Color = clInfoBk
    TabOrder = 8
  end
  object ListBox1: TListBox
    Left = 4
    Top = 316
    Width = 217
    Height = 121
    Color = clBtnFace
    ItemHeight = 13
    TabOrder = 9
  end
  object ListBox2: TListBox
    Left = 224
    Top = 316
    Width = 217
    Height = 121
    Color = clBtnFace
    ItemHeight = 13
    TabOrder = 10
  end
  object Button1: TButton
    Left = 4
    Top = 252
    Width = 185
    Height = 21
    Caption = 'Enlever les '#233'toiles avec r'#233'sidus >= '#224
    TabOrder = 11
    OnClick = Button1Click
  end
  object NbreEdit1: NbreEdit
    Left = 192
    Top = 252
    Width = 57
    Height = 21
    TabOrder = 12
    Text = '0.5'
    ValMax = 1000
    TypeData = 0
  end
  object Button2: TButton
    Left = 308
    Top = 252
    Width = 133
    Height = 21
    Caption = 'Utiliser toutes les '#233'toiles'
    TabOrder = 13
    OnClick = Button2Click
  end
end
