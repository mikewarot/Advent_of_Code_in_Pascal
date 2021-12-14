program advent2020_22a_fancy_premature_optimization;
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

var
  CardCount    : integer;
  CardSequence : integer;
  CardValue    : array[1..10000] of integer;
  CardOwner    : array[1..10000] of integer;
  CardOrder    : array[1..10000] of integer;
  playerfirstcard : array[1..10] of integer;
  playerCardCount : array[1..10] of integer;
  playerName   : array[1..10] of string;
  PlayerCount  : integer;


var
  StartTime  : TDateTime;
  done       : boolean;
  s,t        : string;
  i,j,k,m,n  : integer;
  Card       : integer;
  Player,
  TurnWinner,
  TurnCardCount : Integer;
  GameWinner : Integer;

  procedure DumpCards;
  var
    SumOfCards  : integer;
    PlayerScore : integer;
  begin
    playerscore := 0;
    SumOfCards  := 0;
    for Player := 1 to playercount do
      begin
        Write('Player (',Player,') ',PlayerName[Player],' : ');
        for i := 0 to CardSequence do
          for Card := 1 to CardCount do
            if (CardOrder[Card] = i) and  (CardOwner[Card] = Player) then
              begin
                Inc(SumOfCards,CardValue[Card]);
                Inc(PlayerScore,SumOfCards);
                Write(CardValue[Card],' ');
              end;

        WriteLn(' Score = ',PlayerScore);
      end;
  end;

begin
  StartTime := Now;
  done := false;
  cardcount := 0;
  cardSequence := 0;
  playercount := 0;

  writeln('Input Section');
  repeat
    readln(s);
    if GetWord(s) = 'Player' then
    begin
      Inc(PlayerCount);
      PlayerName[PlayerCount] := GetWord(s);
      PlayerFirstCard[PlayerCount] := CardCount+1;
      PlayerCardCount[PlayerCount] := 0;
      Expect(s,':');
      repeat
        readln(s);
        if s <> '' then
        begin
//          WriteLn('Card: [',s,']');
          Inc(CardCount);
          Inc(CardSequence);
          Inc(PlayerCardCount[PlayerCount]);
          CardValue[CardCount] := GetInteger(s);
          CardOwner[CardCount] := PlayerCount;   // the current player owns this card
          CardOrder[CardCount] := 0;             // while we're dealing, all cards are "new"
        end
        else
          done := true;
//        writeLn('Leftover: ',s);
      until done or eof;
      done := false;
    end;
  until eof;

  WriteLn(PlayerCount,' Players');
  for i := 1 to playercount do
    WriteLn('Player(',i,') is ',PlayerName[i],' with ',PlayerCardCount[i],' cards.');
  WriteLn(CardCount,' Cards accepted');
  DumpCards;

  writeln;
  writeln('Processing Section');
  writeln;

  Done := False;
  n := 10000;
  repeat

    TurnWinner := 0;
    TurnCardCount := 0;
    For Player := 1 to PlayerCount do
      If PlayerCardCount[Player] > 0 then
      begin
        If TurnWinner = 0 then
          TurnWinner := Player;   // handle player with no cards
        Inc(TurnCardCount);       // how many cards in this round?
        WriteLn('  Player (',Player,') plays ',CardValue[PlayerFirstCard[Player]]);
        If CardValue[PlayerFirstCard[Player]] > CardValue[PlayerFirstCard[TurnWinner]] then
          TurnWinner := Player;   // actual test to see who has the highest value, on tie goes to first player with card
      end;
    WriteLn('Winner Is Player(',TurnWinner,') who gets ',TurnCardCount,' cards');

    DumpCards;

    Inc(CardSequence);
    CardOrder[PlayerFirstCard[TurnWinner]] := CardSequence;
    For Player := 1 to PlayerCount do
      If (PlayerCardCount[Player] > 0) AND (Player <> TurnWinner) then  // skip everone out of the game
      begin
        Inc(CardSequence);                 // use this to order cards once they get scrambled
        CardOwner[PlayerFirstCard[Player]] := TurnWinner;   // assign card to the Winner (even if same player)
        CardOrder[PlayerFirstCard[Player]] := CardSequence; // give it a new order number
        Dec(PlayerCardCount[Player]);                       // remove the card from the owners count
        Inc(PlayerCardCount[TurnWinner]);                   // add it to the winners count
      end;

    DumpCards;

    // Find first card for all players left, despite scrambling from multiple loops
    For Player := 1 to PlayerCount do
      If PlayerCardCount[Player] > 0 then  // skip everone out of the game
        begin
          PlayerFirstCard[Player] := 0;
          for Card := 1 to CardCount do
            If (CardOwner[Card] = Player) then
              begin
                If PlayerFirstCard[Player] = 0 then
                  PlayerFirstCard[Player] := Card;
                If CardOrder[Card] < CardOrder[PlayerFirstCard[Player]] then
                  PlayerFirstCard[Player] := Card;
              end;
        end;

    DumpCards;

    WriteLn('Current Statistics');
    For Player := 1 to PlayerCOunt do
      begin
        WriteLn('Player (',Player,') has ',PlayerCardCount[Player],' Cards');
        If PlayerCardCount[Player] = CardCount then
          begin
            WriteLn('Player (',Player,') ',PlayerName[Player],' is the winner!');
            Done := True;
          end;
      end;
    dec(n);
    if n <= 0 then
      done := true;
  until done;

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
end.

