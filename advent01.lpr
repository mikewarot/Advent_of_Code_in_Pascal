program advent01;
var
  src : text;
  s : string;
  data : array[1..1000] of integer;
  i,j,k : integer;
  x : integer;
  sum, prod : integer;
  count : integer;

begin
  assign(src,'input01.txt');
  reset(src);
  count := 0;
  while not eof(src) do
  begin
    inc(count);
    readln(src,x);
    writeln(x);
    data[count] := x;
  end;
  close(src);
  writeln(Count,' entries read');
  for i := 1 to count-1 do
    for j := i+1 to count do
      if (data[i]+data[j]) = 2020 then
        writeln(data[i],',',data[j],',',data[i]*data[j]);
end.
