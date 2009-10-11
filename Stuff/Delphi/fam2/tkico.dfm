object Kicon: TKicon
  Left = 0
  Top = 0
  Width = 106
  Height = 59
  AutoScroll = False
  Color = clBtnFace
  ParentColor = False
  PopupMenu = PopupMenu1
  TabOrder = 0
  OnClick = open1Click
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 106
    Height = 33
    Center = True
    Enabled = False
    OnClick = open1Click
  end
  object Label1: TLabel
    Left = 0
    Top = 37
    Width = 106
    Height = 13
    AutoSize = False
    PopupMenu = PopupMenu1
    OnClick = open1Click
  end
  object PopupMenu1: TPopupMenu
    Left = 112
    Top = 32
    object open1: TMenuItem
      Caption = 'open'
      OnClick = open1Click
    end
    object delete1: TMenuItem
      Caption = 'delete'
      OnClick = delete1Click
    end
  end
end
