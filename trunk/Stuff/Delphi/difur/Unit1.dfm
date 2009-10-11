object Form1: TForm1
  Left = 192
  Top = 107
  Align = alClient
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 680
  ClientWidth = 850
  Color = -1
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 0
    Width = 25
    Height = 13
    Caption = 'Y__='
    Color = -1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 24
    Width = 17
    Height = 13
    Caption = 'x0='
    Color = -1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 48
    Width = 17
    Height = 13
    Caption = 'y0='
    Color = -1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label4: TLabel
    Left = 0
    Top = 72
    Width = 23
    Height = 13
    Caption = 'y_0='
    Color = -1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label5: TLabel
    Left = 400
    Top = 8
    Width = 395
    Height = 13
    Caption = 
      #1055#1088#1086#1096#1091' '#1073#1086#1083#1100#1096#1086#1075#1086' '#1087#1072#1088#1076#1086#1085#1072' '#1079#1072' '#1082#1088#1080#1074#1086#1081' '#1087#1072#1088#1089#1077#1088' ('#1087#1086#1087#1088#1086#1073#1091#1081' '#1074#1084#1077#1089#1090#1086' '#1091' '#1085#1072#1087#1080#1089 +
      #1072#1090#1100' '#1091'*1)'
    Color = -1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label7: TLabel
    Left = 400
    Top = 40
    Width = 77
    Height = 13
    Caption = #1079#1085#1072#1082' <_> = < '#39' >'
    Color = -1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label8: TLabel
    Left = 400
    Top = 24
    Width = 16
    Height = 13
    Caption = 'y(x)'
    Color = -1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label9: TLabel
    Left = 424
    Top = 24
    Width = 34
    Height = 13
    Caption = 'y__(y_)'
    Color = -1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label10: TLabel
    Left = 464
    Top = 24
    Width = 22
    Height = 13
    Caption = 'y_(y)'
    Color = -1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clLime
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label6: TLabel
    Left = 512
    Top = 40
    Width = 130
    Height = 13
    Caption = #1080#1089#1087#1086#1083#1100#1079#1091#1081' enter, tab '#1080' esc'
    Color = -1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 40
    Top = 0
    Width = 345
    Height = 21
    BorderStyle = bsNone
    Color = clNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8421631
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = '0-(y+y_/2)/(1+x/3)'
    OnKeyPress = Edit1KeyPress
  end
  object Edit2: TEdit
    Left = 40
    Top = 24
    Width = 30
    Height = 21
    BorderStyle = bsNone
    Color = clNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8421631
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = '0'
    OnKeyPress = Edit1KeyPress
  end
  object Edit3: TEdit
    Left = 40
    Top = 48
    Width = 30
    Height = 21
    BorderStyle = bsNone
    Color = clNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8421631
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Text = '100'
    OnKeyPress = Edit1KeyPress
  end
  object Edit4: TEdit
    Left = 40
    Top = 72
    Width = 30
    Height = 21
    BorderStyle = bsNone
    Color = clNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8421631
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Text = '0'
    OnKeyPress = Edit1KeyPress
  end
end
