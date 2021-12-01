program advent2021_01a;
var
  x,old_x : integer;
  up,down,neutral : integer;
begin
  up := 0;
  down := 0;
  neutral := 0;
  readln(old_x);
  while not eof do
  begin
    readln(x);
    if x > old_x then inc(up);
    if x < old_x then inc(down);
    if x = old_x then inc(neutral);
    old_x := x;
  end;
  writeln('Up counts : ',up);
  writeln('Down      : ',down);
  Writeln('Neutral   : ',neutral);
end.

