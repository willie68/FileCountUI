unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, SpinEx;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnDup: TButton;
    btnRestore: TButton;
    btnStore: TButton;
    Label1: TLabel;
    spFolder: TSpinEditEx;
    Timer1: TTimer;
    procedure btnDupClick(Sender: TObject);
    procedure btnRestoreClick(Sender: TObject);
    procedure btnStoreClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label1DblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    dir: string;
    baseCount: integer;

    function GetDirCount(): integer;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

uses MCSTools;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  dir := GetCurrentDir;
  baseCount := GetDirCount();
  Label1.Caption := IntToStr(0);
end;

procedure TForm1.btnDupClick(Sender: TObject);
begin
  WinExecAndWait('.\\MCSAddSub.exe -d -f ./', 1);
  Label1Click(Sender);
end;

procedure TForm1.btnRestoreClick(Sender: TObject);
var
  cmd: string;
begin
  cmd := '.\\MCSAddSub.exe -d -f ./ -r -t ' + IntToStr(spFolder.Value);
  WinExecAndWait(PChar(cmd), 1);
  Label1Click(Sender);
end;

procedure TForm1.btnStoreClick(Sender: TObject);
var
  cmd: string;
begin
  cmd := '.\\MCSAddSub.exe -d -f ./ -s -t ' + IntToStr(spFolder.Value);
  WinExecAndWait(PChar(cmd), 1);
  Label1Click(Sender);
end;

procedure TForm1.Label1Click(Sender: TObject);
begin
  baseCount := GetDirCount();
  Timer1Timer(nil);
end;

procedure TForm1.Label1DblClick(Sender: TObject);
begin
  WinExecAndWait('.\\MCSAddSub.exe -d -m -f ./', 1);
  Label1Click(Sender);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Label1.Caption := IntToStr(GetDirCount() - baseCount);
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
