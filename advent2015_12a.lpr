program advent2015_12a;

  function getnumber(var s : string):int64;
  label
    again,done;
  var
    x : int64;
    t : string;
    sign : int64;
  begin
  again:
    x := 0;
    sign := 1;
    while (length(s) <> 0) AND NOT(s[1] in ['0'..'9','-']) do
      delete(s,1,1);
    if s = '' then goto done;
    if s[1] = '-' then
    begin
      sign := -1;
      delete(s,1,1);
      if (s = '') or NOT (s[1] in ['0'..'9']) then goto again;
    end;
    while (s <> '') and (S[1] in ['0'..'9']) do
    begin
      x := x * 10;
      x := x + (ord(s[1])-ord('0'));
      delete(s,1,1);
    end;
    x := x * sign;

  done:
    GetNumber := x;
  end;

var
  s : string;
  grandtotal : int64;
  total : int64;
begin
  grandtotal := 0;
  while not eof do
  begin
    readln(s);
    total := 0;
    while s <> '' do
      total := total + getnumber(s);
    grandtotal := grandtotal + total;
    writeln('total = ',total);
  end;
  writeln('Grand Total : ',GrandTotal);
end.

