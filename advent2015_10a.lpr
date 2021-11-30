program advent2015_10a;
uses
  SysUtils;

  function numberize(s : string):string;
  var
    i,j,k : integer;
    c, lastC : char;
    count : integer;
    t : string;
  begin
    t := '';
    lastC := ' ';
    count := 0;
    for c in s do
    begin
      if c = lastC then
        inc(count)
      else
      begin
        if count > 0 then
        begin
          t := t + IntToStr(count) + lastC;
          count := 1;
          lastC := C;
        end
        else
        begin
          count := 1;
          lastC := c;
        end;
      end;
    end;
    if count > 0 then
    begin
      t := t + IntToStr(count) + lastC;
      count := 1;
      lastC := C;
    end;
    numberize := t;
  end; // numberize



var
  s : string;
  i : integer;

begin
  repeat
    readln(s);
    for i := 1 to 50 do
    begin
      s := numberize(s);
      writeln(i,' ',length(s));
    end;
  until s = '';
end.

