program advent2020_14_redo;
uses
  sysutils, dateutils;

type
  charset = set of char;
const
  whitespace : charset = [' ',#9,#10,#13];

procedure eat(var s : string;  whattoeat : charset);
begin
  while (length(s) <> 0) and (s[1] in whattoeat) do
    delete(s,1,1);
end;

procedure Expect(var s : string; c : char);
begin
  if (s='') OR (s[1] <> c) then
    writeln('Error : Expected [',c,'], Got [',s,']')
  else
    delete(s,1,1);
end;

function getnum(var s : string):longint;
var
  c : char;
  value : longint;
begin
  value := 0;
  while (length(s) <> 0) and NOT (S[1] in ['0'..'9']) do
    delete(s,1,1);
  while (length(s) <> 0) and (s[1] in ['0'..'9']) do
  begin
    value := value * 10 + (ord(s[1])-ord('0'));
    delete(s,1,1);
  end;
  eat(s,whitespace);
  getnum := value;
end;

function getword(var s : string):string;
var
  c : char;
  value : string;
begin
  value := '';
  while (length(s) <> 0) and (s[1] in [' ']) do
    delete(s,1,1);
  while (length(s) <> 0) and (s[1] in ['0'..'9','a'..'z','A'..'Z']) do
  begin
    value := value + s[1];
    delete(s,1,1);
  end;
  while (s <> '') AND (s[1] = ' ') do
    delete(s,1,1);
  getword := value;
end;

var
  TotalValues : Longint;
  MemAddress,
  MemValue    : Array[1..100000] of uInt64;
  MemCount    : Longint;

  Procedure WriteMem(Address,Value : uInt64);
  var
    i,j,k : integer;
    found  : integer;
  begin
    found := 0;
    for i := 1 to MemCount do
      if MemAddress[i] = Address then
        Found := i;
    if found = 0 then  // if not found
      begin
        Inc(memCount);
        MemValue[MemCount] := 0; // safety
        MemAddress[MemCount] := Address;
        Found := MemCount;  // new value at end
      end;
    MemValue[Found] := Value;
  end;

  procedure Iterate(Mask : String; Address, Value : uInt64);
  var
    i,j,k    : integer;
    BitPos   : Byte;
    ThisBit  : uInt64;
    BitCount : Byte;
    BitGen   : Array[0..15] of uInt64;
    NewAddress : uInt64;

  begin
    WriteLn('Iterate [',mask,'] over Address[',Address.ToHexString,'] = ',Value);

    ThisBit := 1;
    BitCount := 0;
    For BitPos := 0 to 35 do
      begin
        case Mask[36-BitPos] of
          'X' : begin
                  WriteLn('Bit ',BitPos,' Bit = ',ThisBit);
                  inc(bitcount);
                  BitGen[BitCount] := ThisBit;
                  WriteLn('Bitgen[',BitCount,'] = ',ThisBit);
                  Address := Address AND (NOT ThisBit);
                end; // case 'X'
          '1' : begin
                  Address := Address OR ThisBit;
                end; // case '1'
        end;  // case
        ThisBit := ThisBit SHL 1;
      end;  // for BitPos
    WriteLn('Total ',BitCount,' variable bits = ',1 shl bitcount,' possible values');
    Inc(TotalValues,1 shl BitCount);
    WriteLn('New Base Address = ',Address.ToHexString);

    for i := 0 to (1 shl BitCount)-1 do
      begin
        NewAddress := Address;
        for j := 1 to BitCount do
          if (i and (1 shl (j-1))) <> 0 then
            NewAddress := NewAddress OR BitGen[j];
        WriteLn('   Memory[',NewAddress,'] = ',Value);
        WriteMem(NewAddress,Value);
      end;
  end;

var
  StartTime   : TDateTime;
  s           : string;
  mask        : string;
  Address,
  Value       : longint;
  Sum         : uInt64;
  i           : integer;


begin
  StartTime := Now;
  TotalValues := 0;
  MemCount := 0;
  repeat
    readln(s);
    if pos('mask = ',s) = 1 then
      begin
        mask := copy(s,8,999);
        writeln('Mask = [',mask,'] ',length(mask));
      end
    else
      begin
        if pos('mem[',s) = 1 then
          begin
            address := getNum(s);
            value   := getNum(s);
            Iterate(Mask,Address,Value)
          end;

      end; // if else

  until eof;

  WriteLn('Possible Values = ',TotalValues);
  WriteLn('Actual Values = ',MemCount);
  Sum := 0;
  for i := 1 to MemCount do
    Sum := Sum + MemValue[i];
  WriteLn('Sum of all values = ',Sum);

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
end.

