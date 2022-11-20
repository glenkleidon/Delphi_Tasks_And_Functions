program SingleInstance;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Diagnostics,
  System.Classes,
  System.Threading,
  System.IOUtils,
  functional in 'functional.pas';

begin
  Randomize;
  try
    writeln('Starting...');
    var watch := TStopwatch.StartNew;

    WriteOneHundredThousandRandomBytes;

    watch.stop;
    Writeln(Format('Time Taken: %.4fms',[watch.Elapsed.TotalMilliseconds]));
    readln
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
