program advent2020_10b;
uses
  classes, sysutils;
var
  i,j,k,n   : integer;
  linecount : integer;
  Buffer    : Array[0..1000] of Integer;
  Delta     : Array[0..10] of integer;
  Valid     : Boolean;
  Count     : Integer;
  mask      : integer;
  reps      : integer;
  d         : integer;
  f         : integer;
  permutations : double;


begin
  linecount := 0;
  buffer[0] := 0;
  repeat
    inc(linecount);
    readln(buffer[linecount]);
  until eof;

  // bubble sort
  for i := 1 to linecount-1 do
    for j := i to linecount do
      if buffer[i] > buffer[j] then
      begin
        n := buffer[i];
        buffer[i] := buffer[j];
        buffer[j] := n;
      end;

  WriteLn('Line Count = ',linecount);
  for i := 1 to linecount do
    write(buffer[i],' ');
  writeln;

  inc(linecount);
  buffer[linecount] := buffer[linecount-1]+3;

  for i := 0 to 10 do
    Delta[i] := 0;

  for i := 1 to linecount do
    Inc(Delta[Buffer[i]-Buffer[i-1]]);

  for i := 0 to 10 do
    writeln('Delta ',i,' --> ',Delta[i]);

  Writeln('PartA --> ',Delta[1],' * ',Delta[3],' = ',Delta[1]*Delta[3]);

  reps := 0;
  permutations := 1;
  for i := 1 to linecount do
  begin
    d := buffer[i]-buffer[i-1];
    if d = 1 then
      inc(reps)
    else
      begin
        if reps <> 0 then
        begin
          writeln('Reps : ',reps);
          case reps of
            1 : f := 1;
            2 : f := 2;
            3 : f := 4;
            4..10 : f := 7 * (1 shl (reps-4));
          end;
          permutations := permutations * f;
          writeln('Reps : ',reps,' f = ',f,'  permutations = ',permutations:0:20);
        end;
        reps := 0;
      end;
  end;
  WriteLn;

end.

