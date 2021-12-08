program advent2021_07b;
uses Math, MyStrings;

var
  src : text;
  s : string;
  n : array[1..100000] of int64;
  count : int64;
  sum : int64;
  low,high : int64;
  i,j,k : int64;
  lowest : int64;
  lowsum : int64;

  function fuelcost(n : int64):int64;
  begin
    fuelcost := (n*(n+1)) div 2;
  end;

begin
  assign(src,'advent2021_07a_input.txt');
  reset(src);

  while not eof(src) do
  begin
    readln(src,s);
    writeln(s);
  end;
  close(src);
  count := 0;
  while s<>'' do
  begin
    inc(count);
    n[count] := grabnumber(s);
  end;

  low := n[1];
  high := n[1];
  for i := 1 to count do
  begin
    low  := min(low,n[i]);
    high := max(high,n[i]);
  end;

  lowest := 0;
  lowsum := 0;

  for i := low to high do
  begin
    sum := 0;
    for j := 1 to count do
      sum := sum + fuelcost(abs(n[j]-i));
    WriteLn(i,' : ',sum);
    if (i = 1) or (sum < lowsum) then
    begin
      lowest := i;
      lowsum := sum;
    end;
  end;

  Writeln('Position : ',lowest);
  WriteLn('Fuel     : ',lowsum);

  readln;
end.

