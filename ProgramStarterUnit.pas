unit ProgramStarterUnit;

interface

uses
  Windows,
  Messages,
  ShellApi,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Buttons,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ImgList,
  Generics.Collections,
  GlobalSettingsUnit,
  SettingsUnit,
  SettingsViewUnit;

type
  TfrmProgramStarter = class(TForm)
    cmdPerferences: TButton;
    sbButtons: TScrollBox;
    cmdClose: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdPerferencesClick(Sender: TObject);
  private
    { Private-Deklarationen }
    FGlobalSettings: TGlobalSettings;
    FSettings: TSettings;
    FButtons: TObjectList<TBitBtn>;
    procedure PosForm;
    procedure UpdateButtons;
  public
    { Public-Deklarationen }
    procedure ProgButtonClick(Sender: TObject);
  end;

var
  frmProgramStarter: TfrmProgramStarter;

implementation

{$R *.dfm}

procedure TfrmProgramStarter.cmdCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmProgramStarter.cmdPerferencesClick(Sender: TObject);
begin
  frmPreferences.ShowModal(FGlobalSettings, FSettings);
  UpdateButtons;
end;

procedure TfrmProgramStarter.FormCreate(Sender: TObject);
var
  ix: Integer;
  profile: string;
  paramState: (psParam, psProfile);
  lock: Boolean;
begin
  FButtons := TObjectList<TBitBtn>.Create;
  FGlobalSettings := TGlobalSettings.Create;
  profile := '';
  lock := False;
  paramState := psParam;
  ix := 1;
  while ix <= ParamCount do
  begin
    case paramState of
    psParam:
      if (ParamStr(ix) = '-p') then
      begin
        paramState := psProfile;
      end;
    psProfile:
      begin
        profile := FGlobalSettings.SettingsPath + ParamStr(ix) + '.xml';
        paramState := psParam;
      end;
    end;
    Inc(ix);
  end;
  if profile = '' then
  begin
    profile := Application.ExeName;
    profile := Copy(profile, 1, Length(profile) - 3) + 'xml';
    if FileExists(profile) then
    begin
      lock := True;
    end
    else
    begin
      profile := FGlobalSettings.SettingsPath + 'Default.xml';
    end;
  end;
  FSettings := TSettings.Create(profile, lock);
  if lock then
  begin
    cmdPerferences.Visible := False;
  end;
  UpdateButtons;
  PosForm;
end;

procedure TfrmProgramStarter.FormDestroy(Sender: TObject);
begin
  FSettings.Free;
  FGlobalSettings.Free;
  FButtons.Free;
end;

procedure TfrmProgramStarter.PosForm;
begin
  Left := Mouse.CursorPos.X;
  if Left+Width > Screen.WorkAreaRect.Right then
  begin
    Left := Screen.WorkAreaRect.Right-Width;
  end;
  if Left < Screen.WorkAreaRect.Left then
  begin
    Left := Screen.WorkAreaRect.Left;
  end;
  Top := Mouse.CursorPos.Y;
  if Top+Height > Screen.WorkAreaRect.Bottom then
  begin
    Top := Screen.WorkAreaRect.Bottom-Height;
  end;
  if Top < Screen.WorkAreaRect.Top then
  begin
    Top := Screen.WorkAreaRect.Top;
  end;
end;

procedure TfrmProgramStarter.ProgButtonClick(Sender: TObject);
var
  res: Integer;
  item: TButtonItem;
begin
  if Sender is TBitBtn then
  begin
    item := FSettings.Button[TBitBtn(Sender).Tag];
    if item <> nil then
    begin
      res := ShellExecute(handle, nil, PChar(item.Execute),
        PChar(item.Parameter), PChar(item.Path), SW_NORMAL);
      if res <= 32 then
      begin
        ShowMessage(SysErrorMessage(res));
      end
      else
      begin
        if item.AutoClose then
        begin
          Close;
        end;
      end;
    end;
  end;
end;

procedure TfrmProgramStarter.UpdateButtons;
var
  ix: Integer;
  button: TBitBtn;
  size: Integer;
  bitmap: TBitmap;
begin
  if cmdPerferences.Visible then
  begin
    cmdPerferences.Top := 0;
    cmdPerferences.Width := ClientWidth;
    sbButtons.Top := cmdPerferences.Height;
  end
  else
  begin
    sbButtons.Top := 0;
  end;
  sbButtons.Width := ClientWidth;
  size := FGlobalSettings.NumberOfButtons;
  if FSettings.ButtonCount < size then
  begin
    size := FSettings.ButtonCount;
  end;
  sbButtons.ClientHeight := 32 * size;
  cmdClose.Top := sbButtons.Top + sbButtons.Height;
  cmdClose.Width := ClientWidth;
  ClientHeight := cmdClose.Top + cmdClose.Height;
  bitmap := TBitmap.Create;
  try
    FButtons.Clear;
    for ix := 0 to FSettings.ButtonCount-1 do
    begin
      bitmap.Width := FSettings.Button[ix].Image.Width;
      bitmap.Height := FSettings.Button[ix].Image.Height;
      bitmap.Canvas.FillRect(Rect(0, 0, bitmap.Width, bitmap.Height));
      bitmap.Canvas.Draw(0 ,0, FSettings.Button[ix].Image);
      button := TBitBtn.Create(Self);
      button.Parent := sbButtons;
      button.Top := ix * 32;
      button.Height := 32;
      button.Caption := FSettings.Button[ix].Name;
      if FileExists(Fsettings.Button[ix].Execute) then
      begin
        button.Font.Style := [];
      end
      else
      begin
        button.Font.Style := [fsStrikeOut];
      end;
      button.Tag := ix;
      button.Layout := blGlyphLeft;
      button.Margin := 0;
      size := button.Height - 4;
      button.Glyph.Width := size;
      button.Glyph.Height := size;
      button.Glyph.Canvas.StretchDraw(Rect(0, 0, size, size), bitmap);
      button.OnClick := ProgButtonClick;
      FButtons.Add(button);
    end;
    for ix := 0 to FButtons.Count-1 do
    begin
      FButtons[ix].Width := sbButtons.ClientWidth;
    end;
  finally
    bitmap.Free;
  end;
end;

end.
