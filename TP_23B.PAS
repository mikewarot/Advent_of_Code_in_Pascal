program day23b;
const
  MaxTerm   = 1000000;
  TurnCount = 10000000;

var
  s : string;
  i : longint;
  Next       : file of longint;

  Pickup     : Array[1..3] of longint;
  Target     : longint;
  Turn       : longint;
  X          : longint;
  TermCount  : longint;

  First,
  Last       : longint;

  Pickup1    : longint;
  NextTarget : longint;
  A,B        : longint;


begin
  assign(next,'next.bin');
  rewrite(next);
  for i := 0 to 10 do
    write(next,i);

  last := 1;

  Write('Enter S : '); readln(S);
  for i := 1 to length(s) do
    begin
      X := ord(s[i]) - ord('0');
      if i = 1 then
        first := x
      else
        begin
          seek(next,last);
          write(next,x);        { next[last] := x; }
        end;
      last := x;
      termcount := i;
    end;

  for i := length(s)+1 to MaxTerm do
    begin
      seek(next,last);
      write(next,i);      { next[last] := i; }
      last := i;
      termcount := i;
    end;

  seek(next,last);
  write(next,first);    { next[last] := first;   // make it into a ring! }

  writeln;
  writeln('Processing Section');
  writeln;

  x := first;
  for i := 1 to 10 do
    begin
      write(x,' ');
      seek(next,x);
      read(next,x);   { x := next[x]; }
    end;
  writeln;

  for turn := 1 to turncount do
    begin
      target  := first-1;
      if target < 1 then target := termcount;
{      writeln('Target = ',target); }
      seek(next,first);
      read(next,pickup[1]);   { pickup[1]     := next[first];}

      seek(next,pickup[1]);
      read(next,pickup[2]);  { pickup[2]   := next[pickup[1]]; }

      seek(next,pickup[2]);
      read(next,pickup[3]);  { pickup[3]   := next[pickup[2]]; }

      seek(next,pickup[3]);
      read(next,x);          { x = next[Pickup3] }
      seek(next,first);
      write(next,x);         { next[first] := next[pickup[3]]; }

      seek(next,first);
      read(next,first);      { first       := next[first]; }

      while (target = pickup[1]) or
            (target = pickup[2]) or
            (target = pickup[3]) do
        begin
          dec(target);  if target = 0 then target := termcount;
        end;

{      writeLn('Target = ',target); }
      seek(next,target);
      read(next,nexttarget);
      seek(next,pickup[3]);
      write(next,nexttarget);  { next[pickup[3]] :=  next[target]; }
      seek(next,target);
      write(next,pickup[1]);   { next[target] := pickup[1]; }
(*
      x := first;
      for i := 1 to 10 do
        begin
          write(x,' ');
          seek(next,x);
          read(next,x);   { x := next[x]; }
        end;
      writeln;
*)
     if (turn mod 100000) = 0 then
       write(turn,#13);

    end; { for turn }

  seek(next,1);
  read(next,x);  { x := next[1]; }
  for i := 1 to 10 do
    begin
      write(x,' ');
      if i = 1 then A := x;
      if i = 2 then B := x;
      seek(next,x);
      read(next,x);  { x := next[x]; }
    end;
  writeln;

  WriteLn('Product = ',A,' * ',B);
  close(next);
end.
