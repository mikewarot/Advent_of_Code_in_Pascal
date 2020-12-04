program advent2020_04a;
const
  FieldNames : Array[1..8] of string = ('byr','iyr','eyr','hgt','hcl','ecl','pid','cid');

  function validpassport(x : string):boolean;
  var
    found : array[1..8] of integer;
    i : integer;
    c : char;
    key,value : string;
    fieldcount : integer;
  begin
    for i := 1 to 8 do
      found[i] := 0;
    while x <> '' do
    begin
      key := '';
      value := '';
      while (x <> '') AND (x[1] in [' ',#9,#10,#13]) do
        delete(x,1,1);
      while (x <> '') AND (x[1] in ['a'..'z']) do
      begin
        key := key+x[1];
        delete(x,1,1);
      end;
      while (x <> '') AND (x[1] in [' ',#9,#10,#13]) do
        delete(x,1,1);
      if (x <> '') AND (x[1] = ':') then
        delete(x,1,1);
      while (x <> '') AND NOT(x[1] in [' ',#9,#10,#13]) do
      begin
        value := value+x[1];
        delete(x,1,1);
      end;
      if (key <> '') and (value <> '') then
      begin
        for i := 1 to 8 do
          if key = FieldNames[i] then
            found[i] := 1;
      end; // if key <> ''
    end; // while x <> ''
    fieldcount := 0;
    for i := 1 to 8 do
      fieldcount := fieldcount + found[i];

    if (fieldcount = 7) and (found[8] = 0) then
    begin
      WriteLn('Stealing a passport');
      FieldCount := 8;
    end;
    WriteLn('FieldCount = ',fieldcount);
    ValidPassport := (fieldcount = 8);
  end;

var
  s : string;
  passport : string;
  done : boolean;
  validcount,
  invalidcount : integer;

begin
  validcount := 0;
  invalidcount := 0;
  passport := '';
  done := false;
  repeat
    s := '';
    readln(s);
//    writeln('S --> [',s,']');
    if (s = '') then
    begin
      if passport <> '' then
      begin
        writeln('Passport [',passport,']');
        if validpassport(passport) then
          inc(validcount)
        else
          inc(invalidcount);
        passport := '';
      end
      else
        done :=true; // two empty lines in a row mark end
    end
    else
      passport := passport + ' ' + s;
  until done;
  WriteLn('Valid Passports   : ',validcount);
  Writeln('Invalid Passports : ',invalidcount);
  Writeln('Total             : ',validcount+invalidcount);
end.

