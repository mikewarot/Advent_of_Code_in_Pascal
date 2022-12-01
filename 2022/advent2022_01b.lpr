program advent2022_01b;
var
  calories,thisElf,maxElf,Elf2,Elf3 : int64;
  s : string;
  err : integer;

procedure UpdateRanking;
begin
  begin
    If ThisElf >= MaxElf then
      begin
        Elf3 := Elf2;
        Elf2 := MaxElf;
        MaxElf := ThisElf;
      end
    Else
      begin
        If ThisElf >= Elf2 then
          begin
            Elf3 := Elf2;
            Elf2 := ThisElf;
          end
        else
          If ThisElf >= Elf3 then
            Elf3 := ThisElf;
      end;

    thisElf := 0 ;
  end
end;

begin
  MaxElf := 0; Elf2 := 0; Elf3 := 0;
  ThisElf := 0;

  while not eof do
  begin
    readln(s);
    if s = '' then
      UpdateRanking
    else
      begin
        val(s,calories,err);
        if err = 0 then
          Inc(ThisElf,Calories);
      end;
  end;
  UpdateRanking;
  WriteLn('Maximum carried by an elf: ',MaxElf);
  WriteLn('                     next: ',Elf2);
  WriteLn('                     next: ',Elf3);
  WriteLn(' Sum Total = ',MaxElf+Elf2+Elf3);
end.

