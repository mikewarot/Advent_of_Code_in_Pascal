program advent2021_17b;
uses Classes, Math, MyStrings, fgl;
var
  x1,x2,y1,y2 : int64;


  function testfire(dx,dy : int64):boolean;
  var
    x,y : int64;
    t : int64;
    hit : boolean;
  begin
    t := 0;
    x := 0;
    y := 0;
    hit := false;

    repeat
      inc(t);
      inc(x,dx);
      inc(y,dy);
      if dx > 0 then dec(dx);
      if dx < 0 then inc(dx);
      dec(dy);
      writeln(t,':',x,',',y,'    ',dx,',',dy);
      if (x >= x1) AND (x <= x2) AND (y >= y1) AND (y <= y2) then
      begin
        writeln('HIT!');
        hit := true;
      end;

    until HIT or (y <= Y1) or (x > x2) or (t > 10000);
    TestFire := Hit;
  end;

var
  s : string;
  dx,dy : int64;
  count : int64;

begin
//  readln(s);
  s := 'target area: x=88..125, y=-157..-103';

  x1 := 88;
  x2 := 125;
  y1 := -157;
  y2 := -103;

  count := 0;

  for dx := 0 to 125 do
    for dy := -200 to 200 do
      if TestFire(dx,dy) then inc(count);

  writeln('Total of ',count,' combinations');


  readln;
end.

