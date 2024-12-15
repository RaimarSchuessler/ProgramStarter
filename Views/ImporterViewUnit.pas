unit ImporterViewUnit;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ComCtrls,
  FunctionUnit;

type
  TfrmImporter = class(TForm)
    pcImporter: TPageControl;
    cmdOk: TButton;
    cmdCancel: TButton;
    tsNewFormat: TTabSheet;
    tsOldFormat: TTabSheet;
    Label1: TLabel;
    cbProfile: TComboBox;
    Label2: TLabel;
    edProgList: TEdit;
    cmdIniFile: TButton;
    dlgOpen: TOpenDialog;
    procedure cmdIniFileClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    function ShowModal(const path: string): Integer; reintroduce;
    function IsNewFormat: Boolean;
    function IsOldFormat: Boolean;
    function GetProfile: string;
    function GetProgList: string;
  end;

var
  frmImporter: TfrmImporter;

implementation

{$R *.dfm}

{ TfrmImporter }

function TfrmImporter.IsNewFormat: Boolean;
begin
  Result := pcImporter.ActivePage = tsNewFormat;
end;

function TfrmImporter.IsOldFormat: Boolean;
begin
  Result := pcImporter.ActivePage = tsOldFormat;
end;

procedure TfrmImporter.cmdIniFileClick(Sender: TObject);
begin
  dlgOpen.InitialDir := ExtractFilePath(edProgList.Text);
  dlgOpen.FileName := ExtractFileName(edProgList.Text);
  if dlgOpen.Execute then
  begin
    edProgList.Text := dlgOpen.FileName;
  end;
end;

function TfrmImporter.GetProgList: string;
begin
  Result := edProgList.Text;
end;

function TfrmImporter.GetProfile: string;
begin
  Result := cbProfile.Text;
end;

function TfrmImporter.ShowModal(const path: string): Integer;
var
  list: TStringList;
begin
  edProgList.Text := '';
  cbProfile.Items.Clear;
  list := TStringList.Create;
  try
    GetLocalSettingsList(list, path);
    cbProfile.Items.AddStrings(list);
  finally
    list.Free;
  end;
  cbProfile.ItemIndex := -1;
  cbProfile.Text := '';
  Result := inherited ShowModal;
end;

end.
