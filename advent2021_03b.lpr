program advent2021_03b;

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
  lines : array[1..1000] of string;
  CO2,O2 : array[1..1000] of boolean;

  thisbit : integer;
  keep : char;
  Got0,Got1 : int64;
  O2Gen,CO2Gen : int64;


begin
  count := 0;
  for i := 1 to 100 do
    bits[i] := 0;
  while not eof do
  begin
    readln(s);
    inc(count);
    lines[count] := s;
    for i := 1 to length(s) do
      if s[i] = '1' then inc(bits[i]);

    writeln(count,' ',s);
  end;

  for i := 1 to count do
  begin
    CO2[i] := true;
    O2[i] := true;
  end;

  thisbit := 0;
  repeat
    inc(ThisBit);
    Got0 := 0;
    Got1 := 0;
    for i := 1 to count do
      if O2[i] then
      begin
        if lines[i][thisbit] = '1' then inc(Got1) else inc(Got0);
      end;
    if Got1 >= Got0 then
      keep := '1'
    else
      keep := '0';

    for i := 1 to count do
      O2[i] := O2[i] AND (lines[i][thisbit] = keep);
    k := 0;
    for i := 1 to count do
      if O2[i] then inc(k);
  until k=1;

  for i := 1 to count do
    if O2[i] then
    begin
      O2gen := 0;
      for j := 1 to length(s) do
        O2gen := (O2gen*2)+ord(lines[i][j])-ord('0');
      WriteLn('O2 = ',lines[i]);
    end;

  thisbit := 0;
  repeat
    inc(ThisBit);
    Got0 := 0;
    Got1 := 0;
    for i := 1 to count do
      if CO2[i] then
      begin
        if lines[i][thisbit] = '1' then inc(Got1) else inc(Got0);
      end;
    if Got1 >= Got0 then
      keep := '0'
    else
      keep := '1';

    for i := 1 to count do
      CO2[i] := CO2[i] AND (lines[i][thisbit] = keep);
    k := 0;
    for i := 1 to count do
      if CO2[i] then inc(k);
  until k=1;

  for i := 1 to count do
    if CO2[i] then
    begin
      CO2gen := 0;
      for j := 1 to length(s) do
        CO2gen := (CO2gen*2)+ord(lines[i][j])-ord('0');
      WriteLn('CO2 = ',lines[i]);
    end;


  WriteLn('Life Support = ',O2Gen*CO2Gen);

end.

