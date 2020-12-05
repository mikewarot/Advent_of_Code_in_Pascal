program advent2020_05a;
var
  s : string;
  row,col,seatid,count : integer;
  maxseat : integer;
  c : char;
  i : integer;

begin
  maxseat := 0;
  readln(s);
  while s <> '' do
  begin
    row := 0;
    col := 0;
    for i := 1 to 7 do
      case s[i] of
        'B' : begin row := row * 2;  inc(row);   end;
        'F' : begin row := row * 2;              end;
      end;
    for i := 8 to 10 do
      case s[i] of
        'R' : begin col := col * 2;  inc(col);   end;
        'L' : begin col := col * 2;              end;
      end;
    seatid := (row * 8) + col;
    if seatid > maxseat then
      maxseat := seatid;
    writeln('Row : ',row,' Col : ',col,' SeatId : ',SeatId,'  S : ',S);
    readln(s);
  end;
  WriteLn('Max SeatId = ',MaxSeat);
  WriteLn('Max Row    = ',MaxSeat div 8);
  WriteLn('Max Col    = ',MaxSeat and 7);
end.

