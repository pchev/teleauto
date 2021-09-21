object pop_histo: Tpop_histo
  Left = 70
  Top = 118
  BorderStyle = bsDialog
  Caption = 'Histogramme'
  ClientHeight = 387
  ClientWidth = 707
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
  object Panel1: TPanel
    Left = 4
    Top = 4
    Width = 701
    Height = 269
    BevelOuter = bvLowered
    TabOrder = 0
    object Image1: TImage
      Left = 41
      Top = 1
      Width = 659
      Height = 248
      OnMouseDown = Image1MouseDown
    end
    object Label4: TLabel
      Left = 40
      Top = 252
      Width = 32
      Height = 13
      Caption = 'Label4'
    end
    object Label5: TLabel
      Left = 664
      Top = 252
      Width = 32
      Height = 13
      Caption = 'Label5'
    end
    object Label6: TLabel
      Left = 28
      Top = 236
      Width = 6
      Height = 13
      Caption = '0'
    end
    object Label7: TLabel
      Left = 4
      Top = 4
      Width = 32
      Height = 13
      Alignment = taRightJustify
      Caption = 'Label7'
    end
  end
  object GroupBox1: TGroupBox
    Left = 4
    Top = 276
    Width = 125
    Height = 109
    Caption = 'Limites'
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 52
      Width = 35
      Height = 13
      Caption = 'Basse :'
    end
    object Label2: TLabel
      Left = 8
      Top = 24
      Width = 35
      Height = 13
      Caption = 'Haute :'
    end
    object Label3: TLabel
      Left = 8
      Top = 80
      Width = 53
      Height = 13
      Caption = 'Incr'#233'ment :'
    end
    object Edit1: TEdit
      Left = 48
      Top = 48
      Width = 49
      Height = 21
      TabOrder = 0
      Text = 'Edit1'
      OnKeyDown = Edit1KeyDown
    end
    object SpinButton1: TSpinButton
      Left = 96
      Top = 48
      Width = 21
      Height = 21
      DownGlyph.Data = {
        BA000000424DBA00000000000000420000002800000009000000060000000100
        1000030000007800000000000000000000000000000000000000007C0000E003
        00001F000000E03DE03DE03DE03DE03DE03DE03DE03DE03D0300E03DE03DE03D
        E03D0000E03DE03DE03DE03DF302E03DE03DE03D000000000000E03DE03DE03D
        F302E03DE03D00000000000000000000E03DE03D2F03E03D0000000000000000
        000000000000E03DD781E03DE03DE03DE03DE03DE03DE03DE03DE03D1FFF}
      TabOrder = 1
      UpGlyph.Data = {
        BA000000424DBA00000000000000420000002800000009000000060000000100
        1000030000007800000000000000000000000000000000000000007C0000E003
        00001F000000E03DE03DE03DE03DE03DE03DE03DE03DE03D0300E03D00000000
        00000000000000000000E03DF302E03DE03D00000000000000000000E03DE03D
        F302E03DE03DE03D000000000000E03DE03DE03D2F03E03DE03DE03DE03D0000
        E03DE03DE03DE03DD281E03DE03DE03DE03DE03DE03DE03DE03DE03DD281}
      OnDownClick = SpinButton1DownClick
      OnUpClick = SpinButton1UpClick
    end
    object Edit2: TEdit
      Left = 48
      Top = 20
      Width = 49
      Height = 21
      TabOrder = 2
      Text = 'Edit2'
      OnKeyDown = Edit2KeyDown
    end
    object SpinButton2: TSpinButton
      Left = 97
      Top = 20
      Width = 20
      Height = 21
      DownGlyph.Data = {
        BA000000424DBA00000000000000420000002800000009000000060000000100
        1000030000007800000000000000000000000000000000000000007C0000E003
        00001F000000E03DE03DE03DE03DE03DE03DE03DE03DE03D03FFE03DE03DE03D
        E03D0000E03DE03DE03DE03D03FFE03DE03DE03D000000000000E03DE03DE03D
        001FE03DE03D00000000000000000000E03DE03D0001E03D0000000000000000
        000000000000E03D00FFE03DE03DE03DE03DE03DE03DE03DE03DE03D1FFF}
      TabOrder = 3
      UpGlyph.Data = {
        BA000000424DBA00000000000000420000002800000009000000060000000100
        1000030000007800000000000000000000000000000000000000007C0000E003
        00001F000000E03DE03DE03DE03DE03DE03DE03DE03DE03D0500E03D00000000
        00000000000000000000E03D8B01E03DE03D00000000000000000000E03DE03D
        8801E03DE03DE03D000000000000E03DE03DE03D9E01E03DE03DE03DE03D0000
        E03DE03DE03DE03D0600E03DE03DE03DE03DE03DE03DE03DE03DE03DD781}
      OnDownClick = SpinButton2DownClick
      OnUpClick = SpinButton2UpClick
    end
    object SpinEdit1: TSpinEdit
      Left = 64
      Top = 75
      Width = 54
      Height = 22
      Increment = 100
      MaxValue = 10000
      MinValue = 10
      TabOrder = 4
      Value = 100
    end
  end
  object GroupBox2: TGroupBox
    Left = 132
    Top = 276
    Width = 133
    Height = 109
    Caption = 'Raquette'
    TabOrder = 2
    object SpeedButton6: TSpeedButton
      Left = 5
      Top = 51
      Width = 23
      Height = 22
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        777777777777777F7777777F0000777777770777777707777777778F7777778F
        0000777777700777777007777777788F7777788F000077777700077777000777
        7777888F7777888F0000777770000777700007777778888F7778888F00007777
        00000777000007777788888F7788888F0000777000000770000007777888888F
        7888888F0000770000000700000007778888888F8888888F0000700000000000
        00000778888888888888888F000070000000000000000778888888888888888F
        0000770000000700000007778888888F8888888F000077700000077000000777
        7888888F7888888F0000777700000777000007777788888F7788888F00007777
        70000777700007777778888F7778888F0000777777000777770007777777888F
        7777888F0000777777700777777007777777788F7777788F0000777777770777
        7777077777777787777777870000777777777777777777777777777777777777
        0000}
      NumGlyphs = 2
      OnClick = SpeedButton6Click
    end
    object SpeedButton4: TSpeedButton
      Left = 30
      Top = 51
      Width = 23
      Height = 22
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777777777777777FF000077777777777777700777777777777777F88F
        0000777777777777700007777777777777F8888F000077777777777000000777
        77777777F888888F000077777777700000000777777777F88888888F00007777
        77700000000007777777F8888888888F00007777700000000000077777F88888
        8888888F000077700000000000000777F88888888888888F0000700000000000
        00000778888888888888888F000070000000000000000778888888888888888F
        000077700000000000000777788888888888888F000077777000000000000777
        777888888888888F000077777770000000000777777778888888888F00007777
        7777700000000777777777788888888F00007777777777700000077777777777
        7888888F000077777777777770000777777777777778888F0000777777777777
        7770077777777777777778870000777777777777777777777777777777777777
        0000}
      NumGlyphs = 2
      OnClick = SpeedButton4Click
    end
    object SpeedButton7: TSpeedButton
      Left = 55
      Top = 51
      Width = 23
      Height = 22
      Caption = 'I'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SpeedButton7Click
    end
    object SpeedButton2: TSpeedButton
      Left = 55
      Top = 76
      Width = 23
      Height = 22
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33033333333333333F7F3333333333333000333333333333F777333333333333
        000333333333333F777333333333333000333333333333F77733333333333300
        033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
        333333773337777333333078F8F87033333337F3333337F33333778F8F8F8773
        333337333333373F333307F8F8F8F70333337F33FFFFF37F3333078999998703
        33337F377777337F333307F8F8F8F703333373F3333333733333778F8F8F8773
        333337F3333337F333333078F8F870333333373FF333F7333333330777770333
        333333773FF77333333333370007333333333333777333333333}
      NumGlyphs = 2
      OnClick = SpeedButton2Click
    end
    object SpeedButton3: TSpeedButton
      Left = 80
      Top = 51
      Width = 23
      Height = 22
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        77777777F7777777777777770000700777777777777777788FF7777777777777
        000070000777777777777778888FF77777777777000070000007777777777778
        88888FF7777777770000700000000777777777788888888FF777777700007000
        0000000777777778888888888FF7777700007000000000000777777888888888
        888FF7770000700000000000000777788888888888888FFF0000700000000000
        00000778888888888888888F0000700000000000000007788888888888888887
        0000700000000000000777788888888888888777000070000000000007777778
        8888888888877777000070000000000777777778888888888777777700007000
        0000077777777778888888877777777700007000000777777777777888888777
        7777777700007000077777777777777888877777777777770000700777777777
        7777777887777777777777770000777777777777777777777777777777777777
        0000}
      NumGlyphs = 2
      OnClick = SpeedButton3Click
    end
    object SpeedButton5: TSpeedButton
      Left = 105
      Top = 51
      Width = 23
      Height = 22
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        777777777777777777777777000070777777707777777778F7777778F7777777
        0000700777777007777777788F7777788F777777000070007777700077777778
        88F7777888F77777000070000777700007777778888F7778888F777700007000
        00777000007777788888F7788888F77700007000000770000007777888888F78
        88888F77000070000000700000007778888888F8888888F70000700000000000
        00000778888888888888888F0000700000000000000007788888888888888887
        0000700000007000000077788888887888888877000070000007700000077778
        8888877888888777000070000077700000777778888877788888777700007000
        0777700007777778888777788887777700007000777770007777777888777778
        8877777700007007777770077777777887777778877777770000707777777077
        7777777877777778777777770000777777777777777777777777777777777777
        0000}
      NumGlyphs = 2
      OnClick = SpeedButton5Click
    end
    object SpeedButton1: TSpeedButton
      Left = 55
      Top = 26
      Width = 23
      Height = 22
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33033333333333333F7F3333333333333000333333333333F777333333333333
        000333333333333F777333333333333000333333333333F77733333333333300
        033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
        33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
        3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
        33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
        333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
        333333773FF77333333333370007333333333333777333333333}
      NumGlyphs = 2
      OnClick = SpeedButton1Click
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 16
      Width = 41
      Height = 17
      Caption = 'Log'
      TabOrder = 0
      OnClick = CheckBox1Click
    end
  end
  object BitBtn1: TBitBtn
    Left = 628
    Top = 328
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkClose
  end
  object GroupBox3: TGroupBox
    Left = 268
    Top = 276
    Width = 353
    Height = 109
    Caption = 'Mesures'
    TabOrder = 4
    object Label8: TLabel
      Left = 8
      Top = 16
      Width = 46
      Height = 13
      Caption = 'Intensit'#233' :'
    end
    object Label9: TLabel
      Left = 8
      Top = 32
      Width = 43
      Height = 13
      Caption = 'Nombre :'
    end
    object SpeedButton8: TSpeedButton
      Left = 8
      Top = 60
      Width = 23
      Height = 22
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777777777777777FF000077777777777777700777777777777777F88F
        0000777777777777700007777777777777F8888F000077777777777000000777
        77777777F888888F000077777777700000000777777777F88888888F00007777
        77700000000007777777F8888888888F00007777700000000000077777F88888
        8888888F000077700000000000000777F88888888888888F0000700000000000
        00000778888888888888888F000070000000000000000778888888888888888F
        000077700000000000000777788888888888888F000077777000000000000777
        777888888888888F000077777770000000000777777778888888888F00007777
        7777700000000777777777788888888F00007777777777700000077777777777
        7888888F000077777777777770000777777777777778888F0000777777777777
        7770077777777777777778870000777777777777777777777777777777777777
        0000}
      NumGlyphs = 2
      OnClick = SpeedButton8Click
    end
    object SpeedButton10: TSpeedButton
      Left = 36
      Top = 60
      Width = 23
      Height = 22
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        77777777F7777777777777770000700777777777777777788FF7777777777777
        000070000777777777777778888FF77777777777000070000007777777777778
        88888FF7777777770000700000000777777777788888888FF777777700007000
        0000000777777778888888888FF7777700007000000000000777777888888888
        888FF7770000700000000000000777788888888888888FFF0000700000000000
        00000778888888888888888F0000700000000000000007788888888888888887
        0000700000000000000777788888888888888777000070000000000007777778
        8888888888877777000070000000000777777778888888888777777700007000
        0000077777777778888888877777777700007000000777777777777888888777
        7777777700007000077777777777777888877777777777770000700777777777
        7777777887777777777777770000777777777777777777777777777777777777
        0000}
      NumGlyphs = 2
      OnClick = SpeedButton10Click
    end
    object Label10: TLabel
      Left = 192
      Top = 42
      Width = 38
      Height = 13
      Caption = 'Label10'
    end
    object Label11: TLabel
      Left = 192
      Top = 66
      Width = 38
      Height = 13
      Caption = 'Label11'
    end
    object Label12: TLabel
      Left = 192
      Top = 16
      Width = 38
      Height = 13
      Caption = 'Label12'
    end
    object SpeedButton9: TSpeedButton
      Left = 140
      Top = 12
      Width = 45
      Height = 25
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'Voir ='
      OnClick = SpeedButton9Click
    end
    object SpeedButton11: TSpeedButton
      Left = 140
      Top = 36
      Width = 45
      Height = 25
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'Voir <'
      OnClick = SpeedButton11Click
    end
    object SpeedButton12: TSpeedButton
      Left = 140
      Top = 60
      Width = 45
      Height = 25
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'Voir >'
      OnClick = SpeedButton12Click
    end
    object Label13: TLabel
      Left = 91
      Top = 88
      Width = 3
      Height = 13
    end
    object Panel2: TPanel
      Left = 56
      Top = 12
      Width = 77
      Height = 17
      BevelOuter = bvLowered
      Caption = 'Panel2'
      TabOrder = 0
    end
    object Panel3: TPanel
      Left = 56
      Top = 32
      Width = 77
      Height = 17
      BevelOuter = bvLowered
      Caption = 'Panel2'
      TabOrder = 1
    end
    object Button1: TButton
      Left = 288
      Top = 36
      Width = 61
      Height = 25
      Caption = 'Couper <'
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 288
      Top = 60
      Width = 61
      Height = 25
      Caption = 'Couper >'
      TabOrder = 3
      OnClick = Button2Click
    end
    object CheckBox2: TCheckBox
      Left = 64
      Top = 64
      Width = 69
      Height = 17
      Caption = 'M'#233'diane'
      TabOrder = 4
      OnClick = CheckBox2Click
    end
    object CheckBox3: TCheckBox
      Left = 8
      Top = 86
      Width = 81
      Height = 17
      Caption = 'Mod'#232'le ciel :'
      TabOrder = 5
      OnClick = CheckBox3Click
    end
  end
  object Button3: TButton
    Left = 628
    Top = 300
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 5
    OnClick = Button3Click
  end
end