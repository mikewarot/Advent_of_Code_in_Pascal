program advent2020_15b;
uses
  classes, sysutils, dateutils;
type
  charset = set of char;
const
  whitespace : charset = [' ',#9,#10,#13];

procedure eat(var s : string;  whattoeat : charset);
begin
  while (length(s) <> 0) and (s[1] in whattoeat) do
    delete(s,1,1);
end;

function getnum(var s : string):integer;
var
  c : char;
  value : integer;
begin
  value := 0;
  while (length(s) <> 0) and NOT(s[1] in ['0'..'9']) do
    delete(s,1,1);
  while (length(s) <> 0) and (s[1] in ['0'..'9']) do
  begin
    value := value * 10 + (ord(s[1])-ord('0'));
    delete(s,1,1);
  end;
  getnum := value;
end;

function getinteger(var s : string):integer;
var
  value : integer;
  sign  : integer;
begin
  value := 0;
  sign := 1;
  eat(s,whitespace);
  if s <> '' then
    if s[1] = '+' then
      delete(s,1,1)
    else
      if s[1] = '-' then
      begin
        sign := -1;
        delete(s,1,1);
      end;
  while (s <> '') AND (s[1] in ['0'..'9']) do
  begin
    value := (value * 10) + (ord(s[1])-ord('0'));
    delete(s,1,1);
  end;
  value := value * sign;
  getinteger := value;
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

function AddString(A,B : String):String;
const
  digits : string = '012345678901234567890';
var
  c : string;
  i,j,k ,x: integer;
  carry : integer;
begin
  C := '';
  carry := 0;
  while length(a) < length(b) do
    a := '0'+a;
  while length(b) < length(a) do
    b := '0'+b;
  for i := length(a) downto 1 do
  begin
    j := pos(a[i],'0123456789')-1;
    k := pos(b[i],'0123456789')-1;
    x := j+k+carry;
    carry := 0;
    if x >= 10 then carry := 1;
    c := digits[x+1]+ c;
  end;
  AddString := c;      // ignore carry at the end, to enable wrap around
end;

function SubString(A,B : String):String;
const
  digits : string = '012345678901234567890';
var
  c : string;
  i,j,k ,x: integer;
  borrow : integer;
begin
  C := '';
  borrow := 0;
  while length(a) < length(b) do
    a := '0'+a;
  while length(b) < length(a) do
    b := '0'+b;
  for i := length(a) downto 1 do
  begin
    j := pos(a[i],'0123456789')-1;
    k := pos(b[i],'0123456789')-1;
    x := 10+j-k-borrow;
    borrow := 0;
    if x < 10 then borrow := 1;
    c := digits[x+1]+ c;
  end;
  SubString := c;      // ignore borrow at the end, to enable wrap around
end;

const
  MemSize   : uint64 = $0fffffffff;

var
  OldBuffer,
  StartTime : TDateTime;
  linecount : integer;
  c         : char;
  count     : integer;
  done      : boolean;
  s,t       : string;
  i,j,k,n   : uint64;
  address   : uint64;
  ea,old_ea : uint64;
  buffer    : array[1..30000000] of integer;
  mask0,
  mask1,
  maskx     : uint64;
  sum       : uint64;
  last      : integer;
  delta   : integer;

begin
  for i := 1 to 30000000 do
    buffer[i] := 0;

  readln(s);
  StartTime := Now;
  count := 0;
  repeat
    done := false;
    inc(count);
    n := getnum(s);
    last := buffer[n];
    if last <> 0 then last := count-last;
    buffer[n] := count;
    eat(s,[',']);
    write(n,',');
  until s = '';

  for i := count+1 to 30000000 do
  begin
    n := last;
    last := buffer[n];
    if last <> 0 then last := i-last;
    buffer[n] := i;
//    write(n,',');
  end;

  writeln(n);

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
end.

