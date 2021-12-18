program advent2021_17a;
uses Classes, Math, MyStrings, fgl;

var
  s : string;
  i,j,k,x,y,z,dx,dy : int64;
  x1,x2,y1,y2 : int64;
  t : int64;
  top : int64;



begin
//  readln(s);
  s := 'target area: x=88..125, y=-157..-103';

  x1 := 88;
  x2 := 125;
  y1 := -157;
  y2 := -103;

  x := 0; dx := 15;
  y := 0; dy := 156;
  top := y;

  t := 0;
  repeat
    inc(t);
    inc(x,dx);
    inc(y,dy);
    if dx > 0 then dec(dx);
    if dx < 0 then inc(dx);
    dec(dy);
    writeln(t,':',x,',',y,'    ',dx,',',dy);
    if (x >= x1) AND (x <= x2) AND (y >= y1) AND (y <= y2) then
      writeln('HIT!');

    if y > top then top := y;

  until (y <= Y1) or (x > x2) or (t > 10000);

  writeln(s);
  writeln(top);


  readln;
end.

