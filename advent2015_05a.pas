program advent2015_05a;
var
  s    : string;
  i,j,k : integer;
  nice : boolean;
  vowels : integer;
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
    vowels := 0;
    for c in s do
      case c of
        'a','e','i','o','u' : inc(vowels);
      end;
    if vowels < 3 then naughty('Less than 3 vowels');

    doubles := 0;
    for c in ['a'..'z'] do
      if pos(c+c,s) <> 0 then inc(doubles);
    if doubles = 0 then naughty('No double letters');

    if pos('ab',s) <> 0 then naughty('ab not allowed');
    if pos('cd',s) <> 0 then naughty('cd not allowed');
    if pos('pq',s) <> 0 then naughty('pq not allowed');
    if pos('xy',s) <> 0 then naughty('xy not allowed');

    If nice then writeln('Nice');
    if nice then inc(nicecount) else inc(naughtyCount);
    readln(s);
  end;
  Writeln('Naughty : ',NaughtyCount);
  Writeln('Nice    : ',NiceCount);
  Writeln('Total   : ',NaughtyCount+NiceCount);

end.

