program advent2020_23a;
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

  Function WordCount(S : String):Integer;
  var
    value : integer;
  begin
    value := 0;
    while getword(s) <> '' do
      inc(value);
    WordCount := value;
  end;

  Function Score(Deck : String):Integer;
  var
    SumOfCards : Integer;
    TotalScore : integer;
  begin
    SumOfCards := 0;
    TotalScore := 0;
    While Deck <> '' do
    begin
      Inc(SumOfCards,GetNum(Deck));
      Inc(TotalScore,SumofCards);
    end;
    Score := TotalScore;
  end;

  Function PlayGame(Deck1,Deck2 : String):Integer;
  var
    Turns      : Array[1..10000] of string;
    TurnCount  : Integer;
    Card1,Card2 : Integer;
    Winner     : Integer;
    PreviousTurn : Integer;
    NewDeck1,
    NewDeck2    : String;
    S : String;
    i : integer;
  begin
    WriteLn('FunctionPlayGame');
    WriteLn('Player 1 : ',Deck1);
    WriteLn('Player 2 : ',Deck2);

    TurnCount := 0;

    Repeat
      Inc(TurnCount);
      Turns[TurnCount] := Deck1+' : '+Deck2;
      WriteLn('Turn [',TurnCount,'] Saved : ',Turns[TurnCount]);

      Winner := 0;
      for PreviousTurn := 1 to TurnCount-1 do
        if (Turns[PreviousTurn] = Turns[TurnCount]) then
          begin
            WriteLn('Matched previous turn #',PreviousTurn);
            Winner := 1;
          end;

      Card1 := GetNum(Deck1);
      Card2 := GetNum(Deck2);

      If Winner = 1 then
        Deck1 := Deck1 + ' ' + Card1.ToString + ' ' + Card2.ToString
      else
        begin
          if (Card1 <= WordCount(Deck1)) AND (Card2 <= WordCount(Deck2)) then
            begin
              WriteLn('Recurse!');
              S := Deck1;  NewDeck1 := GetWord(s); for i := 2 to Card1 do NewDeck1 := NewDeck1 + ' ' + GetWord(s);
              S := Deck2;  NewDeck2 := GetWord(s); for i := 2 to Card2 do NewDeck2 := NewDeck2 + ' ' + GetWord(s);
              Winner := PlayGame(NewDeck1,NewDeck2);
              If Winner = 1 then
                Deck1 := Deck1 + ' ' + Card1.ToString + ' ' + Card2.ToString
              else
                Deck2 := Deck2 + ' ' + Card2.ToString + ' ' + Card1.ToString;
              Winner := 0;
            end
          else
            If Card1 > Card2 then
              Deck1 := Deck1 + ' ' + Card1.ToString + ' ' + Card2.ToString
            else
              Deck2 := Deck2 + ' ' + Card2.ToString + ' ' + Card1.ToString;
        end;

      If Deck1 = '' then Winner := 2;
      If Deck2 = '' then Winner := 1;
    until Winner <> 0;

    WriteLn('Winner = ',Winner);
    WriteLn('Deck 1 (',Score(Deck1),' points): ',Deck1);
    WriteLn('Deck 2 (',Score(Deck2),' points): ',Deck2);
    WriteLn('EXIT PlayGame');
    PlayGame := Winner;
  end;


var
  StartTime  : TDateTime;
  done       : boolean;
  s,t        : string;
  i,j,k,m,n  : integer;
  Deck,
  Pickup     : string;
  Target     : char;
  Turn       : Integer;


begin
  StartTime := Now;
  done := false;

  writeln('Input Section');
  readln(Deck);
  WriteLn(Deck);

  writeln;
  writeln('Processing Section');
  writeln;

  For Turn := 1 to 100 do
    begin
      WriteLn;
      WriteLn('Deck = ',Deck);
      Deck := Deck + Deck[1];
      Target := Pred(Deck[1]);
      If Target = '0' then
        Target := '9';
      Delete(Deck,1,1);

      Pickup := Copy(Deck,1,3);
      Delete(Deck,1,3);

      WriteLn('Pickup = ',Pickup);

      While Pos(Target,Deck) = 0 do
        begin
          dec(target);
          if target = '0' then target := '9';
        end;

      WriteLn('Target = ',Target);

      Insert(Pickup,Deck,Pos(target,deck)+1);

      WriteLn('Deck = ',Deck);
    end; // for turn

  deck := deck + deck;
  delete(deck,1,pos('1',deck));
  delete(deck,9,99);
  WriteLn('Order after 100 = ',Deck);

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
end.

