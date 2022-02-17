program advent2021_25a;
uses sysutils, dateutils, Classes, mystrings, fgl;

type
  state = (empty,east,south);

const
  statechar : array[state] of char = ('.','>','v');

var
  StartTime   : TDateTime;
  Src : Text;
  S : String;

  grid,oldgrid : array[0..1000] of array[0..1000] of state;
  xsize,ysize : integer;

  i,j,k : int64;
  x,y   : int64;
  N : int64;
  SaveSerial : String;
  fubar : int64;
  turn,moves : longint;
begin
  StartTime := Now;

  xsize := 0;
  ysize := 0;

  Assign(Src,'Advent2021_25.txt');
  reset(src);
  while not eof(src) do
  begin
    readln(src,s);
    skipspace(s);
    if s <> '' then
    begin
      if length(s) > xsize then xsize := length(s);
      for i := 1 to length(s) do
      case s[i] of
        '.' : grid[i-1,ysize] := empty;
        '>' : grid[i-1,ysize] := east;
        'v' : grid[i-1,ysize] := south
      end;
      inc(ysize);
    end;
  end;
  close(src);

  WriteLn('Grid Size = ',Xsize,',',Ysize);
  for y := 0 to ysize-1 do
  begin
    for x := 0 to xsize-1 do
      write(StateChar[Grid[x,y]]);
    writeln;
  end; // for y
  WriteLn('Initial State');
  WriteLn;


  turn := 0;
  repeat
    inc(turn);
    moves := 0;
    oldgrid := grid;
    for y := 0 to Ysize-1 do
    begin
      for x := 0 to Xsize-1 do
      begin
        if (oldgrid[x,y] = east) AND (oldgrid[(x+1) mod xsize,y] = empty) then
        begin
          grid[(x+1) mod xsize,y] := east;
          grid[x,y] := empty;
          inc(moves);
        end;
      end; // for x
    end; // for y

    oldgrid := grid;

    for x := 0 to Xsize-1do
    begin
      for y := 0 to Ysize-1 do
      begin
        if (oldgrid[x,y] = south) AND (oldgrid[x,(y+1) mod ysize] = empty) then
        begin
          grid[x,(y+1) mod ysize] := south;
          grid[x,y] := empty;
          inc(moves);
        end;
      end; // for y
    end; // for x


(*
    for y := 0 to ysize-1 do
    begin
      for x := 0 to xsize-1 do
        write(StateChar[Grid[x,y]]);
      writeln;
    end; // for y
*)
    WriteLn('Turn : ',Turn,',',Moves,' moves');
//    readln;
  until moves=0;

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
  readln;
end.
