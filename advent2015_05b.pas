program advent2015_05b;
var
  s,t,u   : string;
  i,j,k : integer;
  nice : boolean;
  doubles : integer;
  c : char;
  NaughtyCount,NiceCount : integer;

  procedure naughty(cause : string);
  begin
    nice := false;
    WriteLn('Naughty because '+cause);
  end;

begin
  niceCount := 0;
  naughtyCount := 0;

  readln(s);
  while s <> '' do
  begin
    nice := true;

    doubles := 0;
    for i := 1 to length(s)-3 do
    begin
      t := copy(s,i,2);
      u := copy(s,i+2,length(s));
      if pos(t,u) <> 0 then
        inc(doubles);
    end;

    if doubles = 0 then naughty('No matching pair of repeated strings');
    doubles := 0;
    for i := 1 to length(s)-2 do
      if s[i] = s[i+2] then
        inc(doubles);
    if doubles = 0 then naughty('No repeated character after a skip');

    If nice then writeln('Nice');
    if nice then inc(nicecount) else inc(naughtyCount);
    readln(s);
  end;
  Writeln('Naughty : ',NaughtyCount);
  Writeln('Nice    : ',NiceCount);
  Writeln('Total   : ',NaughtyCount+NiceCount);

end.

