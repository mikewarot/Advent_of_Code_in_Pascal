program advent2021_15b;
uses Classes, Math, MyStrings, fgl;

var
  src : text;
  s,t : string;
  i,j,k,x,y,z : integer;
  risk,grid : array[0..1000] of array[0..1000] of int64;

  maxX,maxY : Integer;
  a,b,c,d : integer;


begin
  for i := 0 to 1000 do
    for j := 0 to 1000 do
      grid[i,j] := 0;

  for i := 0 to 1000 do
    for j := 0 to 1000 do
      risk[i,j] := 999999;

  assign(src,'advent2021_15_input.txt');
  reset(src);

  maxY := 0;
  while not eof(src) do
  begin
    readln(src,s);
    inc(maxY);
    maxX := length(s);
    for i := 1 to maxX do
      grid[i,maxY] := ord(s[i])-ord('0');
    writeln(s);
  end;
  close(src);

  for i := 1 to 4 do
    for x := 1 to MaxX do
      for y := 1 to MaxY do
        grid[(i*maxx)+x,y] := ((i+grid[x,y]-1) mod 9)+1;

  MaxX := MaxX * 5;

  for i := 1 to 4 do
    for x := 1 to MaxX do
      for y := 1 to MaxY do
        grid[x,(i*maxy)+y] := ((i+grid[x,y]-1) mod 9)+1;

  MaxY := MaxY * 5;

  writeln('Grid Size - (',MaxX,',',MaxY,')');

  risk[MaxX,MaxY] := Grid[MaxX,MaxY];

  for i := 1 to MaxX*10 do
    for x := 1 to MaxX do
      for y := 1 to MaxY do
        begin
          a := 999999; if x < MaxX then a := risk[x+1,Y]+grid[x,y];
          b := 999999; if y < MaxY then b := risk[x,Y+1]+grid[x,y];
          c := 999999; if x > 1 then c := risk[x-1,Y]+grid[x,y];
          d := 999999; if y > 1 then d := risk[x,y-1]+grid[x,y];
          z := 999999;
          if a < z then z := a;
          if b < z then z := b;
          if c < z then z := c;
          if d < z then z := d;
          if (x = MaxX) AND (y = MaxY) then
            z := grid[x,y];
          risk[x,y] := z;
        end; // for y

  writeln('Risk(1,1) = ',Risk[1,1]);
  for y := 1 to MaxY do
  begin
    for x := 1 to MaxX do
      write(Grid[x,y]);
    writeln;
  end;

  WriteLn('Path risk = ',Risk[1,1]-Grid[1,1]);

  readln;
end.

