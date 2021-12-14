program advent2021_09a;
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

  readln;
end.

