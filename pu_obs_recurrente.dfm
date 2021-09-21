object pop_obs_recurrente: Tpop_obs_recurrente
  Left = 429
  Top = 126
  BorderStyle = bsDialog
  Caption = 'Obervations r'#233'curentes'
  ClientHeight = 342
  ClientWidth = 412
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 7
    Top = 312
    Width = 174
    Height = 25
    Caption = 'Lancer les observations'
    Enabled = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListView1: TListView
    Left = 4
    Top = 120
    Width = 404
    Height = 118
    Columns = <
      item
        Caption = 'Nom'
        Width = 100
      end
      item
        Caption = 'Nombre'
      end
      item
        Caption = 'Pose'
      end
      item
        Caption = 'Alpha'
        Width = 100
      end
      item
        Caption = 'Delta'
        Width = 100
      end>
    HotTrack = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
  end
  object BitBtn1: TBitBtn
    Left = 145
    Top = 88
    Width = 121
    Height = 25
    Caption = 'Ajouter '#224' la liste'
    TabOrder = 2
    OnClick = BitBtn1Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
      333333333337F33333333333333033333333333333373F333333333333090333
      33333333337F7F33333333333309033333333333337373F33333333330999033
      3333333337F337F33333333330999033333333333733373F3333333309999903
      333333337F33337F33333333099999033333333373333373F333333099999990
      33333337FFFF3FF7F33333300009000033333337777F77773333333333090333
      33333333337F7F33333333333309033333333333337F7F333333333333090333
      33333333337F7F33333333333309033333333333337F7F333333333333090333
      33333333337F7F33333333333300033333333333337773333333}
    NumGlyphs = 2
  end
  object GroupBox1: TGroupBox
    Left = 4
    Top = 4
    Width = 404
    Height = 77
    Caption = 'Images'
    TabOrder = 3
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 78
      Height = 13
      Caption = 'Nom g'#233'n'#233'rique :'
    end
    object Label2: TLabel
      Left = 164
      Top = 25
      Width = 43
      Height = 13
      Caption = 'Nombre :'
    end
    object outLabel17: TLabel
      Left = 8
      Top = 52
      Width = 33
      Height = 13
      Caption = 'Alpha :'
    end
    object outLabel22: TLabel
      Left = 148
      Top = 51
      Width = 31
      Height = 13
      Caption = 'Delta :'
    end
    object Label6: TLabel
      Left = 264
      Top = 24
      Width = 33
      Height = 13
      Caption = 'Pose : '
    end
    object Edit1: TEdit
      Left = 92
      Top = 20
      Width = 61
      Height = 21
      TabOrder = 0
      Text = 'Image1'
    end
    object SpinEdit1: TSpinEdit
      Left = 212
      Top = 20
      Width = 45
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 3
    end
    object MaskDelta: TMaskEdit
      Left = 188
      Top = 47
      Width = 69
      Height = 21
      EditMask = '!#90'#176'00'#39'00";1;_'
      MaxLength = 10
      TabOrder = 3
      Text = '+45'#176'21'#39'13"'
    end
    object MaskAlpha: TMaskEdit
      Left = 48
      Top = 48
      Width = 69
      Height = 21
      EditMask = '!90:00:00;1;_'
      MaxLength = 8
      TabOrder = 4
      Text = '16:42:03'
    end
    object NbreEdit2: NbreEdit
      Left = 300
      Top = 20
      Width = 61
      Height = 21
      TabOrder = 2
      Text = '60'
      TypeData = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 4
    Top = 240
    Width = 404
    Height = 65
    Caption = 'Contr'#244'le'
    TabOrder = 4
    object Label3: TLabel
      Left = 8
      Top = 20
      Width = 216
      Height = 13
      Caption = 'Arr'#234'ter l'#39'acquisition en dessous de la hauteur :'
    end
    object Label4: TLabel
      Left = 284
      Top = 20
      Width = 34
      Height = 13
      Caption = 'Degr'#233's'
    end
    object Label5: TLabel
      Left = 8
      Top = 40
      Width = 307
      Height = 13
      Caption = 
        'A la fin le t'#233'l'#233'scope est maintenu '#224' la croise'#233' m'#233'ridien / '#233'quat' +
        'eur'
    end
    object NbreEdit1: NbreEdit
      Left = 236
      Top = 16
      Width = 37
      Height = 21
      TabOrder = 0
      Text = '25'
      ValMax = 90
      TypeData = 0
    end
  end
  object BitBtn2: TBitBtn
    Left = 352
    Top = 88
    Width = 25
    Height = 25
    Hint = 'Sauver une liste'
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = BitBtn2Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
      00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
      00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
      00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
      00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
      00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
      00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
      0003737FFFFFFFFF7F7330099999999900333777777777777733}
    NumGlyphs = 2
  end
  object BitBtn3: TBitBtn
    Left = 324
    Top = 88
    Width = 25
    Height = 25
    Hint = 'Charger une liste'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = BitBtn3Click
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000C0C0C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      0000000000000000000000000000000000000000000000000000000000000000
      00C0C0C0C0C0C0C0C0C0C0C0C0C0C0C080808000000000FFFFFFFFFF00FFFFFF
      FFFF00FFFFFFFFFF00FFFFFFFFFF00FFFF000000C0C0C0C0C0C0C0C0C0C0C0C0
      00FFFF000000FFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFF
      FF000000C0C0C0C0C0C0C0C0C0C0C0C080808000000000FFFFFFFFFF00FFFFFF
      FFFF00FFFFFFFFFF00FFFFFFFFFF00FFFF000000C0C0C0C0C0C0C0C0C0C0C0C0
      00FFFF80808000000000FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFF
      FFFFFFFF000000C0C0C0C0C0C0C0C0C080808000FFFF000000FFFFFF00FFFFFF
      FFFF00FFFFFFFFFF00FFFFFFFFFF00FFFF00FFFF000000C0C0C0C0C0C0C0C0C0
      80808000FFFF80808000FFFF80808000FF00FFFF0000FF0000000000FFFF0000
      00000000C0C0C0C0C0C0C0C0C0C0C0C000000000000000FFFF80808000FFFF00
      000000FF00FFFF0000FF00000000C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0
      C0C0C0C0C0C0000000000000000000C0C0C000000000FF00FFFF0000FF000000
      00000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C0C0C0C0C000000000FF00FFFF0000FF00000000C0C0C0C0C0C0C0C0C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000FF00FFFF
      00000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C0C0C0C0C000000000FF00FFFF0000FF00000000C0C0C0C0C0C0C0C0C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
  end
  object BitBtn4: TBitBtn
    Left = 380
    Top = 88
    Width = 25
    Height = 25
    Hint = 'Effacer la liste'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 7
    OnClick = BitBtn4Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
      555557777F777555F55500000000555055557777777755F75555005500055055
      555577F5777F57555555005550055555555577FF577F5FF55555500550050055
      5555577FF77577FF555555005050110555555577F757777FF555555505099910
      555555FF75777777FF555005550999910555577F5F77777775F5500505509990
      3055577F75F77777575F55005055090B030555775755777575755555555550B0
      B03055555F555757575755550555550B0B335555755555757555555555555550
      BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
      50BB555555555555575F555555555555550B5555555555555575}
    NumGlyphs = 2
  end
  object Button2: TButton
    Left = 232
    Top = 312
    Width = 173
    Height = 25
    Caption = 'Arr'#234'ter et quitter'
    TabOrder = 8
    OnClick = Button2Click
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 332
    Top = 256
  end
end
