program advent2015_13a;
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
  Guest1,Guest2 : string;
  Key1, Key2    : integer;
  Delta : Int64;
  Guests : TStringList;
  Deltas : Array[0..1000] of Array[0..1000] of Int64;
  i,j,k : int64;

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
  Guests := TStringList.Create;
  for i := 0 to 1000 do
     for j := 0 to 1000 do
        Deltas[i,j] := 0;

  while not eof do
  begin
    readln(s);
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
    Deltas[Key1,Key2] := Delta;
  end;

  WriteLn('GuestCount = ',Guests.Count);

end.

