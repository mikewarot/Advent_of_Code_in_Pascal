program advent2020_14b;
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
  buffer    : array[1..1000] of string;
  mask0,
  mask1,
  maskx     : uint64;
  memories  : array[0..memsize] of uint64;
  sum       : uint64;

begin
  StartTime := Now;
  linecount := 0;
  repeat
    done := false;
    inc(linecount);
    readln(buffer[linecount]);

  until done or eof;

  for i := 0 to 255 do
    for j := 0 to memsize shr 8 do
      memories[i,j] := 0;

  for i := 1 to linecount do
    writeln(i:4,' ',buffer[i]);


  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');

  mask0 := $0000000000000000;
  mask1 := $0000000000000000;
  maskx := $0000000000000000;
  for i := 1 to linecount do
  begin
    s := buffer[i];
    t := getword(s);
    case t of
      'mask' : begin
                 writeln('handle_mask ',s);
                 eat(s,[' ','=']);
                 mask0 := $0000000000000000;
                 mask1 := $0000000000000000;
                 maskx := $0000000000000000;
                 while s <> '' do
                 begin
                   mask0 := mask0 shl 1;
                   mask1 := mask1 shl 1;
                   maskX := maskX shl 1;
                   case s[1] of
                     '0' : mask0 := mask0 or 1;
                     '1' : mask1 := mask1 or 1;
                     'X','x' : maskX := maskX or 1;
                   end;
                   delete(s,1,1);
                 end;
                 writeln('Mask0 = ',mask0.ToHexString);
                 writeln('Mask1 = ',mask1.ToHexString);
                 writeln('Maskx = ',maskX.ToHexString);
               end;
      'mem'  : begin
                 writeln('handle_mem ',s);
                 eat(s,['[']);
                 address := getnum(s);
                 eat(s,[']','=',' ']);
                 n := getnum(s);
                 old_ea := -1;
                 for k := 0 to memsize do
                 begin
                   ea := (k AND maskX) OR (address AND mask0);
                   ea := ea OR mask1;   // handles 1 setting ea
                   memories[(ea shr 28), (ea AND $fffffff) ] := n;
                 end; // for k
               end;
    else
      writeln('Unknown [',t,']');
    end;
  end;

  sum := 0;
  count := 0;
  for i := 0 to 255 do
    for j := 0 to memsize do
      if memories[i,j] <> 0 then
      begin
        inc(count);
        sum := sum + memories[i,j];
      end;

  WriteLn('Total of ',Count,' entries = ',sum);

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
end.

