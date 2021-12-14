program advent2020_13c;
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
  factors   : array[1..100] of integer;
  remainder : array[1..100] of integer;
  s         : string;
  i,j,k     : integer;
  togo      : integer;
  billions  : integer;
  delta     : integer;
  matchcol  : integer;


begin
  StartTime := Now;
  linecount := 0;
  readln(x);
  readln(s);
  count := 0;
  i := 0;
  repeat
    X := getnum(s);
    if x <> 0 then
    begin
      inc(count);
      factors[count] := x;
      remainder[count] := -i;
      while remainder[count] < 1 do
        inc(remainder[count],factors[count]);
    end;
    inc(i);
    eat(s,[',']);
  until s='';

  for i := 1 to count do
    writeln(i,' ',factors[i],' ',remainder[i]);
  x := 0;
  billions := 0;

  delta := factors[1];
  matchcol := 1;
  repeat
    inc(x,delta);
    done := true;
    for i := 1 to count do
    begin
      dec(remainder[i],delta);
      if (remainder[i] < 0) then
        remainder[i] := (remainder[i] mod factors[i]);
      while (remainder[i] < 0) do
        remainder[i] := remainder[i]+factors[i];
    end;
//    write(x,' ');
//    for i := 1 to count do
//      write(remainder[i],' ');
//    writeln;
    for i := 1 to count do
      if remainder[i] = 0 then
      begin
        if done and (i=(matchcol+1)) and (matchcol <5) then
        begin
          writeln('internal match X=',X,' ');
          for j := 1 to count do
            writeln(j,' ',factors[j],' ',remainder[j]);
          writeln('Delta was ',delta);
          inc(matchcol);
          delta := delta * factors[matchcol];
          writeln('Delta is ',delta);
        end;
      end
      else
        done := false;
    if x >= 1000000000 then
    begin
//      for j := 1 to count do
//        writeln(j,' ',factors[j],' ',remainder[j]);

      x := x - 1000000000;
      inc(billions);
      writeln(billions,' ',x);
    end;
  until done;

  writeln(billions,' ',x);
  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');

end.

