unit Hashable;

{$mode objfpc}{$H+}

interface
type
  IMyDelegate = interface
   function MakeHash (path: string): string;
  end;

implementation
begin

end.
