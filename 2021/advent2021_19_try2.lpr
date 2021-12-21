program advent2021_19_try2;
uses  sysutils, mystrings;

var
  s : string;
  src : text;

begin
  assign(src,'advent2021_19_sample.txt');
  reset(src);
  while not eof(src) do
  begin
    readln(src,s);
    if pos('---',s) <> 0 then
      s := '';

    writeln(s);
  end;
  close(src);

  readln;
end.

