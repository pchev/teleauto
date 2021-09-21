object pop_skychart: Tpop_skychart
  Left = 284
  Top = 160
  Width = 540
  Height = 409
  Caption = 'Carte du ciel'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SkyChart1: TSkyChart
    Left = 0
    Top = 0
    Width = 532
    Height = 363
    Align = alClient
    PopupMenu = PopupMenu1
    Stretch = True
    OnMouseDown = SkyChart1MouseDown
    OnMouseMove = SkyChart1MouseMove
    SelColor = coColor
    ChartPosition.Projection = prTAN
    ChartPosition.ProjPole = pPolar
    ChartPosition.FOV = 90
    ChartPosition.FlipX = False
    ChartPosition.FlipY = False
    ChartPosition.JulianDay = 2451545
    ChartCatalog.NebLimit = False
    ChartCatalog.StarLimit = False
    ChartCatalog.NebShowBig = False
    Observatory.Temperature = 10
    Observatory.Pressure = 1010
    StarSize = 13
    StarDynamic = 65
    GridEnabled = True
    GridSpace = 1.5
    GridColor = clGray
    GridLabel = True
    ConstellationLineEnabled = False
    ConstellationLineColor = clSilver
    ConstellationBoundaryEnabled = False
    ConstellationBoundaryColor = clNavy
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 363
    Width = 532
    Height = 19
    Panels = <
      item
        Width = 150
      end
      item
        Width = 150
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object PopupMenu1: TPopupMenu
    Left = 48
    Top = 24
    object Dplacerletlescopeici1: TMenuItem
      Caption = '&D'#233'placer le t'#233'lescope ici'
      OnClick = Dplacerletlescopeici1Click
    end
    object Ralignerletlscopeici1: TMenuItem
      Caption = '&Synchroniser le t'#233'l'#233'scope ici'
      OnClick = Ralignerletlscopeici1Click
    end
  end
end
