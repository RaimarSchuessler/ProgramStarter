unit SettingsUnit;

interface

uses
  Classes,
  Generics.Collections,
  SysUtils,
  Graphics,
  Controls,
  ByteBlockUnit,
  ExtendedFunctionUnit,
  XmlParserUnit,
  FunctionUnit;

type
  TButtonItem = class
  private
    FPath: string;
    FName: string;
    FParameter: string;
    FExecute: string;
    FImage: TIcon;
    FSmallImage: Graphics.TBitmap;
    FAutoClose: Boolean;
    procedure SetExecute(const Value: string);
    procedure SetName(const Value: string);
    procedure SetParameter(const Value: string);
    procedure SetPath(const Value: string);
    procedure SetAutoClose(const Value: Boolean);
    procedure DoImageChange(Sender: TObject);
  public
    constructor Create(xml: TXmlParserTag = nil); reintroduce;
    destructor Destroy; override;
    procedure SaveXml(xml: TXmlParserTag);
    procedure SetDefaultImage(default: TPicture; filename: string = '');
    property Name: string read FName write SetName;
    property Execute: string read FExecute write SetExecute;
    property Parameter: string read FParameter write SetParameter;
    property Path: string read FPath write SetPath;
    property AutoClose: Boolean read FAutoClose write SetAutoClose;
    property Image: TIcon read FImage;
    property SmallImage: Graphics.TBitmap read FSmallImage;
  end;
  TSettings = class
  private
    FSettingsFilename: string;
    FButtons: TObjectList<TButtonItem>;
    procedure LoadButton(xml: TXmlParserTag);
    function GetButton(index: Integer): TButtonItem;
    function GetButtonCount: Integer;
  public
    constructor Create(const filename: string; lock: Boolean);
    destructor Destroy; override;
    procedure AddButton(item: TButtonItem);
    procedure DeleteButton(item: TButtonItem);
    procedure MoveItems(fromIndex, toIndex: Integer);
    property ButtonCount: Integer read GetButtonCount;
    property Button[index: Integer]: TButtonItem read GetButton;
  end;

implementation

type
  ByteBlockHelper = class helper for TByteBlock
  public
    procedure SaveIcon(icon: TIcon);
    procedure LoadIcon(icon: TIcon);
  end;

{ TSettings }

procedure TSettings.AddButton(item: TButtonItem);
begin
  FButtons.Add(item);
end;

constructor TSettings.Create(const filename: string; lock: Boolean);
var
  xml: TXmlParserRootLoad;
begin
  inherited Create;
  FButtons := TObjectList<TButtonItem>.Create;
  if lock then
  begin
    FSettingsFilename := '';
  end
  else
  begin
    FSettingsFilename := filename;
  end;
  if FileExists(filename) then
  begin
    xml := TXmlParserRootLoad.Create(filename);
    try
      xml.ForAllDo('Button', LoadButton);
    finally
      xml.Free;
    end;
  end;
end;

procedure TSettings.DeleteButton(item: TButtonItem);
var
  index: Integer;
begin
  index := FButtons.IndexOf(item);
  if index >= 0 then
  begin
    FButtons.Delete(index);
  end;
end;

destructor TSettings.Destroy;
var
  xml: TXmlParserRootNewExtended;
  ix: Integer;
begin
  if FSettingsFilename <> '' then
  begin
    xml := TXmlParserRootNewExtended.Create('LocalSettings');
    try
      for ix := 0 to FButtons.Count-1 do
      begin
        FButtons[ix].SaveXml(xml.AddTag('Button'));
      end;
      xml.SaveToFile(FSettingsFilename);
    finally
      xml.Free;
    end;
  end;
  FButtons.Free;
  inherited Destroy;
end;

function TSettings.GetButton(index: Integer): TButtonItem;
begin
  if (index >= 0) and (index < FButtons.Count) then
  begin
    Result := FButtons[index];
  end
  else
  begin
    Result := nil;
  end;
end;

function TSettings.GetButtonCount: Integer;
begin
  Result := FButtons.Count;
end;

procedure TSettings.LoadButton(xml: TXmlParserTag);
var
  item: TButtonItem;
