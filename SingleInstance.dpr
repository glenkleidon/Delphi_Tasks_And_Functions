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
  //  var c := 0;
    var watch := TStopwatch.StartNew;
    for var I := 1 to 10 do
    begin
      var task := TTask.Run( procedure
      begin
        var
        c := WriteOneHundredThousandRandomBytesIncrementingCounter(1);
        Writeln(Format('Call %d complete.', [c]));
      end);
    end;

    watch.stop;
    Writeln(Format('Time Taken: %.4fms',[watch.Elapsed.TotalMilliseconds]));
    readln
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
