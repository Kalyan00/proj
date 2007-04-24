object Frame1: TFrame1
  Left = 0
  Top = 0
  Width = 426
  Height = 22
  TabOrder = 0
  object ComboBox1: TComboBox
    Left = 0
    Top = 0
    Width = 161
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = ComboBox1Change
  end
  object ComboBox2: TComboBox
    Left = 168
    Top = 0
    Width = 81
    Height = 21
    Style = csDropDownList
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
    ItemHeight = 13
    TabOrder = 2
  end
end
