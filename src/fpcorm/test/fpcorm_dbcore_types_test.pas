unit fpcorm_dbcore_types_test;

{$mode objfpc}{$H+}

interface

uses
  Classes, sysutils,
  sqldb,
  syncobjs,
  FGL,
  fpcorm_dbcore_objects;


type

  TSchoolClass = class;
  TSchoolClassList = specialize TFPGList<TSchoolClass>;
  TSchoolPerson = class;
  TSchoolPersonList = specialize TFPGList<TSchoolPerson>;

  { TSchoolClass }

  TSchoolClass = class(TfoDBTableObject)
  private
    fREC_ID: TfoDBTableFieldLongInt;
    fClassName: TfoDBTableFieldString;

    fSchoolPersonList_by_fk_Class_ID: TSchoolPersonList;

    // TfoDBFKReferencingListFunction
    function GetSchoolPersonList_by_fk_Class_ID(): TSchoolPersonList;
  public
    constructor Create(aConnection: TSQLConnector; aMutex: TCriticalSection);
    destructor Destroy; override;

  published
    property REC_ID: TfoDBTableFieldLongInt read fREC_ID;
    property ClassName: TfoDBTableFieldString read fClassName;

    property PersonList: TSchoolPersonList read GetSchoolPersonList_by_fk_Class_ID; { named by the UI, istead of "SchoolPersonList_by_fk_Class_ID" }
  end;

  { TSchoolPerson }

  TSchoolPerson = class(TfoDBTableObject)
  private
    fREC_ID: TfoDBTableFieldLongInt;
    fFirstName: TfoDBTableFieldString;
    fLastName: TfoDBTableFieldString;
    fAge: TfoDBTableFieldLongInt;
    ffk_Class_ID: TfoDBTableFieldLongInt;

    fSchoolClass_by_fk_Class_ID: TSchoolClass;

    function GetSchoolClass_by_fk_Class_ID(): TSchoolClass;
    procedure SetSchoolClass_by_fk_Class_ID(aSchoolClass: TSchoolClass);

  public
    constructor Create(aConnection: TSQLConnector; aMutex: TCriticalSection);
    destructor Destroy; override;

    function InsertAsNew(): Boolean; override;
    function Update(): Boolean; override;
  published
    property REC_ID: TfoDBTableFieldLongInt read fREC_ID;
    property FirstName: TfoDBTableFieldString read fFirstName;
    property LastName: TfoDBTableFieldString read fLastName;
    property Age: TfoDBTableFieldLongInt read fAge;
    property fk_Class_ID: TfoDBTableFieldLongInt read ffk_Class_ID;

    property SchoolClass: TSchoolClass read GetSchoolClass_by_fk_Class_ID write SetSchoolClass_by_fk_Class_ID;
  end;

implementation

{ TSchoolPerson }

function TSchoolPerson.GetSchoolClass_by_fk_Class_ID: TSchoolClass;
begin
  if Assigned(fSchoolClass_by_fk_Class_ID) then
    Result := fSchoolClass_by_fk_Class_ID
  else
  begin
    fSchoolClass_by_fk_Class_ID := TSchoolClass.Create(Connection, Mutex);

    { Lazy load }
    {if not ObjectStatus.IsNew then
      if not fk_Class_ID.IsNull then
        fSchoolClass_by_fk_Class_ID.LoadBy_PK_REC_ID(fk_Class_ID.Value);}

    Result := fSchoolClass_by_fk_Class_ID;
  end;
end;

procedure TSchoolPerson.SetSchoolClass_by_fk_Class_ID(aSchoolClass: TSchoolClass);
begin
  if not Assigned(aSchoolClass) then
  begin
    // user setting this object to nil
    ffk_Class_ID.IsNull := True;
    fSchoolClass_by_fk_Class_ID := nil;
  end
  else
  begin
    fSchoolClass_by_fk_Class_ID := aSchoolClass;

    if not aSchoolClass.REC_ID.IsNull then
      ffk_Class_ID.Value := aSchoolClass.REC_ID.Value
    else
      ffk_Class_ID.IsNull := True;
  end;
end;

constructor TSchoolPerson.Create(aConnection: TSQLConnector;
  aMutex: TCriticalSection);
begin
  inherited Create(aConnection, aMutex);

  with TableInformation do
  begin
    TableCatalog := 'Students';
    TableSchema := 'dbo';
    TableType := 'U';
    TableName := 'SchoolPerson';
  end;

  fREC_ID := TfoDBTableFieldLongInt.Create(Self, 'REC_ID');
  fREC_ID.IsPrimaryKey := True;
  fREC_ID.HasDefault := True;
  fREC_ID.IsIndexed := True;

  fFirstName := TfoDBTableFieldString.Create(Self, 'FirstName');

  fLastName := TfoDBTableFieldString.Create(Self, 'LastName');

  fAge := TfoDBTableFieldLongInt.Create(Self, 'Age');

  ffk_Class_ID := TfoDBTableFieldLongInt.Create(Self, 'fk_Class_ID');
  ffk_Class_ID.IsForeignKey := True;
  ffk_Class_ID.IsIndexed := True;
  ffk_Class_ID.IsNullable := True;
end;

destructor TSchoolPerson.Destroy;
begin
  inherited Destroy;
end;

function TSchoolPerson.InsertAsNew: Boolean;
const
  lProcedureName = 'InsertAsNew';
begin
  { Prevent recursive insertion }
  if ObjectStatus.IsInserting or ObjectStatus.IsUpdating or ObjectStatus.IsDeleting then
    Exit;

  if not Assigned(Connection) then
    raise Exception.Create('Unable to insert object of type: ' + ClassName + ', Connection is not set');

  { if not ObjectStatus.IsNew then
    raise Exception.Create('Unable to insert object of type: ' + ClassName + ', the object is already in the database!'); }

  if Assigned(fSchoolClass_by_fk_Class_ID) then
  begin
    if fSchoolClass_by_fk_Class_ID.ObjectStatus.IsNew then
    begin
      if fSchoolClass_by_fk_Class_ID.InsertAsNew then
        ffk_Class_ID.Value := fSchoolClass_by_fk_Class_ID.REC_ID.Value
    end
    else if fSchoolClass_by_fk_Class_ID.ObjectStatus.IsChanged then
    begin
      if

    end;
  end;


end;

function TSchoolPerson.Update: Boolean;
begin

end;

{ TSchoolClass }

function TSchoolClass.GetSchoolPersonList_by_fk_Class_ID: TSchoolPersonList;
begin
  Result := fSchoolPersonList_by_fk_Class_ID;
end;

constructor TSchoolClass.Create(aConnection: TSQLConnector;
 aMutex: TCriticalSection);
begin
  inherited Create(aConnection, aMutex);

  fREC_ID := TfoDBTableFieldLongInt.Create(Self, 'REC_ID');
  fClassName := TfoDBTableFieldString.Create(Self, 'ClassName');

  fSchoolPersonList_by_fk_Class_ID := TSchoolPersonList.Create;
end;

destructor TSchoolClass.Destroy;
begin
 inherited Destroy;
end;

end.

