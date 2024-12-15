program ProgramStarter;

uses
  Forms,
  ProgramStarterUnit in 'ProgramStarterUnit.pas' {frmProgramStarter},
  GlobalSettingsUnit in 'Data\GlobalSettingsUnit.pas',
  SettingsViewUnit in 'Views\SettingsViewUnit.pas' {frmPreferences},
  SettingsUnit in 'Data\SettingsUnit.pas',
  GlobalSettingsViewUnit in 'Views\GlobalSettingsViewUnit.pas' {frmGeneralSettings},
  ImporterViewUnit in 'Views\ImporterViewUnit.pas' {frmImporter},
  FunctionUnit in 'Data\FunctionUnit.pas',
  EditItemViewUnit in 'Views\EditItemViewUnit.pas' {frmEditButton},
  ImageSelectViewUnit in 'Views\ImageSelectViewUnit.pas' {frmSelectImage};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmProgramStarter, frmProgramStarter);
  Application.CreateForm(TfrmPreferences, frmPreferences);
  Application.CreateForm(TfrmGeneralSettings, frmGeneralSettings);
  Application.CreateForm(TfrmImporter, frmImporter);
  Application.CreateForm(TfrmEditButton, frmEditButton);
  Application.CreateForm(TfrmSelectImage, frmSelectImage);
  Application.Run;
end.
