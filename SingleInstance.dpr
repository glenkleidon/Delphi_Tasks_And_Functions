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
   // var c := 0;
    var watch := TStopwatch.StartNew;

    TParallel.For(0,9, procedure (i: integer)
    begin
      var id := WriteOneHundredThousandRandomBytesIncrementingCounter(i);
      SynchronizeDisplay(id);
    end);

    watch.stop;
    Writeln(Format('Time Taken: %.f2 ms',[watch.Elapsed.TotalMilliseconds]));
    readln
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
