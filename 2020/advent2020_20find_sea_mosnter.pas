program advent2020_20find_sea_mosnter;
uses
  classes, sysutils, dateutils;
const
  SeaMonster : array[1..3] of string = ('                  # ',
                                        '#    ##    ##    ###',
                                        ' #  #  #  #  #  #   ');

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

var
  Ocean,
  OldOcean  : array[1..96] of string;
  StartTime : TDateTime;
  done      : boolean;
  s,t       : string;
  i,j,k,m,n : integer;
  x,y,r     : integer;
  src       : text;
  roughness : integer;
  dx,dy     : integer;
  found     : boolean;

  procedure MarkSeaMonster(x,y : integer);
  begin
    WriteLn('Marking Sea Monster at (',x,',',y,')');
    for dx := 0 to 19 do
      for dy := 0 to 2 do
        if (SeaMonster[dy+1][dx+1] = '#') then
          if (ocean[y+dy][x+dx] = '#') then
            Ocean[y+dy][x+dx] := 'O'
          else
            WriteLn('ABORT');
  end;



begin
  StartTime := Now;

  assign(src,'advent2020_20_picture.txt');
  reset(src);
  for i := 1 to 96 do
    readln(src,ocean[i]);
  close(src);

  for y := 1 to 94 do
    for x := 1 to 76 do
      begin
        found := true;
        for dx := 0 to 19 do
          for dy := 0 to 2 do
            if (SeaMonster[dy+1][dx+1] = '#') and (ocean[y+dy][x+dx] <> '#') then
                found := false;
        if found then
          MarkSeaMonster(x,y);
      end;

  // flip Y
  for y := 1 to 94 do
    for x := 1 to 76 do
      begin
        found := true;
        for dx := 0 to 19 do
          for dy := 0 to 2 do
            if (SeaMonster[(2-dy)+1][dx+1] = '#') and (ocean[y+dy][x+dx] <> '#') then
                found := false;
        if found then
          MarkSeaMonster(x,y);
      end;

  for y := 1 to 96 do
    ocean[y] := reverse(ocean[y]);

  for y := 1 to 94 do
    for x := 1 to 76 do
      begin
        found := true;
        for dx := 0 to 19 do
          for dy := 0 to 2 do
            if (SeaMonster[dy+1][dx+1] = '#') and (ocean[y+dy][x+dx] <> '#') then
                found := false;
        if found then
          MarkSeaMonster(x,y);
      end;

  // flip Y
  for y := 1 to 94 do
    for x := 1 to 76 do
      begin
        found := true;
        for dx := 0 to 19 do
          for dy := 0 to 2 do
            if (SeaMonster[(2-dy)+1][dx+1] = '#') and (ocean[y+dy][x+dx] <> '#') then
                found := false;
        if found then
          MarkSeaMonster(x,y);
      end;

  oldocean := ocean;
  for x := 1 to 96 do
    for y := 1 to 96 do
      ocean[97-y][x] := oldocean[x][y];


  for y := 1 to 94 do
    for x := 1 to 76 do
      begin
        found := true;
        for dx := 0 to 19 do
          for dy := 0 to 2 do
            if (SeaMonster[dy+1][dx+1] = '#') and (ocean[y+dy][x+dx] <> '#') then
                found := false;
        if found then
          MarkSeaMonster(x,y);
      end;

  // flip Y
  for y := 1 to 94 do
    for x := 1 to 76 do
      begin
        found := true;
        for dx := 0 to 19 do
          for dy := 0 to 2 do
            if (SeaMonster[(2-dy)+1][dx+1] = '#') and (ocean[y+dy][x+dx] <> '#') then
                found := false;
        if found then
          MarkSeaMonster(x,y);
      end;

  for y := 1 to 96 do
    ocean[y] := reverse(ocean[y]);

  for y := 1 to 94 do
    for x := 1 to 76 do
      begin
        found := true;
        for dx := 0 to 19 do
          for dy := 0 to 2 do
            if (SeaMonster[dy+1][dx+1] = '#') and (ocean[y+dy][x+dx] <> '#') then
                found := false;
        if found then
          MarkSeaMonster(x,y);
      end;

  // flip Y
  for y := 1 to 94 do
    for x := 1 to 76 do
      begin
        found := true;
        for dx := 0 to 19 do
          for dy := 0 to 2 do
            if (SeaMonster[(2-dy)+1][dx+1] = '#') and (ocean[y+dy][x+dx] <> '#') then
                found := false;
        if found then
          MarkSeaMonster(x,y);
      end;





  for i := 1 to 96 do
    writeln(i:3,' ',ocean[i]);


  roughness := 0;
  for y := 1 to 96 do
    for x := 1 to 96 do
      if ocean[y][x] = '#' then
        inc(roughness);

  WriteLn('Roughness = ',Roughness);

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
  readln;
end.

