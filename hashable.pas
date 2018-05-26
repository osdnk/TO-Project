unit Hashable;

{$mode objfpc}{$H+}

interface
type
  IMyDelegate = interface
   function makeHash (path: string): string;
  end;

implementation
begin

end.
