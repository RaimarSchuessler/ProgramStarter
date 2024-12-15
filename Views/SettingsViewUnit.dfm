object frmPreferences: TfrmPreferences
  Left = 0
  Top = 0
  Caption = 'Preferences'
  ClientHeight = 268
  ClientWidth = 551
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    551
    268)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 468
    Top = 132
    Width = 48
    Height = 13
    Anchors = [akTop, akRight]
    Caption = '# Buttons'
  end
  object sgButtons: TStringGrid
    Left = 8
    Top = 8
    Width = 454
    Height = 252
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColCount = 4
    DefaultRowHeight = 16
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowMoving, goRowSelect]
    TabOrder = 0
    OnDrawCell = sgButtonsDrawCell
    OnRowMoved = sgButtonsRowMoved
  end
  object cmdAdd: TButton
    Left = 468
    Top = 39
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Add'
    TabOrder = 2
    OnClick = cmdAddClick
  end
  object cmdEdit: TButton
    Left = 468
    Top = 70
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Edit'
    TabOrder = 3
    OnClick = cmdEditClick
  end
  object cmdDelete: TButton
    Left = 468
    Top = 101
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Delete'
    TabOrder = 4
    OnClick = cmdDeleteClick
  end
  object cmdClose: TButton
    Left = 468
    Top = 235
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    TabOrder = 6
    OnClick = cmdCloseClick
  end
  object cmdAbout: TButton
    Left = 468
    Top = 204
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'About'
    TabOrder = 5
    OnClick = cmdAboutClick
  end
  object cmdImport: TButton
    Left = 468
    Top = 8
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Import'
    TabOrder = 1
    OnClick = cmdImportClick
  end
  object cbNumberOfButtons: TComboBox
    Left = 468
    Top = 151
    Width = 75
    Height = 21
    Anchors = [akTop, akRight]
    TabOrder = 7
    Text = 'cbNumberOfButtons'
  end
end
