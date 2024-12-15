object frmGeneralSettings: TfrmGeneralSettings
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'General Settings'
  ClientHeight = 282
  ClientWidth = 141
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 126
    Height = 13
    Caption = 'Number of buttons in View'
  end
  object cbNumberOfButtons: TComboBox
    Left = 8
    Top = 27
    Width = 126
    Height = 21
    TabOrder = 0
    Text = 'cbNumberOfButtons'
  end
  object cmdClose: TButton
    Left = 8
    Top = 54
    Width = 125
    Height = 25
    Caption = 'Close'
    TabOrder = 1
    OnClick = cmdCloseClick
  end
end
