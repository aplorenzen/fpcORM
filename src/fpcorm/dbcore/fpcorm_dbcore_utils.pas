unit fpcorm_dbcore_utils;

{< This unit contains helper/utility functions, for the fpcORM database object super classes. }

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

{ Prepares a data string for use, in a SQL statement. Also secures against SQL injection.
  @param(aString is any source string)
  @returns(A String, quoted for usage in an SQL statement and with all quote characters inside escaped.) }
function ToSqlStr(aString: String): String;

implementation

function ToSqlStr(aString: String): String;
begin
  { replace all occurrences of the string seperator char ' with two of them
  in order to avoid SQL injection. finally wrap the string with a quote character on each side. }
  Result := StringReplace(aString, '''', '''''', [rfReplaceAll]);
  Result := '''' + Result + '''';
end;

end.

