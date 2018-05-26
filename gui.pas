unit GUI;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls,
  Graphics, Dialogs, StdCtrls, HashAlgorithm1, FileComparator;

type

  { TGraphicalInterface }

  TGraphicalInterface = class(TForm)
    ComprareWithButton: TButton;
    SaveButton: TButton;
    CalcButton: TButton;
    FileSelectButton: TButton;
    Edit1: TEdit;
    FileLabel: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure CalcButtonClick(Sender: TObject);
    procedure ComprareWithButtonClick(Sender: TObject);
    procedure FileSelectButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
  private

  public

  end;

var
  filename: string;
  hashed: string;
  GraphicalInterface: TGraphicalInterface;

implementation

{$R *.lfm}

{ TGraphicalInterface }

procedure TGraphicalInterface.CalcButtonClick(Sender: TObject);
var
  HashAlgorithm1: THashAlgorithm1;
begin
  HashAlgorithm1 := Default(THashAlgorithm1);
  hashed := HashAlgorithm1.makeHash(filename);
  Edit1.Text := hashed;
end;

procedure TGraphicalInterface.ComprareWithButtonClick(Sender: TObject);
var
  CurrentFileName: string;
  FileComparator: TFileComparator;
begin
  if OpenDialog1.Execute then
  begin
    CurrentFileName := OpenDialog1.Filename;
    FileComparator := TFileComparator.Create(CurrentFileName);
    if FileComparator.ComprareWith(hashed) then
    begin
      ShowMessage('Same!');
    end
    else
    begin
      ShowMessage('Not same!');
    end;
  end;
end;

procedure TGraphicalInterface.FileSelectButtonClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    filename := OpenDialog1.Filename;
    FileLabel.Caption:=filename;
  end;
end;

procedure TGraphicalInterface.SaveButtonClick(Sender: TObject);
var
  SText: TStringlist;
begin
  SText:= TStringlist.create;
  SaveDialog1.FileName := 'sample.txt';
  if SaveDialog1.execute then
  begin
    SText.Add(Edit1.Text);
    SText.SaveToFile(SaveDialog1.FileName);
  end;
end;

end.

