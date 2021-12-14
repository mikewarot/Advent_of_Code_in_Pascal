program advent2020_03b;

var
  trees : array[0..999] of array[0..999] of integer;
  width,height : integer;

  function treecount(dx,dy : integer):integer;
  var
    x,y,count : integer;
  begin
    x := 0;
    y := 0;
    count := 0;
    repeat
      inc(x,dx);  if x >= width then x := x-width;
      inc(y,dy);
      count := count + trees[x,y];
    until y >= height;
    treecount := count;
  end;


var
  x,y   : integer;
  s     : string;
  c     : char;
  count : integer;
  h,i,j,k,l : integer;

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

  h := treecount(1,1);
  i := treecount(3,1);
  j := treecount(5,1);
  k := treecount(7,1);
  l := treecount(1,2);
  writeln(h,',',i,',',j,',',k,',',l,',',h*i*j*k*l);
  readln;
end.

