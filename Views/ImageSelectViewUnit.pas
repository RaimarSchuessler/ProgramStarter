unit ImageSelectViewUnit;

interface

uses
  Windows,
  Messages,
  ShellApi,
  SysUtils,
  Variants,
  Classes,
  Generics.Collections,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  StdCtrls,
  Grids,
  ExtDlgs,
  ExtendedFunctionUnit,
  FunctionUnit;

type
  TIconObjectList = TObjectList<TIcon>;
  TfrmSelectImage = class(TForm)
    rbApplication: TRadioButton;
    gbApplication: TGroupBox;
    cmdOk: TButton;
    cmdCancel: TButton;
    gbSystem: TGroupBox;
    rbSystem: TRadioButton;
    gbFile: TGroupBox;
    rbFile: TRadioButton;
    dgApplication: TDrawGrid;
    dgSystem: TDrawGrid;
    edFilename: TEdit;
    cmdFilename: TButton;
    imgPreview: TImage;
    imgDefault: TImage;
    dlgOpen: TOpenPictureDialog;
    procedure dgApplicationDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure dgSystemDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure dgApplicationClick(Sender: TObject);
    procedure dgSystemClick(Sender: TObject);
    procedure cmdFilenameClick(Sender: TObject);
    procedure rbApplicationClick(Sender: TObject);
    procedure rbSystemClick(Sender: TObject);
    procedure rbFileClick(Sender: TObject);
  private
    { Private-Deklarationen }
    FSystemIcons: TIconObjectList;
    FApplicationIcons: TIconObjectList;
    procedure ScanIcons(const filename: string; list: TIconObjectList);
    procedure DrawGridItem(grid: TDrawGrid; list: TIconObjectList;
      col, row: Integer; drawRect: TRect; state: TGridDrawState);
    procedure ActivateGridIcon(grid: TDrawGrid; list: TIconObjectList);
    procedure ActivateFileImage;
    function GetImage: TPicture;
    function GetDefaultImage: TPicture;
  public
    { Public-Deklarationen }
    function ShowModal(const exeFilename: string; icon: TIcon): Integer; reintroduce;
    property Image: TPicture read GetImage;
    property DefaultImage: TPicture read GetDefaultImage;
  end;

var
  frmSelectImage: TfrmSelectImage;

implementation

{$R *.dfm}

procedure PictureToIcon(image: TPicture; icon: TIcon);
var
  bmp: TBitmap;
  imageList: TImageList;
begin
  bmp  := TBitmap.Create;
  try
    bmp.Width := 32;
    bmp.Height := 32;
    bmp.Canvas.StretchDraw(Rect(0, 0, 32, 32), Image.Graphic);
    imageList := TImageList.CreateSize(bmp.Width, bmp.Height);
    try
      imageList.AddMasked(bmp, bmp.TransparentColor);
      imageList.GetIcon(0, icon);
      // Save it to a file
    finally
      imageList.Free;
    end;
  finally
    bmp.Free;
  end;
end;

{ TfrmSelectImage }

procedure TfrmSelectImage.ActivateFileImage;
var
  pic: TPicture;
  icon: TIcon;
begin
  if FileExists(edFilename.Text) then
  begin
    pic := TPicture.Create;
    icon := TIcon.Create;
    try
      pic.LoadFromFile(edFilename.Text);
      PictureToIcon(pic, icon);
      imgPreview.Picture.Assign(icon);
    finally
      pic.Free;
      icon.Free;
    end;
    rbFile.Checked := True;
  end;
end;

procedure TfrmSelectImage.ActivateGridIcon(grid: TDrawGrid;
  list: TIconObjectList);
var
  index: Integer;
begin
  index := grid.Selection.Top * grid.ColCount + grid.Selection.Left;
  if (index >= 0) and (index < list.Count) then
  begin
    imgPreview.Picture.Assign(list[index]);
  end
  else
  begin
    imgPreview.Picture.Assign(imgDefault.Picture);
  end;
end;

procedure TfrmSelectImage.cmdFilenameClick(Sender: TObject);
var
  tmp: string;
