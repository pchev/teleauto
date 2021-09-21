object pop_graphe: Tpop_graphe
  Left = 233
  Top = 131
  Width = 699
  Height = 540
  Caption = 'Graphe'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TAChart1: TTAChart
    Left = 0
    Top = 0
    Width = 691
    Height = 513
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
    Align = alClient
    Color = clBtnFace
    ParentColor = False
  end
end
