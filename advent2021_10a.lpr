program advent2021_10a;
uses Math, MyStrings;

var
  src : text;
  s,t : string;
  old_s : string;
  count : integer;
  i,j,k : integer;
  sum  : integer;
  Valid,Invalid,Incomplete : integer;
  score : integer;

begin
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
  end; // while not eof(src)
  close(src);


  WriteLn('Valid Lines : ',Valid);
  WriteLn('Invalid Lines : ',Invalid);
  WriteLn('Incomplete Lines : ',Incomplete);
  WriteLn('Sum = ',Sum);

  readln;
end.

