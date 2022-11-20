program SingleInstance;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Diagnostics,
  System.Classes,
  System.Threading,
  System.IOUtils,
  System.SyncObjs,
  functional in 'functional.pas';

var
  i,c: integer;
  Tasks:TArray<ITask>;

begin
  Randomize;
  try
    c:= 0;
    setlength(Tasks,10);
    writeln('Starting...');
    ThreadTracker.Start(10);

    for I := 0 to 9 do
    begin
      Tasks[i] := TTask.Create( procedure
      begin
        TInterlocked.Increment(c);
        var id := WriteOneHundredThousandRandomBytes(c);
        ThreadTracker.ThreadFinished(id);
      end);
      Tasks[i].start;
    end;

    ThreadTracker.OnStop := procedure(AElapsed: int64)
    begin
      Writeln(Format('Time Taken: %dms',[AElapsed]));
    end;

    ReadLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
