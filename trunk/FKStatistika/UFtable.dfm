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
  object TreeView1: TTreeView
    Left = 372
    Top = 57
    Width = 161
    Height = 299
    Align = alRight
    Indent = 19
    ReadOnly = True
    TabOrder = 1
    Items.Data = {
      020000002B0000000000000000000000FFFFFFFFFFFFFFFF0000000005000000
      12C4EEE1E0E2EEF7EDFBE520EAEEEBEEEDEAE8280000000000000000000000FF
      FFFFFFFFFFFFFF00000000000000000F5B5F5D2053756D2028D1F3ECECE0292A
      0000000000000000000000FFFFFFFFFFFFFFFF0000000000000000115B5F5D20
      4176672028F1F0E5E4EDE5E529310000000000000000000000FFFFFFFFFFFFFF
      FF0000000000000000185B5F5D205369676D612028F1F2E0EDE42E20EEF2EAEB
      2E292F0000000000000000000000FFFFFFFFFFFFFFFF0000000000000000165B
      5F5D20562028EAEEFDF42E20E2E0F0E8E0F6E8E8292F00000000000000000000
      00FFFFFFFFFFFFFFFF0000000000000000165B5F5D206D2028CEF8E8E1EAE020
      F1F0E5E4EDE5E9292A0000000000000000000000FFFFFFFFFFFFFFFF00000000
      0500000011C4EEE1E0E2EEF7EDFBE520F1F2F0EEEAE828000000000000000000
      0000FFFFFFFFFFFFFFFF00000000000000000F5B5F5D2053756D2028D1F3ECEC
      E0292A0000000000000000000000FFFFFFFFFFFFFFFF0000000000000000115B
      5F5D204176672028F1F0E5E4EDE5E529310000000000000000000000FFFFFFFF
      FFFFFFFF0000000000000000185B5F5D205369676D612028F1F2E0EDE42E20EE
      F2EAEB2E292F0000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      00165B5F5D20562028EAEEFDF42E20E2E0F0E8E0F6E8E8292F00000000000000
      00000000FFFFFFFFFFFFFFFF0000000000000000165B5F5D206D2028CEF8E8E1
      EAE020F1F0E5E4EDE5E929}
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 57
    Width = 206
    Height = 299
    Align = alClient
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goTabs]
    TabOrder = 2
    OnKeyPress = StringGrid1KeyPress
    OnKeyUp = StringGrid1KeyUp
    OnSetEditText = StringGrid1SetEditText
  end
  object Panel2: TPanel
    Left = 206
    Top = 57
    Width = 166
    Height = 299
    Align = alRight
    Caption = 'Panel2'
    TabOrder = 3
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
