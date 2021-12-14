program advent2015_15a;
uses
  mystrings;

var
  src : text;
  s : string;
  name : array[1..100] of string;
  factor : array[1..100] of array[1..5] of int64;
  count : int64;
  i,j,k : int64;

  t1,t2 : array[1..100] of int64;
  P     : array[1..100] of int64;
  Points : array[1..100] of int64;
  t     : int64;
  score : int64;
  best : int64;
  item : int64;
  a,b,c,d : int64;
  calories : int64;

begin
  assign(src,'Advent2015_15a_input.txt');
  reset(src);

  count := 0;
  while not eof(src) do
  begin
    readln(src,s);
    inc(count);
    Name[Count] := GrabString(s);

    for i := 1 to 5 do
    begin
      Grabstring(S);  Factor[Count,i] := GrabNumber(s);
    end;

    WriteLn('S--> ',S);

    Write(Name[Count]);
    for i := 1 to 5 do
      write(Factor[Count,i]:8);
    writeln;
  end;
  close(src);

  best := 0;

  for a := 0 to 100 do
    for b := 0 to 100-a do
      for c := 0 to 100-a-b do
      begin
        d := 100-a-b-c;
        score := 1;
        for j := 1 to 4 do
        begin
          item := Factor[1,j]*a + Factor[2,j]*b + Factor[3,j]*c + Factor[4,j]*d;
          score := score * item;
          if score < 0 then score := 0;
        end;
        calories := Factor[1,5]*a + Factor[2,5]*b + Factor[3,5]*c + Factor[4,5]*d;
        writeln(i,' ',score);
        if (score > best) AND (Calories = 500) then best := score;
      end;


  writeln('Best score = ',Best);

  Readln;
end.

