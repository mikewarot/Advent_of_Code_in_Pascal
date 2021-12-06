program advent2021_06b;
uses Math, MyStrings;

var
  src : text;
  s : string;
  count,oldcount : int64;
  daysleft : array[0..8] of int64;
  i,z : int64;
  day : int64;

begin
  assign(src,'advent2021_06a.txt');
  reset(src);

  for i := 0 to 8 do
    daysleft[i] := 0;

  readln(src,s);
  close(src);
  writeln(s);
  count := 0;
  while s <> '' do
  begin
    inc(count);
    inc(daysleft[GrabNumber(s)]);
  end;

  for i := 0 to 8 do
    Write(daysleft[i],',');
  WriteLn;

  for day := 1 to 256 do
    begin
      Z :=daysleft[0];
      for i := 0 to 7 do
        daysleft[i] := daysleft[i+1];
      inc(daysleft[6],z);
      daysleft[8] := z;

      Count := 0;
      write('Day ',day,' ');
      for i := 0 to 8 do
        begin
          Write(daysleft[i],',');
          inc(count,daysleft[i]);
        end;

      WriteLn(' Count = ',Count);;
      end;

  readln;
end.

