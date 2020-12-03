program advent2015_07a;

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
  getnum := value;
end;

function getname(var s : string): string;
var
  c : char;
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
  getkeyword := value;
end;

procedure match_arrow(var s : string);
var
  p : integer;
begin
  p := pos('->',s);
  if p <> 0 then
    delete(s,1,p+1);
end;

var
  s,t   : string;
  a,b,c,d : integer;
  count,i,j,k : integer;
  bright : integer;

begin
  readln(s);
  while s <> '' do
  begin
    while s <> '' do
      case s[1] of
        '0'..'9' : begin
                     a := getnum(s);
                     writeln('Number : ',a);
                   end;
        'a'..'z' : begin
                     t := getname(s);
                     writeln('Name : ',t);
                   end;
        'A'..'Z' : begin
                    t := getkeyword(s);
                    writeln('Keyword : ',t);
                  end;
        '-'      : match_arrow(s);
        else
          delete(s,1,1);
      end;
    readln(s);
  end;
end.

