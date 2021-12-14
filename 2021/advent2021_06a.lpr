program advent2021_06a;
uses Math, MyStrings;

var
  src : text;
  s : string;
  count,oldcount : int64;
  daysleft : array[1..1000000] of int64;
  i : int64;
  day : int64;

begin
  assign(src,'advent2021_06a.txt');
  reset(src);

  readln(src,s);
  close(src);
  writeln(s);
  count := 0;
  while s <> '' do
  begin
    inc(count);
    daysleft[count] := GrabNumber(s);
  end;



  for i := 1 to count do
    Write(daysleft[i],',');
  WriteLn;

  for day := 1 to 80 do
    begin
      oldcount := count;
      for i := 1 to count do
        begin
          dec(daysleft[i]);
          if daysleft[i] < 0 then
          begin
            daysleft[i] :=6;
            inc(count);
            daysleft[count] := 8;
          end; // if
        end; // for i
      write('Day ',day,' ');
      for i := 1 to count do
        Write(daysleft[i],',');

      WriteLn(' Count = ',Count);;
      end;

  readln;
end.

