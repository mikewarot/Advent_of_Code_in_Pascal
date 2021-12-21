program advent2021_21b;
const
  outcome : array[1..9] of qword =     (0,0,1,3,6,7,6,3,1);    // outcome of 3 dirac dice
var
  i,j,k : int64;
  p,s,t : int64;

  p1,p2,
  s1,s2 : int64;
  gamestate : array[0..30] of array[1..10] of array[1..10] of array [0..30] of array[0..30] of qword;
//                  turn      pos 1           pos 2           score 1          score 2
  count : qword;
  win1,win2 : qword;
  score : array[1..9] of integer;
begin
  fillchar(gamestate,sizeof(gamestate),0); // just null it out!

  Write('Player 1 Position : '); ReadLn(p1);
  Write('Player 2 Position : '); ReadLn(p2);

  gamestate[0,p1,p2,0,0] := 1;   // set up the initial conditions

  t := 0;
  repeat
    for i := 1 to 9 do
    begin
      for p1 := 1 to 10 do
        for p2 := 1 to 10 do
          for s1 := 0 to 20 do
            for s2 := 0 to 20 do
              inc(gamestate[t+1,((p1+i-1) mod 10)+1,p2,s1+((p1+i-1) mod 10)+1,s2],
                  gamestate[t,p1,p2,s1,s2]*outcome[i]);
    end;

    for i := 1 to 9 do
    begin
      for p1 := 1 to 10 do
        for p2 := 1 to 10 do
          for s1 := 0 to 20 do
            for s2 := 0 to 20 do
              inc(gamestate[t+2,p1,((p2+i-1) mod 10)+1,s1,s2+((p2+i-1) mod 10)+1],
                  gamestate[t+1,p1,p2,s1,s2]*outcome[i]);
    end;

    count := 0;
    for p1 := 1 to 10 do
      for p2 := 1 to 10 do
        for s1 := 0 to 30 do
          for s2 := 0 to 30 do
            if gamestate[t+2,p1,p2,s1,s2] <> 0 then
            begin
            //  writeln(t+2,' ',p1,' ',p2,' ',s1,' ',s2,' ',gamestate[t+2,p1,p2,s1,s2]);
              inc(count,gamestate[t+2,p1,p2,s1,s2]);
            end;

    writeln(t,' ',count,' universes exist');
    inc(t,2);
  until t > 28;

  Win1 := 0;
  for t := 0 to 20 do
    for p1 := 1 to 10 do
      for p2 := 1 to 10 do
        for s1 := 21 to 30 do
          for s2 := 0 to 20 do
            inc(win1,gamestate[t,p1,p2,s1,s2]);
  WriteLn('Win1 = ',Win1);

  Win2 := 0;
  for t := 0 to 20 do
    for p1 := 1 to 10 do
      for p2 := 1 to 10 do
        for s1 := 0 to 20 do
          for s2 := 21 to 30 do
            inc(win2,gamestate[t,p1,p2,s1,s2]);
  WriteLn('Win2 = ',Win2);

  readln;
end.