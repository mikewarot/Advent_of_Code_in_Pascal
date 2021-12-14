program advent2020_04b;
const
  FieldNames : Array[1..8] of string = ('byr','iyr','eyr','hgt','hcl','ecl','pid','cid');

  function getnum(var s : string):integer;
  var
    c : char;
    value : integer;
  begin
    value := 0;
    while (length(s) <> 0) and NOT(s[1] in ['0'..'9']) do
      delete(s,1,1);
    while (length(s) <> 0) and (s[1] in ['0'..'9']) do
    begin
      value := value * 10 + (ord(s[1])-ord('0'));
      delete(s,1,1);
    end;
    getnum := value;
  end;

  function validpassport(x : string):boolean;
  var
    found : array[1..8] of integer;
    i,j,k : integer;
    c : char;
    key,value : string;
    fieldcount : integer;
    bad : boolean;
    year : integer;
    height : integer;
  begin
    bad := false;
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
          begin
            found[i] := 1;
//            WriteLn('Key : [',Key,']');
//            WriteLn('Value : [',Value,']');
            case i of
              1 :  begin
                     year := getnum(value);
                     bad := bad or (year < 1920) or (Year > 2002);
                     if bad then writeln('1 - Year = ',year);
                   end;
              2 : begin
                    year := getnum(value);
                    bad := bad or (year < 2010) or (Year > 2020);
                     if bad then writeln('2 - Year = ',year);
                  end;
              3 : begin
                    year := getnum(value);
                    bad := bad or (year < 2020) or (Year > 2030);
                     if bad then writeln('3 - Year = ',year);
                  end;
              4 : begin
                    height := getnum(value);
                    if pos('in',value) <> 0 then bad := bad or (height < 59) or (height > 76)
                    else
                      if pos('cm',value) <> 0 then bad := bad or (height < 150) or (height > 193)
                        else
                          bad := true;
                    if bad then writeln('4 - height = ',height,' [',value,']');
                  end;
              5 : begin
                    bad := bad or (length(value) < 7);
                    if not bad then
                    begin
                      bad := bad OR (value[1] <> '#');
                      for k := 2 to 7 do
                        bad := bad OR NOT (value[k] in ['0'..'9','a'..'f']);
                    end; // if not bad
                    if bad then writeln('5 - value [',value,']');
                  end;
              6 : begin
                    case value of
                      'amb','blu','brn','gry','grn','hzl','oth' : { nothing } ;
                    else
                      bad := true;
                    end;
                    if bad then writeln('6 - value [',value,']');
                  end;
              7 : begin
                    bad := bad OR (length(value) <> 9);
                    if not bad then
                      for k := 1 to 9 do
                        if NOT (value[k] in ['0'..'9']) then
                          bad := true;
                    if bad then writeln('7 - value [',value,']');
                  end;
              end; // case
            end; // if key = fieldnames[i]
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
    ValidPassport := (fieldcount = 8)AND (not bad);
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

