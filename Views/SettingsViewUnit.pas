unit SettingsViewUnit;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  RegularExpressions,
  StrUtils,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Grids,
  StdCtrls,
  AboutBox,
  ExtendedFunctionUnit,
  EditItemViewUnit,
  GlobalSettingsUnit,
  GlobalSettingsViewUnit,
  ImageSelectViewUnit,
  ImporterViewUnit,
  FunctionUnit,
  SettingsUnit;

type
  TfrmPreferences = class(TForm)
    sgButtons: TStringGrid;
    cmdAdd: TButton;
    cmdEdit: TButton;
    cmdDelete: TButton;
    cmdClose: TButton;
    cmdAbout: TButton;
    cmdImport: TButton;
    Label1: TLabel;
    cbNumberOfButtons: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure cmdAboutClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdGeneralClick(Sender: TObject);
    procedure cmdImportClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure cmdAddClick(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
    procedure sgButtonsRowMoved(Sender: TObject; FromIndex, ToIndex: Integer);
    procedure sgButtonsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private-Deklarationen }
    FGlobal: TGlobalSettings;
    FLocal: TSettings;
    procedure ShowButtons;
    procedure ImportNewFormat(const profile: string);
    procedure ImportOldFormat(const inifile: string);
    procedure RepairString(var value: string);
    function GetCurrentButton: TButtonItem;
  public
    { Public-Deklarationen }
    function ShowModal(global: TGlobalSettings; local: TSettings): Integer; reintroduce;
  end;

var
  frmPreferences: TfrmPreferences;

implementation

{$R *.dfm}

procedure TfrmPreferences.cmdAboutClick(Sender: TObject);
begin
  ShowAboutWindow(Application, 'Raimar@Schuesslers-Home.de');
end;

procedure TfrmPreferences.cmdAddClick(Sender: TObject);
var
  item: TButtonItem;
begin
  item := TButtonItem.Create;
  if frmEditButton.ShowModal(item) = mrOk then
  begin
    FLocal.AddButton(item);
    ShowButtons;
  end
  else
  begin
    item.Free;
  end;
end;

procedure TfrmPreferences.cmdCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPreferences.cmdDeleteClick(Sender: TObject);
var
  item: TButtonItem;
begin
  item := GetCurrentButton;
  if item <> nil then
  begin
    if MessageDlg(Format('Delete %s?', [item.Name]), mtConfirmation,
      [mbYes, mbNo], 0) = mrYes then
    begin
      FLocal.DeleteButton(item);
      ShowButtons;
    end;
  end;
end;

procedure TfrmPreferences.cmdEditClick(Sender: TObject);
var
  item: TButtonItem;
begin
  item := GetCurrentButton;
  if item <> nil then
  begin
    if frmEditButton.ShowModal(item) = mrOk then
    begin
      ShowButtons;
    end;
  end;
end;

procedure TfrmPreferences.cmdGeneralClick(Sender: TObject);
begin
  frmGeneralSettings.ShowModal(FGlobal);
end;

procedure TfrmPreferences.cmdImportClick(Sender: TObject);
begin
  if frmImporter.ShowModal(FGlobal.SettingsPath) = mrOk then
  begin
    if frmImporter.IsNewFormat then
    begin
      ImportNewFormat(frmImporter.GetProfile);
    end
    else if frmImporter.IsOldFormat then
    begin
      ImportOldFormat(frmImporter.GetProgList);
    end;
  end;
end;

procedure TfrmPreferences.FormCreate(Sender: TObject);
var
  ix: Integer;
begin
  sgButtons.ColCount := 6;
  sgButtons.Cells[0, 0] := 'View name';
  sgButtons.Cells[1, 0] := 'Icon';
  sgButtons.Cells[2, 0] := 'Execute';
  sgButtons.Cells[3, 0] := 'Parameter';
  sgButtons.Cells[4, 0] := 'Path';
  sgButtons.Cells[5, 0] := 'AutoClose';
  cbNumberOfButtons.Items.Clear;
  for ix := CButtonCountMin to CButtonCountMax do
  begin
    cbNumberOfButtons.Items.Add(IntToStr(ix));
  end;
