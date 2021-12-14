program advent2020_02a;

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
  s : string;
  a,b : integer;
  c,t : char;
  occurances : integer;
  valid : boolean;
  Good,Bad : integer;
begin
  good := 0;
  bad := 0;
  readln(s);
  while s <> '' do
  begin
    a := getnum(s);
    b := getnum(s);
    c := s[2];
    delete(s,1,3);
    occurances := 0;
    for t in s do
      if t = c then inc(occurances);
    valid := (occurances >= a) and (occurances <= b);

    if valid then inc(good) else inc(bad);
    if valid then write('OK - ') else Write('Bad - ');
    writeln('Min = ',a,',','Max = ',b,' Occurances = ',occurances);

    readln(s);
  end;
  WriteLn('Good  : ',good);
  WriteLn('Bad   : ',bad);
  WriteLn('Total : ',good+bad);
end.

