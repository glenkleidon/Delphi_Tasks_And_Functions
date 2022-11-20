unit functional;

interface
uses System.SysUtils, System.IOUtils, System.Classes, System.SyncObjs,
     System.Diagnostics;

Type

 TThreadsTracker = record
 private
    FLock: TSpinLock;
    FWatch: TStopWatch;
    FCounter: Integer;
    FMax: integer;
    FOnStop : TProc<Int64>;
    function GetElapsedTime: Int64;
    function GetOnStop: TProc<Int64>;
    procedure SetOnStop(const Value: TProc<Int64>);
    procedure Stop;
 public
   property Counter: Integer read FCounter;
   procedure Start(AStopOn : Integer);
   procedure ThreadFinished(ATaskId: integer);
   property ElapsedTime: int64 read GetElapsedTime;
   Property OnStop : TProc<Int64> read FOnStop write SetOnStop;
 end;


function WriteOneHundredThousandRandomBytes(ACounter: Integer): integer;

var ThreadTracker : TThreadsTracker;

implementation

procedure SynchronizeDisplay(AIndex, APosition: Integer); overload;
begin
   Writeln(Format('Call %2d complete in position %2d', [AIndex, APosition]))
end;

function WriteOneHundredThousandRandomBytes(ACounter: Integer): integer;
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
    Exit(ACounter);
  finally
    FileStream.free;
  end;
end;

{ TThreadsTracker }

function TThreadsTracker.GetElapsedTime: int64;
begin
   result := FWatch.ElapsedMilliseconds;
end;

function TThreadsTracker.GetOnStop: TProc<Int64>;
begin
  result := FOnStop;
end;

procedure TThreadsTracker.SetOnStop(const Value: TProc<Int64>);
begin
  FOnStop := Value;
end;

procedure TThreadsTracker.Start(AStopOn : Integer);
begin
  FCounter := 0;
  FMax := AStopOn;
  FLock := TSpinLock.Create(false);
  FWatch := TStopwatch.StartNew;
end;

procedure TThreadsTracker.Stop;
begin
  FWatch.stop;
end;

procedure TThreadsTracker.ThreadFinished(ATaskId: integer);
begin
  FLock.Enter;
  try
    inc(FCounter);
    SynchronizeDisplay(ATaskId, Counter);
  finally
    FLock.Exit;
  end;
  if (Counter>=FMax) and (Assigned(OnStop)) then
    Onstop(ElapsedTime);
end;

end.
