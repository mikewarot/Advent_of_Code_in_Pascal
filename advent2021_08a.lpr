program advent2021_08a;
uses Math, MyStrings;

var
  src : text;
  s1,s2 : string;
  count : integer;
  i,j,k : integer;
  z : string;

begin
  assign(src,'advent2021_08a_input.txt');
  reset(src);

  count := 0;
  while not eof(src) do
  begin
    readln(src,s2);
    writeln(s2);
    for i := 1 to 11 do
      z := grabstring(s2);

    for i := 1 to 4 do
    begin
      z := grabstring(s2);
      write(z);
      if length(z) in [2,3,4,7] then
        inc(count);
    end;  // for i
    writeln;

  end;
  close(src);
  writeln('Count = ',Count);

  readln;
end.

