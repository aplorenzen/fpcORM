unit fpcorm_common_types;

{< @author(Andreas Lorenzen)
   @created(2014-06-25)
   @abstract(Common types, inherited into other objects throughout the project.)

   This unit contains common interface declarations, that are applied in
   multiple other places in the project. }

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  FGL,

  fpcorm_common_interfaces;

type
  { A list type, for containing multiple subjects }
  TfoObserverList = specialize TFPGList<IfoObserver>;

  { The procedure signature, that the subject will use to notify the observer }
  //TfoOnObserverSubjectChangeEvent = procedure(aSubject: IfoObserverSubject) of object;

  { TfoObserverSubject }

  TfoObserverSubject = class(TInterfacedPersistent, IfoObserverSubject)
  private
    fObserverList: TfoObserverList;
  protected
    procedure NotifyAllObservers;
  public
    constructor Create;
    destructor Destroy; override;

    procedure AttachObserver(aObserver: IfoObserver);
    procedure DetachObserver(aObserver: IfoObserver);
  end;


  TfoObserver = class(TfoObserverSubject, IfoObserver)
  //private
  //  fOnSubjectChangeEvent: TfoOnObserverSubjectChangeEvent;
  public
    procedure ReceiveSubjectUpdate(aSubject: IfoObserverSubject); virtual;

    //property OnUpdate: TfoOnObserverSubjectChangeEvent read fOnSubjectChangeEvent write fOnSubjectChangeEvent;
  end;

implementation

procedure TfoObserver.ReceiveSubjectUpdate(aSubject: IfoObserverSubject);
begin
  NotifyAllObservers;

  //if Assigned(OnUpdate) then
  //  OnUpdate(aSubject);
end;

{ TfoObserverSubject }

procedure TfoObserverSubject.NotifyAllObservers;
var
  lObserver: IfoObserver;
begin
  for lObserver in fObserverList do
    if Assigned(lObserver) then
      lObserver.ReceiveSubjectUpdate(Self);
end;

constructor TfoObserverSubject.Create;
begin
  inherited Create;

  fObserverList := TfoObserverList.Create;
end;

destructor TfoObserverSubject.Destroy;
begin
  if Assigned(fObserverList) then
    fObserverList.Free;

  inherited Destroy;
end;

procedure TfoObserverSubject.AttachObserver(aObserver: IfoObserver);
const
  lProcedureName = 'AttachObserver';
begin
  if not Assigned(aObserver) then
    raise Exception.Create(Self.ClassName + lProcedureName + ': ' + 'aObserver parameter not assigned.');

  if Assigned(fObserverList) then
    fObserverList.Add(aObserver);
end;

procedure TfoObserverSubject.DetachObserver(aObserver: IfoObserver);
const
  lProcedureName = 'DetachObserver';
begin
  if not Assigned(aObserver) then
    raise Exception.Create(Self.ClassName + lProcedureName + ': ' + 'aObserver parameter not assigned.');

  if Assigned(fObserverList) then
    fObserverList.Remove(aObserver);
end;

end.

