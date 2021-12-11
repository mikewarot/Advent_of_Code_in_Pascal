unit MyStrings;

interface

  type
    CharSet = Set of Char;

  procedure SkipSpace(Var S : String);

  function GrabString(Var S : String): String;

  function GrabNumber(Var S : String): Int64;

  function GrabUntil(Var S : String; Delimiter : CharSet):String;


implementation

  procedure SkipSpace(Var S : String);
  begin
    While (S <> '') AND (S[1] in [' ',',',#9,#13,#10]) do
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
    x := x * sign;
    GrabNumber := X;
  end;

  function GrabUntil(Var S : String; Delimiter : CharSet):String;
  var
    t : string;
  begin
    Skipspace(S);
    t := '';
    SkipSpace(S);
    while (s <> '') AND NOT(S[1] in Delimiter) do
    begin
      t := t + s[1];
      delete(s,1,1);
    end;

    while (S <> '') AND (S[1] in Delimiter) do
      delete(s,1,1);

    GrabUntil := T;
  end; // GrabUntil

end.