begin
  item := TButtonItem.Create(xml);
  FButtons.Add(item);
end;

procedure TSettings.MoveItems(fromIndex, toIndex: Integer);
begin
  FButtons.Move(fromIndex, toIndex);
end;

{ TButtonItem }

constructor TButtonItem.Create(xml: TXmlParserTag);
var
  stream: TByteBlock;
  subXml: TXmlParserTag;
begin
  inherited Create;
  FImage := TIcon.Create;
  FImage.OnChange := DoImageChange;
  FSmallImage := Graphics.TBitmap.Create;
  FSmallImage.Width := 16;
  FSmallImage.Height := 16;
  if xml = nil then
  begin
    FPath := '';
    FName := '';
    FParameter := '';
    FExecute := '';
    FAutoClose := True;
  end
  else
  begin
    xml.GetAttributeDyn('Path', FPath);
    xml.GetAttributeDyn('Name', FName);
    xml.GetAttributeDyn('Parameter', FParameter);
    xml.GetAttributeDyn('Execute', FExecute);
    xml.GetAttributeDyn('AutoClose', FAutoClose);
    subXml := xml.Tag('Icon');
    if subXml <> nil then
    begin
      stream := TByteBlock.Create;
      try
        stream.FromString(subXml.ContentString);
        stream.LoadIcon(FImage);
      finally
        stream.Free;
      end;
    end;
  end;
end;

destructor TButtonItem.Destroy;
begin
  FSmallImage.Free;
  FImage.Free;
  inherited;
end;

procedure TButtonItem.DoImageChange(Sender: TObject);
var
  tmp: Graphics.TBitmap;
begin
  tmp := Graphics.TBitmap.Create;
  try
    tmp.Width := FImage.Width;
    tmp.Height := FImage.Height;
    tmp.Canvas.Draw(0, 0, FImage);
    FSmallImage.Canvas.StretchDraw(Rect(0, 0, 16, 16), tmp);
  finally
    tmp.Free;
  end;
end;

procedure TButtonItem.SaveXml(xml: TXmlParserTag);
var
  stream: TByteBlock;
  subXml: TXmlParserTag;
begin
  if xml <> nil then
  begin
    xml.AddAttributeDyn('Path', FPath);
    xml.AddAttributeDyn('Name', FName);
    xml.AddAttributeDyn('Parameter', FParameter);
    xml.AddAttributeDyn('Execute', FExecute);
    xml.AddAttributeDyn('AutoClose', FAutoClose);
    subXml := xml.AddTag('Icon');
    if subXml <> nil then
    begin
      stream := TByteBlock.Create;
      try
        stream.SaveIcon(FImage);
        subXml.ContentString := stream.ToString;
      finally
        stream.Free;
      end;
    end;
  end;
end;

procedure TButtonItem.SetAutoClose(const Value: Boolean);
begin
  FAutoClose := Value;
end;

procedure TButtonItem.SetExecute(const Value: string);
begin
  FExecute := Value;
end;

procedure TButtonItem.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TButtonItem.SetParameter(const Value: string);
begin
  FParameter := Value;
end;

procedure TButtonItem.SetPath(const Value: string);
begin
  FPath := Value;
end;

procedure TButtonItem.SetDefaultImage(default: TPicture; filename: string);
begin
  if filename = '' then
  begin
    filename:= FExecute;
  end;
  SetDefaultFileIcon(filename, FImage, default);
end;

{ ByteBlockHelper }

procedure ByteBlockHelper.LoadIcon(icon: TIcon);
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    Position := 0;
    CopyTo(ms, Size);
    ms.Seek(0, soFromBeginning);
    icon.LoadFromStream(ms);
  finally
    ms.Free;
  end;
end;

procedure ByteBlockHelper.SaveIcon(icon: TIcon);
var
  ms: TMemoryStream;
begin
  Clear;
  ms := TMemoryStream.Create;
  try
    ms.Seek(0,soFromBeginning);
    icon.SaveToStream(ms);
    ms.Seek(0,soFromBeginning);
    Position := 0;
    CopyFrom(ms, ms.Size);
  finally
    ms.Free;
  end;
end;

end.
