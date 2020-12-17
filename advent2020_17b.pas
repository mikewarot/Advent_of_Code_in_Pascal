program advent2020_17b;
uses
  classes, sysutils, dateutils;

// given a string, eats delimiters and gets a positive integer
// string is shorter after call


var
  Space,OldSpace : array[-20..20] of array[-20..20] of array[-20..20] of array[-20..20] of integer;
  ActiveCount    : integer;

procedure cycle;
var
  count : integer;
  w,x,y,z,
  dw,dx,dy,dz   : integer;
begin
  oldspace := space;
  for w := -20 to 20 do
    for x := -20 to 20 do
      for y := -20 to 20 do
        for z := -20 to 20 do
          space[w,x,y,z] := 0;

  activecount := 0;
  for w := -19 to 19 do
    for x := -19 to 19 do
      for y := -19 to 19 do
        for z := -19 to 19 do
        begin
          count := 0;
          for dw := -1 to 1 do
            for dx := -1 to 1 do
              for dy := -1 to 1 do
                for dz := -1 to 1 do
                  count := count+oldspace[w+dw,x+dx,y+dy,z+dz];
          count := count-oldspace[w,x,y,z];
          if oldspace[w,x,y,z] = 0 then
          begin
            if count = 3 then
              space[w,x,y,z] := 1;
          end
          else
          begin
            if (count>=2) and (count<=3) then
              space[w,x,y,z] := 1;
          end;
          activecount := activecount + space[w,x,y,z];
        end;
end;

var
  StartTime  : TDateTime;
  s          : string;
  Turn,i,j,k,n  : uint64;
  W,X,Y,Z : Integer;
begin
  StartTime := Now;
  for w := -20 to 20 do
    for x := -20 to 20 do
      for y := -20 to 20 do
        for z := -20 to 20 do
          space[w,x,y,z] := 0;

  y := 0;
  repeat
    readln(s);
    inc(y);
    for x := 1 to length(s) do
      if s[x] = '#' then
        space[0,x,y,0] := 1;
  until eof;

  for i := 1 to 1000 do
  begin
    for x := 1 to 5 do
    begin
      for y := 1 to 5 do
        if space[0,x,y,0] <> 0 then write('#') else write('.');
      writeln;
    end;

    cycle;
    writeln('Active Count = ',activecount);
  end;

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
end.

