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
    function readFirstLineOfFile(): string;
    Constructor Create(path : string); overload;
end;

implementation
  constructor TFileHandler.Create(path: string);
  begin
    AssignFile(self.F,path);
  end;
  function TFileHandler.readFirstLineOfFile(): string;
  var
    Line: String;
  begin
    Reset(self.F);
    if not eof(self.F) then
    begin
      ReadLn(self.F,Line);
      readFirstLineOfFile := Line;
    end
    else
    begin
      readFirstLineOfFile := '';
    end;
  end;

end.

