unit FileComparator;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileHandler, Dialogs;
type
  TFileComparator = class
  private
    FH: TFileHandler;
  public
    function ComprareWith(word: string): boolean;
    Constructor Create(path : string); overload;
end;
implementation
  constructor TFileComparator.Create(path: string);
  begin
    self.FH := TFileHandler.Create(path);
  end;
  function TFileComparator.ComprareWith(word: string): boolean;
  begin
    ComprareWith := self.FH.readFirstLineOfFile() = word;
  end;
end.

