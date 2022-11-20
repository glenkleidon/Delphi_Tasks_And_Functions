unit functional;

interface

procedure WriteOneHundredThousandRandomBytes;

implementation
 uses System.IOUtils;

procedure WriteOneHundredThousandRandomBytes;
begin
    var FileStream :=  TFile.Create(TPath.GetTempFileName);
    try
    for var I := 0 to 100000 do
    begin
      var b := byte(random(256));
      FileStream.Write(b,1);
    end;
    finally
      FileStream.free;
    end;
end;


end.
