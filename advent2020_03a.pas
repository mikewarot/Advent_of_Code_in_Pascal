program advent2020_03a;

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
  trees : array[0..999] of array[0..999] of integer;
  x,y   : integer;
  width,height : integer;
  s     : string;
  c     : char;
  count : integer;
begin
  for x := 0 to 999 do
    for y := 0 to 999 do
      trees[x,y] := 0;

  width := 0;
  height := 0;
  readln(s);
  while s <> '' do
  begin
    x := 0;
    y := height;
    for c in s do
      case c of
        '#' : begin   trees[x,y] := 1;  inc(x); end;
        '.' : inc(x);
      end;
    if x > width then width := x;
    writeln('[',s,']');
    inc(Height);
    readln(s);
  end;
  writeln(Height,' columns and ',width,' rows');
  x := 0;
  y := 0;
  count := 0;
  repeat
    inc(x,3);  if x >= width then x := x-width;
    inc(y);
    writeln(x,',',y,',',trees[x,y]);
    count := count + trees[x,y];
  until y >= height;
  writeln('There were ',count,' trees encountered');
  readln;
end.

