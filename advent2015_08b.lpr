program advent2015_08b;
var
  s : string;
  i,j,k : integer;
  totalcode,totalsource : integer;

begin
  totalsource := 0;
  totalcode   := 0;
  while not eof do
  begin
    readln(s);
    if s <> '' then
    begin
      inc(totalsource,length(s));  // add the whole string to the source length
      inc(totalcode,2);  // leading and trailing quote
    end;

    while s <> '' do
      case s[1] of
        '"','\'  : begin
                     delete(s,1,1);
                     inc(totalcode,2);
                   end;
      else
        inc(totalcode);
        delete(s,1,1);
      end;
  end;
  WriteLn('Total Source   : ',TotalSource);
  WriteLn('Total Code     : ',TotalCode);
  WriteLn('Delta : ',TotalCode-TotalSource);
end.

