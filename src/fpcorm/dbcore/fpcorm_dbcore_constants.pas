unit fpcorm_dbcore_constants;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

const
  c_SQL_NULL = 'NULL';
  c_XML_NULL = '';
  c_String_NULL = '';
  c_SQL_Boolean: array [Boolean] of String = ('0', '1');
  c_XML_Boolean: array [Boolean] of String = ('False', 'True');
  c_String_Boolean: array [Boolean] of String = ('False', 'True');
  c_SQL_DecimalSeparatorChar = '.';
  c_XML_DecimalSeparatorChar = '.';
  c_String_DecimalSeparatorChar = ',';
  c_SQL_DateTimeFormat = 'yyyymmdd hh:nn:ss.zzz';
  c_XML_DateTimeFormat = 'yyyymmdd hh:nn:ss.zzz';
  c_String_DateTimeFormat = 'yyyy-mm-dd hh:nn:ss';

implementation

end.

