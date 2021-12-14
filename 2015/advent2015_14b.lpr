program advent2015_14b;
uses
  mystrings;

var
  src : text;
  s : string;
  name : array[1..100] of string;
  speed,duration,rest : array[1..100] of int64;
  count : integer;
  i,j,k : integer;

  t1,t2 : array[1..100] of int64;
  P     : array[1..100] of int64;
  Points : array[1..100] of int64;
  t     : integer;
  best : int64;

begin
  assign(src,'Advent2015_14a_input.txt');
  reset(src);

  count := 0;
  while not eof(src) do
  begin
    readln(src,s);
    inc(count);
    Name[Count] := GrabString(s);
    Grabstring(S);
    Grabstring(s);
    Speed[Count] := GrabNumber(s);
    Grabstring(s);
    GrabString(s);
    Duration[Count] := GrabNumber(s);
    for i := 1 to 6 do
      Grabstring(s);
    Rest[Count] := GrabNumber(s);
    WriteLn(Name[Count],Speed[Count]:8,Duration[Count]:8,Rest[Count]:8,' -->',s);
    t1[Count] := Duration[Count];
    t2[Count] := Rest[Count];
    p[Count] := 0;
    points[Count] := 0;
  end;
  close(src);

  for t := 1 to 2503 do
  begin
    for i := 1 to count do
    begin
      if t1[i] > 0 then
      begin
        inc(p[i],Speed[i]);
        dec(t1[i]);
      end
      else
      begin
        dec(t2[i]);
        if t2[i] = 0 then
        begin
          t1[i] := duration[i];
          t2[i] := rest[i];
        end;
      end;
    end;

    best := 0;
    for i := 1 to count do
      if p[i] > best then
        best := p[i];

    for i := 1 to count do
      if p[i] = best then
        inc(points[i]);

  end;

  for i := 1 to Count do
    WriteLn(i,' ',Name[i],' ',P[i],' ',points[i]);

  Readln;
end.

