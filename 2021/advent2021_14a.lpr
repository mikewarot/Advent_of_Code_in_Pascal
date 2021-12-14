program advent2021_14a;
uses Classes, Math, MyStrings, fgl;

var
  src : text;
  s,t : string;
  i,j,k : integer;
  base,next : string;

  rule   : array[1..1000] of string;
  count : integer;
  insert : string;

  Iteration : int64;
  Counts : Array[0..25] of int64;
  Min,Max : int64;

begin
  count := 0;
  assign(src,'advent2021_14_input.txt');
  reset(src);

  readln(src,base);
  readln(src,s);

  while not eof(src) do
  begin
    inc(count);
    readln(src,rule[count]);
  end;
  close(src);

  writeln(Count,' rules loaded');
  writeln('Base --> ',Base);


  for iteration := 1 to 10 do
  begin
    next := '';
    while length(base) >= 2 do
    begin
      insert := '';
      for i := 1 to count do
        if (rule[i][1] = base[1]) AND (rule[i][2] = base[2]) then
          insert := rule[i][7];

      next := next + base[1] + insert;
      delete(base,1,1);
    end;
    next := next + base;
    WriteLn('Iteration : ',Iteration,'  length = ',length(next),' ',copy(next,1,20));
    base := next;
  end;

  for i := 0 to 25 do
    Counts[i] := 0;

  for i := 1 to length(base) do
    inc(counts[ord(base[i])-ord('A')]);

  max := 0;
  for i := 0 to 25 do
    if counts[i] > max then max := counts[i];
  min := max;
  for i := 0 to 25 do
    if (counts[i] <> 0) AND (counts[i] < min) then min := counts[i];

  WriteLn('Max = ',max);
  WriteLn('Min = ',Min);
  WriteLn('Delta = ',Max-Min);

  readln;
end.

