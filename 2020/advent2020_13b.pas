program advent2020_13b;
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
  while (length(s) <> 0) and NOT(s[1] in [' ']) do
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


var
  OldBuffer,
  StartTime : TDateTime;
  linecount : integer;
  c         : char;
  count     : integer;
  done      : boolean;
  X,DX      : integer;
  min,minx  : integer;
  factors   : array[1..1000] of integer;
  delta     : array[1..1000] of integer;
  s         : string;
  i,j,k     : integer;
  togo      : integer;
  billions  : integer;

begin
  StartTime := Now;
  linecount := 0;
  readln(x);
  readln(s);
  count := 0;
  i := 1;
  repeat
    X := getnum(s);
    if x <> 0 then
    begin
      inc(count);
      factors[count] := x;
      delta[count] := x-i;
    end;
    inc(i);
    eat(s,[',']);
  until s='';

  x := 1;
  billions := 0;

  repeat
    done := true;
    inc(x);
    for i := 1 to count do
    begin
      dec(delta[i]);
      if delta[i] <= 0 then
      begin
        delta[i] := delta[i]+factors[i];
//          writeln('Match ',X,' ',factors[i]);
      end
      else
        done := false;
    end;
    if done OR ((x mod 1000000) = 0) then
    begin
      write(x,' ');
      for i := 1 to count do
        write(delta[i],' ');
      writeln;
      if x = 1000000000 then
      begin
        x := 0;
        inc(billions);
      end;
    end;
  until done; // or (x=20);


  writeln('Answer = ',billions,x:9);
  write(x,' ');
  for i := 1 to count do
    write(delta[i],' ');
  writeln;

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');

end.

