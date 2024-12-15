unit GlobalSettingsViewUnit;

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
  FunctionUnit,
  GlobalSettingsUnit;

type
  TfrmGeneralSettings = class(TForm)
    Label1: TLabel;
    cbNumberOfButtons: TComboBox;
    cmdClose: TButton;
    procedure cmdCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    function ShowModal(global: TGlobalSettings): Integer; reintroduce;
  end;

var
  frmGeneralSettings: TfrmGeneralSettings;

implementation

{$R *.dfm}

procedure TfrmGeneralSettings.cmdCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmGeneralSettings.FormCreate(Sender: TObject);
var
  ix: Integer;
begin
  ClientWidth := cmdClose.Width + 2 * cmdClose.Left;
  ClientHeight := cmdClose.Top + cmdClose.Height + cmdClose.Left;
  cbNumberOfButtons.Items.Clear;
  for ix := CButtonCountMin to CButtonCountMax do
  begin
    cbNumberOfButtons.Items.Add(IntToStr(ix));
  end;
end;

function TfrmGeneralSettings.ShowModal(global: TGlobalSettings): Integer;
begin
  cbNumberOfButtons.ItemIndex := global.NumberOfButtons - CButtonCountMin;
  Result := inherited ShowModal;
  global.NumberOfButtons := cbNumberOfButtons.ItemIndex + CButtonCountMin;
end;

end.
