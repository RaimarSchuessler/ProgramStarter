object frmProgramStarter: TfrmProgramStarter
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Program Starter'
  ClientHeight = 282
  ClientWidth = 236
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object cmdPerferences: TButton
    Left = 0
    Top = 0
    Width = 184
    Height = 25
    Caption = 'Preferences'
    TabOrder = 0
    OnClick = cmdPerferencesClick
  end
  object sbButtons: TScrollBox
    Left = 0
    Top = 25
    Width = 184
    Height = 232
    TabOrder = 1
  end
  object cmdClose: TButton
    Left = 0
    Top = 263
    Width = 184
    Height = 25
    Caption = 'Close'
    TabOrder = 2
    OnClick = cmdCloseClick
  end
end
