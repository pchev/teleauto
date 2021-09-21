object pop_plugwebcam: Tpop_plugwebcam
  Left = 710
  Top = 218
  Width = 170
  Height = 80
  Caption = 'Webcam'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  Menu = MainMenu1
  OldCreateOrder = False
  OnCanResize = FormCanResize
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object VideoCap1: TVideoCap
    Left = 0
    Top = 0
    Width = 162
    Height = 34
    align = alClient
    color = clBlack
    DriverOpen = False
    DriverIndex = -1
    VideoOverlay = False
    VideoPreview = False
    PreviewScaleToWindow = False
    PreviewScaleProportional = False
    PreviewRate = 1
    MicroSecPerFrame = 1000000
    FrameRate = 1
    CapAudio = False
    VideoFileName = 'Video.avi'
    SingleImageFile = 'Capture.bmp'
    CapTimeLimit = 0
    AbortKey = 27
    CapIndexSize = 0
    CapToFile = True
    BufferFileSize = 0
    Yield = True
  end
  object MainMenu1: TMainMenu
    Left = 48
    object Options1: TMenuItem
      Caption = 'Options'
      object VideoSource1: TMenuItem
        Caption = 'Video Source'
        OnClick = VideoSource1Click
      end
      object VideoFormat1: TMenuItem
        Caption = 'Video Format'
        OnClick = VideoFormat1Click
      end
      object Color1: TMenuItem
        Caption = 'Color'
        Checked = True
        OnClick = Color1Click
      end
      object Preview1: TMenuItem
        Caption = 'Preview'
        OnClick = Preview1Click
      end
      object AutoConnect1: TMenuItem
        Caption = 'Auto-Connect'
        OnClick = AutoConnect1Click
      end
      object SelectDriver1: TMenuItem
        Caption = 'Select Driver'
        OnClick = SelectDriver1Click
      end
    end
  end
end
