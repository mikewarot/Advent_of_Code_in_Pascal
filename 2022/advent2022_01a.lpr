program advent2022_01a;
var
  calories,thisElf,maxElf : int64;
  s : string;
  err : integer;
begin
  MaxElf := 0;
  ThisElf := 0;

  while not eof do
  begin
    readln(s);
    if s = '' then
      thisElf := 0
    else
    begin
      val(s,calories,err);
      if err = 0 then
      begin
        Inc(ThisElf,Calories);
        If ThisElf > MaxElf then
          MaxElf := ThisElf;
      end;
    end;
  end;
  WriteLn('Maximum carried by an elf: ',MaxElf);
end.

