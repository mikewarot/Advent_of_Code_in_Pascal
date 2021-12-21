program advent2021_20a;
uses Sysutils, MyStrings, Classes, fgl;
// Conway's game of life, brought to you by Advent of Code 2021

const
  hardlimit = 1000;
var
  grid,oldgrid : array[-hardlimit..hardlimit] of array[-hardlimit..hardlimit] of integer;
  minx,miny,maxx,maxy : integer;
  rule  : array[0..511] of integer;
  limit : integer;

  function Count: int64;
  var
    x,y,c : int64;
  begin
    c := 0;
    for x := -limit to limit do
      for y := -limit to limit do
        c := c + grid[x,y];
    count := c;
  end;

  procedure dump;
  var
    x,y,c : int64;
  begin
    c := 0;
    minx := limit;
    miny := limit;
    maxx := -limit;
    maxy := -limit;

    for y := -limit to limit do
      for x := -limit to limit do
        if grid[x,y] <> 0 then
        begin
          inc(c);
          if x < minx  then minx := x;
          if y < miny  then miny := y;
          if x > maxx  then maxx := x;
          if y > maxy  then maxy := y;
        end;

    for y := miny to maxy do
    begin
      for x := minx to maxy do
        if grid[x,y] = 1 then
          write('#')
        else
          write('.');
      writeln;
    end;
    writeln('Total of ',c,' bits set');
  end;

  procedure Iterate;
  var
    x,y,c : integer;
    dx,dy : integer;
  begin
    dec(limit); // ignore the outer edge
    oldgrid := grid;
    for y := -limit to limit do
      for x := -limit to limit do
        begin
          c := 0;
          for dy := -1 to 1 do
            for dx := -1 to 1 do
              c := c + c + oldgrid[x+dx,y+dy];
          grid[x,y] := rule[c];
        end; // for y
  end;

var
  src : text;
  s   : string;


  i,j,k,l,n,x,y,z : integer;
  t : integer;


begin
  limit := hardlimit;
  for x := -limit to limit do
    for y := -limit to limit do
      grid[x,y] := 0;

//  assign(src,'Advent2021_20_sample.txt');
  assign(src,'Advent2021_20.txt');
  reset(src);
  readln(src,s);
  if length(s) <> 512 then
  begin
    writeln('Wrong rule length');
    Exit;
  end
  else
  begin
    for i := 1 to 512 do
    case s[i] of
      '.' : rule[i-1] := 0;
      '#' : rule[i-1] := 1;
    else
      WriteLn('Invalid rule char [',s[i],']');
    end; // case
  end;

  x:= 0;
  y:= 0;
  while not eof(src) do
  begin
    readln(src,s);
    if s<> '' then
    begin
      inc(y);
      for x := 1 to length(s) do
        case s[x] of
          '.' : grid[x,y] := 0;
          '#' : grid[x,y] := 1;
        else
          WriteLn('Invalid data char [',s[i],']');
        end; // case
    end; // if s <> ''
  end; // while not eof
  close(src);

//  dump;

  WriteLn('Grid Loaded, ',Count,' bits set');
  for t := 1 to 50 do
  begin
    iterate;
    WriteLn('Iteration : ',t,', ',Count,' bits set');
  end;
  dump;

  readln;  // wait for user to hit enter, otherwise window goes away
end.
