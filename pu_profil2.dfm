object pop_profil: Tpop_profil
  Left = 353
  Top = 162
  Width = 578
  Height = 514
  Caption = 'Coupe photom'#233'trique'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TAChart1: TTAChart
    Left = 0
    Top = 0
    Width = 570
    Height = 417
    AutoUpdateXMin = True
    AutoUpdateXMax = True
    AutoUpdateYMin = True
    AutoUpdateYMax = True
    MirrorX = False
    GraphBrush.Color = clBtnFace
    ShowLegend = False
    ShowTitle = False
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    ShowAxisLabel = True
    XAxisLabel = 'Index des points'
    YAxisLabel = 'intensit'#233's en ADUs'
    ShowVerticalReticule = True
    ShowReticule = False
    OnDrawVertReticule = TAChart1DrawVertReticule
    Align = alClient
    Color = clBtnFace
    ParentColor = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 417
    Width = 570
    Height = 70
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 4
      Width = 35
      Height = 13
      Alignment = taCenter
      Caption = 'Index : '
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 88
      Top = 4
      Width = 72
      Height = 13
      Alignment = taCenter
      Caption = 'Coordonn'#233'es : '
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 256
      Top = 4
      Width = 46
      Height = 13
      Alignment = taCenter
      Caption = 'Intensit'#233' :'
      Layout = tlCenter
    end
    object BitBtn2: TBitBtn
      Left = 180
      Top = 42
      Width = 105
      Height = 25
      Caption = 'Sauver la &Liste'
      TabOrder = 0
      OnClick = BitBtn2Click
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
        7700333333337777777733333333008088003333333377F73377333333330088
        88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
        000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
        FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
        99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
        99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
        99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
        93337FFFF7737777733300000033333333337777773333333333}
      NumGlyphs = 2
    end
    object BitBtn3: TBitBtn
      Left = 288
      Top = 42
      Width = 113
      Height = 25
      Caption = 'Sauver le &Graphe'
      TabOrder = 1
      OnClick = BitBtn3Click
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330080
        8800333333338888888833333333007077003333333388F83388333333330077
        77003333333388FFFF8833333333000000003FFFFFFF88888888000000000000
        000088888888888888880FFFFFFF0FFFFFF08F3333338F333338099999990FFF
        FFF08F33333F8FFFFFF809CFFFCF0CCC9CC08F3333338888888809CFFCFCF039
        99338F333333F8F888F309FCCFFFF09999938F3333383888888F09FCFFFFF999
        99998F3333FFF888888809FCF000003999338F333388883888F309FFF0FF0339
        99338F3333F3833888F30FFFF0F0338999338F3333F83F8888330FFFF0039999
        93338FFFF8838888833300000033333333338888883333333333}
      NumGlyphs = 2
    end
    object BitBtn1: TBitBtn
      Left = 404
      Top = 42
      Width = 165
      Height = 25
      Caption = '&Copier dans le presse-papier'
      TabOrder = 2
      OnClick = BitBtn1Click
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330080
        8800333333338888888833333333007077003333333388F83388333333330077
        77003333333388FFFF8833333333000000003FFFFFFF88888888000000000000
        000088888888888888880FFFFFFF0FFFFFF08F3333338F333338099999990FFF
        FFF08F33333F8FFFFFF809CFFFCF0CCC9CC08F3333338888888809CFFCFCF039
        99338F333333F8F888F309FCCFFFF09999938F3333383888888F09FCFFFFF999
        99998F3333FFF888888809FCF000003999338F333388883888F309FFF0FF0339
        99338F3333F3833888F30FFFF0F0338999338F3333F83F8888330FFFF0039999
        93338FFFF8838888833300000033333333338888883333333333}
      NumGlyphs = 2
    end
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofEnableSizing]
    Left = 132
    Top = 448
  end
end
