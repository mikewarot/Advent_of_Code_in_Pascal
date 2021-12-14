program advent2021_14b;
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

  pairs,oldpairs : array[0..25] of array[0..25] of int64;
  match : integer;

  last : integer;


begin
  count := 0;
  assign(src,'advent2021_14_input.txt');
  reset(src);

  readln(src,base);
  last := ord(base[length(base)])-ord('A');
  readln(src,s);

  while not eof(src) do
  begin
    inc(count);
    readln(src,rule[count]);
  end;
  close(src);

  writeln(Count,' rules loaded');
  writeln('Base --> ',Base);

  for i := 0 to 25 do
    for j := 0 to 25 do
      pairs[i,j] := 0;

  for i := 1 to length(base)-1 do
  begin
    j := ord(base[i])-ord('A');
    k := ord(base[i+1])-ord('A');
    inc(pairs[j,k]);
  end;

  for iteration := 1 to 40 do
  begin
    oldpairs := pairs;
    for i := 0 to 25 do
      for j := 0 to 25 do
        pairs[i,j] := 0;

    for i := 0 to 25 do
      for j := 0 to 25 do
      begin
        match := 0;
        for k := 1 to count do
          if ((ord(rule[k][1])-ord('A')) = i) AND ((ord(rule[k][2])-ord('A')) = j) then
            match := k;
        if match = 0 then
          inc(pairs[i,j],oldpairs[i,j])
        else
          begin
            inc(pairs[i,ord(rule[match][7])-ord('A')],oldpairs[i,j]);
            inc(pairs[ord(rule[match][7])-ord('A'),j],oldpairs[i,j]);
          end;
      end;

  end;

  for i := 0 to 25 do
    Counts[i] := 0;

  for i := 0 to 25 do
    for j := 0 to 25 do
      begin
        inc(counts[i],pairs[i,j]);
      end;

  inc(counts[last]); // the last character never changes

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

