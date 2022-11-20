program SingleInstance;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Diagnostics,
  System.Generics.Collections,
  System.Classes,
  System.Threading,
  System.IOUtils,
  functional in 'functional.pas',
  RandomByteWriterThread in 'RandomByteWriterThread.pas';


begin
  Randomize;
  try
    var c := 0;
    var threads := TList<TRandomByteWriter>.Create;

    writeln('Starting...');
    var watch := TStopwatch.StartNew;

    for var I := 1 to 10 do
    begin
      threads.add(TRandomByteWriter.Create(c));;
    end;



    watch.stop;
    Writeln(Format('Time Taken: %.4fms',[watch.Elapsed.TotalMilliseconds]));
    readln
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
