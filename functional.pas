unit functional;

interface

function WriteOneHundredThousandRandomBytesIncrementingCounter(ACounter: Integer): integer;
procedure OutputCompletedResult(ACounter: integer);

implementation

uses System.Syncobjs, System.SysUtils, System.IOUtils, winapi.Windows;

var
  SpinLock : TSpinLock;

procedure OutputCompletedResult(ACounter: Integer);
begin
  SpinLock.Enter;
  try
    Writeln(Format('Call %d complete.', [ACounter]));
  finally
    SpinLock.Exit;
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

initialization
  SpinLock := TSpinLock.create(false);

end.
