object pop_anal_modele: Tpop_anal_modele
  Left = 467
  Top = 166
  BorderStyle = bsDialog
  Caption = 'R'#233'glage et analyse du mod'#232'le de pointage'
  ClientHeight = 258
  ClientWidth = 459
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
    Left = 4
    Top = 8
    Width = 128
    Height = 13
    Caption = 'Termes correctifs '#224' utiliser :'
  end
  object TAChart1: TTAChart
    Left = 204
    Top = 0
    Width = 253
    Height = 257
    AutoUpdateXMin = True
    AutoUpdateXMax = True
    AutoUpdateYMin = True
    AutoUpdateYMax = True
    MirrorX = False
    ShowLegend = False
    ShowTitle = False
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    ShowAxisLabel = False
    ShowVerticalReticule = False
    Color = clBtnFace
    ParentColor = False
  end
  object RadioGroup1: TRadioGroup
    Left = 4
    Top = 164
    Width = 197
    Height = 37
    Caption = 'Type de graphe'
    ItemIndex = 0
    Items.Strings = (
      'Erreur Alpha / Erreur Delta')
    TabOrder = 0
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 232
    Width = 125
    Height = 17
    Caption = 'Apr'#233's corrections'
    Checked = True
    State = cbChecked
    TabOrder = 1
    OnClick = CheckBox1Click
  end
  object CheckListBox1: TCheckListBox
    Left = 4
    Top = 24
    Width = 197
    Height = 133
    ItemHeight = 13
    Items.Strings = (
      'CH : Erreur de collimation'
      'NP : Non perpendicularit'#233
      'MA : Horizontalit'#233' de l'#39'axe alpha'
      'ME : Verticalit'#233' de l'#39'axe alpha'
      'TF : Flexion du tube'
      'FO : Flexion de la monture'
      'DAF : flexion de l'#39'axe Delta'
      'PHH1D0 : Polyn'#244'me 1'
      'PDH1D0 : Polyn'#244'me 2'
      'PHH0D1 : Polyn'#244'me 3'
      'PDH0D1 : Polyn'#244'me 4'
      'PHH2D0 : Polyn'#244'me 5'
      'PDH2D0 : Polyn'#244'me 6'
      'PHH1D2 : Polyn'#244'me 7'
      'PDH1D2 : Polyn'#244'me 8'
      'PHH0D2 : Polyn'#244'me 9'
      'PDH0D2 : Polyn'#244'me 10')
    TabOrder = 2
    OnClick = CheckListBox1Click
  end
end
