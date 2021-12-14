program advent2020_24b;
uses
  sysutils, dateutils;


var
  StartTime   : TDateTime;
  s           : string;
  i           : integer;
  target      : array[1..1000] of array[1..2] of integer;
  targetCount : integer;
  x,y         : integer;
  eat         : integer;
  grid,
  oldgrid     : array[-1000..1000] of array[-1000..1000] of integer;

  upcount     : integer;
  nCount      : integer;
  count       : integer;
  turn        : integer;
  minx,maxx,
  miny,maxy   : integer;

begin
  StartTime := Now;

  for x := -1000 to 1000 do
    for y := -1000 to 1000 do
      grid[x,y] := 0;
  TargetCount := 0;
  UpCount := 0;

  repeat
    readln(S);
    Inc(TargetCount);
    Write(TargetCount:4,' ');

    x := 0;
    y := 0;
    while s <> '' do
      begin
        eat := 1;
        case s[1] of
          'e' : inc(x,2);
          'w' : dec(x,2);
          'n' : begin
                  inc(y,1);
                  case s[2] of
                    'e' : inc(x,1);
                    'w' : dec(x,1);
                  end;
                  eat := 2;
                end;
          's' : begin
                  dec(y,1);
                  case s[2] of
                    'e' : inc(x,1);
                    'w' : dec(x,1);
                  end;
                  eat := 2;
                end;
          end;  // case s[1]
          write(copy(s,1,eat),' ');
          delete(s,1,eat);
      end; // while s <> '' do
    target[targetcount,1] := x;
    target[targetcount,2] := y;
    grid[x,y] := 1 - grid[x,y];
    upcount := upcount -1 + (grid[x,y]*2);
    WriteLn('(',x,',',y,') = ',grid[x,y],' ',upcount);

  until eof;

  writeln;
  writeln('Life Tiles part');
  writeln;

  for turn := 1 to 100 do
    begin
      oldgrid := grid;
      upcount := 0;
      minx := 1000; maxx := -1000;
      miny := 1000; maxy := -1000;
      for x := -998 to 998 do
        for y := -998 to 998 do
          if ((x+Y+3000) mod 2) = 0 then  { only do even rows of even or odd rows of odd }
            begin
              ncount := oldgrid[x-2,y]   +  // west
                        oldgrid[x-1,y+1] +  // nw
                        oldgrid[x+1,y+1] +  // ne
                        oldgrid[x+2,y]   +  // e
                        oldgrid[x+1,y-1] +  // se
                        oldgrid[x-1,y-1];   // sw
              if oldgrid[x,y] = 1 then
                begin
                  if (ncount = 0) or (ncount > 2) then
                    grid[x,y] := 0;
                end
              else
                begin
                  if (ncount = 2) then
                    grid[x,y] := 1;
                end;
              inc(upcount,grid[x,y]);
              if grid[x,y] = 1 then
                begin
                  if x < minx  then minx := x;
                  if y < miny  then miny := y;
                  if x > minx  then maxx := x;
                  if y > miny  then maxy := y;
                end;
            end;
      writeln('Turn ',turn,' Total of ',upcount,' tiles now Black', minx,',',maxy,',',miny,',',maxy);

      writeln;
      writeln('Visualization part');
      writeln;
      for y := miny-1 to maxy+1 do
        begin
          write(y:4);
          for x := minx-1 to maxx+1 do
            if grid[x,y]+grid[x+1,y] > 0 then
              write('*')
            else
              write('.');
          writeln;
        end;
      writeln;
    end;

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
end.

