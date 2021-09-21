object pop_cree_proj: Tpop_cree_proj
  Left = 364
  Top = 256
  BorderStyle = bsDialog
  Caption = 'Calibration astrom'#233'trique'
  ClientHeight = 212
  ClientWidth = 466
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
    Left = 291
    Top = 184
    Width = 77
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 107
    Top = 184
    Width = 77
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object Panel1: TPanel
    Left = 1
    Top = 0
    Width = 464
    Height = 177
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object Label1: TLabel
      Left = 4
      Top = 8
      Width = 38
      Height = 13
      Caption = 'Focale :'
    end
    object Label2: TLabel
      Left = 4
      Top = 32
      Width = 70
      Height = 13
      Caption = 'Taille pixels X :'
    end
    object Label4: TLabel
      Left = 4
      Top = 80
      Width = 65
      Height = 13
      Caption = 'Apha Centre :'
    end
    object Label5: TLabel
      Left = 4
      Top = 103
      Width = 65
      Height = 13
      Caption = 'Delta Centre :'
    end
    object Label3: TLabel
      Left = 228
      Top = 110
      Width = 59
      Height = 13
      Caption = 'Catalogues :'
    end
    object Label6: TLabel
      Left = 180
      Top = 8
      Width = 16
      Height = 13
      Caption = 'mm'
    end
    object Label7: TLabel
      Left = 180
      Top = 32
      Width = 14
      Height = 13
      Caption = 'um'
    end
    object Bevel1: TBevel
      Left = 221
      Top = 12
      Width = 7
      Height = 157
      Shape = bsLeftLine
    end
    object Label8: TLabel
      Left = 4
      Top = 129
      Width = 39
      Height = 13
      Caption = 'Taille x :'
    end
    object Label9: TLabel
      Left = 4
      Top = 153
      Width = 39
      Height = 13
      Caption = 'Taille y :'
    end
    object Label10: TLabel
      Left = 184
      Top = 129
      Width = 27
      Height = 13
      Caption = 'Pixels'
    end
    object Label11: TLabel
      Left = 184
      Top = 153
      Width = 27
      Height = 13
      Caption = 'Pixels'
    end
    object Label12: TLabel
      Left = 232
      Top = 32
      Width = 167
      Height = 13
      Caption = 'Flux d'#39'une '#233'toile de magnitude 14 : '
      Enabled = False
    end
    object Label13: TLabel
      Left = 228
      Top = 96
      Width = 70
      Height = 13
      Caption = 'Cliquez sur les '
    end
    object Label14: TLabel
      Left = 180
      Top = 56
      Width = 14
      Height = 13
      Caption = 'um'
    end
    object Label15: TLabel
      Left = 4
      Top = 56
      Width = 70
      Height = 13
      Caption = 'Taille pixels Y :'
    end
    object NbreEdit1: NbreEdit
      Left = 80
      Top = 4
      Width = 97
      Height = 21
      TabOrder = 0
      TypeData = 0
    end
    object mask_alpha: TMaskEdit
      Left = 80
      Top = 76
      Width = 97
      Height = 21
      EditMask = '!90:00:00;1;_'
      MaxLength = 8
      TabOrder = 1
      Text = '00:00:00'
    end
    object Mask_delta: TMaskEdit
      Left = 80
      Top = 99
      Width = 97
      Height = 21
      EditMask = '!#90'#176'00'#39'00";1;_'
      MaxLength = 10
      TabOrder = 2
      Text = '+00'#176'00'#39'00"'
    end
    object outListBox1: TListBox
      Left = 300
      Top = 52
      Width = 157
      Height = 117
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 3
    end
    object NbreEdit2: NbreEdit
      Left = 80
      Top = 28
      Width = 97
      Height = 21
      TabOrder = 4
      TypeData = 0
    end
    object SpinEdit1: TSpinEdit
      Left = 80
      Top = 124
      Width = 97
      Height = 22
      Increment = 128
      MaxValue = 99999
      MinValue = 30
      TabOrder = 5
      Value = 512
    end
    object SpinEdit2: TSpinEdit
      Left = 80
      Top = 148
      Width = 97
      Height = 22
      Increment = 128
      MaxValue = 99999
      MinValue = 30
      TabOrder = 6
      Value = 512
    end
    object Edit1: TEdit
      Left = 400
      Top = 28
      Width = 57
      Height = 21
      Enabled = False
      TabOrder = 7
      Text = '10000'
    end
    object CheckBox1: TCheckBox
      Left = 232
      Top = 8
      Width = 169
      Height = 17
      Caption = 'Calcul automatique des flux'
      Checked = True
      State = cbChecked
      TabOrder = 8
      OnClick = CheckBox1Click
    end
    object NbreEdit3: NbreEdit
      Left = 80
      Top = 52
      Width = 97
      Height = 21
      TabOrder = 9
      TypeData = 0
    end
  end
end
