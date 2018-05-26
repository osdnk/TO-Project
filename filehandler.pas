unit FileHandler;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;
type
  TFileHandler = class
  private
    F : Text;
  public
    function ReadFirstLineOfFile(): string;
    Constructor Create(path : string); overload;
end;

implementation
  constructor TFileHandler.Create(path: string);
  begin
    AssignFile(self.F,path);
  end;
  function TFileHandler.ReadFirstLineOfFile(): string;
  var
    Line: String;
  begin
    Reset(self.F);
    if not EOF(self.F) then
    begin
      ReadLn(self.F,Line);
      ReadFirstLineOfFile := Line;
    end
    else
    begin
      ReadFirstLineOfFile := '';
    end;
  end;
end.

