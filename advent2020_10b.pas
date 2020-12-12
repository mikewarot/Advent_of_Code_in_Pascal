program advent2020_10b;
uses
  classes, sysutils, dateutils;
var
  Buffer    : Array[0..2000000] of Integer;
  StartTime : TDateTime;

procedure midsort(a,b : integer);
var
  min,max,mid : integer;
  i,j,k,n     : integer;
begin
  WriteLn('MidSort(',a,',',b,')');
  if a>=b then exit;
  if (b-a) = 1 then
  begin
    n := buffer[a];
    buffer[a] := buffer[b];
    buffer[b] := n;
    writeln('Sort(2) --> SWAPPED');
    exit;
  end;

  writeln('Before Sort');
  min := 0;
  max := 0;
  for i := a to b do
  begin
    if min > buffer[i] then min := buffer[i];
    if max < buffer[i] then max := buffer[i];
    mid := (max-min) div 2;
    WriteLn(i,' ',buffer[i],' ',min,' ',max);
  end;

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds'); // for the challenge file, bubble sort is SLOOOOOW
  j := a;
  k := b;
  repeat
    if buffer[j] < mid then inc(j);
    if buffer[k] > mid then dec(k);
    if j < k then
    begin
      n := buffer[j];
      buffer[j] := buffer[k];
      buffer[k] := n;
//      writeln('Swapped ',j,' ',k);
    end;
  until j>= k;

  writeln('After Sort');
  min := 0;
  max := 0;
  for i := a to b do
  begin
    if min > buffer[i] then min := buffer[i];
    if max < buffer[i] then max := buffer[i];
    mid := (max-min) div 2;
    WriteLn(i,' ',buffer[i],' ',min,' ',max);
  end;
  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds'); // for the challenge file, bubble sort is SLOOOOOW

  midsort(a,j); // split based on where j/k end up, not "middle"
  midsort(j+1,b);
end; // midsort



var
  i,j,k,n   : integer;
  linecount : integer;
  Delta     : Array[0..10] of integer;
  Valid     : Boolean;
  Count     : Integer;
  mask      : integer;
  reps      : integer;
  d         : integer;
  f         : integer;
  permutations : double;
  min,max,mid   : integer;
  a,b       : integer;


begin
  StartTime := Now;
  linecount := 0;
  buffer[0] := 0;
  repeat
    inc(linecount);
    readln(buffer[linecount]);
    writeln(linecount,' ',buffer[linecount]);
  until eof;
  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds'); // for the challenge file, bubble sort is SLOOOOOW

  midsort(1,linecount);
  for i := 1 to linecount do
    WriteLn(i,' ',buffer[i]);

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds'); // for the challenge file, bubble sort is SLOOOOOW

  halt;

  j := 1;
  k := linecount;
  repeat
    if buffer[j] < mid then inc(j);
    if buffer[k] > mid then dec(k);
    if j < k then
    begin
      n := buffer[j];
      buffer[j] := buffer[k];
      buffer[k] := n;
      writeln('Swapped ',j,' ',k);
    end;
  until j>= k;

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds'); // for the challenge file, bubble sort is SLOOOOOW

  writeln('j = ',j,'    k = ',k);

  writeln('Min = ',min);
  writeln('Mid = ',mid);
  WriteLn('Max = ',max);
  for i := 1 to linecount do
  begin
    if buffer[i] >= mid then write('  ');
    WriteLn(i,' ',buffer[i]);
  end;


  halt;

  // bubble sort
  for i := 1 to linecount-1 do
  begin
    for j := i to linecount do
      if buffer[i] > buffer[j] then
      begin
        n := buffer[i];
        buffer[i] := buffer[j];
        buffer[j] := n;
      end;
    if ((i mod 1000) = 0) then
    begin
      writeln(i,' ',MilliSecondsBetween(Now,StartTime)); // for the challenge file, bubble sort is SLOOOOOW
    end;

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

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds'); // for the challenge file, bubble sort is SLOOOOOW

  halt;

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

