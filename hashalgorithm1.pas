unit HashAlgorithm1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Hashable;

type
THashAlgorithm1 = class (TInterfacedObject, IMyDelegate)
    function makeHash (value: integer):string;
  end;

implementation
  function THashAlgorithm1.makeHash(value: integer): string;
  begin
    makeHash := { all the magic happens } intToStr(value);
  end;

end.

