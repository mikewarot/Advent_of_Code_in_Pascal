program advent2021_02b;
uses
  classes, fgl;

  procedure SkipSpace(Var S : String);
  begin
    While (S <> '') AND (S[1] in [' ',#9,#13,#10]) do
      delete(s,1,1);
  end;

  function GrabString(Var S : String): String;
  var
    t : string;
  begin
    t := '';
    SkipSpace(S);
    while (s <> '') AND NOT(S[1] in [' ',#9,#13,#10]) do
    begin
      t := t + s[1];
      delete(s,1,1);
    end;
    GrabString := T;
  end;

  function GrabNumber(Var S : String): Int64;
  var
    sign : int64;
    x    : Int64;
  begin
    sign := +1;
    x := 0;
    SkipSpace(S);
    if (s <> '') and (s[1] = '-') then
    begin
      sign := -1;
      delete(s,1,1);
    end;
    while (s <> '') AND (s[1] in ['0'..'9']) do
    begin
      x := x * 10;
      x := x + (ord(s[1])-ord('0'));
      delete(s,1,1);
    end;
    GrabNumber := X;
  end;

type
  tfal = set of Byte;

var
  s : string;
  x,y,aim : Int64;
  i,j,k : int64;
  delta : int64;
  direction : string;

begin
  x := 0;
  y := 0;
  aim := 0;
  while not eof do
  begin
    readln(s);
    direction := grabstring(s);
    delta := grabnumber(s);

    case direction of
      'up' : dec(aim,delta);       // x is depth
      'down' : inc(aim,delta);
      'forward' : begin
                    inc(y,delta);
                    inc(x,delta*aim);
      end;
    end;

    Writeln(direction,' ',delta);
    WriteLn(x,',',y);
  end;
  WriteLn(x*y);

end.

