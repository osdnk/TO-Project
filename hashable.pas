unit Hashable;

{$mode objfpc}{$H+}

interface
type
  IMyDelegate = interface
   function makeHash (value: integer): string;
  end;

implementation
begin

end.
