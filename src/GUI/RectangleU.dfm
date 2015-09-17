object RectForm: TRectForm
  Left = 552
  Top = 372
  Width = 473
  Height = 242
  Caption = 'Create Rectangle'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 20
  object Width: TLabel
    Left = 40
    Top = 24
    Width = 53
    Height = 20
    Caption = 'Width : '
  end
  object Label1: TLabel
    Left = 40
    Top = 64
    Width = 54
    Height = 20
    Caption = 'Heigh : '
  end
  object Label3: TLabel
    Left = 216
    Top = 16
    Width = 89
    Height = 20
    Caption = 'Border Color'
  end
  object Label4: TLabel
    Left = 216
    Top = 56
    Width = 60
    Height = 20
    Caption = 'Fill Color'
  end
  object Edit1: TEdit
    Left = 96
    Top = 24
    Width = 65
    Height = 28
    TabOrder = 0
    Text = '1'
  end
  object Edit2: TEdit
    Left = 96
    Top = 64
    Width = 65
    Height = 28
    TabOrder = 1
    Text = '1'
  end
  object Button1: TButton
    Left = 328
    Top = 120
    Width = 89
    Height = 25
    Caption = 'Create'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 312
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Select'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 296
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Select'
    TabOrder = 4
    OnClick = Button3Click
  end
end
