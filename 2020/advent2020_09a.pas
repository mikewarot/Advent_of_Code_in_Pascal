program advent2020_09a;
uses
  classes, sysutils;

const
  PREAMBLE_LENGTH = 25;
var
  buffer : array[1..PREAMBLE_LENGTH] of integer;
  i,j,k,n  : integer;
  bufferpos : integer;
  done   : boolean;

begin
  for i := 1 to PREAMBLE_LENGTH do
    readln(buffer[i]);
  bufferpos := PREAMBLE_LENGTH;
  repeat
    readln(n);
    done := true;
    for i := 1 to PREAMBLE_LENGTH-1 do
      for j := i+1 to PREAMBLE_LENGTH do
        if ((buffer[i]+buffer[j]) = n) AND (buffer[i] <> buffer[j]) then
        begin
          writeln(buffer[i],' + ',buffer[j],' = ',n);
          done := false;
        end;

    inc(bufferpos);
    if bufferpos > PREAMBLE_LENGTH then
      dec(bufferpos,PREAMBLE_LENGTH);
    buffer[bufferpos] := n;
  until done or eof;

  WriteLn('N = ',n);
end.

