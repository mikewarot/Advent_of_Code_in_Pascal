program advent2015_01a;
var
  src   : text;
  x     : string;
  floor : integer;
  i     : integer;
  count : integer;
begin
  floor := 0;
  count := 0;
  assign(src,'advent2015_01a.txt');
  reset(src);
  while not eof(src) do
  begin
    readln(src,x);
    for i := 1 to length(x) do
      case x[i] of
        '(' : begin  inc(count); inc(floor); end;
        ')' : begin  inc(count); dec(floor); if (floor=-1) then writeln('basement at count ',count);end;
      end;

    writeln(x);
  end;
  close(src);
  WriteLn('Ending floor --> ',floor);
end.

