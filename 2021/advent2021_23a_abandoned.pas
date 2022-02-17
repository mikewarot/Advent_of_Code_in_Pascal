program advent2021_23a_abandoned;
uses sysutils, dateutils, Classes, mystrings, fgl;
type
  tpoint = record
    x,y : integer;
  end;

  TMap = specialize TFPGMap<String, Integer>;

  gamestate = array[1..15] of char;

const
  cost : array[1..4] of integer = (1,10,100,1000);
  points : array[1..15] of tpoint =
     ((x:3;y:3),(x:3;y:2),(x:5;y:3),(x:5;y:2),(x:7;y:3),(x:7;y:2),(x:9;y:3),(x:9;y:2),         // start/end positions
      (x:1;y:1),(x:2;y:1),(x:4;y:1),(x:6;y:1),(x:8;y:1),(x:10;y:1),(x:11;y:1));


Var
  indent : integer;
  cache  : tMap;

  function energy(currentstate : gamestate):int64;
  var
    idx : LongInt;
    zz : int64;
    valid : array[1..15] of boolean;
    i,j,k : integer;
    Correct : integer;
    MinEnergy : Int64;
    Distance : Int64;
    NewState : gamestate;
    NewEnergy : int64;
    ok : boolean;

    function ClearPath(i,j):boolean;
    var
      ok : boolean;
      c  : integer;
    begin
      ok := true;
      c := 0;
      repeat
        if (c <> 0) and currentstate[i] <> ' ' then
          ok := false
        else
        begin

        end;
        inc(c);
      until i=j;
      ClearPath := ok;
    end;

  begin
    zz := -1;
    if cache.Find(currentstate,idx) then
      zz := cache.Data[idx]
    else
    begin
      if indent < 2 then
      begin
        for i := 1 to indent do
          write(' ');
        WriteLn('Energy(',Currentstate,') START');
      end;
      inc(indent);
      for i := 1 to 15 do
        valid[i] := false;
      if currentstate[1] = 'A' then begin valid[1] := true; if currentstate[2] = 'A' then valid[2] := true; end;
      if currentstate[3] = 'B' then begin valid[3] := true; if currentstate[4] = 'B' then valid[4] := true; end;
      if currentstate[5] = 'C' then begin valid[5] := true; if currentstate[6] = 'C' then valid[6] := true; end;
      if currentstate[7] = 'D' then begin valid[7] := true; if currentstate[8] = 'D' then valid[8] := true; end;
      Correct := 0;
      for i := 1 to 8 do
        if valid[i] then inc(Correct);

  //    WriteLn('Correct = ',Correct);
      If (Correct = 8) then
        ZZ := 10
      else
      begin
        MinEnergy := 999999999;
  //      WriteLn('Trying possible swaps');

        for i := 1 to 15 do
        begin
          for j := 1 to 15 do
          begin
            if (i <> j) AND
               (currentstate[i] in ['A'..'D']) AND
               (currentstate[j] = ' ') AND
               ((i > 9) OR (NOT valid[i])) AND
               ((j > 9) OR (NOT valid[j])) AND
               (((i < 9) AND (j > 8)) OR ((j < 9) AND (i > 8))) AND
               ((j <> 1) OR ((currentstate[i] = 'A') AND(currentstate[2] = ' '))) AND
               ((j <> 2) OR ((currentstate[i] = 'A') AND(currentstate[1] = 'A'))) AND
               ((j <> 3) OR ((currentstate[i] = 'B') AND(currentstate[4] = ' '))) AND
               ((j <> 4) OR ((currentstate[i] = 'B') AND(currentstate[3] = 'B'))) AND
               ((j <> 5) OR ((currentstate[i] = 'C') AND(currentstate[6] = ' '))) AND
               ((j <> 6) OR ((currentstate[i] = 'C') AND(currentstate[5] = 'C'))) AND
               ((j <> 7) OR ((currentstate[i] = 'D') AND(currentstate[8] = ' '))) AND
               ((j <> 8) OR ((currentstate[i] = 'D') AND(currentstate[7] = 'D'))) then
            begin
              newstate := currentstate;
              newstate[j] := newstate[i];
              newstate[i] := ' ';


              NewEnergy := 0;
              if newstate[j] = 'A' then NewEnergy := 1;
              if newstate[j] = 'B' then NewEnergy := 10;
              if newstate[j] = 'C' then NewEnergy := 100;
              if newstate[j] = 'D' then NewEnergy := 1000;

              distance := abs(points[i].x-points[j].x)+
                          abs(points[i].y-points[j].y);
              NewEnergy := NewEnergy * Distance;

              NewEnergy := NewEnergy + Energy(NewState);
              If NewEnergy < MinEnergy then
                MinEnergy := NewEnergy;

   //           WriteLn('Tried ',i,',',j,' got ',NewEnergy);
            end;  // if
          end; // for j
        end; // for i

        ZZ := MinEnergy;
      end; // correct <> 8

      Dec(Indent);
      if indent < 2 then
      begin
        For i := 1 to indent do
          write(' ');
        WriteLn('Energy(',Currentstate,') STOP ',ZZ);
      end;
      cache.Add(currentstate,zz);
    end; // if not in cache
    Energy := ZZ;
  end; // energy

var
  StartTime   : TDateTime;
  Src : Text;
  S : String;

  state : gamestate;

  i,j,k : int64;
  x,y,z : int64;
  Correct : integer;


begin
  StartTime := Now;

  cache := TMap.Create;
  cache.Sorted:= true;

  Indent := 0;

  for i := 1 to 15 do
    state[i] := ' ';

  Assign(Src,'Advent2021_23_sample.txt');
  reset(src);
  readln(src,s);
  readln(src,s);
  readln(src,s);
    state[1] := s[4];
    state[2] := s[6];
    state[3] := s[8];
    state[4] := s[10];
  readln(src,s);
    state[5] := s[4];
    state[6] := s[6];
    state[7] := s[8];
    state[8] := s[10];
  close(src);

  WriteLn('Energy of current state = ',Energy(State));

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
  readln;
end.