begin
  dlgOpen.InitialDir := ExtractFilePath(edFilename.Text);
  dlgOpen.FileName := ExtractFileName(edFilename.Text);
  if dlgOpen.Execute then
  begin
    edFilename.Text := dlgOpen.FileName;
    ActivateFileImage;
  end;
end;

procedure TfrmSelectImage.dgApplicationClick(Sender: TObject);
begin
  ActivateGridIcon(dgApplication, FApplicationIcons);
  rbApplication.Checked := True;
end;

procedure TfrmSelectImage.dgApplicationDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  DrawGridItem(dgApplication, FApplicationIcons, ACol, ARow, Rect, State);
end;

procedure TfrmSelectImage.dgSystemClick(Sender: TObject);
begin
  ActivateGridIcon(dgSystem, FSystemIcons);
  rbSystem.Checked := True;
end;

procedure TfrmSelectImage.dgSystemDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  DrawGridItem(dgSystem, FSystemIcons, ACol, ARow, Rect, State);
end;

procedure TfrmSelectImage.DrawGridItem(grid: TDrawGrid; list: TIconObjectList;
  col, row: Integer; drawRect: TRect; state: TGridDrawState);
var
  index: Integer;
begin
  index := row * grid.ColCount + col;
  if gdSelected in State then
  begin
    grid.canvas.Brush.Color := clBlue;
  end
  else
  begin
    grid.canvas.Brush.Color := clWhite;
  end;
  grid.canvas.FillRect(drawRect);
  Inc(drawRect.Top, 2);
  Inc(drawRect.Left, 2);
  Dec(drawRect.Right, 2);
  Dec(drawRect.Bottom, 2);
  grid.canvas.Brush.Color := clWhite;
  grid.canvas.FillRect(drawRect);
  if index < list.Count then
  begin
    grid.canvas.StretchDraw(drawRect, list[index]);
  end;
end;

function TfrmSelectImage.GetDefaultImage: TPicture;
begin
  Result := imgDefault.Picture;
end;

function TfrmSelectImage.GetImage: TPicture;
begin
  Result := imgPreview.Picture;
end;

procedure TfrmSelectImage.rbApplicationClick(Sender: TObject);
begin
  ActivateGridIcon(dgApplication, FApplicationIcons);
end;

procedure TfrmSelectImage.rbFileClick(Sender: TObject);
begin
  ActivateFileImage;
end;

procedure TfrmSelectImage.rbSystemClick(Sender: TObject);
begin
  ActivateGridIcon(dgSystem, FSystemIcons);
end;

procedure TfrmSelectImage.ScanIcons(const filename: string;
  list: TIconObjectList);
var
  icon: TIcon;
  ix: Integer;
begin
  list.Clear;
  for ix := 0 to ExtractIcon(Handle, PWideChar(filename), UINT(-1))-1 do
  begin
    icon := TIcon.Create;
    icon.Handle := ExtractIcon(HInstance, PWideChar(filename), ix);
    if icon.Handle = 0 then
    begin
      icon.Free;
    end
    else
    begin
      list.Add(icon);
    end;
  end;
end;

function TfrmSelectImage.ShowModal(const exeFilename: string;
  icon: TIcon): Integer;
var
  tmp: TIcon;
begin
  FSystemIcons := TIconObjectList.Create;
  FApplicationIcons := TIconObjectList.Create;
  ScanIcons(GetSystemPath + '\system32\shell32.dll', FSystemIcons);
  ScanIcons(exeFilename, FApplicationIcons);
  if FApplicationIcons.Count = 0 then
  begin
    tmp := TIcon.Create;
    SetDefaultFileIcon(exeFilename, tmp, DefaultImage);
    FApplicationIcons.Add(tmp);
  end;
  dgApplication.RowCount := (FApplicationIcons.Count + 9) div 10;
  dgSystem.RowCount := (FSystemIcons.Count + 9) div 10;
  imgPreview.Picture.Assign(icon);
  edFilename.Text := '';
  Result := inherited ShowModal;
  FSystemIcons.Free;
  FApplicationIcons.Free;
end;

end.
