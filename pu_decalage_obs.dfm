object pop_decalage_obs: Tpop_decalage_obs
  Left = 498
  Top = 193
  BorderStyle = bsDialog
  Caption = 'D'#233'calages de guidage'
  ClientHeight = 218
  ClientWidth = 319
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 12
    Width = 77
    Height = 13
    Caption = 'D'#233'calage en X :'
  end
  object Label2: TLabel
    Left = 164
    Top = 12
    Width = 77
    Height = 13
    Caption = 'D'#233'calage en Y :'
  end
  object outListView1: TListView
    Left = 5
    Top = 64
    Width = 309
    Height = 118
    Columns = <
      item
        Caption = 'Dx'
        Width = 153
      end
      item
        Caption = 'Dy'
        Width = 152
      end>
    HotTrack = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object BitBtn1: TBitBtn
    Left = 99
    Top = 36
    Width = 121
    Height = 25
    Caption = 'Ajouter '#224' la liste'
    TabOrder = 1
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
  object BitBtn4: TBitBtn
    Left = 288
    Top = 36
    Width = 21
    Height = 25
    Hint = 'Effacer la liste'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 2
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
  object NbreEdit1: NbreEdit
    Left = 92
    Top = 8
    Width = 61
    Height = 21
    TabOrder = 3
    Text = '5'
    ValMax = 10
    TypeData = 0
  end
  object NbreEdit2: NbreEdit
    Left = 248
    Top = 8
    Width = 61
    Height = 21
    TabOrder = 4
    Text = '5'
    ValMax = 10
    TypeData = 0
  end
  object BitBtn5: TBitBtn
    Left = 122
    Top = 188
    Width = 75
    Height = 25
    TabOrder = 5
    OnClick = BitBtn5Click
    Kind = bkOK
  end
end
