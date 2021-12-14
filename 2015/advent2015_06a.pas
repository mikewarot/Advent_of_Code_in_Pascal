program advent2015_06a;

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

var
  lights : array[0..999] of array[0..999] of integer;

procedure turn_off(x1,y1,x2,y2 : integer);
var
  x,y : integer;
begin
  for x := x1 to x2 do
    for y := y1 to y2 do
      lights[x,y] := 0;
end;

procedure turn_on(x1,y1,x2,y2 : integer);
var
  x,y : integer;
begin
  for x := x1 to x2 do
    for y := y1 to y2 do
      lights[x,y] := 1;
end;

procedure toggle(x1,y1,x2,y2 : integer);
var
  x,y : integer;
begin
  for x := x1 to x2 do
    for y := y1 to y2 do
      lights[x,y] := 1 - lights[x,y];
end;

var
  s,t   : string;
  a,b,c,d : integer;
  count,i,j,k : integer;

begin
  turn_off(0,0,999,999);

  readln(s);
  while s <> '' do
  begin
    t := s;  // save the old value
    a := getnum(s);
    b := getnum(s);
    c := getnum(s);
    d := getnum(s);
    if pos('off',t)     <> 0 then turn_off(a,b,c,d);
    if pos('on',t)      <> 0 then turn_on(a,b,c,d);
    if pos('toggle',t)  <> 0 then toggle(a,b,c,d);

    count := 0;
    for i := 0 to 999 do
      for j := 0 to 999 do
        if lights[i,j] <> 0 then inc(count);
    writeln(count,' lights on');
    readln(s);
  end;
end.

