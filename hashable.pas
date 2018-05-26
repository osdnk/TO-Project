unit Hashable;

{$mode objfpc}{$H+}

interface
type
  IHashable = interface
   function MakeHash (path: string): string;
  end;

implementation
begin

end.
