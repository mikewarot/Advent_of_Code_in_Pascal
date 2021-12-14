program advent2021_04a;

uses MyStrings;

type
  tBingoCard = record
    hits    : array[1..5] of array[1..5] of boolean;
    numbers : array[1..5] of array[1..5] of integer;
  end;


var
  src : text;
  s : string;
  count : int64;
  draws : string;
  draw  : integer;
  Cards : Array[1..1000] of tBingoCard;
  CardCount : integer;

  procedure readcard;
  var
    i,j,k : integer;
    s : string;
  begin
    readln(src,s);
    Inc(CardCount);
    for i := 1 to 5 do
    begin
      readln(src,s);
      for j := 1 to 5 do
      begin
        Cards[CardCount].hits[i,j] := false;
        Cards[CardCount].numbers[i,j] := GrabNumber(s);
      end; // for j
    end; // for i
  end;  // readcard

var
  i,j,k,x,y : int64;
  Winner  : int64;
  Unmarked : int64;
begin
  assign(src,'advent2021_04a_input.txt');
  reset(src);

  CardCount := 0;
  Winner := 0;

  readln(src,draws);
  count := 0;
  s := '';
  while not eof(src) do
  begin
    readcard;

    writeln(count,' ',s);
  end;
  close(src);
  WriteLn(CardCount,' cards read in');

  repeat
    draw := GrabNumber(draws);
    WriteLn('Draw = ',Draw);
    WriteLn('Draws = [',Draws,']');
    for i := 1 to CardCount do
      for x := 1 to 5 do
        for y := 1 to 5 do
          if Cards[i].numbers[x,y] = draw then
            Cards[i].hits[x,y] := true;

    for i := 1 to CardCount do
      for x := 1 to 5 do
        if Cards[i].hits[x,1] AND
           Cards[i].hits[x,2] AND
           Cards[i].hits[x,3] AND
           Cards[i].hits[x,4] AND
           Cards[i].hits[x,5] then
           winner := i;

    for i := 1 to CardCount do
      for y := 1 to 5 do
        if Cards[i].hits[1,y] AND
           Cards[i].hits[2,y] AND
           Cards[i].hits[3,y] AND
           Cards[i].hits[4,y] AND
           Cards[i].hits[5,y] then
           winner := i;

  until (draws = '') or (Winner <> 0);

  unmarked := 0;
  for x := 1 to 5 do
    for y := 1 to 5 do
      if not Cards[winner].hits[x,y] then inc(Unmarked,Cards[winner].numbers[x,y]);

  WriteLn('Last Draw = ',Draw);
  WriteLn('Winner = ',Winner);
  WriteLn('Unmarked = ',UnMarked);
  WriteLn('answer = ',Draw*Unmarked);
  readln;
end.

