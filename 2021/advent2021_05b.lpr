program advent2021_05b;
uses Math, MyStrings;


var
  src : text;
  s : string;
  x1,x2,y1,y2 : integer;
  grid : array[0..1000] of array [0..1000] of integer;
  x,y : integer;
  hits : integer;
  delta,dx,dy : integer;
  i :integer;
begin
  assign(src,'advent2021_05_input.txt');
  reset(src);

  for x := 0 to 1000 do
    for y := 0 to 1000 do
      grid[x,y] := 0;

  while not eof(src) do
  begin
    readln(src,s);
    x1 := grabnumber(s);
    y1 := grabnumber(s);
    grabstring(s);  // toss away the -> in the middle
    x2 := grabnumber(s);
    y2 := grabnumber(s);

    if x1 = x2 then
      for y := min(y1,y2) to max(y1,y2) do
          inc(grid[x1,y]);

    if y1 = y2 then
      for x := min(x1,x2) to max(x1,x2) do
          inc(grid[x,y1]);

    if abs(x1-x2)=abs(y1-y2) then
    begin
      delta := abs(x2-x1);
      dx := (x2-x1) div delta;
      dy := (y2-y1) div delta;
      for i := 0 to delta do
        inc(grid[x1+(i*dx),y1+(i*dy)]);
    end;

    writeln(x1,',',y1,' -> ',x2,',',y2);

  end;
  close(src);

  hits := 0;
  for x := 0 to 1000 do
    for y := 0 to 1000 do
      if grid[x,y] > 1 then inc(hits);

  writeln('Total of ',hits,' intersections');
  readln;
end.

