program advent2021_11b;
uses Math, MyStrings, fgl;

var
  grid : array[0..1000] of array[0..1000] of integer;
  count,hits : int64;

  procedure Bump(X,Y : Integer);
  var
    dx,dy : integer;
  begin
    if grid[x,y] <> 0 then
    begin
      if grid[x,y] > 9 then
      begin
        grid[x,y] := 0;
        inc(hits);
        for dx := -1 to 1 do
          for dy := -1 to 1 do
            If Grid[x+dx,y+dy] <> 0 then
            begin
              inc(Grid[x+dx,y+dy]);
              Bump(x+dx,y+dy);  // recurse
            end;
      end; // if grid
    end; // if grid
  end; // Bump

  procedure Step;
  var
    i,j : integer;
  begin
    for i := 1 to count do
      for j := 1 to count do
        inc(grid[i,j]);
    for i := 1 to count do
      for j := 1 to count do
        bump(i,j);
  end;

var
  src : text;
  s,t : string;
  i,j,k : integer;
  x,y,z : integer;
  all : boolean;

begin
  for i := 0 to 1000 do
    for j := 0 to 1000 do
      grid[i,j] := 0;

  count := 0;
  hits := 0;

  assign(src,'advent2021_11a_input.txt');
  reset(src);

  while not eof(src) do
  begin
    readln(src,s);

    inc(count);
    for i := 1 to length(s) do
      grid[count,i] := ord(s[i])-ord('0');

  end; // while not eof(src)
  close(src);

  z := 0;
  repeat
    inc(z);
    writeln('Step ',z);
    step;
    all := true;
    for i := 1 to count do
    begin
      for j := 1 to length(s) do
      begin
        write(grid[i,j]);
        if grid[i,j] <> 0 then all := false;
      end;
      writeln;
    end;
    writeln('Hits = ',Hits);
  until all;

  readln;
end.

