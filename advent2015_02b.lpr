program advent2015_02b;

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

var
  src   : text;
  s,x   : string;
  a,b,c : integer;
  sum   : integer;
  ab,ac,bc : integer;
  smallest : integer;
  ribbon : integer;
  count : integer;
begin
  sum := 0;
  count := 0;
  assign(src,'advent2015_02a.txt');
  reset(src);
  while not eof(src) do
  begin
    inc(count);
    readln(src,s);
    x := s;
    a := getnum(x);
    b := getnum(x);
    c := getnum(x);
    ab := a+b;
    ac := a+c;
    bc := b+c;
    smallest := ab;
    if ac < smallest then smallest := ac;
    if bc < smallest then smallest := bc;

    ribbon := 2*smallest + a*b*c;

    writeln('[',s,'] --> ',a,',',b,',',c,' ab=',ab,' ac=',ac,' bc=',bc,' smallest=',smallest,' ribbon=',ribbon);
    sum := sum + ribbon;
  end;
  close(src);
  writeln('Total of ',count,' presents, totalling ',sum,' feet of required ribbon');
end.

