object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 481
  ClientWidth = 947
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 888
    Top = 21
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Button1: TButton
    Left = 8
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = Button1Click
  end
  object lst_Threads: TListView
    AlignWithMargins = True
    Left = 3
    Top = 47
    Width = 941
    Height = 431
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvNone
    BevelOuter = bvNone
    Columns = <
      item
        AutoSize = True
        Caption = 'Thread'
        MinWidth = 215
      end
      item
        AutoSize = True
        Caption = 'Status'
        MinWidth = 220
      end>
    ColumnClick = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    GridLines = True
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    ShowWorkAreas = True
    SortType = stText
    TabOrder = 1
    ViewStyle = vsReport
  end
  object Button2: TButton
    Left = 97
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 2
    OnClick = Button2Click
  end
end
