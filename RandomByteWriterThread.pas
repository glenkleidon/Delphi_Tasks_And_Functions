unit RandomByteWriterThread;

interface

uses
  System.Classes;

type
  TRandomByteWriter = class(TThread)
  private
    FCounter: Integer;
  protected
    procedure Execute; override;
    property Counter : integer read FCounter;
  public
    constructor Create(ACounter: integer); overload;
  end;

implementation
uses functional;
{$REGION 'Sync Comment'}

{
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure RandomByteWriter.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end;

    or

    Synchronize(
      procedure
      begin
        Form1.Caption := 'Updated in thread via an anonymous method'
      end
      )
    );

  where an anonymous method is passed.

  Similarly, the developer can call the Queue method with similar parameters as
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.

}
{$ENDREGION}

{ RandomByteWriter }

constructor TRandomByteWriter.Create(ACounter: integer);
begin
  FCounter:=ACounter;
  inherited Create(false);
end;

procedure TRandomByteWriter.Execute;
begin
  FreeOnTerminate := False;
  WriteOneHundredThousandRandomBytesIncrementingCounter(FCounter);
  inc(FCounter);
  OutputCompletedResult(FCounter);
end;

end.
