program advent2020_11a;
uses
  classes, sysutils, dateutils;
var
  OldBuffer,
  Buffer    : Array[1..1000] of String;
  Width,Height : Integer;
  StartTime : TDateTime;
  x,y,dx,dy : integer;
  i,j,k,n   : integer;
  linecount : integer;
  c         : char;
  count     : integer;
  done      : boolean;

  function getseat(xx,yy : integer):integer;
  begin
    if (xx < 1) or (xx > width) OR
       (yy < 1) or (yy > height) then
      getseat := 0
    else
    begin
      case oldbuffer[yy][xx] of
        '.','L' : getseat := 0;
        '#'     : getseat := 1;
      else
        getseat := 0;
      end; // case
    end; // if else begin
  end;

begin
  StartTime := Now;
  linecount := 0;
  repeat
    inc(linecount);
    readln(buffer[linecount]);
    writeln(linecount:4,' ',buffer[linecount]);
  until eof;
  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');

  height := linecount;
  width := length(buffer[1]);
  WriteLn('Height = ',Height,'   Width = ',Width);

  repeat
    OldBuffer := Buffer;

    for x := 1 to width do
      for y := 1 to height do
      begin
        count := 0;
        for dx := -1 to 1 do
          for dy := -1 to 1 do
            if (dx <> 0) OR (dy <> 0) then
              count := count + getseat(x+dx,y+dy);

        case oldbuffer[y][x] of
          '#' : if count >= 4 then
                  buffer[y][x] := 'L';
          'L' : if count = 0 then
                  buffer[y][x] := '#';
        end; // case
      end; // for y

    writeln;
    for y := 1 to height do
      writeln(y:4,' ',buffer[y]);

    done := true;
    count := 0;
    for y := 1 to height do
      for x := 1 to width do
        if buffer[y][x] = '#' then
          inc(count);
    Writeln(Count,' seats occupied');

    for y := 1 to height do
      if buffer[y] <> oldbuffer[y] then
        done := false;

    writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
  until done;
end.

