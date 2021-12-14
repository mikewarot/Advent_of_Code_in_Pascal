program advent2021_10b;
uses Math, MyStrings, fgl;

type
  TInt64List = specialize TFPGList<Int64>;

  function Fubar(Const Item1, Item2: Int64): Integer;
  begin
    if (Item1 < Item2) then
      fubar := -1
    else
      if (Item1 = Item2) then
        fubar := 0
      else
        fubar := 1;
  end;

var
  src : text;
  s,t : string;
  old_s : string;
  count : integer;
  i,j,k : integer;
  sum  : integer;
  Valid,Invalid,Incomplete : integer;
  score : integer;
  cscore : int64;
  CompleteList : tInt64list;

begin
  CompleteList := tInt64list.create;
  assign(src,'advent2021_10a_input.txt');
  reset(src);
  sum := 0;
  count := 0;
  Valid := 0;
  InValid := 0;
  Incomplete := 0;

  while not eof(src) do
  begin
    readln(src,s);
    old_s := s;
    inc(count);
    t := '';
    score := 0;

    repeat
      if (s <> '') then
      begin
        case s[1] of
          '[','<','(','{'  : begin
                               t := s[1] + t;
                               delete(s,1,1);
                             end;
          ']'              : if (t <> '') and (t[1] = '[') then
                             begin
                               delete(t,1,1);
                               delete(s,1,1);
                             end
                             else
                               score := 57;
          ')'              : if (t <> '') and (t[1] = '(') then
                             begin
                               delete(t,1,1);
                               delete(s,1,1);
                             end
                             else
                               score := 3;
          '>'              : if (t <> '') and (t[1] = '<') then
                             begin
                               delete(t,1,1);
                               delete(s,1,1);
                             end
                             else
                               score := 25137;
          '}'              : if (t <> '') and (t[1] = '{') then
                             begin
                               delete(t,1,1);
                               delete(s,1,1);
                             end
                             else
                               score := 1197;
        end;  // case s[1]
      end; // if
    until (score <> 0) OR (s = '');

    sum := sum + score;

    if score <> 0 then
      inc(invalid)
    else
    begin
      if t = '' then
        inc(Valid)
      else
        inc(InComplete);
    end; // if score <> 0

    WriteLn(old_s,' ',score);

    If Score = 0 then
    begin
      WriteLn('Completion String = ',t);
      cscore := 0;
      for i := 1 to length(t) do
        cscore := (cscore*5) + pos(t[i],'([{<');
      WriteLn('Completion String = ',t,' ',cscore);

      CompleteList.Add(cscore);
    end;
  end; // while not eof(src)
  close(src);


  WriteLn('Valid Lines : ',Valid);
  WriteLn('Invalid Lines : ',Invalid);
  WriteLn('Incomplete Lines : ',Incomplete);
  WriteLn('Sum = ',Sum);

  CompleteList.Sort(@Fubar);
  for i := 1 to CompleteList.Count do
    writeln(i,' ',CompleteList.Items[i-1]);

  WriteLn('Middle of CompleteList scores = ',CompleteList[((Completelist.Count+1)div 2)-1]);

  readln;
end.

