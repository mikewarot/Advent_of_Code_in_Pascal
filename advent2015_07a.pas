program advent2015_07a;
uses
  Classes, SysUtils, fgl;

type
  tStringDictionary = specialize TFPGMap<string, string>;
  tWordDictionary   = specialize TFPGMap<string, Word>;

var
  stringexpr  : tStringDictionary;
  solvedexpr  : tWordDictionary;
  depth       : integer;

procedure skipspace(var s : string);
begin
  while (s <> '') and (S[1] in [' ',#9,#10,#13]) do
    delete(s,1,1);
end;

function getnum(var s : string):integer;
var
  c : char;
  value : integer;
begin
  value := 0;
  while (length(s) <> 0) and NOT(s[1] in ['0'..'9']) do
    delete(s,1,1);
  while (length(s) <> 0) and (s[1] in ['0'..'9']) do
  begin
    value := value * 10 + (ord(s[1])-ord('0'));
    delete(s,1,1);
  end;
  skipspace(s);
  getnum := value;
end;

function getname(var s : string): string;
var
  value : string;
begin
  value := '';
  while (length(s) <> 0) and NOT(s[1] in ['a'..'z']) do
    delete(s,1,1);
  while (length(s) <> 0) and (s[1] in ['a'..'z']) do
  begin
    value := value+s[1];
    delete(s,1,1);
  end;
  skipspace(s);
  getname := value;
end;

function getkeyword(var s : string): string;
var
  c : char;
  value : string;
begin
  value := '';
  while (length(s) <> 0) and NOT(s[1] in ['A'..'Z']) do
    delete(s,1,1);
  while (length(s) <> 0) and (s[1] in ['A'..'Z']) do
  begin
    value := value+s[1];
    delete(s,1,1);
  end;
  skipspace(s);
  getkeyword := value;
end;


  function Evaluate(S : String) : Word;
  var
    zz : word;
    key : string;
    fubar : string;
    i : integer;
    name : string;
    index : integer;
  begin
    fubar := s;
    inc(depth);
//    write('Depth : ',depth,' ',#13);
    zz := 0;
    case S[1] of
      '0'..'9' : zz := GetNum(s);
      'a'..'z' :
      begin
        name := GetName(S);
        index := SolvedExpr.IndexOf(name);
        if (index >= 0) then
          zz := SolvedExpr[name]
        else
        begin
          zz := Evaluate(stringexpr.KeyData[Name]);
          SolvedExpr.Add(Name,zz);
        end;
      end;
    end; // case
    key := GetKeyword(S);
    case key of
      'AND' : zz := zz and Evaluate(S);
      'OR'  : zz := zz or  Evaluate(S);
      'NOT' : zz := Evaluate(S) XOR $FFFF;
      'LSHIFT' : zz := zz shl Evaluate(S);
      'RSHIFT' : zz := zz shr Evaluate(S);
      '' : ;
    else
      Writeln('Unknown keyword : ',key);
    end;

    dec(depth);
    Evaluate := zz;
  end;

var
  s,t   : string;
  a,b,c,d : integer;
  count,i,j,k : integer;
  bright : integer;

  l : string;
  p : integer;
  expr : string;

begin
  stringexpr := tStringDictionary.Create;
  solvedExpr := tWordDictionary.Create;

  depth := 0;
  readln(s);
  while s <> '' do
  begin
    p := pos('->',s);
    expr := copy(s,1,p-2);
    l := copy(s,p+3,length(s));
    WriteLn('Expression : [',Expr,']  -->  (',l,')');

    stringexpr.Add(l,Expr);

    readln(s);
  end;

  WriteLn('a = ',Evaluate('a'));
end.

