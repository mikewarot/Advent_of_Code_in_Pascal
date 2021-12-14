program advent2015_03b;

var
  houses : array[-500..500] of array[-500..500] of integer;
  src   : text;
  s     : string;
  count : integer;
  x,y   : integer;
  xp,yp : array[0..1] of integer;
  id    : integer;
  i,j,k : integer;
begin
  for x := -500 to 500 do
    for y := -500 to 500 do
      houses[x,y] := 0;

  xp[0] := 0;  yp[0] := 0;
  xp[1] := 0;  yp[1] := 0;
  id := 0;
  houses[0,0] := 1; // initial house gets a present, always
  assign(src,'advent2015_03a.txt');
  reset(src);
  while not eof(src) do
  begin
    readln(src,s);
    for i := 1 to length(s) do
      case s[i] of
        '>' : begin   inc(xp[id]);   inc(houses[xp[id],yp[id]]); id := 1-id; end;
        '^' : begin   inc(yp[id]);   inc(houses[xp[id],yp[id]]); id := 1-id; end;
        '<' : begin   dec(xp[id]);   inc(houses[xp[id],yp[id]]); id := 1-id; end;
        'v' : begin   dec(yp[id]);   inc(houses[xp[id],yp[id]]); id := 1-id; end;
      end;
  end;
  close(src);
  count := 0;
  for x := -500 to 500 do
    for y := -500 to 500 do
      if (houses[x,y] <> 0) then
        inc(count);
  writeln('Total of ',count,' houses received presents');
end.

