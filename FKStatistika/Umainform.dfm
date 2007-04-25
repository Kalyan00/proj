object Form1: TForm1
  Left = 198
  Top = 128
  Width = 507
  Height = 455
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 192
    Top = 32
    Width = 113
    Height = 33
    Caption = #1076#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 32
    Top = 32
    Width = 153
    Height = 97
    ItemHeight = 13
    TabOrder = 1
    OnDblClick = ListBox1DblClick
    OnKeyPress = ListBox1KeyPress
  end
  object Button3: TButton
    Left = 192
    Top = 64
    Width = 113
    Height = 33
    Caption = #1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 16
    Top = 32
    Width = 17
    Height = 49
    Caption = '^'
    TabOrder = 4
    TabStop = False
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 16
    Top = 80
    Width = 17
    Height = 49
    Caption = 'v'
    TabOrder = 5
    OnClick = ButtonClick
  end
  object Button6: TButton
    Left = 336
    Top = 56
    Width = 129
    Height = 57
    Caption = 'Button6'
    TabOrder = 6
  end
  object Button2: TButton
    Left = 192
    Top = 96
    Width = 113
    Height = 33
    Caption = #1091#1076#1072#1083#1080#1090#1100
    TabOrder = 3
    OnClick = Button2Click
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 136
    Width = 457
    Height = 177
    ActivePage = TabSheet1
    TabIndex = 0
    TabOrder = 7
    object TabSheet1: TTabSheet
      Caption = #1083#1080#1085#1077#1081#1085#1072#1103' '#1082#1086#1088#1088#1077#1083#1103#1094#1080#1103
      object ListBox2: TListBox
        Left = 24
        Top = 8
        Width = 153
        Height = 97
        ItemHeight = 13
        TabOrder = 1
        OnDblClick = ListBox2DblClick
        OnKeyPress = ListBox2KeyPress
      end
      object Button9: TButton
        Left = 184
        Top = 8
        Width = 113
        Height = 33
        Caption = #1076#1086#1073#1072#1074#1080#1090#1100
        TabOrder = 2
        OnClick = Button9Click
      end
      object Button8: TButton
        Left = 184
        Top = 40
        Width = 113
        Height = 33
        Caption = #1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
        TabOrder = 3
        OnClick = Button8Click
      end
      object Button11: TButton
        Left = 8
        Top = 8
        Width = 17
        Height = 49
        Caption = '^'
        TabOrder = 4
        TabStop = False
        OnClick = Button11Click
      end
      object Button10: TButton
        Left = 8
        Top = 56
        Width = 17
        Height = 49
        Caption = 'v'
        TabOrder = 5
        OnClick = Button10Click
      end
      object Button7: TButton
        Left = 184
        Top = 72
        Width = 113
        Height = 33
        Caption = #1091#1076#1072#1083#1080#1090#1100
        TabOrder = 0
        OnClick = Button7Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1088#1072#1085#1086#1075#1074#1072#1103' '#1082#1086#1088#1088#1077#1083#1103#1094#1080#1103
      ImageIndex = 1
    end
  end
  inline Frame11: TFrame1
    Left = 16
    Top = 360
    Width = 457
    Height = 49
    TabOrder = 8
  end
  object Button12: TButton
    Left = 344
    Top = 384
    Width = 65
    Height = 57
    Caption = 'Button12'
    TabOrder = 9
    OnClick = Button12Click
  end
end
