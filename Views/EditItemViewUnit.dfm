object frmEditButton: TfrmEditButton
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Edit Button'
  ClientHeight = 156
  ClientWidth = 561
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 38
    Width = 27
    Height = 13
    Caption = 'Name'
  end
  object Label2: TLabel
    Left = 8
    Top = 11
    Width = 39
    Height = 13
    Caption = 'Execute'
  end
  object Label3: TLabel
    Left = 8
    Top = 65
    Width = 50
    Height = 13
    Caption = 'Parameter'
  end
  object Label4: TLabel
    Left = 8
    Top = 92
    Width = 22
    Height = 13
    Caption = 'Path'
  end
  object imgIcon: TImage
    Left = 119
    Top = 116
    Width = 32
    Height = 32
    Picture.Data = {
      055449636F6E0000010001002020100000000000E80200001600000028000000
      2000000040000000010004000000000080020000000000000000000000000000
      0000000000000000000080000080000000808000800000008000800080800000
      80808000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
      FFFFFF00CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFCCFFFF000000000FFFF00000000000FFCCFFFF000000000FFFF000000
      00000FFCCFFFF000000000FFFF00000000000FFCCFFFF000000000FFFF000000
      00000FFCCFFFF000000000FFFF00000000000FFCCFFFF000000000FFFF000000
      00000FFCCFFFF000000000FFFF00000000000FFCCFFFFFFFFFFFFFFFFF000000
      00000FFCCFF000000000000FFFFFFFFFFFFFFFFCCFF000000000000FFFFFFFFF
      FFFFFFFCCFF00000000000099F000000000FFFFCCFF000000000009999000000
      000FFFFCCFF000000000099999900000000FFFFCCFF000000000999999990000
      000FFFFCCFF000000009999999999000000FFFFCCFF000000099999999999900
      000FFFFCCFFFFFFFF9999F9999F9999FFFFFFFFCCFFFFFFF9999FF9999FF9999
      FFFFFFFCCCCCCCC9999CCC9999CCC9999CCCCCCCC77777999977779999777799
      9977777CC777799997777799997777799997777CCCCC9999CCCCCC9999CCCCCC
      9999CCCC00000990000000999900000009900000000000000000009999000000
      0000000000000000000000999900000000000000000000000000009999000000
      0000000000000000000000999900000000000000000000000000009999000000
      0000000000000000000000999900000000000000000000000000009999000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000F9FC3F9FFFFC3FFFFFFC3FFFFFFC3FFFFFFC3FFFFFFC3FFFFFFC3FFF
      FFFC3FFF}
    OnDblClick = imgIconDblClick
  end
  object cmdOk: TButton
    Left = 478
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 7
  end
  object cmdCancel: TButton
    Left = 478
    Top = 39
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 8
  end
  object edName: TEdit
    Left = 64
    Top = 35
    Width = 408
    Height = 21
    TabOrder = 2
    Text = 'edName'
  end
  object edExecute: TEdit
    Left = 64
    Top = 8
    Width = 381
    Height = 21
    TabOrder = 0
    Text = 'edExecute'
    OnChange = edExecuteChange
  end
  object edParameter: TEdit
    Left = 64
    Top = 62
    Width = 408
    Height = 21
    TabOrder = 3
    Text = 'edParameter'
  end
  object edPath: TEdit
    Left = 64
    Top = 89
    Width = 381
    Height = 21
    TabOrder = 4
    Text = 'edPath'
  end
  object cbAutoClose: TCheckBox
    Left = 8
    Top = 116
    Width = 97
    Height = 17
    Caption = 'Auto Close'
    TabOrder = 6
  end
  object cmdExecute: TButton
    Left = 451
    Top = 8
    Width = 21
    Height = 21
    Caption = '...'
    TabOrder = 1
    OnClick = cmdExecuteClick
  end
  object cmdPath: TButton
    Left = 451
    Top = 89
    Width = 21
    Height = 21
    Caption = '...'
    TabOrder = 5
    OnClick = cmdPathClick
  end
  object dlgOpen: TOpenDialog
    Filter = 
      'Executable (*.exe)|*.exe|Batch file (*.bat)|*.bat|All Files (*.*' +
      ')|*.*'
    FilterIndex = 0
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Title = 'Select Executable'
    Left = 488
    Top = 72
  end
end
