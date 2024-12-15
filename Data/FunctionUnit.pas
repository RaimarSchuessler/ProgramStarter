unit FunctionUnit;

interface

uses
  Classes,
  SysUtils,
  Graphics,
  RegularExpressions,
  ShellApi,
  Registry,
  Windows,
  XmlParserUnit;

procedure GetLocalSettingsList(list: TStrings; const path: string);
procedure SetDefaultFileIcon(filename: string; icon: TIcon; default: TPicture);

const
  CButtonCountMin = 3;
  CButtonCountMax = 20;

implementation

function GetAssociationIconString(const DocFileName: string): string;
var
  FileClass: string;
  Reg: TRegistry;
begin
  Result := '';
  Reg := TRegistry.Create(KEY_EXECUTE);
  Reg.RootKey := HKEY_CLASSES_ROOT;
  FileClass := '';
  if Reg.OpenKeyReadOnly(ExtractFileExt(DocFileName)) then
  begin
    FileClass := Reg.ReadString('');
    Reg.CloseKey;
  end;
  if FileClass <> '' then
  begin
    if Reg.OpenKeyReadOnly(FileClass + '\DefaultIcon') then
    begin
      Result := Reg.ReadString('');
      Reg.CloseKey;
    end;
  end;
  Reg.Free;
end;

procedure GetLocalSettingsList(list: TStrings; const path: string);
var
  sr: TSearchRec;
  xml: TXmlParserRootLoad;
begin
  if SysUtils.FindFirst(path + '*.xml', faAnyFile, sr) = 0 then
  begin
    repeat
      xml := TXmlParserRootLoad.Create(path + sr.Name);
      try
        if xml.Name = 'LocalSettings' then
        begin
          list.Add(sr.Name);
        end;
      finally
        xml.Free;
      end;
    until SysUtils.FindNext(sr) <> 0;
    SysUtils.FindClose(sr);
  end;
end;

procedure SetDefaultFileIcon(filename: string; icon: TIcon; default: TPicture);
var
  ext: string;
  list: TArray<string>;
  index: Integer;
  tmp: TIcon;
begin
  if FileExists(filename) then
  begin
    tmp := TIcon.Create;
    try
      tmp.Handle := ExtractIcon(HInstance, PChar(filename), 0);
      if tmp.Handle = 0 then
      begin
        ext := ExtractFileExt(filename);
        if ext <> '' then
        begin
          list := TRegEx.Split(GetAssociationIconString(ext), ',');
          filename := list[0];
          if Length(list) > 1 then
          begin
            index := StrToIntDef(list[1], 0);
          end
          else
          begin
            index := 0;
          end;
          try
            tmp.Handle := ExtractIcon(HInstance, PChar(filename), index);
          except
            tmp.Handle := 0;
          end;
        end;
      end;
      if tmp.Handle = 0 then
      begin
        tmp.Assign(default);
      end;
      icon.Assign(tmp);
    finally
      tmp.Free;
    end;
  end
  else
  begin
    icon.Assign(default);
  end;
end;

end.
