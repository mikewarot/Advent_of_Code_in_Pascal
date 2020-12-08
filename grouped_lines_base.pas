program grouped_lines_base;
var
  s : string;
  c : char;
  i,j,k : integer;
  LineCount,
  GroupCount : Integer;
  GroupMembers : Integer;
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
      writeln('S = [',s,']');
      readln(s);
    end;
    inc(groupcount);
    WriteLn('Group had ',GroupMembers,' members');
    readln(s);
  until s = '';
  writeln('Lines  : ',linecount);
  writeln('Groups : ',GroupCount);
end.

