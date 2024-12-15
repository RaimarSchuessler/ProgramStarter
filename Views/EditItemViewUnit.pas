unit EditItemViewUnit;

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
  ExtCtrls,
  StdCtrls,
  DirDialog,
  ExtendedFunctionUnit,
  ImageSelectViewUnit,
  SettingsUnit;

type
  TfrmEditButton = class(TForm)
    cmdOk: TButton;
    cmdCancel: TButton;
    edName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edExecute: TEdit;
    Label3: TLabel;
    edParameter: TEdit;
    Label4: TLabel;
    edPath: TEdit;
    cbAutoClose: TCheckBox;
    imgIcon: TImage;
    cmdExecute: TButton;
    cmdPath: TButton;
    dlgOpen: TOpenDialog;
    procedure cmdExecuteClick(Sender: TObject);
    procedure cmdPathClick(Sender: TObject);
    procedure imgIconDblClick(Sender: TObject);
    procedure edExecuteChange(Sender: TObject);
  private
    { Private-Deklarationen }
    FButton: TButtonItem;
    procedure SetExecuteName;
  public
    { Public-Deklarationen }
    function ShowModal(item: TButtonItem): Integer; reintroduce;
  end;

var
  frmEditButton: TfrmEditButton;

implementation

{$R *.dfm}

procedure TfrmEditButton.cmdExecuteClick(Sender: TObject);
begin
  dlgOpen.InitialDir := ExtractFilePath(edExecute.Text);
  dlgOpen.FileName := ExtractFilePath(edExecute.Text);
  if dlgOpen.Execute then
  begin
    if (ExtractFilePath(edExecute.Text) = edPath.Text) or (edPath.Text = '') then
    begin
      edPath.Text := ExtractFilePath(dlgOpen.FileName);
    end;
    edExecute.Text := dlgOpen.FileName;
  end;
end;

procedure TfrmEditButton.cmdPathClick(Sender: TObject);
var
  tmp: string;
begin
  tmp := edPath.Text;
  if DirectoryDialog(tmp, 'Select Path', True) then
  begin
    edPath.Text := tmp;
  end;
end;

procedure TfrmEditButton.edExecuteChange(Sender: TObject);
begin
  if FileExists(edExecute.Text) then
  begin
    SetExecuteName;
  end;
end;

procedure TfrmEditButton.imgIconDblClick(Sender: TObject);
begin
  if frmSelectImage.ShowModal(edExecute.Text, imgIcon.Picture.Icon) = mrOk then
  begin
    imgIcon.Picture.Assign(frmSelectImage.Image);
  end;
end;

function TfrmEditButton.ShowModal(item: TButtonItem): Integer;
begin
  FButton := item;
  edName.Text := item.Name;
  edExecute.Text := item.Execute;
  edParameter.Text := item.Parameter;
  edPath.Text := item.Path;
  cbAutoClose.Checked := item.AutoClose;
  imgIcon.Picture.Assign(item.Image);
  Result := inherited ShowModal;
  if Result = mrOk then
  begin
    if edPath.Text = '' then
    begin
      edPath.Text := ExtractFilePath(edExecute.Text);
    end;
    item.Name := edName.Text;
    item.Execute := ExpandUNCFileName(edExecute.Text);
    item.Parameter := edParameter.Text;
    item.Path := ExpandUNCFileName(edPath.Text);
    item.AutoClose := cbAutoClose.Checked;
    item.Image.Assign(imgIcon.Picture);
  end;
end;

procedure TfrmEditButton.SetExecuteName;
var
  tmp: string;
begin
  if edPath.Text = '' then
  begin
    edPath.Text := ExtractFilePath(edExecute.Text);
  end;
  if edName.Text = '' then
  begin
    tmp := ExtractFileName(edExecute.Text);
    tmp := Copy(tmp, 1, Length(tmp) - Length(ExtractFileExt(tmp)));
    edName.Text := tmp;
  end;
  if ExtractFileName(FButton.Execute) <> ExtractFileName(edExecute.Text) then
  begin
    FButton.SetDefaultImage(frmSelectImage.DefaultImage, edExecute.Text);
    imgIcon.Picture.Assign(FButton.Image);
  end;
end;

end.
