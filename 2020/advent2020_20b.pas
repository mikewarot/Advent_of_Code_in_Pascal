program advent2020_20b;
uses
  classes, sysutils, dateutils;
type
  charset = set of char;
const
  whitespace : charset = [' ',#9,#10,#13];

procedure eat(var s : string;  whattoeat : charset);
begin
  while (length(s) <> 0) and (s[1] in whattoeat) do
    delete(s,1,1);
end;

procedure Expect(var s : string; c : char);
begin
  if (s='') OR (s[1] <> c) then
    writeln('Error : Expected [',c,'], Got [',s,']')
  else
    delete(s,1,1);
end;

function getnum(var s : string):integer;
var
  c : char;
  value : integer;
begin
  value := 0;
  eat(s,whitespace);
  while (length(s) <> 0) and (s[1] in ['0'..'9']) do
  begin
    value := value * 10 + (ord(s[1])-ord('0'));
    delete(s,1,1);
  end;
  eat(s,whitespace);
  getnum := value;
end;

function getinteger(var s : string):integer;
var
  value : integer;
  sign  : integer;
begin
  value := 0;
  sign := 1;
  eat(s,whitespace);
  if s <> '' then
    if s[1] = '+' then
      delete(s,1,1)
    else
      if s[1] = '-' then
      begin
        sign := -1;
        delete(s,1,1);
      end;
  while (s <> '') AND (s[1] in ['0'..'9']) do
  begin
    value := (value * 10) + (ord(s[1])-ord('0'));
    delete(s,1,1);
  end;
  value := value * sign;
  getinteger := value;
end;

function getword(var s : string):string;
var
  c : char;
  value : string;
begin
  value := '';
  while (length(s) <> 0) and (s[1] in [' ']) do
    delete(s,1,1);
  while (length(s) <> 0) and (s[1] in ['0'..'9','a'..'z','A'..'Z']) do
  begin
    value := value + s[1];
    delete(s,1,1);
  end;
  while (s <> '') AND (s[1] = ' ') do
    delete(s,1,1);
  getword := value;
end;

function reverse(s : string):string;
var
  t : string;
begin
  t := '';
  while s <> '' do
    begin
      t := s[1]+t;
      delete(s,1,1);
    end;
  reverse := t;
end;

type
  tMatch    = record
    TheirIndex    : integer;
    TheirRotation : integer;
    flipped       : boolean;
  end;

  tTile     = record
    Data       : array[1..10] of string;
    Number     : Integer;
    MatchCount : integer;
    Match      : array[0..3] of tMatch;
    Rotation   : integer;
    FlipX,
    FlipY      : Boolean;
  end;

  function GetTileXY(t : ttile; x,y : integer):char;
  begin
    GetTileXY := t.Data[y][x];
  end;

  procedure RotateXY(var x,y : integer; count : integer);
  var
    i : integer;
    t : integer;
  begin
    for i := 1 to count do
      begin
        t := y;
        y := x;
        x := 11-t;
      end;
  end;

  function GetTileXYrotated(t :tTile;  x,y : integer; rotate : integer):char;
  begin
    RotateXY(x,y,rotate);
//    WriteLn('x,y = ',x,',',y);
    GetTileXYRotated := GetTileXY(t,x,y);
  end;

  function GetTileAll(t : tTile; x,y : integer;  rotate : integer; flipX,flipY : boolean): char;
  begin
    RotateXY(x,y,rotate);
    if flipX then x := 11 - x;
    if flipy then y := 11 - y;
    GetTileAll := GetTileXY(t,x,y);
  end;

  Procedure RotateRight(var T : tTile);
  var
    oldtile : ttile;
    x,y     : integer;
  begin
    oldtile := t;
    for x := 1 to 10 do
      for y := 1 to 10 do
        t.Data[11-y][x] := oldtile.Data[x][y];

  end;

  Procedure FlipTileX(Var T : tTile);
  var
    y : integer;
  begin
    for y := 1 to 10 do
      t.data[y] := reverse(t.data[y]);
  end;

  Procedure FlipTileY(Var T : tTile);
  var
    y : integer;
    oldTile : tTile;
  begin
    oldTile := T;
    for y := 1 to 10 do
      t.data[y] := oldtile.data[11-y];
  end;

var
  StartTime : TDateTime;
  done      : boolean;
  s,t       : string;
  i,j,k,m,n : integer;
  TileCount : integer;
  Tile      : Array[1..1000] of tTile;
  x,y,r     : integer;
  a,b,c,d   : integer;
  s1,s2     : string;

  Grid      : array[0..13] of array[0..13] of integer;
  Spin      : array[0..13] of array[0..13] of integer;
  CornerCount : Integer;
  NextTile  : integer;
  match     : boolean;
  width,
  height    : integer;
  ThisTile  : integer;
  src       : text;
  GridX,GridY : integer;
  GridRight,
  GridDown    : integer;
  FlippedX,
  FlippedY    : Boolean;
  LeftMatch,
  RightMatch,
  UpMatch,
  DownMatch   : Integer;
  MatchForward,
  MatchReverse : Boolean;

begin
  StartTime := Now;

  assign(src,'advent2020_20a.txt');
  reset(src);

  TileCount := 0;
  done := false;
  writeln;
  writeln('Input Section');
  writeln;
  repeat
    readln(src,s);
    If Pos('Tile',S) <> 0 then
    begin
      Inc(TileCount);
      Delete(S,1,5);
      Tile[TileCount].Number:= GetNum(s);
      Expect(S,':');
      for i := 1 to 10 do
        Readln(src,Tile[TileCount].Data[i]);
      Tile[TileCount].MatchCount:=0;
      Tile[TileCount].FlipX:= False;
      Tile[TileCount].FlipY:= False;
      WriteLn('Tile# ',Tile[TileCount].Number,' accepted as input');
    end;
  until done or eof(src);
  close(src);

  WriteLn(TileCount,' tiles accepted as input');

  if TileCount=144 then
    Width := 12
  else
    Width := 3;
  Height := Width;

  Writeln;
  WriteLn('Processing section');
  WriteLn;

  for a := 1 to TileCount-1 do
    for b := a+1 to Tilecount do
      for c := 0 to 3 do
        for d := 0 to 3 do
          begin
            s1 := '';
            s2 := '';
            for i := 1 to 10 do
              s1 := s1 + GetTileXYrotated(Tile[a],i,1,c);
            for i := 1 to 10 do
              s2 := s2 + GetTileXYrotated(Tile[b],i,1,d);
            if (s1=s2) or (s1=reverse(s2)) then
            begin
              writeln(a,' rotated ',c,' times  -->',s1,' ',s1);
              writeln(b,' rotated ',d,' times  -->',s2,' ',reverse(s2));
            end;
            if s1=s2 then
              begin
                writeln(a,' ',b,' ',c,' ',d);
                Inc(Tile[a].MatchCount);
                with Tile[a].Match[c] do
                  begin
                    TheirIndex    := b;
                    TheirRotation := d;
                    Flipped := True;
                  end; // with
                Inc(Tile[b].MatchCount);
                with Tile[b].Match[d] do
                  begin
                    TheirIndex    := a;
                    TheirRotation := c;
                    Flipped := True;
                  end; // with
              end;
            if s1=reverse(s2) then
              begin
                writeln(a,' ',b,' ',c,' ',d,' reversed');
                Inc(Tile[a].MatchCount);
                with Tile[a].Match[c] do
                  begin
                    TheirIndex    := b;
                    TheirRotation := d;
                    Flipped := False;
                  end; // with
                Inc(Tile[b].MatchCount);
                with Tile[b].Match[d] do
                  begin
                    TheirIndex    := a;
                    TheirRotation := c;
                    Flipped := False;
                  end; // with
              end;
          end;

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');

  for i := 1 to tilecount do
    WriteLn(i,' has ',tile[i].MatchCount,' matches');

  writeln;
  writeln('Seeking corners');
  writeln;

  for x := 1 to 12 do
    for y := 1 to 12 do
      begin
        grid[x,y] := 0;
        spin[x,y] := 0;
      end;

  cornercount := 0;
  for i := 1 to tilecount do
    if tile[i].MatchCount = 2 then
      begin
        inc(cornercount);
        if cornercount = 1 then
          grid[1,1] := i;  // tag the upper left corner
        writeln('Corner found : ',i);
      end;
  WriteLn(CornerCount,' corners found');

  WriteLn;
  WriteLn('Output Section');
  WriteLn;

  FlippedX := False;
  FlippedY := False;

  Tile[Grid[1,1]].FlipX:= FlippedX;
  Tile[Grid[1,1]].FlipY:= FlippedY;

  writeln('Grid[1,1] = ',Grid[1,1]);
  for i := 0 to 3 do
    writeln(i,' ',Tile[Grid[1,1]].Match[i].TheirIndex);

  Grid[2,1] := Tile[Grid[1,1]].Match[1].TheirIndex;
  Grid[1,2] := Tile[Grid[1,1]].Match[2].TheirIndex;


  GridX := 2;
  GridY := 1;
  done := false;
  repeat
    While Tile[Grid[GridX,GridY]].Match[(3 + Spin[GridX,GridY]) mod 4].TheirIndex <> Grid[GridX-1,GridY] do
      Inc(Spin[GridX,GridY]);
(*
    writeln('Grid[',GridX,',',GridY,'] = ',Grid[GridX,GridY]);
    for i := 0 to 3 do
      writeln(i,' ',Tile[Grid[GridX,GridY]].Match[i].TheirIndex);
*)
    writeln('Grid[',GridX,',',GridY,'] = ',Grid[GridX,GridY],' after spin[',spin[GridX,GridY],']');
    for i := 0 to 3 do
      writeln(i,' ',Tile[Grid[GridX,GridY]].Match[(i+spin[GridX,GridY]) mod 4].TheirIndex);

    if NOT (Tile[Grid[GridX,GridY]].Match[(i+spin[GridX,GridY]) mod 4].flipped) then
      FlippedY := NOT FlippedY;
    Tile[Grid[GridX,GridY]].FlipY := FlippedY;

    GridRight := Tile[Grid[GridX,GridY]].Match[(1+spin[GridX,GridY]) mod 4].TheirIndex;
    If GridRight <> 0 then
      begin
        Inc(GridX);
        Grid[GridX,GridY] := GridRight;
      end
    else
      begin
        GridX := 1;
        GridDown := Tile[Grid[GridX,GridY]].Match[(2 + Spin[GridX,GridY]) mod 4].TheirIndex;
        If GridDown <> 0 then
          begin
            Inc(GridY);
            Grid[GridX,GridY] := GridDown;
            FlippedX := false;
            While Tile[Grid[GridX,GridY]].Match[(0 + Spin[GridX,GridY]) mod 4].TheirIndex <> Grid[GridX,GridY-1] do
              Inc(Spin[GridX,GridY]);
  (*
            writeln('Grid[',GridX,',',GridY,'] = ',Grid[GridX,GridY],' after spin[',spin[GridX,GridY],']');
            for i := 0 to 3 do
              writeln(i,' ',Tile[Grid[GridX,GridY]].Match[(i+spin[GridX,GridY]) mod 4].TheirIndex);
*)
            GridRight := Tile[Grid[GridX,GridY]].Match[(1+spin[GridX,GridY]) mod 4].TheirIndex;
            If GridRight = 0 then  // kludge to get around flipped X on left edge
              GridRight := Tile[Grid[GridX,GridY]].Match[(3+spin[GridX,GridY]) mod 4].TheirIndex;

            If GridRight <> 0 then
              begin
                Inc(GridX);
                Grid[GridX,GridY] := GridRight;
              end
            else
              done := true;
          end
        else
          done := true;
      end;
  until done;

  writeln;
  for gridy := 1 to 12 do
    begin
      for gridX := 1 to 12 do
        write(grid[gridX,gridY]:7,
              tile[grid[gridx,gridy]].FlipX.ToInteger:2,
              tile[grid[gridx,gridy]].FlipY.ToInteger:2);

      writeln;
    end;

  writeln;
  writeln('The Big Adjustment');
  writeln;

  gridx := 1;
  for gridy := 2 to 12 do
    begin
      while (tile[grid[gridx,gridy]].Data[1] <> tile[grid[gridx,gridy-1]].Data[10]) AND
            (tile[grid[gridx,gridy]].Data[1] <> Reverse(tile[grid[gridx,gridy-1]].Data[10])) do
        RotateRight(Tile[Grid[GridX,GridY]]);
      If tile[grid[gridx,gridy]].Data[1] = Reverse(tile[grid[gridx,gridy-1]].Data[10]) then
        FlipTileX(tile[Grid[Gridx,GridY]]);
    end;

  for gridy := 1 to 12 do
    for gridx := 2 to 12 do
      begin
        repeat
          matchforward := true;
          for y := 1 to 10 do
            if tile[grid[gridx-1,gridy]].Data[y][10] <> tile[grid[gridx,gridy]].Data[y][1] then
              matchforward := false;

          matchreverse := true;
          for y := 1 to 10 do
            if tile[grid[gridx-1,gridy]].Data[y][10] <> tile[grid[gridx,gridy]].Data[11-y][1] then
              matchreverse := false;

          if matchreverse then
            FlipTileY(tile[Grid[GridX,GridY]]);
          if not (MatchForward or MatchReverse) then
            RotateRight(tile[Grid[GridX,GridY]]);
        until (MatchForward OR MatchReverse);
      end;

  writeln;
  writeln('Here comes the big bitmap');
  writeln;

  for gridy := 1 to 12 do
    begin
      for y := 1 to 10 do
        begin
          for gridX := 1 to 12 do
          begin
            for x := 1 to 10 do
              begin
                if (x = 1) or (x=10) or (y=1) or (y=10) then
                  write(GetTileXY(tile[grid[gridX,gridY]],x,y))
                else
                  write(' ');
              end;
            write('=');
          end; // for GridX
          writeln;
        end;  // for Y
      For i := 1 to 12 do
        Write('|||||||||| ');
      Writeln;
    end; // for GridY

  writeln;
  writeln('Final output');
  writeln;

  for gridy := 1 to 12 do
    begin
      for y := 2 to 9 do
        begin
          for gridX := 1 to 12 do
          begin
            for x := 1 to 10 do
              begin
                if NOT((x = 1) or (x=10) or (y=1) or (y=10)) then
                  write(GetTileXY(tile[grid[gridX,gridY]],x,y));
              end;
          end; // for GridX
          writeln;
        end;  // for Y
    end; // for GridY



  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
  readln;
end.

