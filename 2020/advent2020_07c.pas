program advent2020_07c;
uses
  classes, sysutils;

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

function getword(var s : string):string;
var
  c : char;
  value : string;
begin
  value := '';
  while (length(s) <> 0) and (s[1] in [' ']) do
    delete(s,1,1);
  while (length(s) <> 0) and NOT(s[1] in [' ']) do
  begin
    value := value + s[1];
    delete(s,1,1);
  end;
  while (s <> '') AND (s[1] = ' ') do
    delete(s,1,1);
  getword := value;
end;



type
  bag = record
          kind   : string;
          count  : array[1..10] of integer;
          sub    : array[1..10] of string;
          subtotal : array[1..10] of integer;
          total  : integer;
        end;
var
  bags : array[1..1000] of bag;
  match : array[1..1000] of integer;

  s : string;
  c : char;
  i,j,k : integer;
  LineCount,
  GroupCount : Integer;
  GroupMembers : Integer;
  matchcount : integer;
  SearchItem : string;
  NextList,DoneList : TStringlist;

begin
  GroupCount := 0;
  LineCount := 0;
  readln(s);
  repeat
    GroupMembers := 0;
    while s <> '' do
    begin
      inc(linecount);
      inc(groupmembers);
//      writeln('S = [',s,']');
      i := pos('bag',s);
      bags[linecount].kind := copy(s,1,i-2);
      bags[linecount].total:= -1;
      delete(s,1,i-2);
      getword(s);
      getword(s);

      writeln('Bag Kind :',bags[linecount].kind);
      writeln('Left [',s,']');
      for i := 1 to 10 do
      begin
        bags[linecount].count[i] := 0;
        bags[linecount].sub[i] := '';
        bags[linecount].subtotal[i] := -1;
      end;

      if pos('no',s) = 0 then
      begin
        i := 0;
        while s <> '' do
        begin
          inc(i);
          bags[linecount].count[i] := getnum(s);
//          writeln('after number Left [',s,']');
          while (s <> '') AND (s[1] = ' ') do
            delete(s,1,1);
          writeln('after number Left [',s,']');
          k := pos(' bag',s);
          bags[linecount].sub[i] := copy(s,1,k-1);
          delete(s,1,k-1);
          getword(s);
          while (s <> '') AND (s[1] in [' ',',']) do
            delete(s,1,1);
        end;
      end;
      readln(s);
    end;
    inc(groupcount);
    WriteLn('Group had ',GroupMembers,' members');
    readln(s);
  until s = '';
  writeln('Lines  : ',linecount);
  writeln('Groups : ',GroupCount);
  for i := 1 to linecount do
  begin
    write(Bags[i].kind);
    for j := 1 to 10 do
      if bags[i].count[j] <> 0 then
        write(',',Bags[i].count[j],' of ',Bags[i].sub[j]);
    writeln;
    match[i] := 0;
  end;

  NextList := TstringList.Create;
  DoneList := TstringList.Create;

  matchcount := 0;
  NextList.Add('shiny gold');
  repeat
    SearchItem := NextList.Strings[matchcount];
    DoneList.Add(SearchItem);

    for i := 1 to linecount do
    begin
      if bags[i].kind = SearchItem then
        match[i] := 1;
      for j := 1 to 10 do
        if bags[i].sub[j] = SearchItem then
//          if match[i] = 0 then
          begin
            match[i] := 1;
            NextList.Add(bags[i].kind);
          end; // for j
    end; // for i
    inc(matchcount);
  until DoneList.Count >= NextList.Count;

  matchcount := 0;
  for i := 1 to linecount do
    if match[i] <> 0 then
    begin
      inc(MatchCount);
      write('Match [',MatchCount,']: ',Bags[i].kind);
      for j := 1 to 10 do
        if bags[i].count[j] <> 0 then
          write(',',Bags[i].count[j],' of ',Bags[i].sub[j]);
      writeln;
    end;

end.

