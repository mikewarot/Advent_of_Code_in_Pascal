program advent2020_06b;
var
  s : string;
  c : char;
  i,j,k : integer;
  me,us,all : array[0..25] of integer;
  AllCount,UsCount,GroupCount : Integer;
  UsAns,AllAns : integer;

  GroupAns : integer;
begin
  AllCount := 0;
  AllAns := 0;
  GroupAns := 0;
  GroupCount := 0;
  for i := 0 to 25 do
    all[i] := 0;
  readln(s);
  repeat
    for i := 0 to 25 do
      me[i] := 0;
    for i := 0 to 25 do
      us[i] := 0;
    UsCount := 0;
    UsAns := 0;

    while s <> '' do
    begin
      for i := 0 to 25 do
        me[i] := 0;
      inc(UsCount);
      inc(AllCount);
      for c in s do
        inc(me[Ord(C)-Ord('a')]);
      for i := 0 to 25 do
        if me[i] <> 0 then inc(us[i]);  // only count single answer

      readln(s);
    end;

    if s <> '' then begin writeln('bad logic s = ',s); exit; end; // assert?
    for i := 0 to 25 do
      if us[i] = uscount then
      begin
        s := s + char(ord('a')+i);
        inc(all[i]);
      end;
    UsAns := length(s);
    Inc(GroupAns,UsAns);
    writeln('Group : ',UsCount,',',S,' Answer Count ',UsAns);
    s := '';
    Inc(GroupCount);
    readln(s);
  until s = '';
  for i := 0 to 25 do
    if all[i] <> 0 then
      s := s + char(ord('a')+i);
  AllAns := Length(S);
  writeln('All : ',allcount,',',s,' Answer Count ',AllAns);
  Writeln('Groups : ',GroupCount,' Answers : ',GroupAns);
end.

