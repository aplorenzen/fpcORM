program fpcorm;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp,
  { you can add units after this }
  fpcorm_common_constants,
  fpcorm_common_interfaces,
  fpcorm_common_types,
  fpcorm_dbcore_constants,
  fpcorm_dbcore_interfaces,
  fpcorm_dbcore_utils,
  fpcorm_dbcore_objects,
  FGL;

type

  { TfoApplication }

  { TTestObj }

  TTestObj = class(TObject)
  private
    fTestField: String;
  public
    constructor Create;
    destructor Destroy; override;

    property TestField: String read fTestField write fTestField;
  end;

  TTestObjPtr = ^TTestObj;
  TTestObjPtrPtr = ^TTestObjPtr;

  TTestObjList = specialize TFPGList<TTestObj>;
  TTestObjPtrList = specialize TFPGList<TTestObjPtr>;
  TTestObjPtrPtrList = specialize TFPGList<TTestObjPtrPtr>;
  TPointerList = specialize TFPGList<Pointer>;


  TfoApplication = class(TCustomApplication)
  private
    aTestObjSource: TTestObj;
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ TTestObj }

constructor TTestObj.Create;
begin
  inherited Create;
end;

destructor TTestObj.Destroy;
begin
  inherited Destroy;
end;

{ TfoApplication }

procedure TfoApplication.DoRun;
var
  ErrorMsg: String;
  lSomeDateTime: TDateTime;
  aTestObjSecondary: TTestObjPtr;
  aTestList: TTestObjList;
  aTestObjEnum: TTestObjPtr;
  aPtr: Pointer;
  aPointerList: TPointerList;
begin
  // quick check parameters
  ErrorMsg := CheckOptions('h','help');

  if ErrorMsg <> '' then begin
    writeln(ErrorMsg);
    // ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h','help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;

  { add your program here }

  // create generic pointer list
  aTestList := TTestObjList.Create;
  aPointerList := TPointerList.Create;

  try

    aPtr := @aTestObjSource;

    aTestObjSource := TTestObj.Create;
    aTestObjSource.TestField := 'testing';

    // add the test object (source) to the list
    // aTestList.Add(@@aTestObjSource);
    //aPtr := @@aTestObjSource;
    //
    //// assign local reference (secondary) to the class reference
    //aTestObjSecondary := @@aTestObjSource;
    //
    //// create and assign the field in the class reference
    //
    //// go through the list, and print all the enumerated objects fields
    //for aTestObjEnum in aTestList do
    //begin
    //  WriteLn(aTestObjEnum^.TestField);
    //end;
    //
    //// attempt to print the directly assigned (pre creation) seconday field value
    //WriteLn(aTestObjSecondary.TestField);
    //
    //

    finally
    begin
      aTestList.Free;
      aTestObjSource.Free;
      aPointerList.Free;
    end;
  end;


  // Byte	      0 .. 255	                                    1
  WriteLn(Format('Low(Byte) = %u', [Low(Byte)]));
  WriteLn(Format('High(Byte) = %u', [High(Byte)]));
  // ShortInt	 -128 .. 127	                                  1
  WriteLn(Format('Low(ShortInt) = %d', [Low(ShortInt)]));
  WriteLn(Format('High(ShortInt) = %d', [High(ShortInt)]));
  // Smallint	 -32768 .. 32767	                              2
  WriteLn(Format('Low(SmallInt) = %d', [Low(SmallInt)]));
  WriteLn(Format('High(SmallInt) = %d', [High(SmallInt)]));
  // Word	      0 .. 65535	                                  2
  WriteLn(Format('Low(Word) = %u', [Low(Word)]));
  WriteLn(Format('High(Word) = %u', [High(Word)]));
  // Longint	 -2147483648 .. 2147483647	                    4
  WriteLn(Format('Low(LongInt) = %d', [Low(LongInt)]));
  WriteLn(Format('High(LongInt) = %d', [High(LongInt)]));
  // Longword	  0 .. 4294967295	                              4
  WriteLn(Format('Low(LongWord) = %u', [Low(LongWord)]));
  WriteLn(Format('High(LongWord) = %u', [High(LongWord)]));
  // Int64	    -9223372036854775808 .. 9223372036854775807	  8
  WriteLn(Format('Low(Int64) = %d', [Low(Int64)]));
  WriteLn(Format('High(Int64) = %d', [High(Int64)]));
  // QWord	    0 .. 18446744073709551615	                    8
  WriteLn(Format('Low(QWord) = %u', [Low(QWord)]));
  WriteLn(Format('High(QWord) = %u', [High(QWord)]));

  lSomeDateTime := Now;

  if lSomeDateTime < MinDateTime then
    WriteLn(Format('%s < %s', [FormatDateTime('yyyy-mm-dd hh:nn:ss', lSomeDateTime), FormatDateTime('yyyy-mm-dd hh:nn:ss', MinDateTime)]))
  else if lSomeDateTime = MinDateTime then
    WriteLn(Format('%s = %s', [FormatDateTime('yyyy-mm-dd hh:nn:ss', lSomeDateTime), FormatDateTime('yyyy-mm-dd hh:nn:ss', MinDateTime)]))
  else
    WriteLn(Format('%s > %s', [FormatDateTime('yyyy-mm-dd hh:nn:ss', lSomeDateTime), FormatDateTime('yyyy-mm-dd hh:nn:ss', MinDateTime)]));


  // Type	      Range	                            Significant digits	  Size
  // Real	      platform dependant	 ???	                      4 or    8
  //WriteLn(Format('Low(Real) = %g', [Low(Real)]));
  //WriteLn(Format('High(Real) = %g', [High(Real)]));
  // Single	    1.5E-45               .. 3.4E38	                 7-8	  4
  //WriteLn(Format('Low(QWord) = %u', [Low(QWord)]));
  //WriteLn(Format('High(QWord) = %u', [High(QWord)]));
  //// Double	    5.0E-324              .. 1.7E308	              15-16	  8
  //WriteLn(Format('Low(QWord) = %u', [Low(QWord)]));
  //WriteLn(Format('High(QWord) = %u', [High(QWord)]));
  //// Extended	  1.9E-4932             .. 1.1E4932	              19-20	  10
  //WriteLn(Format('Low(QWord) = %u', [Low(QWord)]));
  //WriteLn(Format('High(QWord) = %u', [High(QWord)]));
  //// Comp	      -2E64+1               .. 2E63-1	                19-20	  8
  //WriteLn(Format('Low(QWord) = %u', [Low(QWord)]));
  //WriteLn(Format('High(QWord) = %u', [High(QWord)]));
  //// Currency	  -922337203685477.5808 .. 922337203685477.5807	  19-20	  8
  //WriteLn(Format('Low(QWord) = %u', [Low(QWord)]));
  //WriteLn(Format('High(QWord) = %u', [High(QWord)]));

  // stop program loop
  Terminate;
end;

constructor TfoApplication.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor TfoApplication.Destroy;
begin
  inherited Destroy;
end;

procedure TfoApplication.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ',ExeName,' -h');
end;

var
  Application: TfoApplication;

{$R *.res}

begin
  Application:=TfoApplication.Create(nil);
  Application.Run;
  Application.Free;
end.

