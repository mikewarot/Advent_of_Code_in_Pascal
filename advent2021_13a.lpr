program advent2021_13a;
uses Classes, Math, MyStrings, fgl;

var
  src : text;
  s,t : string;
  a,b : int64;
  i,j,k : integer;
  paper : array[0..2000] of array[0..2000] of integer;
  x,y : integer;
  MaxX,MaxY : integer;
  Count : Integer;
  axis : char;

procedure ShowPaper;
begin
  Count := 0;
  for y := 0 to MaxY do
  begin
    for x := 0 to MaxX do
      if paper[x,y] >= 1 then
      begin
        inc(count);
        Write('#');
      end
      else
        Write('.');
    writeln;
  end; // for y
  WriteLn('Count = ',Count);
end;

begin
  MaxX := 0;
  MaxY := 0;
  for i := 0 to 2000 do
    for j := 0 to 2000 do
      paper[i,j] := 0;

  assign(src,'advent2021_13a_input.txt');
  reset(src);

  readln(src,s);
  repeat
    x := grabnumber(s);
    y := grabnumber(s);
    writeln(x,' ',y);
    paper[x,y] := 1;
    if x > MaxX then MaxX := X;
    if y > MaxY then MaxY := Y;
    readln(src,s);
  until s = '';

  writeln('grid loaded');

  ShowPaper;
  while not eof(src) do
  begin
    readln(src,s);

    if s <> '' then
      delete(s,1,11);

    axis := s[1];
    delete(s,1,2);
    case axis of
      'x' : begin
              MaxX := GrabNumber(s);
              for x := 0 to MaxX do
                for y := 0 to MaxY do
                  Paper[x,y] := Paper[x,y] OR Paper[(2*MaxX)-X,y];
              Dec(MaxX);

            end; // fold x=
      'y' : begin
              MaxY := GrabNumber(s);
              for x := 0 to MaxX do
                for y := 0 to MaxY do
                  Paper[x,y] := Paper[x,y] OR Paper[x,(2*MaxY)-Y];
              Dec(MaxY);
            end; // fold y=
    end; // case


    writeln(s);
    ShowPaper;
  end; // while not eof(src)
  close(src);

  readln;
end.

