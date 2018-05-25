unit GUI;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls,
  Graphics, Dialogs, StdCtrls, Hashable, HashAlgorithm1;

type

  { TGraphicalInterface }

  TGraphicalInterface = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  GraphicalInterface: TGraphicalInterface;

implementation

{$R *.lfm}

{ TGraphicalInterface }

procedure TGraphicalInterface.Button1Click(Sender: TObject);
var
   sample: THashAlgorithm1;
begin
  Edit1.Text:=sample.makeHash(123);
end;

end.

