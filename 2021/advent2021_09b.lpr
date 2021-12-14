program advent2021_09b;
uses Math, MyStrings;

var
  src : text;
  s,t : string;
  count : integer;
  i,j,k : integer;
  height : array[0..1000] of array[0..1000] of integer;
  hits : integer;
  risk : integer;
  sum  : integer;
  first,last : integer;

  bc : integer;
  found : integer;
  id,size : array[1..1000] of integer;

  product : int64;

begin
  assign(src,'advent2021_09a_input.txt');
  reset(src);

  for i := 0 to 1000 do
    for j := 0 to 1000 do
      height[i,j] := 1000000;

  count := 0;
  while not eof(src) do
  begin
    readln(src,s);
    inc(count);
    for i := 1 to length(s) do
      height[count,i] := ord(s[i])-ord('0');

    writeln(s);
  end;
  close(src);

  hits := 0;
  sum := 0;
  for i := 1 to count do
    for j := 1 to length(s) do
      begin
        risk := 0;
        if (height[i,j] < height[i,j+1]) AND
           (height[i,j] < height[i,j-1]) AND
           (height[i,j] < height[i+1,j]) AND
           (height[i,j] < height[i-1,j]) then
        begin
          risk := height[i,j] + 1;
          inc(sum,risk);
          inc(hits);
        end; // if
      end; // for j

  writeln('Hits = ',Hits);
  Writeln('Risk Sum = ',Sum);

  for i := 0 to 1000 do
    for j := 0 to 1000 do
      if height[i,j] >= 9 then
        height[i,j] := 0
      else
        height[i,j] := i*1000+j;

  for i := 1 to count do
  begin
    for j := 1 to length(s) do
      write(Height[i,j]:6);
    writeln;
  end;


  for k := 1 to count do
  begin
    for i := 1 to count do
      for j := 1 to length(s)-1 do
        if (height[i,j] <> 0) AND (height[i,j+1] <> 0)then
        begin
          height[i,j] := max(height[i,j],height[i,j+1]);
          height[i,j+1] := height[i,j];
        end;

    for i := 1 to count-1 do
      for j := 1 to length(s) do
        if (height[i,j] <> 0) AND (height[i+1,j] <> 0)then
        begin
          height[i,j] := max(height[i,j],height[i+1,j]);
          height[i+1,j] := height[i,j]
        end;
  end; // for k

  writeln;
  for i := 1 to count do
  begin
    for j := 1 to length(s) do
      write(Height[i,j]:6);
    writeln;
  end;

  bc := 0;
  id[1] := 0;
  for i := 1 to count do
    for j := 1 to length(s) do
    begin
      if height[i,j] <> 0 then
      begin
        found := -1;
        for k := 1 to bc do
          if id[k]=height[i,j] then
            found := k;
        if found = -1 then
        begin
          inc(bc);
          id[bc] := height[i,j];
          size[bc] := 0;
          found := bc;
        end;
        inc(size[found]);
      end;
    end;

  for i := 1 to bc do
  begin
    writeln(id[i],' ',size[i]);
  end;

  product := 1;
  found := 1;
  for i := 2 to bc do
    if size[i] > size[found] then
      found := i;

  writeln('Largest Basin --> ',size[found]);
  product := product * size[found];
  size[found] := 1;

  found := 1;
  for i := 2 to bc do
    if size[i] > size[found] then
      found := i;

  writeln('Largest Basin2 --> ',size[found]);
  product := product * size[found];
  size[found] := 1;

  found := 1;
  for i := 2 to bc do
    if size[i] > size[found] then
      found := i;

  writeln('Largest Basin3 --> ',size[found]);
  product := product * size[found];
  size[found] := 1;

  WriteLn('Product = ',product);

  readln;
end.

