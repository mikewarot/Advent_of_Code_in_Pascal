program advent2021_01b;
var
  x,old,older,oldest : integer;
  up,down,neutral : integer;
begin
  up := 0;
  down := 0;
  neutral := 0;
  readln(oldest);
  readln(older);
  readln(old);
  while not eof do
  begin
    readln(x);
    if x > oldest then inc(up);
    if x < oldest then inc(down);
    if x = oldest then inc(neutral);
    oldest := older;
    older  := old;
    old := x;
  end;
  writeln('Up counts : ',up);
  writeln('Down      : ',down);
  Writeln('Neutral   : ',neutral);
end.

