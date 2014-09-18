unit fpcorm_common_interfaces;

{< @author(Andreas Lorenzen)
   @created(2014-06-25)
   @abstract(Common interface declarations, used throughout the object paradigms
   of the project.)

   This unit contains common interface declarations, that are applied in
   multiple other places in the project.

   @br

   This is a list of what this unit includes:

   @orderedList(
    @item(Observer pattern interfaces)
   ) }

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  { Forward declaration of interfaces }
  IfoObserver = interface;
  IfoObserverSubject = interface;

  { The observer interface for the observer design pattern, used in fpcorm }
  IfoObserver = interface(IInterface)
    ['{406D054E-A3C3-43AE-8042-983E1EF0D258}']
    procedure ReceiveSubjectUpdate(aSubject: IfoObserverSubject);
  end;

  { The subject interface of the observer design pattern implementation used in fpcorm }
  IfoObserverSubject = interface(IInterface)
    ['{CA223949-18FE-4044-AF30-6B3778DC45A4}']
    procedure AttachObserver(aObserver: IfoObserver);
    procedure DetachObserver(aObserver: IfoObserver);
  end;

  IloLogger = interface(IInterface)
    ['{354AB046-EA70-448C-9582-18F7C2E462E7}']
    procedure Fatal(aMsg: String);
    procedure Error(aMsg: String);
    procedure Warning(aMsg: String);
    procedure Info(aMsg: String);
    procedure Debug(aMsg: String);
    procedure Trace(aMsg: String);
  end;


implementation

end.

