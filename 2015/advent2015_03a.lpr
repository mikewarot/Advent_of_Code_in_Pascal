program advent2015_03a;

var
  houses : array[-500..500] of array[-500..500] of integer;
  src   : text;
  s     : string;
  count : integer;
  x,y   : integer;
  i,j,k : integer;
begin
  for x := -500 to 500 do
    for y := -500 to 500 do
      houses[x,y] := 0;

  x := 0;
  y := 0;
  houses[0,0] := 1; // initial house gets a present, always
  assign(src,'advent2015_03a.txt');
  reset(src);
  while not eof(src) do
  begin
    readln(src,s);
    for i := 1 to length(s) do
      case s[i] of
        '>' : begin   inc(x);   inc(houses[x,y]); end;
        '^' : begin   inc(y);   inc(houses[x,y]); end;
        '<' : begin   dec(x);   inc(houses[x,y]); end;
        'v' : begin   dec(y);   inc(houses[x,y]); end;
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

