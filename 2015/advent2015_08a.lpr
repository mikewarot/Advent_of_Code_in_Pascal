program advent2015_08a;
var
  s : string;
  i,j,k : integer;
  totalcode,totalmemory : integer;

begin
  totalcode := 0;
  totalmemory := 0;
  while not eof do
  begin
    readln(s);
    if s <> '' then
    begin
      // strip off leading and trailing quotes, add to code counter
      inc(totalcode,length(s));  // add the whole string to the code length
      delete(s,1,1);
      delete(s,length(s),1);
    end;
    while s <> '' do
      case s[1] of
        '\'  : begin
                 delete(s,1,1);
                 case s[1] of
                   '\','"' : begin
                               delete(s,1,1);
                               inc(totalmemory);
                             end;
                   'x'     : begin
                               delete(s,1,3);
                               inc(totalmemory);
                             end;
                 else
                   WriteLn('Unhandled escape character  \',s);
                   Halt(1);
                 end;
               end
      else
        inc(totalmemory);
        delete(s,1,1);
      end;
  end;
  WriteLn('Total Code   : ',TotalCode);
  WriteLn('Total Memory : ',TotalMemory);
  WriteLn('Delta : ',TotalCode-TotalMemory);
end.

