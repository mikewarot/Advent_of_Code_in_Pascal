program advent2021_21a;

const
  ringsize = 10;

var
  rollcount : int64;


  function diceroll : int64;
  begin
    inc(rollcount);
    diceroll := ((rollcount-1) mod 100) + 1;
  end;

var
  position, score : array[1..100] of int64;
  playercount,p   : int64;
  a,b : int64;
  a_score,b_score : int64;
  i,j,k : int64;

begin
  rollcount := 0;
  playercount := 0;
  p := 0;

  for i := 1 to 2 do
  begin
    inc(playercount);
    write('Player ',playercount,' position : '); readln(position[playercount]);
    score[playercount] := 0;
  end;

  p := 0;
  repeat
    inc(p);
    if p > playercount then p := 1;
    for i := 1 to 3 do
    begin
      position[p] := position[p] + diceroll;
      while position[p] > ringsize do
        dec(position[p],ringsize);
    end;
    inc(score[p],position[p]);
  until score[p] >= 1000;

  for i := 1 to playercount do
    writeln(i,',',score[i],',',rollcount*score[i]);

  readln;  // wait for user to hit enter, otherwise window goes away
end.
