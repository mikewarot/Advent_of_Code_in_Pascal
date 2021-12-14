program advent2020_20a;
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

type
  TTile     = record
    TileNumber : Integer;
    Rotation   : Integer;
    FlipX      : Boolean;
    FlipY      : Boolean;
    Data       : Array[1..10] of String;
    EdgeMatch  : Array[0..3] of Integer;
    X,Y        : Integer;
  end;

  Function GetEdge(T : TTile; EdgeNum : Integer): String;
  var
    s : string;
    i : integer;
  begin
    s := '';
    Case (EdgeNum mod 4) of
      0  : s := T.Data[1];
      1  : for i := 1 to 10 do
             s := s + T.Data[i][10];
      2  : for i := 1 to 10 do
             s := s + T.Data[10][11-i];
      3  : for i := 1 to 10 do
             s := s + T.Data[11-i][1];
    end; // case
    GetEdge := S;
  end;

  Function GetRotatedRow(T : tTile; RowNum : Integer): String;
  var
    s : string;
    i : integer;
    x,y : integer;
  begin
    s := '';
    for i := 1 to 10 do
      begin
        Case T.Rotation of
          0 : begin
                x := i;
                y := rownum;
              end;
          2 : begin
                x := 11-i;
                y := 11-rownum;
              end;
          1 : begin
                x := rownum;
                y := i;
              end;
          3 : begin
                x := 11-rownum;
                y := 11-i;
              end;
        end; // case
        if T.FlipX then
          y := 11-y;
        S := s + t.Data[y][x];
    end;
    GetRotatedRow := s;
  end;

  Function Reverse(T : String):String;
  var
    i : integer;
    s : string;
  begin
    s := '';
    for i := length(t) downto 1 do
      s := s + t[i];
    Reverse := s;
  end;

var
  Tile      : Array[1..1000] of TTile;
  TileCount : Integer;
  StartTime : TDateTime;
  done      : boolean;
  s,t       : string;
  i,j,k,m,n : integer;
  matchsize : integer;
  Matches   : Array[1..1000] of integer;

  product   : extended;
  CornerCount : integer;
  Corner   : Array[1..10] of integer;
  Rotation : Integer;
  LeftPiece : Integer;
  NextPiece : Integer;
  NewEdge   : Integer;
  X,Y       : Integer;
  Width,Height : Integer;
  Row,Col   : Integer;

  grid      : array[1..12] of array[1..12] of integer;

begin
  StartTime := Now;
  tilecount := 0;
  done := false;
  writeln('Input Section');
  repeat
    readln(s);
    If Pos('Tile',S) <> 0 then
    begin
      Inc(TileCount);
      Delete(S,1,5);
      Tile[TileCount].TileNumber:= GetNum(s);
      Expect(S,':');
      for i := 1 to 10 do
        Readln(Tile[TileCount].Data[i]);
      for i := 0 to 3 do
        Tile[TileCount].EdgeMatch[i] := 0;
      Tile[TileCount].FlipX := false;
      Tile[TileCount].FlipY := false;
      Tile[TileCount].Rotation := 0;
      Tile[TileCount].X := 0;
      Tile[TileCount].Y := 0;
      WriteLn('Tile# ',Tile[TileCount].TileNumber,' accepted as input');
    end;
  until done or eof;


  If TileCount = 9 then
    begin
      Width := 3;
      Height := 3;
    end
  else
    begin
      Width := 12;
      Height := 12;
    end;
  WriteLn(TileCount,' tiles accepted');
  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');

  WriteLn('Output Section');

  for i := 1 to tilecount do
    Matches[i] := 0;

(*
  for i :=1 to tilecount do
    for j := 0 to 3 do
      WriteLn(Tile[i].TileNumber,' : Rotation(',j,') = ',GetEdge(Tile[i],j));
*)
  for i := 1 to tilecount do
    for j := 0 to 3 do
      for k := i+1 to tilecount do
        for m := 0 to 3 do
          if (GetEdge(Tile[i],j) = GetEdge(Tile[k],m)) then
          begin
