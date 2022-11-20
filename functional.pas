unit functional;

interface

function WriteOneHundredThousandRandomBytesIncrementingCounter(ACounter: Integer): integer;

implementation

uses System.IOUtils, System.Classes;

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

end.
