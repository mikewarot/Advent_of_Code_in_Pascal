program advent2021_22a;
uses sysutils, dateutils, mystrings;
const
  limit = 50;

var
  StartTime   : TDateTime;
  Src : Text;
  S : String;
  grid : array[-limit..limit] of array[-limit..limit] of array[-limit..limit] of int64;

  i,j,k : int64;
  x,y,z : int64;
  x1,x2,y1,y2,z1,z2 : int64;
  T,count : int64;

begin
  StartTime := Now;
  fillchar(grid,sizeof(grid),0);
//  assign(src,'advent2021_22_sample.txt');
  assign(src,'advent2021_22.txt');
  reset(src);
  while not eof(src) do
  begin
    readln(src,s);
    t := 0;
    if GrabString(s) = 'on' then t := 1;
    Expect(' x=',s); x1 := grabnumber(S);  expect('..',s);  x2 := grabnumber(s);
    Expect(',y=',s); y1 := grabnumber(S);  expect('..',s);  y2 := grabnumber(s);
    Expect(',z=',s); z1 := grabnumber(S);  expect('..',s);  z2 := grabnumber(s);

//    writeln(s, X1,' ',X2,' ',Y1,' ',Y2,' ',Z1,' ',Z2);
    for x := x1 to x2 do
      if (x>=-limit) and (x <= limit) then
        for y := y1 to y2 do
          if (y>=-limit) and (y <= limit) then
            for z := z1 to z2 do
              if (z>=-limit) and (z <= limit) then
                grid[x,y,z] := t;

    count := 0;
    for x := -limit to limit do
      for y := -limit to limit do
        for z := -limit to limit do
          inc(count,grid[x,y,z]);

    writeln('Count = ',count);

  end;
  close(src);

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
  readln;
end.
