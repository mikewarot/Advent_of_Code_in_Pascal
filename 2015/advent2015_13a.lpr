program advent2015_13a;
uses
  classes, fgl, my_permute;

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
  src : text;
  s : string;
  Guest1,Guest2 : string;
  Key1, Key2    : integer;
  Best,Delta : Int64;
  Guests : TStringList;
  Deltas : Array[1..1000] of Array[1..1000] of Int64;
  i,j,k : int64;
  Ordering : Array[1..1000] of integer;


  function AddUnsorted(S : String): integer;
  var
    key : integer;
  begin
    key := Guests.IndexOf(s);   // if it's already there, find it
    if key = -1 then
      key := Guests.Add(s);  // otherwise add it
    AddUnsorted := key;
  end;



begin
  assign(src,'Advent2015_13a_input.txt');
  reset(src);
  Guests := TStringList.Create;
  for i := 1 to 1000 do
     for j := 1 to 1000 do
        Deltas[i,j] := 0;


  while not eof(src) do
  begin
    readln(src,s);
    Guest1 := GrabString(S);
    GrabString(S);  // skips "would"

    If GrabString(S) = 'lose' then
      Delta := -GrabNumber(S)
    else
      Delta := GrabNumber(S);

    GrabString(S); // skips happiness
    GrabString(S); // skips units
    GrabString(S); // skips by
    GrabString(S); // skips sitting
    GrabString(S); // skips next
    GrabString(S); // skips to
    SkipSpace(S);
    Delete(S,Length(S),1);
    Guest2 := S;

    WriteLn(Guest1,' - ',Guest2,' ',Delta);

    Key1 := AddUnsorted(Guest1);
    Key2 := AddUnsorted(Guest2);
    Deltas[Key1+1,Key2+1] := Delta;
  end;
  close(src);

  for i := 1 to Guests.Count do
  begin
    for j := 1 to Guests.Count do
      write(Deltas[i,j]:6);
    writeln;
  end;

  Best := -99999999;
  WriteLn('GuestCount = ',Guests.Count);
  for i := 1 to factorial(guests.count) do
  begin
    permute(Guests.Count,i,Ordering);
    delta := 0;
    for j := 1 to Guests.Count-1 do
    begin
      write(Ordering[j],' ');
      delta := delta + Deltas[Ordering[j],Ordering[j+1]] + Deltas[Ordering[j+1],Ordering[j]];
    end;
    delta := delta + Deltas[Ordering[Guests.Count],Ordering[1]] + Deltas[Ordering[1],Ordering[Guests.Count]];
    Write(Ordering[Guests.Count],' ');
    writeln('Delta = ',Delta);
    If Delta > Best then
      Best := Delta;
  end;

  WriteLn('Best = ',Best);

  Readln;

end.

