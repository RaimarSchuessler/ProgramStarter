object frmSelectImage: TfrmSelectImage
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Select Image'
  ClientHeight = 360
  ClientWidth = 529
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object imgPreview: TImage
    Left = 470
    Top = 70
    Width = 32
    Height = 32
  end
  object imgDefault: TImage
    Left = 470
    Top = 108
    Width = 32
    Height = 32
    Picture.Data = {
      055449636F6E0000010001002020100000000000E80200001600000028000000
      2000000040000000010004000000000080020000000000000000000000000000
      0000000000000000000080000080000000808000800000008000800080800000
      80808000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
      FFFFFF00C99CCCCCCCCCCCCCCCCCCCCCCCCCC99C9999FFFFFFFFFFFFFFFFFFFF
      FFFF999999999000000000FFFF00000000099999C9999000000000FFFF000000
      0099999CCF999900000000FFFF000000009999FCCFF99990000000FFFF000000
      09999FFCCFFFF999000000FFFF00000099900FFCCFFFF099900000FFFF000009
      99000FFCCFFFF009990000FFFF00009990000FFCCFFFFFFF999FFFFFFF000999
      00000FFCCFF000000999000FFFFF999FFFFFFFFCCFF000000099000FFFF999FF
      FFFFFFFCCFF000000009900FFF099000000FFFFCCFF000000000090FFF900000
      000FFFFCCFF000000000009FF9000000000FFFFCCFF00000000000099F000000
      000FFFFCCFF00000000000099F000000000FFFFCCFF000000000009FF9000000
      000FFFFCCFFFFFFFFFFFF9FFFF9FFFFFFFFFFFFCCFFFFFFFFFF99FFFFF999FFF
      FFFFFFFCCCCCCCCCCC999CCCCCC999CCCCCCCCCCC77777777999777777779997
      7777777CC777777799977777777779997777777CCCCCCCC999CCCCCCCCCCCC99
      9CCCCCCC00000099900000000000000999000000000009990000000000000000
      9990000000099990000000000000000009999000009999000000000000000000
      0999990009999900000000000000000000999990999990000000000000000000
      0009999999990000000000000000000000009999099000000000000000000000
      0000099000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FC7FFE3FF8FFFF1FE1FFFF87C3FFFF8383FFFFC107FFFFE00FFFFFF0
      9FFFFFF9}
    Visible = False
  end
  object rbApplication: TRadioButton
    Left = 8
    Top = 8
    Width = 17
    Height = 17
    Checked = True
    TabOrder = 0
    TabStop = True
    OnClick = rbApplicationClick
  end
  object gbApplication: TGroupBox
    Left = 31
    Top = 8
    Width = 409
    Height = 64
    Caption = 'Application'
    TabOrder = 1
    object dgApplication: TDrawGrid
      Left = 8
      Top = 16
      Width = 393
      Height = 40
      ColCount = 10
      DefaultColWidth = 36
      DefaultRowHeight = 36
      DefaultDrawing = False
      DrawingStyle = gdsClassic
      FixedCols = 0
      FixedRows = 0
      GridLineWidth = 0
      TabOrder = 0
      OnClick = dgApplicationClick
      OnDrawCell = dgApplicationDrawCell
    end
  end
  object cmdOk: TButton
    Left = 446
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object cmdCancel: TButton
    Left = 446
    Top = 39
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object gbSystem: TGroupBox
    Left = 31
    Top = 78
    Width = 409
    Height = 222
    Caption = 'System'
    TabOrder = 4
    object dgSystem: TDrawGrid
      Left = 8
      Top = 16
      Width = 393
      Height = 198
      ColCount = 10
      DefaultColWidth = 36
      DefaultRowHeight = 36
      DefaultDrawing = False
      DrawingStyle = gdsClassic
      FixedCols = 0
      FixedRows = 0
      GridLineWidth = 0
      TabOrder = 0
      OnClick = dgSystemClick
      OnDrawCell = dgSystemDrawCell
    end
  end
  object rbSystem: TRadioButton
    Left = 8
    Top = 78
    Width = 17
    Height = 17
    TabOrder = 5
    OnClick = rbSystemClick
  end
  object gbFile: TGroupBox
    Left = 31
    Top = 306
    Width = 409
    Height = 46
    Caption = 'File'
    TabOrder = 6
    object edFilename: TEdit
      Left = 8
      Top = 16
      Width = 364
      Height = 21
      TabOrder = 0
      Text = 'edFilename'
    end
    object cmdFilename: TButton
      Left = 378
      Top = 16
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 1
      OnClick = cmdFilenameClick
    end
  end
  object rbFile: TRadioButton
    Left = 8
    Top = 306
    Width = 17
    Height = 17
    TabOrder = 7
    OnClick = rbFileClick
  end
  object dlgOpen: TOpenPictureDialog
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Title = 'Select Image'
    Left = 472
    Top = 208
  end
end
