object Ftable: TFtable
  Left = 335
  Top = 139
  Width = 541
  Height = 383
  Caption = 'Ftable'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 533
    Height = 57
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 145
      Top = 40
      Width = 5
      Height = 13
      Caption = 'x'
    end
    object Label2: TLabel
      Left = 8
      Top = 37
      Width = 27
      Height = 13
      Caption = 'X * Y:'
    end
    object Label3: TLabel
      Left = 7
      Top = 12
      Width = 50
      Height = 13
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077
    end
    object Edit1: TEdit
      Left = 40
      Top = 32
      Width = 105
      Height = 21
      TabOrder = 0
      Text = '2'
      OnChange = Edit1Change
    end
    object Edit2: TEdit
      Left = 152
      Top = 32
      Width = 105
      Height = 21
      TabOrder = 1
      Text = '2'
      OnChange = Edit1Change
    end
    object Edit3: TEdit
      Left = 64
      Top = 8
      Width = 193
      Height = 21
      TabOrder = 2
      Text = 'Edit3'
      OnChange = Edit3Change
    end
    object CheckBox1: TCheckBox
      Left = 272
      Top = 32
      Width = 145
      Height = 17
      Caption = #1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1085#1072#1079#1074#1072#1085#1080#1103
      TabOrder = 3
      OnClick = CheckBox1Click
    end
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 57
    Width = 367
    Height = 299
    Align = alClient
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goTabs]
    TabOrder = 1
    OnKeyPress = StringGrid1KeyPress
    OnKeyUp = StringGrid1KeyUp
    OnSetEditText = StringGrid1SetEditText
  end
  object Panel2: TPanel
    Left = 367
    Top = 57
    Width = 166
    Height = 299
    Align = alRight
    Caption = 'Panel2'
    TabOrder = 2
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 164
      Height = 120
      Align = alTop
      Caption = #1044#1086#1073#1072#1074'. '#1082#1086#1083#1086#1085#1082#1080
      TabOrder = 0
      object cSum: TCheckBox
        Left = 16
        Top = 16
        Width = 137
        Height = 17
        Caption = 'Sum'
        TabOrder = 0
        OnClick = rVClick
      end
      object cAvg: TCheckBox
        Tag = 1
        Left = 16
        Top = 32
        Width = 137
        Height = 17
        Caption = 'Avg'
        TabOrder = 1
        OnClick = rVClick
      end
      object cSigma: TCheckBox
        Tag = 2
        Left = 16
        Top = 48
        Width = 137
        Height = 17
        Caption = 'Sigma'
        TabOrder = 2
        OnClick = rVClick
      end
      object cV: TCheckBox
        Tag = 3
        Left = 16
        Top = 64
        Width = 137
        Height = 17
        Caption = 'V'
        TabOrder = 3
        OnClick = rVClick
      end
      object cm: TCheckBox
        Tag = 4
        Left = 16
        Top = 80
        Width = 137
        Height = 17
        Caption = 'm'
        TabOrder = 4
        OnClick = rVClick
      end
    end
    object GroupBox2: TGroupBox
      Left = 1
      Top = 121
      Width = 164
      Height = 120
      Align = alTop
      Caption = #1044#1086#1073#1072#1074'. '#1089#1090#1088#1086#1082#1080
      TabOrder = 1
      object rSum: TCheckBox
        Tag = 5
        Left = 16
        Top = 16
        Width = 137
        Height = 17
        Caption = 'Sum'
        TabOrder = 0
        OnClick = rVClick
      end
      object rAvg: TCheckBox
        Tag = 6
        Left = 16
        Top = 32
        Width = 137
        Height = 17
        Caption = 'Avg'
        TabOrder = 1
        OnClick = rVClick
      end
      object rSigma: TCheckBox
        Tag = 7
        Left = 16
        Top = 48
        Width = 137
        Height = 17
        Caption = 'Sigma'
        TabOrder = 2
        OnClick = rVClick
      end
      object rV: TCheckBox
        Tag = 8
        Left = 16
        Top = 64
        Width = 137
        Height = 17
        Caption = 'V'
        TabOrder = 3
        OnClick = rVClick
      end
      object rm: TCheckBox
        Tag = 9
        Left = 16
        Top = 80
        Width = 137
        Height = 17
        Caption = 'm'
        TabOrder = 4
        OnClick = rVClick
      end
    end
  end
end
