unit GlobalSettingsUnit;

interface

uses
  SysUtils,
  ExtendedFunctionUnit,
  XmlParserUnit;

type
  TGlobalSettings = class
  private
    FSettingsPath: string;
    FSettingsFilename: string;
    FNumberOfButtons: Integer;
    procedure InitDefaults;
    procedure LoadView(xml: TXmlParserTag);
    procedure SaveView(xml: TXmlParserTag);
    procedure SetNumberOfButtons(const Value: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    property SettingsPath: string read FSettingsPath;
    property NumberOfButtons: Integer read FNumberOfButtons write SetNumberOfButtons;
  end;

implementation

{ TGlobalSettings }

constructor TGlobalSettings.Create;
var
  xml: TXmlParserRootLoad;
begin
  inherited Create;
  FSettingsPath := GetProgramSettingsPath('ProgramStarter');
  FSettingsFilename := FSettingsPath + 'Global.xml';
  InitDefaults;
  if FileExists(FSettingsFilename) then
  begin
    xml := TXmlParserRootLoad.Create(FSettingsFilename);
    try
      LoadView(xml.Tag('View'));
    finally
      xml.Free;
    end;
  end;
end;

destructor TGlobalSettings.Destroy;
var
  xml: TXmlParserRootNewExtended;
begin
  xml := TXmlParserRootNewExtended.Create('GlobalSettings');
  try
    SaveView(xml.AddTag('View'));
    xml.SaveToFile(FSettingsFilename);
  finally
    xml.Free;
  end;
  inherited Destroy;
end;

procedure TGlobalSettings.InitDefaults;
begin
  FNumberOfButtons := 6;
end;

procedure TGlobalSettings.LoadView(xml: TXmlParserTag);
begin
  if xml <> nil then
  begin
    xml.GetAttributeDyn('NumberOfButtons', FNumberOfButtons);
  end;
end;

procedure TGlobalSettings.SaveView(xml: TXmlParserTag);
begin
  xml.AddAttributeDyn('NumberOfButtons', FNumberOfButtons);
end;

procedure TGlobalSettings.SetNumberOfButtons(const Value: Integer);
begin
  FNumberOfButtons := Value;
end;

end.
