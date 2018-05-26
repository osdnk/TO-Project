unit HashAlgorithm1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Hashable, FileHandler;

type
THashAlgorithm1 = class (TInterfacedObject, IMyDelegate)
    function makeHash (path: string):string;
    private
      function invert(N:integer; word: string): string;
  end;

implementation
  function THashAlgorithm1.invert (N:integer; word:string) : string;
  begin
    if N=0 then
      Invert:=''
    else
      invert:= word[N] + Invert(N-1,word);
  end;
  function THashAlgorithm1.makeHash(path: string): string;
  var
    FileHandler: TFileHandler;
    Line: string;
  begin
    FileHandler := TFileHandler.Create(path);
    Line := FileHandler.readFirstLineOfFile();
    makeHash := self.invert(Length(Line), Line);
  end;

end.

