program advent2022_02b;
uses
  mystrings,FGL;

  function RockPaperScissors(A,B : Integer):Integer;
  var
    diff : integer;
  begin
    diff := (b+3-a) mod 3;
    case diff of
      1 : result := 6;
      2 : result := 0;
      0 : result := 3;
    end;
  end;

  function ModRPS(A,B : Integer): Integer;
  begin
    result := RockPaperScissors(A,B)+B;
  end;

type
  TMap = specialize TFPGMap<String, Integer>;
var
  s : string;
  a,b : string;
  a_,b_ : integer;
  moves : TMap;
  score : integer;

begin
  score := 0;
  moves := TMap.Create;
  moves.Sorted:= True;

  moves.add('A',1);
  moves.add('B',2);
  moves.add('C',3);

  moves.add('X',3-1); // the delta instead of the move to play, in part b
  moves.add('Y',3-0);
  moves.add('Z',3+1);

  while not eof do
  begin
    readln(s);
    a := GrabString(s);   a_ := moves.KeyData[a];
    b := Grabstring(s);   b_ := moves.KeyData[b];

    b_ := (a_ + b_);
    while b_ > 3 do
      dec(b_,3);

    writeln('A,B = ',A,',',B,'    Decoded = ',A_,',',B_,' RPS = ',RockPaperScissors(A_,B_),' ModRPS = ',ModRPS(A_,B_));
    inc(score,ModRPS(A_,B_));
  end;
  WriteLn('Total Score : ',Score);
end.

