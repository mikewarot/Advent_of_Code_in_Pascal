program advent2020_12a;
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


const
  Directions : Array[1..4] of Array[1..2] of integer = ((0,1),(1,0),(0,-1),(-1,0));
var
  OldBuffer,
  Buffer    : Array[1..1000] of String;
  Width,Height : Integer;
  StartTime : TDateTime;
  x,y,dx,dy : integer;
  i,j,k,n   : integer;
  linecount : integer;
  c         : char;
  count     : integer;
  done      : boolean;

  direction : integer;
  s         : string;
  distance  : integer;


begin
  StartTime := Now;
  linecount := 0;
  repeat
    inc(linecount);
    readln(buffer[linecount]);
    writeln(linecount:4,' ',buffer[linecount]);
  until eof;
  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');

  direction := 2;
  x := 0;
  y := 0;
  for i := 1 to linecount do
  begin
    s := buffer[i];
    c := s[1];
    delete(s,1,1);
    distance := getinteger(s);
    case c of
      'N' : inc(y,distance);
      'S' : dec(y,distance);
      'E' : inc(x,distance);
      'W' : dec(x,distance);
      'L' : begin
              direction := direction - (distance div 90);
              while direction > 4 do dec(direction,4);
              while direction < 1 do inc(direction,4);
            end;
      'R' : begin
              direction := direction + (distance div 90);
              while direction > 4 do dec(direction,4);
              while direction < 1 do inc(direction,4);
            end;
      'F' : begin
              inc(x,distance*directions[direction,1]);
              inc(y,distance*directions[direction,2]);
            end;
    end;  // case c
    WriteLn(C,' ',distance:4,' X,Y = ',X,' ',Y);
  end;
  WriteLn('Manhattan Distance = ',abs(x)+abs(y));
end.

