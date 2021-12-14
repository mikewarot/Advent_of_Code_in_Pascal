program advent2021_03a;

  procedure SkipSpace(Var S : String);
  begin
    While (S <> '') AND (S[1] in [' ',#9,#13,#10]) do
      delete(s,1,1);
  end;

  function GrabString(Var S : String): String;
  var
    t : string;
  begin
    t := '';
    SkipSpace(S);
    while (s <> '') AND NOT(S[1] in [' ',#9,#13,#10]) do
    begin
      t := t + s[1];
      delete(s,1,1);
    end;
    GrabString := T;
  end;

  function GrabNumber(Var S : String): Int64;
  var
    sign : int64;
    x    : Int64;
  begin
    sign := +1;
    x := 0;
    SkipSpace(S);
    if (s <> '') and (s[1] = '-') then
    begin
      sign := -1;
      delete(s,1,1);
    end;
    while (s <> '') AND (s[1] in ['0'..'9']) do
    begin
      x := x * 10;
      x := x + (ord(s[1])-ord('0'));
      delete(s,1,1);
    end;
    GrabNumber := X;
  end;


var
  s : string;
  bits : array[1..100] of int64;
  i,j,k : int64;
  count : int64;

  avg : array[1..100] of int64;
  gamma, epsilon : int64;


begin
  count := 0;
  for i := 1 to 100 do
    bits[i] := 0;
  while not eof do
  begin
    readln(s);
    inc(count);
    for i := 1 to length(s) do
      if s[i] = '1' then inc(bits[i]);

    writeln(count,' ',s);
  end;
  gamma := 0;
  epsilon := 0;

  for i := 1 to length(s) do
  begin
    if (bits[i] > (count-bits[i])) then
      avg[i] := 1
    else
      avg[i] := 0;
    gamma := (gamma*2) + avg[i];
    epsilon := (epsilon*2) + (1-avg[i]);

    WriteLn('Bit[',i,'] ',bits[i]);
  end;
  WriteLn('Gamma = ',Gamma);
  WriteLn('Epsilon = ',Epsilon);
  WriteLn('Power = ',Gamma*Epsilon);
  WriteLn('Done');
end.

