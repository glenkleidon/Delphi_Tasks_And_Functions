program SingleInstance;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Diagnostics,
  System.Classes,
  System.Threading,
  System.IOUtils;

begin
  Randomize;
  try
    writeln('Starting...');
    var watch := TStopwatch.StartNew;
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
    watch.stop;
    Writeln(Format('Time Taken: %.4fms',[watch.Elapsed.TotalMilliseconds]));
    readln
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
