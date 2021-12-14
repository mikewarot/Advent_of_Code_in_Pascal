program advent2015_11a;

  procedure IncrementPassword(var s : string);
  var
    i : integer;
    carry : boolean;
  begin
    i := length(s);
    carry := true;
    while carry and (i > 0) do
    begin
      if s[i] <> 'z' then
      begin
        s[i] := char(ord(s[i])+1);
        carry := false;
      end
      else
      begin
        s[i] := 'a';
        dec(i);
      end;
    end;
  end;

  function ValidPassword(s : String) : boolean;
  const
    letters = 'abcdefghijklmnopqrstuvwxyz';
  var
    isvalid : boolean;
    i,j,k   : integer;
    t       : string;
    count   : integer;
  begin
    isvalid := true;
    count := 0;
    for i := 1 to length(letters)-2 do
    begin
      t := copy(letters,i,3);
      if pos(t,s) <> 0 then inc(count);
    end;

    isvalid := isvalid AND (count > 0);
    isvalid := isvalid AND (pos('i',s) = 0);
    isvalid := isvalid AND (pos('l',s) = 0);
    isvalid := isvalid AND (pos('o',s) = 0);

    count := 0;
    for i := 1 to length(letters) do
    begin
      t := letters[i]+letters[i];
      if pos(t,s) <> 0 then inc(count);
    end;
    isvalid := isvalid AND (count >= 2);

    ValidPassword := isvalid;
  end;

var
  s : string;
  i : integer;

begin
  readln(s);
  repeat
    repeat
      IncrementPassword(s);
    until ValidPassword(s);
    writeln(s);
    readln(s);
  until s = '';
end.

