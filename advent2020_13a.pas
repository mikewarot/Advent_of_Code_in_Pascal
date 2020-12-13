program advent2020_13a;
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

  procedure turnright(var x,y : integer);
  var
    n : integer;
  begin
    n := x;
    x := y;;
    y := -n;
  end;

  procedure turnleft(var x,y : integer);
  begin
    turnright(x,y);
    turnright(x,y);
    turnright(x,y);
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
  s         : string;
  i,j,k     : integer;
  togo      : integer;

begin
  StartTime := Now;
  linecount := 0;
  readln(x);
  readln(s);
  count := 0;
  repeat
    inc(count);
    factors[count] := getnum(s);
    eat(s,[',']);
  until s='';

  for i := 1 to count do
  begin
    togo := factors[i]-(x mod factors[i]);
    if x mod factors[i] = 0 then
    begin
      writeln('ON ',Factors[i]);
      halt;
    end;
    writeln(factors[i]:4,' ',(x mod factors[i]):4,(factors[i]-(x mod factors[i])):4, (togo*factors[i]):4 );


  end;
  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');

end.

