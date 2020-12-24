program advent2020_24a;
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
  grid        : array[-100..100] of array[-100..100] of integer;
  upcount     : integer;

begin
  StartTime := Now;

  for x := -100 to 100 do
    for y := -100 to 100 do
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

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
end.