end;

function TfrmPreferences.GetCurrentButton: TButtonItem;
begin
  Result := nil;
  if (sgButtons.Selection.Top > 0) and
     (sgButtons.Selection.Top < sgButtons.RowCount) then
  begin
    if sgButtons.Objects[0, sgButtons.Selection.Top] is TButtonItem then
    begin
      Result := TButtonItem(sgButtons.Objects[0, sgButtons.Selection.Top]);
    end;
  end;
end;

procedure TfrmPreferences.ImportNewFormat(const profile: string);
begin

end;

procedure TfrmPreferences.ImportOldFormat(const inifile: string);
var
  fd: TStringList;
  ix: Integer;
  list: TArray<string>;
  item: TButtonItem;
  jx: Integer;
begin
  if FileExists(inifile) then
  begin
    fd := TStringList.Create;
    try
      fd.LoadFromFile(inifile);
      for ix := 0 to fd.Count-1 do
      begin
        if fd[ix] <> '' then
        begin
          list := TRegEx.Split(fd[ix], ',');
          for jx := 0 to Length(list)-1 do
          begin
            RepairString(list[jx]);
          end;
          if Length(list) > 3 then
          begin
            item := TButtonItem.Create;
            item.Name := list[0];
            item.Execute := list[1];
            item.Parameter := list[2];
            item.Path := list[3];
            item.AutoClose := True;
            item.SetDefaultImage(frmSelectImage.DefaultImage);
            FLocal.AddButton(item);
          end;
        end;
      end;
    finally
      fd.Free;
    end;
    ShowButtons;
  end;
end;

procedure TfrmPreferences.RepairString(var value: string);
begin
  if (LeftStr(value, 1) = '"') and (RightStr(value, 1) = '"') then
  begin
    value := Copy(value, 2, Length(Value) - 2);
  end;
end;

procedure TfrmPreferences.sgButtonsDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  item: TButtonItem;
begin
  if (ARow > 0) and (ACol = 1) then
  begin
    item := TButtonItem(sgButtons.Objects[0, ARow]);
    if item <> nil then
    begin
      sgButtons.Canvas.Draw(Rect.Left, Rect.Top, item.SmallImage);
    end;
  end;
end;

procedure TfrmPreferences.sgButtonsRowMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);
begin
  FLocal.MoveItems(FromIndex-1, ToIndex-1);
  ShowButtons;
end;

function TfrmPreferences.ShowModal(global: TGlobalSettings;
  local: TSettings): Integer;
begin
  FGlobal := global;
  FLocal := local;
  cbNumberOfButtons.ItemIndex := global.NumberOfButtons - CButtonCountMin;
  ShowButtons;
  Result := inherited ShowModal;
  global.NumberOfButtons := cbNumberOfButtons.ItemIndex + CButtonCountMin;
end;

procedure TfrmPreferences.ShowButtons;
var
  ix: Integer;
begin
  if FLocal.ButtonCount = 0 then
  begin
    sgButtons.RowCount := 2;
    sgButtons.Rows[1].Text := '';
    sgButtons.Objects[0, 1] := nil;
  end
  else
  begin
    sgButtons.RowCount := FLocal.ButtonCount+1;;
    for ix := 0 to FLocal.ButtonCount - 1 do
    begin
      sgButtons.Objects[0, ix + 1] := FLocal.Button[ix];
      sgButtons.Cells[0, ix + 1] := FLocal.Button[ix].Name;
      sgButtons.Cells[2, ix + 1] := FLocal.Button[ix].Execute;
      sgButtons.Cells[3, ix + 1] := FLocal.Button[ix].Parameter;
      sgButtons.Cells[4, ix + 1] := FLocal.Button[ix].Path;
      sgButtons.Cells[5, ix + 1] := BoolToStr(FLocal.Button[ix].AutoClose, True);
    end;
  end;
  RescaleStringGrid(sgButtons);
end;

end.
