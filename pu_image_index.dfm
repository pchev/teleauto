object pop_image_index: Tpop_image_index
  Left = 319
  Top = 209
  BorderStyle = bsToolWindow
  Caption = 'Image index'
  ClientHeight = 258
  ClientWidth = 265
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 16
    Top = 8
    Width = 57
    Height = 33
    Caption = 'Clear'
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 88
    Top = 8
    Width = 57
    Height = 33
    Caption = 'Check'
    OnClick = SpeedButton2Click
  end
  object lb_images: TListBox
    Left = 8
    Top = 48
    Width = 249
    Height = 201
    ItemHeight = 13
    TabOrder = 0
    OnDblClick = lb_imagesDblClick
  end
end
