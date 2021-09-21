object pop_balance: Tpop_balance
  Left = 361
  Top = 183
  BorderStyle = bsDialog
  Caption = 'Balance des couleurs'
  ClientHeight = 137
  ClientWidth = 190
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 57
    Height = 13
    Caption = 'ROUGE : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 46
    Height = 13
    Caption = 'VERT : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 72
    Width = 45
    Height = 13
    Caption = 'BLEU : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 16
    Top = 104
    Width = 75
    Height = 25
    Caption = '&Annuler'
    TabOrder = 3
    Kind = bkCancel
  end
  object BitBtn2: TBitBtn
    Left = 104
    Top = 104
    Width = 75
    Height = 25
    Caption = '&OK'
    TabOrder = 4
    Kind = bkOK
  end
  object Edit1: TEdit
    Left = 88
    Top = 8
    Width = 89
    Height = 21
    TabOrder = 0
    Text = '1.0'
  end
  object Edit2: TEdit
    Left = 88
    Top = 40
    Width = 89
    Height = 21
    TabOrder = 1
    Text = '0.75'
  end
  object Edit3: TEdit
    Left = 88
    Top = 72
    Width = 89
    Height = 21
    TabOrder = 2
    Text = '1.0'
  end
end
