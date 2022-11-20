unit functional;

interface

function WriteOneHundredThousandRandomBytesIncrementingCounter(ACounter: Integer): integer;
procedure SynchronizeDisplay(AIndex: integer);

implementation

uses System.SysUtils, System.IOUtils, System.Classes, System.SyncObjs,
  winapi.Windows;

var SpinLock: TSpinLock;

procedure SynchronizeDisplay(AIndex: integer);
begin
  SpinLock.Enter;
  try
    Writeln(format('Call %-2d finished.',[AIndex]));
  finally
    SpinLock.exit;
  end;
end;


function WriteOneHundredThousandRandomBytesIncrementingCounter(ACounter: Integer): integer;
begin
  var
  FileStream := TFile.Create(TPath.GetTempFileName);
  try
    for var I := 0 to 100000 do
    begin
      var
      b := byte(random(256));
      FileStream.Write(b, 1);
    end;
    Exit(ACounter+1);
  finally
    FileStream.free;
  end;
end;

initialization;

  SpinLock := TSpinLock.create(false);

end.
