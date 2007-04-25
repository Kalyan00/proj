object Frame1: TFrame1
  Left = 0
  Top = 0
  Width = 536
  Height = 26
  TabOrder = 0
  object Label1: TLabel
    Left = 424
    Top = 5
    Width = 108
    Height = 13
    Caption = #1058#1072#1073#1083#1080#1094#1072' '#1080#1079#1084#1077#1085#1080#1083#1072#1089#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object ComboBox1: TComboBox
    Left = 0
    Top = 0
    Width = 161
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = ComboBox1Change
    OnDropDown = ComboBox1DropDown
    OnEnter = ComboBox1Enter
    OnStartDrag = ComboBox1StartDrag
  end
  object ComboBox2: TComboBox
    Left = 168
    Top = 0
    Width = 81
    Height = 21
    Style = csDropDownList
    Enabled = False
    ItemHeight = 13
    TabOrder = 1
    OnChange = ComboBox2Change
    Items.Strings = (
      #1089#1090#1088#1086#1082#1072
      #1075#1088#1072#1092#1072)
  end
  object ComboBox3: TComboBox
    Left = 256
    Top = 0
    Width = 161
    Height = 21
    Style = csDropDownList
    Enabled = False
    ItemHeight = 13
    TabOrder = 2
  end
end
