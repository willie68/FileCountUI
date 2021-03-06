unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Label1: TLabel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Label1DblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    dir: string;
    baseCount : Integer;

    function GetDirCount(): integer;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  dir := GetCurrentDir;
  baseCount := GetDirCount();
  Label1.Caption := IntToStr(0);
end;

procedure TForm1.Label1DblClick(Sender: TObject);
begin
  baseCount := GetDirCount();
  Timer1Timer(nil);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Label1.Caption:=IntToStr(GetDirCount() - baseCount);
end;

function TForm1.GetDirCount(): integer;
var
  Count: integer;
  SR: TSearchRec;
begin
  Count := 0;
  try
    if FindFirst(dir + '\*.*', faArchive, SR) = 0 then
    begin
      repeat
        Inc(Count);
      until FindNext(SR) <> 0;
      FindClose(SR);
    end;
  finally
  end;
  Result := Count;
end;

end.
