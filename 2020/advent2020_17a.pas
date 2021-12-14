program advent2020_17a;
uses
  classes, sysutils, dateutils;

// given a string, eats delimiters and gets a positive integer
// string is shorter after call


var
  Space,OldSpace : array[-100..100] of array[-100..100] of array[-100..100] of integer;
  ActiveCount    : integer;

procedure cycle;
var
  count : integer;
  x,y,z,
  dx,dy,dz   : integer;
begin
  oldspace := space;
  for x := -100 to 100 do
    for y := -100 to 100 do
      for z := -100 to 100 do
        space[x,y,z] := 0;

  activecount := 0;
  for x := -99 to 99 do
    for y := -99 to 99 do
      for z := -99 to 99 do
      begin
        count := 0;
        for dx := -1 to 1 do
          for dy := -1 to 1 do
            for dz := -1 to 1 do
              count := count+oldspace[x+dx,y+dy,z+dz];
        count := count-oldspace[x,y,z];
        if oldspace[x,y,z] = 0 then
        begin
          if count = 3 then
            space[x,y,z] := 1;
        end
        else
        begin
          if (count>=2) and (count<=3) then
            space[x,y,z] := 1;
        end;
        activecount := activecount + space[x,y,z];
      end;
end;

var
  StartTime  : TDateTime;
  s          : string;
  Turn,i,j,k,n  : uint64;
  X,Y,Z : Integer;
begin
  StartTime := Now;
  for x := -100 to 100 do
    for y := -100 to 100 do
      for z := -100 to 100 do
        space[x,y,z] := 0;

  y := 0;
  repeat
    readln(s);
    inc(y);
    for x := 1 to length(s) do
      if s[x] = '#' then
        space[x,y,0] := 1;
  until eof;

  for i := 1 to 6 do
  begin
    for x := 1 to 5 do
    begin
      for y := 1 to 5 do
        if space[x,y,0] <> 0 then write('#') else write('.');
      writeln;
    end;

    cycle;
    writeln('Active Count = ',activecount);
  end;

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
end.

