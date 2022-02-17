program advent2021_23a;
uses sysutils, dateutils, Classes, mystrings, fgl;
type
  tpoint = record
    x,y : integer;
  end;

  tgoal = record
    p : tpoint;
    c : char;
    done : boolean;
  end;

  TMap = specialize TFPGMap<String, Integer>;

  tString10 = Array[1..10] of string;

const
  cost : array[1..4] of integer = (1,10,100,1000);
  goalstring : string = '...A.B.C.D.E.F.G.H....';

Var
  indent : integer;
  cache  : tMap;
  Bench  : Array[1..100] of tPoint;
  BenchC : integer;
  Goal   : Array[1..100] of tGoal;
  GoalC  : integer;

  Procedure UnpackGame(ZZZ : String; Var S10 : tString10);
  var
    i : integer;
    s : string;
    c : integer;
  begin
    for i := 1 to 10 do
      s10[i] := '';
    c := 0;
    while zzz <> '' do
    begin
      inc(c);
      i := pos('|',zzz);
      if i <> 0 then
      begin
        s := copy(zzz,1,i-1);
        delete(zzz,1,i);
      end
      else
      begin
        s := zzz;
        zzz := '';
      end;
      s10[c] := s;
    end;
  end;

  function PackGame(zzz : tString10):String;
  var
    c : integer;
    t : string;
  begin
    t := zzz[1];
    c := 1;
    repeat
      inc(c);
      t := t + '|' + zzz[c];
    until (zzz[c]='') or (c=10);
    PackGame := t;
  end;

  procedure SetupGoalsAndBenches(ZZZ : String);
  var
    s10 : tString10;
    x,y : integer;
  begin
    GoalC := 0;
    BenchC := 0;
    UnpackGame(zzz,S10);
    y := 2;
    for x := 2 to length(s10[y])-1 do
      if s10[y+1][x] = '#' then
                     begin
                       inc(BenchC);
                       Bench[BenchC].x := x;
                       Bench[BenchC].y := y;
                     end;

    for y := 3 to 9 do
      for x := 1 to length(s10[y]) do
        Case s10[y][x] of
          'A'..'D','.' : begin
                           inc(goalc);
                           Goal[GoalC].c:= goalstring[x];  // string with A B C...
                           Goal[GoalC].p.x := x;
                           Goal[GoalC].p.y := y;
                           Goal[GoalC].done := false;
                         end;
        end;

  end;

  Procedure Dump(ZZZ : String);
  var
    i : integer;
    s : string;
  begin
    while zzz <> '' do
    begin
      i := pos('|',zzz);
      if i <> 0 then
      begin
        s := copy(zzz,1,i-1);
        delete(zzz,1,i);
      end
      else
      begin
        s := zzz;
        zzz := '';
      end;
      WriteLn(S);
    end;
  end;

  function PathLength(p1,p2 : tPoint; s10 : tString10):Int64;
  var
    dx,dy : integer;
    count : integer;
    x,y : integer;
    points : array[1..20] of tpoint;
    ok : boolean;
    i : integer;
  begin
    count := 0;
    x := p1.x;
    y := p1.y;

    while y > 2 do
    begin
      dec(y);
      inc(count);
      points[count].x := x;
      points[count].y := y;
    end;

    while x > p2.x do
    begin
      dec(x);
      inc(count);
      points[count].x := x;
      points[count].y := y;
    end;

    while x < p2.x do
    begin
      inc(x);
      inc(count);
      points[count].x := x;
      points[count].y := y;
    end;

    while y < p2.y do
    begin
      inc(y);
      inc(count);
      points[count].x := x;
      points[count].y := y;
    end;

    ok := true;
    for i := 1 to count do
      if s10[points[i].y][points[i].x] <> '.' then
        ok := false;

    if ok then pathlength := count
          else pathlength := -1;
  end;

  function Energy(gamestate : string):int64;
  label
    skip;
  var
    minEnergy : int64;
    s10 : tString10;
    i,j,k : integer;
    tmp : char;
    thispath : int64;
    tmpS10 : tString10;
    goalsdone : integer;
    GotEnergy : int64;
    idx : longint;
  begin
    if cache.Find(gamestate,idx) then
    begin
      MinEnergy := cache.Data[idx];
      WriteLn('Found in cache : ',MinEnergy);
      Goto Skip;
    end;

    minenergy := 1 shl 50; // 2^50, a very big number
    cache.Add(gamestate,minenergy);
    WriteLn('Starting Energy(',GameState,')');


    UnpackGame(gamestate,s10);

    minenergy := 1 shl 50; // 2^50, a very big number
    goalsdone := 0;

    for i := 1 to goalc do
      goal[i].done := false;

    for i := goalc downto 1 do
    begin
      tmp := s10[goal[i].p.y][goal[i].p.x];
      if goal[i].c = tmp then
      begin
        if (i > (GoalC-4)) OR (Goal[i+4].done) then
        begin
          inc(goalsdone);
          goal[i].done := true;
        end;
      end;
    end;

    WriteLn('GoalsDone = ',GoalsDone);

    if GoalsDone <> GoalC then
    begin
      for i := 1 to GoalC do
      begin
        tmp := s10[goal[i].p.y][goal[i].p.x];
        if (tmp <> '.') AND (Not Goal[i].Done) then
        begin
          for j := 1 to BenchC do
            begin
              thispath := PathLength(Goal[i].p,Bench[j],S10);
              if thisPath >= 1 then
              begin
                tmpS10 := S10;
                tmps10[goal[i].p.y][goal[i].p.x] := '.';
                tmps10[Bench[j].y][Bench[j].x] := tmp;
                case tmp of
                  'A' : ;
                  'B' : thispath := thispath * 10;
                  'C' : thispath := thispath * 100;
                  'D' : thispath := thispath * 1000;
                end; // case tmp
                GotEnergy := Energy(PackGame(tmpS10));
                thispath := thispath + GotEnergy;

  //              WriteLn('Goal[',i,'] to Bench[',j,'] path length = ',PathLength(Goal[i].p,Bench[j],S10));
  //              WriteLn(' energy = ',thispath);

                If ThisPath < MinEnergy then
                  MinEnergy := ThisPath;
              end;  // if thispath >= 1
            end; // for j
        end; // if (tmp...

        // goal to goal transfer

        if (tmp <> '.') then
        for j := 1 to GoalC do
          if (Goal[j].c = tmp) AND (not Goal[j].Done) then
          begin
            thispath := PathLength(Goal[i].p,Goal[j].p,S10);
            if thisPath >= 1 then
            begin
              tmpS10 := S10;
              tmps10[goal[j].p.y][goal[j].p.x] := tmp;
              tmps10[goal[i].p.y][goal[i].p.x] := '.';
              case tmp of
                'A' : ;
                'B' : thispath := thispath * 10;
                'C' : thispath := thispath * 100;
                'D' : thispath := thispath * 1000;
              end; // case tmp
              WriteLn(' thispath = ',thispath);
              GotEnergy := Energy(PackGame(tmpS10));
              thispath := thispath + GotEnergy;

