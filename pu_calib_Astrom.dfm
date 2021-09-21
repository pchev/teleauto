object pop_calib_astrom: Tpop_calib_astrom
  Left = 416
  Top = 158
  BorderStyle = bsDialog
  Caption = 'Calibration  astrom'#233'trique'
  ClientHeight = 295
  ClientWidth = 225
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 143
    Top = 268
    Width = 77
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 7
    Top = 268
    Width = 77
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object Panel1: TPanel
    Left = 5
    Top = 4
    Width = 216
    Height = 261
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 38
      Height = 13
      Caption = 'Focale :'
    end
    object Label2: TLabel
      Left = 16
      Top = 32
      Width = 70
      Height = 13
      Caption = 'Taille pixels X :'
    end
    object Label4: TLabel
      Left = 16
      Top = 80
      Width = 65
      Height = 13
      Caption = 'Apha Centre :'
    end
    object Label5: TLabel
      Left = 16
      Top = 103
      Width = 65
      Height = 13
      Caption = 'Delta Centre :'
    end
    object Label6: TLabel
      Left = 192
      Top = 8
      Width = 16
      Height = 13
      Caption = 'mm'
    end
    object Label7: TLabel
      Left = 192
      Top = 32
      Width = 14
      Height = 13
      Caption = 'um'
    end
    object Label13: TLabel
      Left = 16
      Top = 124
      Width = 131
      Height = 13
      Caption = 'Cliquez sur les catalogues : '
    end
    object Label3: TLabel
      Left = 16
      Top = 56
      Width = 70
      Height = 13
      Caption = 'Taille pixels Y :'
    end
    object Label8: TLabel
      Left = 192
      Top = 56
      Width = 14
      Height = 13
      Caption = 'um'
    end
    object NbreEdit1: NbreEdit
      Left = 92
      Top = 4
      Width = 97
      Height = 21
      TabOrder = 0
      TypeData = 0
    end
    object mask_alpha: TMaskEdit
      Left = 92
      Top = 76
      Width = 97
      Height = 21
      EditMask = '!90:00:00;1;_'
      MaxLength = 8
      TabOrder = 1
      Text = '00:00:00'
    end
    object Mask_delta: TMaskEdit
      Left = 92
      Top = 99
      Width = 97
      Height = 21
      EditMask = '!#90'#176'00'#39'00";1;_'
      MaxLength = 10
      TabOrder = 2
      Text = '+00'#176'00'#39'00"'
    end
    object outListBox1: TListBox
      Left = 16
      Top = 140
      Width = 173
      Height = 89
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 3
    end
    object NbreEdit2: NbreEdit
      Left = 92
      Top = 28
      Width = 97
      Height = 21
      TabOrder = 4
      TypeData = 0
    end
    object NbreEdit3: NbreEdit
      Left = 92
      Top = 52
      Width = 97
      Height = 21
      TabOrder = 5
      TypeData = 0
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 236
      Width = 169
      Height = 17
      Caption = 'Haute pr'#233'cision (pc rapides)'
      TabOrder = 6
    end
  end
end
