object pop_dome: Tpop_dome
  Left = 834
  Top = 241
  BorderStyle = bsToolWindow
  Caption = 'Dome/toit'
  ClientHeight = 74
  ClientWidth = 142
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 142
    Height = 17
    Align = alTop
    Alignment = taCenter
    BorderStyle = sbsSunken
    Caption = 'StaticText1'
    TabOrder = 0
  end
  object Button1: TButton
    Left = 0
    Top = 20
    Width = 141
    Height = 25
    Caption = 'Ouvrir'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 0
    Top = 48
    Width = 141
    Height = 25
    Caption = 'Fermer'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 36
    Top = 32
  end
  object Timer2: TTimer
    Enabled = False
    OnTimer = Timer2Timer
    Left = 4
    Top = 32
  end
end
