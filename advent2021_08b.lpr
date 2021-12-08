program advent2021_08b;
uses Math, MyStrings;
type
  t7 = set of 'a'..'g';
  t10 = set of 0..9;

var
  src : text;
  s1,s2 : string;
  count : integer;
  i,j,k : integer;
  z : string;

  sample : array[1..10] of t7;
  options : array[1..10] of t10;
  digits  : array[1..4] of t7;

  n : array[0..9] of integer;

  segments : array[0..9] of t7;

  ll : integer;
  c : char;
  old_a,old_b,old_c,old_d,old_e,old_f,old_g : t7;
  linesum,linenumber : int64;

  function ToT7(s : string):t7;
  var
    zz : t7;
    c : char;
  begin
    zz := [];
    for c in s do
      zz := zz + [c];
    ToT7 := zz;
  end;


begin
  assign(src,'advent2021_08a_input.txt');
  reset(src);

  count := 0;
  LineSum := 0;
  while not eof(src) do
  begin
    readln(src,s2);
    for i := 1 to 10 do
      sample[i] := ToT7(grabstring(s2));
    z := grabstring(s2);

    for i := 1 to 4 do
      digits[i] := ToT7(grabstring(s2));

    for i := 0 to 9 do
      n[i] := -1;

    for i := 1 to 10 do
    begin
      options[i] := [];
      k := 0;
      for c in sample[i] do
        inc(k);
      case k of
        2 : begin options[i] := [1];  n[1] := i; end;
        3 : begin options[i] := [7];  n[7] := i; end;
        4 : begin options[i] := [4];  n[4] := i; end;
        5 : options[i] := [2,3,5];
        6 : options[i] := [0,6,9];
        7 : begin options[i] := [8];  n[8] := i; end;
      end; // case k
    end;

    old_a := sample[n[7]] - sample[n[1]];

    for i := 1 to 10 do
      if (6 in options[i]) then
      begin
        if (sample[i] + sample[n[1]]) <> (sample[i]) then
        begin
          options[i] := [6];
          n[6] := i;
        end
        else
        begin
          options[i] := [0,9];
          if sample[i]+sample[n[4]] <> sample[i] then
          begin
            options[i] := [0];
            n[0] := i;
          end
          else
          begin
            options[i] := [9];
            n[9] := i;
          end; // if sample[i]
        end; // else begin
      end; // if (6 in options

    old_f := sample[n[6]]*sample[n[1]];   // intersection of sets

    for i := 1 to 10 do
      if (3 in options[i]) then
      begin
        if (sample[i]+sample[n[1]]) = sample[i] then
        begin
          options[i] := [3];
          n[3] := i;
        end
        else
        begin
          options[i] := [2,5];
          if (sample[i] + old_f) = sample[i] then
          begin
            options[i] := [5];
            n[5] := i;
          end
          else
          begin
            options[i] := [2];
            n[2] := i;
          end;
        end;
      end; // if 3 in options

    for i := 1 to 10 do
    begin
      for c in sample[i] do
        write(c);
      write(' ');
      for k in options[i] do
        write(k,' ');
      write('   ');
    end; // for i

    writeln;
    linenumber := 0;

    for i := 1 to 4 do
    begin
      linenumber := linenumber * 10;
      for j := 0 to 9 do
        if sample[n[j]] = digits[i] then
        begin
          write(j);
          linenumber := linenumber+j;
        end;
    end;

    writeln(' Line Number = ',LineNumber);
    LineSum := LineSum + LineNumber;
  end;
  close(src);
  writeln('Count = ',Count);
  Writeln('LineSum = ',LineSum);

  readln;
end.

