program advent2020_23b;
uses
  sysutils, dateutils;

const
  MaxTerm    = 1000000;
  TurnCount  = 10000000;

var
  StartTime  : TDateTime;
  s          : string;
  i          : integer;

  Next       : Array[1..MaxTerm] of integer;    // a singly linked list, of sorts
  Pickup     : Array[1..3] of integer;
  Target     : Integer;
  Turn       : Integer;
  X          : Integer;
  TermCount  : Integer;

  First,
  Last       : Integer;

  Pickup1    : Integer;


begin
  StartTime := Now;

  last := 1;

  readln(S);
  for i := 1 to length(s) do
    begin
      X := ord(s[i]) - ord('0');
      if i = 1 then
        first := x
      else
        next[last] := x;
      last := x;
      termcount := i;
    end;

  for i := termcount+1 to MaxTerm do
    begin
      next[last] := i;
      last := i;
      termcount := i;
    end;

  next[last] := first;   // make it into a ring!

  writeln;
  writeln('Processing Section');
  writeln;

  x := first;
  for i := 1 to 10 do
    begin
      write(x,' ');
      x := next[x];
    end;
  writeln;

  for turn := 1 to turncount do
    begin
      target  := first-1;     if target < 1 then target := termcount;
      pickup1     := next[first];
      pickup[1]   := pickup1;
      pickup[2]   := next[pickup[1]];
      pickup[3]   := next[pickup[2]];
      next[first] := next[pickup[3]];
      first       := next[first];

      while (target = pickup[1]) or
            (target = pickup[2]) or
            (target = pickup[3]) do
        begin
          dec(target);  if target = 0 then target := termcount;
        end;

      next[pickup[3]] :=  next[target];
      next[target] := pickup[1];
    end; // for turn

  x := next[1];
  for i := 1 to 10 do
    begin
      write(x,' ');
      x := next[x];
    end;
  writeln;

  WriteLn('Product = ',Next[1] * Next[Next[1]]);

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
end.

