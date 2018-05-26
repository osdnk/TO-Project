unit HashAlgorithm1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Hashable, FileHandler;

type
THashAlgorithm1 = class (TInterfacedObject, IMyDelegate)
    function MakeHash (path: string):string;
    private
      function Invert(N:integer; word: string): string;
  end;

implementation
  function THashAlgorithm1.Invert (N:integer; Word:string) : string;
  begin
    if N=0 then
      Invert:=''
    else
      Invert:= Word[N] + Invert(N-1,word);
  end;
  function THashAlgorithm1.MakeHash(path: string): string;
  var
    FileHandler: TFileHandler;
    Line: string;
  begin
    FileHandler := TFileHandler.Create(path);
    Line := FileHandler.ReadFirstLineOfFile();
    MakeHash := self.Invert(Length(Line), Line);
  end;

end.

