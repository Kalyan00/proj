object ParaForm: TParaForm
  Left = 191
  Top = 242
  Width = 516
  Height = 467
  Caption = 'ParaForm'
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
    Left = 16
    Top = 8
    Width = 210
    Height = 13
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1082#1086#1088#1088#1077#1083#1103#1094#1080#1086#1085#1085#1086#1081' '#1079#1072#1074#1080#1089#1080#1084#1086#1089#1090#1080':'
  end
  object Label2: TLabel
    Left = 16
    Top = 40
    Width = 172
    Height = 13
    Caption = #1074#1099#1073#1077#1088#1080#1090#1077' '#1089#1088#1072#1074#1085#1080#1074#1072#1077#1084#1099#1077' '#1076#1072#1085#1085#1099#1077':'
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 216
    Width = 473
    Height = 57
    Caption = 'GroupBox1'
    TabOrder = 3
    object CheckBox2: TCheckBox
      Left = 8
      Top = 0
      Width = 81
      Height = 17
      Caption = #1048#1089#1082#1083#1102#1095#1080#1090#1100':'
      TabOrder = 0
      OnClick = CheckBox2Click
    end
    inline Frame13: TFrame1
      Left = 17
      Top = 15
      Width = 449
      Height = 24
      Enabled = False
      TabOrder = 1
    end
  end
  inline Frame11: TFrame1
    Left = 16
    Top = 56
    Width = 465
    Height = 25
    TabOrder = 0
  end
  inline Frame12: TFrame1
    Left = 16
    Top = 80
    Width = 465
    Height = 25
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 240
    Top = 8
    Width = 249
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
    OnChange = Edit1Change
  end
  object Panel1: TPanel
    Left = 168
    Top = 280
    Width = 161
    Height = 153
    TabOrder = 4
    object Label3: TLabel
      Left = 8
      Top = 8
      Width = 116
      Height = 13
      Caption = #1082#1086#1101#1092'. '#1083#1080#1085'. '#1082#1086#1088#1088#1077#1083#1103#1094#1080#1080
    end
    object Label5: TLabel
      Left = 8
      Top = 48
      Width = 105
      Height = 13
      Caption = #1082#1086#1101#1092'. '#1076#1077#1090#1077#1088#1084#1080#1085#1072#1094#1080#1080
    end
    object Label6: TLabel
      Left = 8
      Top = 112
      Width = 108
      Height = 13
      Caption = 'p=0.05              p=0.01'
    end
    object Label7: TLabel
      Left = 12
      Top = 99
      Width = 115
      Height = 13
      Caption = #1050#1088#1080#1090#1080#1095#1077#1089#1082#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
    end
    object Edit2: TEdit
      Left = 8
      Top = 20
      Width = 145
      Height = 21
      TabOrder = 0
    end
    object Edit4: TEdit
      Left = 8
      Top = 60
      Width = 145
      Height = 21
      TabOrder = 1
    end
    object Edit5: TEdit
      Left = 80
      Top = 124
      Width = 73
      Height = 21
      TabOrder = 2
    end
    object Edit6: TEdit
      Left = 8
      Top = 124
      Width = 73
      Height = 21
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 16
    Top = 280
    Width = 145
    Height = 153
    TabOrder = 5
    object Image1: TImage
      Left = 8
      Top = 16
      Width = 137
      Height = 137
    end
    object Label9: TLabel
      Left = 8
      Top = 0
      Width = 101
      Height = 13
      Caption = #1042#1080#1079#1091#1072#1083#1100#1085#1099#1081' '#1072#1085#1072#1083#1080#1079
    end
  end
  object Panel3: TPanel
    Left = 336
    Top = 280
    Width = 153
    Height = 153
    TabOrder = 6
    object Label4: TLabel
      Left = 8
      Top = 8
      Width = 122
      Height = 13
      Caption = #1095#1072#1089#1090#1085#1099#1081' '#1082#1086#1101#1092'. '#1083#1080#1085'. '#1082#1086#1088'.'
    end
    object Edit3: TEdit
      Left = 8
      Top = 36
      Width = 137
      Height = 21
      TabOrder = 0
    end
  end
  object Panel4: TPanel
    Left = 16
    Top = 160
    Width = 473
    Height = 49
    TabOrder = 7
    object Label8: TLabel
      Left = 8
      Top = 16
      Width = 147
      Height = 13
      Caption = #1076#1086#1089#1090#1086#1074#1077#1088#1085#1086#1089#1090#1100' '#1088#1072#1079#1083#1080#1095#1080#1103':  t ='
    end
    object Label10: TLabel
      Left = 224
      Top = 16
      Width = 51
      Height = 13
      Caption = 'tkp (0,05)='
    end
    object Label11: TLabel
      Left = 344
      Top = 16
      Width = 51
      Height = 13
      Caption = 'tkp (0,01)='
    end
    object Label12: TLabel
      Left = 8
      Top = 28
      Width = 117
      Height = 13
      Caption = '(t-'#1082#1088#1080#1090#1077#1088#1080#1081' '#1057#1090#1100#1102#1076#1077#1085#1090#1072')'
    end
    object Edit7: TEdit
      Left = 159
      Top = 13
      Width = 58
      Height = 21
      TabOrder = 0
      Text = 'Edit7'
    end
    object Edit8: TEdit
      Left = 279
      Top = 13
      Width = 58
      Height = 21
      TabOrder = 1
      Text = 'Edit7'
    end
    object Edit9: TEdit
      Left = 399
      Top = 13
      Width = 66
      Height = 21
      TabOrder = 2
      Text = 'Edit7'
    end
  end
  object GroupBox2: TGroupBox
    Left = 16
    Top = 112
    Width = 473
    Height = 41
    Caption = ' '#1080#1089#1089#1083#1077#1076#1086#1074#1072#1085#1080#1103'  '#1087#1088#1086#1074#1086#1076#1080#1083#1080#1089#1100' '#1085#1072' '
    TabOrder = 8
    object RadioButton1: TRadioButton
      Left = 16
      Top = 16
      Width = 161
      Height = 17
      Caption = #1086#1076#1085#1086#1081' '#1080' '#1090#1086#1081#1078#1077' '#1075#1088#1091#1087#1087#1077
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = RadioButton2Click
    end
    object RadioButton2: TRadioButton
      Left = 256
      Top = 16
      Width = 161
      Height = 17
      Caption = #1076#1088#1091#1093' '#1088#1072#1079#1085#1099#1093' '#1075#1088#1091#1087#1087#1072#1093
      TabOrder = 1
      OnClick = RadioButton2Click
    end
  end
end