//            WriteLn('Match ',Tile[i].TileNumber,' ',j,' ',Tile[k].TileNumber,' ',m);
            inc(Matches[i]);
            inc(Matches[k]);
            Tile[i].EdgeMatch[j] := -k;
            Tile[k].EdgeMatch[m] := -i;
          end;

  for i := 1 to tilecount do
    for j := 0 to 3 do
      for k := i+1 to tilecount do
        for m := 0 to 3 do
          if (Reverse(GetEdge(Tile[i],j)) = GetEdge(Tile[k],m)) then
          begin
//            WriteLn('Flip Match ',Tile[i].TileNumber,' ',j,' ',Tile[k].TileNumber,' ',m);
            inc(Matches[i]);
            inc(Matches[k]);
            Tile[i].EdgeMatch[j] := k;
            Tile[k].EdgeMatch[m] := i;
          end;

(*
  for i := 1 to tilecount do
    writeln('Tile ',Tile[i].TileNumber,' has ',Matches[i],' matches');
*)

  writeln;
  product := 1;
  cornercount := 0;

  for i := 1 to tilecount do
    if (Matches[i] = 2) then
      begin
        inc(CornerCount);
        Corner[CornerCount] := i;
        WriteLn(Tile[i].TileNumber);
        product := product * Tile[i].TileNumber;
      end;

  WriteLn('Product = ',Product:1:0);

  WriteLn('Corner Tiles');
  for i := 1 to CornerCount do
    WriteLn(Tile[Corner[i]].TileNumber);

  WriteLn('1st corner matching tiles');

  Rotation := -1;
  for i := 0 to 3 do
    if Tile[Corner[1]].EdgeMatch[i] <> 0 then
      begin
        WriteLn(i,' ',Tile[abs(Tile[Corner[1]].EdgeMatch[i])].TileNumber);
        Rotation := i;
      end;

  X := 1;
  Y := 1;
  WriteLn('Rotation = ',Rotation);
  Rotation := (6-rotation) mod 4;
  WriteLn('New Rotation = ',Rotation);
  Tile[Corner[1]].Rotation := Rotation;
  Tile[Corner[1]].X := 1;
  Tile[Corner[1]].Y := 1;

  LeftPiece := Corner[1];
  WriteLn('Left Piece = ',LeftPiece);
  NextPiece := Tile[LeftPiece].EdgeMatch[(5-Tile[LeftPiece].Rotation) mod 4];
  WriteLn('Next Piece = ',NextPiece);
  WriteLn('*RECORD* (',y,',',x,') <<',Tile[LeftPiece].TileNumber,'>>');
  Tile[LeftPiece].X := X;
  Tile[LeftPiece].Y := Y;
  Grid[X,Y] := LeftPiece;
  Inc(X);

  repeat
    NextPiece := Abs(NextPiece);
    NewEdge := -1;
    for i := 0 to 3 do
      if (Abs(Tile[NextPiece].EdgeMatch[i]) = LeftPiece) then
        NewEdge := i;
    WriteLn('New Edge = ',NewEdge);
    Tile[NextPiece].Rotation := (7-newEdge) mod 4;

    If Tile[NextPiece].EdgeMatch[i] > 0 then             // need to flip the next part relative to this one
      Tile[NextPiece].FlipY := Tile[LeftPiece].FlipY
    else
      Tile[NextPiece].FlipY := NOT Tile[LeftPiece].FlipY;


    LeftPiece := NextPiece;
    WriteLn('Left Piece = ',LeftPiece);
    WriteLn('Left Matches = ',Matches[LeftPiece]);
    WriteLn('*RECORD* (',x,',',y,') <<',Tile[LeftPiece].TileNumber,'>>');
    Tile[LeftPiece].X := X;
    Tile[LeftPiece].Y := Y;
    Grid[X,Y] := LeftPiece;
    Inc(X);
    NextPiece := Tile[LeftPiece].EdgeMatch[(5-Tile[LeftPiece].Rotation) mod 4];
    WriteLn('Next Piece = ',NextPiece);
  until (NextPiece = 0);  // goes across a row to the right, ignoring flips for now


  writeln;
  writeln('Picture output - I hope');
  writeln;


  for y := 1 to 1 do
    for row := 1 to 10 do
      begin
        for x := 1 to width do
          write(GetRotatedRow(Tile[Grid[x,y]],Row),'-');
        writeln;
      end; // for row

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
end.

