unit fpcorm_common_constants;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

const
  { Byte 0 .. 255 }
  c_fo_MinByte: Byte = Low(Byte);
  c_fo_MaxByte: Byte = High(Byte);
  { ShortInt -128 .. 127 }
  c_fo_MinShortInt: ShortInt = Low(ShortInt);
  c_fo_MaxShortInt: ShortInt = High(ShortInt);
  { SmallInt -32768 .. 32767 }
  c_fo_MinSmallInt: SmallInt = Low(SmallInt);
  c_fo_MaxSmallInt: SmallInt = High(SmallInt);
  { Word 0 .. 65535 }
  c_fo_MinWord: Word = Low(Word);
  c_fo_MaxWord: Word = High(Word);
  { LongInt -2147483648 .. 2147483647 }
  c_fo_MinLongInt: LongInt = Low(LongInt);
  c_fo_MaxLongInt: LongInt = High(LongInt);
  { LongWord 0 .. 4294967295 }
  c_fo_MinLongWord: LongWord = Low(LongWord);
  c_fo_MaxLongWord: LongWord = High(LongWord);
  { Int64 -9223372036854775808 .. 9223372036854775807 }
  c_fo_MinInt64: Int64 = Low(Int64);
  c_fo_MaxInt64: Int64 = High(Int64);
  { QWord 0 .. 18446744073709551615 }
  c_fo_MinQWord: QWord = Low(QWord);
  c_fo_MaxQWord: QWord = High(QWord);

  { Single 1.5E-45 .. 3.4E38 }
  c_fo_MinSingle: Single = 1.5E-45;
  c_fo_MaxSingle: Single = 3.4E38;
  { Double 5.0E-324 .. 1.7E308 }
  c_fo_MinDouble: Double = 5.0E-324;
  c_fo_MaxDouble: Double = 1.7E308;
  { Extended 1.9E-4932 .. 1.1E4932 }
  c_fo_MinExtended: Extended = 1.9E-4932;
  c_fo_MaxExtended: Extended = 1.1E4932;
  { Currency -922337203685477.5808 .. 922337203685477.5807 }
  { c_fo_MinCurrency = MinCurrency;
  c_fo_MaxCurrency = MaxCurrency; }
  { TDateTime 01/01/0001 12:00:00.000 AM .. 12/31/9999 11:59:59.999 PM }
  { c_fo_MinDateTime = MinDateTime;
  c_fo_MaxDateTime = MaxDateTime; }

implementation

end.

