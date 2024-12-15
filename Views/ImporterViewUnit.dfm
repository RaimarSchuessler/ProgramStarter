object frmImporter: TfrmImporter
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Importer'
  ClientHeight = 71
  ClientWidth = 458
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    458
    71)
  PixelsPerInch = 96
  TextHeight = 13
  object pcImporter: TPageControl
    Left = 8
    Top = 8
    Width = 361
    Height = 55
    ActivePage = tsOldFormat
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    TabPosition = tpBottom
    object tsNewFormat: TTabSheet
      Caption = 'New Format'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        353
        29)
      object Label1: TLabel
        Left = 3
        Top = 6
        Width = 30
        Height = 13
        Caption = 'Profile'
      end
      object cbProfile: TComboBox
        Left = 72
        Top = 3
        Width = 278
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        Text = 'cbProfile'
      end
    end
    object tsOldFormat: TTabSheet
      Caption = 'Old Format'
      ImageIndex = 1
      DesignSize = (
        353
        29)
      object Label2: TLabel
        Left = 3
        Top = 6
        Width = 59
        Height = 13
        Caption = 'Program List'
      end
      object edProgList: TEdit
        Left = 72
        Top = 3
        Width = 251
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        Text = 'edProgList'
      end
      object cmdIniFile: TButton
        Left = 329
        Top = 3
        Width = 21
        Height = 21
        Anchors = [akTop, akRight]
        Caption = '...'
        TabOrder = 1
        OnClick = cmdIniFileClick
      end
    end
  end
  object cmdOk: TButton
    Left = 375
    Top = 8
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object cmdCancel: TButton
    Left = 375
    Top = 39
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object dlgOpen: TOpenDialog
    DefaultExt = '.lst'
    Filter = 'Program List (*.lst)|*.lst|All Files (*.*)|*.*'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Title = 'Import Old Format'
    Left = 276
    Top = 20
  end
end
