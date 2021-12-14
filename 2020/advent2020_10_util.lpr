program advent2020_10_util;

var
  bits : integer;
  i,j,k : integer;
  top  : integer;
  last : integer;
  valid : boolean;
  count : integer;

begin
  top := 20;
  count := 0;
  for bits := 0 to (1 shl top)-1 do
  begin
    last := 0;
    valid := true;
    for i := 1 to top-1 do
      if (bits AND (1 shl i-1)) <> 0 then
      begin
        if i-last > 3 then valid := false;
        last := i;
      end;

    if top-last > 3 then valid := false;
    if valid then
    begin
      inc(count);
      writeln(bits,' ',count);
    end;
  end;
end.