//              WriteLn('Bench[',i,'] to Goal[',j,'] path length = ',PathLength(Bench[i],Goal[j].p,S10));

              If ThisPath < MinEnergy then
                MinEnergy := ThisPath;
            end;  // if thispath >= 1
          end; // for j   (goal..goal)

      end; // for i

      for i := 1 to BenchC do
      begin
        tmp := s10[bench[i].y][Bench[i].x];
        if (tmp <> '.') then
        for j := 1 to GoalC do
          if Goal[j].c = tmp then
          begin
            thispath := PathLength(Bench[i],Goal[j].p,S10);
            if thisPath >= 1 then
            begin
              tmpS10 := S10;
              tmps10[goal[j].p.y][goal[j].p.x] := tmp;
              tmps10[Bench[i].y][Bench[i].x] := '.';
              case tmp of
                'A' : ;
                'B' : thispath := thispath * 10;
                'C' : thispath := thispath * 100;
                'D' : thispath := thispath * 1000;
              end; // case tmp
              GotEnergy := Energy(PackGame(tmpS10));

              thispath := thispath + GotEnergy;

//              WriteLn('Bench[',i,'] to Goal[',j,'] path length = ',PathLength(Bench[i],Goal[j].p,S10));
//              WriteLn(' energy = ',thispath);

              If ThisPath < MinEnergy then
                MinEnergy := ThisPath;
            end;  // if thispath >= 1
          end; // for j
      end; // for i
    end // if GoalsDone <> Goalc
    else
      MinEnergy := 0;

    WriteLn('Adding Cache : ',GameState,'  ,',MinEnergy);
    Cache.Add(GameState,MinEnergy);

Skip:
    WriteLn('Ending Energy(',GameState,') = ',MinEnergy);
    Energy := MinEnergy;
  end;

var
  StartTime   : TDateTime;
  Src : Text;
  S : String;

  i,j,k : int64;
  x,y,z : int64;
  gamestate : string;
  zz : int64;
begin
  StartTime := Now;

  cache := TMap.Create;
  cache.Sorted:= true;

  Indent := 0;
  gamestate := '';
  GoalC := 0;

  Assign(Src,'Advent2021_23_sample.txt');
  reset(src);
  while not eof(src) do
  begin
    readln(src,s);
    if gamestate <> '' then
      Gamestate := GameState+'|';
    GameState := GameState + s;
  end;
  close(src);

  SetupGoalsAndBenches(GameState);
  WriteLn(BenchC,' benches');
  for i := 1 to benchC do
    writeln('  ',bench[i].x,',',bench[i].y);

  WriteLn(GoalC,' goals');
  for i := 1 to GoalC do
    writeln('  ',Goal[i].p.x,',',Goal[i].p.y,' - ',Goal[i].c);

  WriteLn('Gamestate  >>>',GameState,'<<<');
  Dump(GameState);


  zz := Energy(GameState);
  WriteLn('Energy Required = ',ZZ);

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
  readln;
end.
