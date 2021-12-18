program advent2021_18a_fail2;
uses Sysutils, MyStrings;

Procedure AssertEqual(Actual,Expected : String; Description : String);
begin
  if Expected = Actual then
    WriteLn(Description,' passed!')
  else
  begin
    WriteLn(Description,' failed!');
    WriteLn(' Expected : ',Expected);
    WriteLn(' Got      : ',Actual);
    WriteLn;
    WriteLn;
  end; // if
end; // AssertEqual


procedure Expect(Var S : String; Expected : String);
begin
  If (S = '') or (Pos(Expected,S)<>1) then
    WriteLn('Expected ',Expected,'  got ',s,' instead!')
  else
    Delete(S,1,Length(Expected));
end;

type
  pPair = ^tPair;
  tPair = record
    a,b : integer;
    leafa,leafb : pPair;
  end;

  function ReadSnailNumber(var s : string):pPair;
  var
    this : pPair;
  begin
    this := new(pPair);
    this^.a := 0;
    this^.b := 0;
    this^.leafa := nil;
    this^.leafb := nil;

    Expect(S,'[');

    If S[1] = '[' then
      this^.leafa := ReadSnailNumber(S)
    else
      this^.a := grabnumber(s);
    Expect(S,',');

    If S[1] = '[' then
      this^.leafb := ReadSnailNumber(S)
    else
      this^.b := grabnumber(s);
    Expect(S,']');
    ReadSnailNumber := this;
  end;

  function SnailNumberToString(Z : pPair):string;
  var
    s,t : string;
  begin
    s := '[';
    if Z^.leafa <> nil then
      S := S + SnailNumberToString(Z^.leafa)
    else
      S := S + IntToStr(Z^.a);

    s := s + ',';

    if Z^.leafb <> nil then
      S := S + SnailNumberToString(Z^.leafb)
    else
      S := S + IntToStr(Z^.b);

    S := S + ']';

    SnailNumberToString := s;
  end;

  Function AddSnailNumber(Node1,Node2 : pPair):pPair;
  var
    this : pPair;
  begin
    this := new(pPair);
    this^.a := 0;
    this^.b := 0;
    this^.leafa := Node1;
    this^.leafb := Node2;
    AddSnailNumber := this;
  end;

  Procedure CheckNode(This : pPair, Depth : Integer)

var
  src : text;
  s,old_s,t : string;

  tree : pPair;
begin
  assign(src,'Advent2021_18_test1.txt');
  reset(src);
  while not eof(src) do
  begin
    readln(src,s);
    old_s := s;
    tree := ReadSnailNumber(S);
    t := SnailNumberToString(tree);

    AssertEqual(T,Old_S,'round trip to SnailNumber');
  end;
  close(src);

  assign(src,'Advent2021_18_test2.txt');
  reset(src);
  readln(src,s);
  tree := ReadSnailNumber(S);
  while not eof(src) do
  begin
    readln(src,s);
    tree := AddSnailNumber(tree,ReadSnailNumber(S));
  end;
  close(src);

  t := SnailNumberToString(tree);
  WriteLn('Result = ',t);




  readln;
end.
