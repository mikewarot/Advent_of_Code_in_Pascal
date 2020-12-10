program advent2020_09b;
uses
  classes, sysutils;

const
  MAGIC_NUMBER = 373803594;
var
  buffer : array[1..1000] of integer;
  i,j,k,n  : integer;
  bufferpos : integer;
  done   : boolean;
  linecount : integer;
  sum,min,max : integer;

begin
  done := false;
  linecount := 0;
  repeat
    inc(linecount);
    readln(buffer[linecount]);
    for i :=1 to linecount-1 do
    begin
      sum := 0;
      min := buffer[i];
      max := buffer[i];
      for j := i to linecount do
      begin
        inc(sum,buffer[j]);
        if buffer[j] < min then min := buffer[j];
        if buffer[j] > max then max := buffer[j];
      end;
      if sum = MAGIC_NUMBER then
      begin
        done := true;
        writeln(min,'+',max,'=',min+max);
      end;
    end;
  until eof or done;

  WriteLn('Line Count = ',linecount);
end.

