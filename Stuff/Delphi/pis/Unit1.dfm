object Form1: TForm1
  Left = 195
  Top = 104
  Width = 696
  Height = 609
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 592
    Top = 16
    Width = 12
    Height = 13
    Caption = '=0'
  end
  object Image1: TImage
    Left = 24
    Top = 40
    Width = 561
    Height = 521
  end
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 585
    Height = 21
    TabOrder = 0
    Text = '(x*x-y*y-10)*x*y*(x+y)*(x*x+y*y-10)*(y*y+x)'
    OnKeyPress = Edit1KeyPress
  end
  object Button1: TButton
    Left = 616
    Top = 8
    Width = 33
    Height = 25
    Caption = '=>'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit2: TEdit
    Left = 616
    Top = 96
    Width = 25
    Height = 21
    TabOrder = 2
    Text = '10'
  end
  object Edit3: TEdit
    Left = 592
    Top = 112
    Width = 25
    Height = 21
    TabOrder = 3
    Text = '-10'
  end
  object Edit4: TEdit
    Left = 616
    Top = 128
    Width = 25
    Height = 21
    TabOrder = 4
    Text = '-10'
  end
  object Edit5: TEdit
    Left = 640
    Top = 112
    Width = 25
    Height = 21
    TabOrder = 5
    Text = '10'
  end
  object Memo1: TMemo
    Left = 600
    Top = 192
    Width = 73
    Height = 145
    Lines.Strings = (
      'Memo1')
    TabOrder = 6
  end
end
