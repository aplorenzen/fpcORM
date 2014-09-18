unit fpcorm_codebuilder_types_test;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,

  fpcorm_codebuilder_types;

type

  { TCodeBuiderTestClass }

  TCodeBuiderTestClass = class(TObject)
  private
  public
    constructor Create();
    destructor Destroy; override;
    function Test: String;
  end;

implementation

{ TCodeBuiderTestClass }

constructor TCodeBuiderTestClass.Create;
begin
  inherited Create;


end;

destructor TCodeBuiderTestClass.Destroy;
begin
  inherited Destroy;
end;

function TCodeBuiderTestClass.Test: String;
var
  aUnit: TcbUnit;
  aTObjectClass: TcbExternalType;
  aSourceCode: TStringList;
begin
  aUnit := TcbUnit.Create(nil, 'TestUnit');
  try
    aTObjectClass := TcbExternalType.Create(aUnit, 'TObject');

    try

      with aUnit do
      begin
        UnitTopCommentBlock.Add('This is just a test unit man!');

        with aUnit.UnitSections.AddSection do
        begin
          AddClass('TTheTestClass', True, aTObjectClass);
        end;
      end;

      aSourceCode := aUnit.WriteSourceCode;

      try

        Result := aSourceCode.Text;

      finally
        // aSourceCode.Free;
      end;

    finally
      // aTObjectClass.Free;
    end;
  finally
    aUnit.Free;
    aTObjectClass.Free;
  end;


end;

end.

