program advent2020_19a;
uses
  classes, sysutils, dateutils;
type
  charset = set of char;
const
  whitespace : charset = [' ',#9,#10,#13];

procedure eat(var s : string;  whattoeat : charset);
begin
  while (length(s) <> 0) and (s[1] in whattoeat) do
    delete(s,1,1);
end;

procedure Expect(var s : string; c : char);
begin
  if (s='') OR (s[1] <> c) then
    writeln('Error : Expected [',c,'], Got [',s,']')
  else
    delete(s,1,1);
end;

function getnum(var s : string):integer;
var
  c : char;
  value : integer;
begin
  value := 0;
  eat(s,whitespace);
  while (length(s) <> 0) and (s[1] in ['0'..'9']) do
  begin
    value := value * 10 + (ord(s[1])-ord('0'));
    delete(s,1,1);
  end;
  eat(s,whitespace);
  getnum := value;
end;

function getinteger(var s : string):integer;
var
  value : integer;
  sign  : integer;
begin
  value := 0;
  sign := 1;
  eat(s,whitespace);
  if s <> '' then
    if s[1] = '+' then
      delete(s,1,1)
    else
      if s[1] = '-' then
      begin
        sign := -1;
        delete(s,1,1);
      end;
  while (s <> '') AND (s[1] in ['0'..'9']) do
  begin
    value := (value * 10) + (ord(s[1])-ord('0'));
    delete(s,1,1);
  end;
  value := value * sign;
  getinteger := value;
end;

function getword(var s : string):string;
var
  c : char;
  value : string;
begin
  value := '';
  while (length(s) <> 0) and (s[1] in [' ']) do
    delete(s,1,1);
  while (length(s) <> 0) and (s[1] in ['0'..'9','a'..'z','A'..'Z']) do
  begin
    value := value + s[1];
    delete(s,1,1);
  end;
  while (s <> '') AND (s[1] = ' ') do
    delete(s,1,1);
  getword := value;
end;

type
  TMatchRule = record
                MatchChar  : Char;
                SubRule    : Array[1..10] of Array[1..10] of Integer;

  end;
var
  MatchRule : array[0..999] of TMatchRule;

  procedure ReadRule(Var S : String);
  var
    i,j,k,l     : integer;
    t           : string;
    RuleNumber  : integer;
    ListNumber  : integer;
    LinkNumber  : integer;
  begin
    RuleNumber := getnum(s);
    ListNumber := 1;
    LinkNumber := 1;
    expect(s,':');
    Eat(s,WhiteSpace);
    If S = '' then
    begin
      WriteLn('Unexepected End of Rule');
      Halt;
    end;
    If S[1] = '"' then
    begin
      Expect(s,'"');
      MatchRule[RuleNumber].MatchChar := S[1];
      delete(s,1,1);
      Expect(s,'"');
    end
    else
    while s <> '' do
    begin
      case s[1] of
        '0'..'9' : begin
                     MatchRule[RuleNumber].SubRule[ListNumber,LinkNumber] := GetNum(s);
                     Inc(LinkNumber);
                     If LinkNumber > 10 then
                     begin
                       writeln('Too many links in list');
                       halt;
                     end;
                   end; // case '0'..'9'
        '|'      : begin
                     Expect(s,'|');
                     Inc(ListNumber);
                     If ListNumber > 10 then
                     begin
                       WriteLn('Too many sub lists');
                       Halt;
                     end;
                     LinkNumber := 1;
                   end;
      end; // case s[1]
      Eat(s,WhiteSpace);
    end;

    If S <> '' then
      WriteLn('Rule Left ==> [',s,']');
  end;

  procedure dumpRules;
  var
    i,j,k,l : integer;
  begin
    for i := 0 to 999 do
    begin
      If MatchRule[i].MatchChar <> #0 then
        writeln(i,' : "',MatchRule[i].MatchChar,'"')
      else
        If MatchRule[i].SubRule[1,1] >= 0 then
        begin
          Write(i, ' : ');
          for j := 1 to 10 do
            if MatchRule[i].SubRule[j,1] >= 0 then
            begin
              if j > 1 then write(' | ');
              for k := 1 to 10 do
                if MatchRule[i].Subrule[j,k] >= 0 then
                  write(MatchRule[i].Subrule[j,k],' ');
            end;
          writeln;
        end; // else / If MatchRule
    end; // for i

  end;

(*
function ValidRule(r : integer; var s : string):boolean;
var
  value : boolean;
  i,j   : integer;
  olds  : string;
  done  : boolean;
  c     : string;
begin
  Writeln('Entering ValidRule(',r,',[',s,'])');
  value := false;
  olds := s;
  c := MatchRule[r].MatchChar;
  if (C <> '') then
  begin
    WriteLn('Character Match ',c,' ?? [',s,']');
    value := (pos(C,S) = 1);
    if value then
      delete(s,1,1);
    WriteLn('                ',c,' ?? [',s,']');
  end
  else
  begin
    i := 1;
    repeat
      done := true;
      for j := 1 to 10 do
        if (MatchRule[r].SubRule[i,j] >= 0) then
          done := done AND ValidRule(MatchRule[r].SubRule[i,j],S)
        else
          if j = 0 then
            done := false;

      if not done then
      begin
        inc(i);
        s := olds;
      end;
    until done OR (i > 10);
    done := done AND (S = '');
    if not done then s := olds;
    value := done;
  end;
  Write('ValidRule(',r,',[',olds,']) = ');
  if value then writeln('True') else Writeln('False');
  WriteLn('Remaineder : [',s,']');
  ValidRule := value;
end;

procedure dumptree(r : integer);
var
  i,j : integer;
  next : integer;
begin
  if MatchRule[r].MatchChar <> #0 then
    Write('"',MatchRule[r].MatchChar,'"')
  else
    for i := 1 to 10 do
      for j := 1 to 10 do
      begin
        next :=  MatchRule[r].SubRule[i,j];
        if (i > 1) and (j=1) and (next >= 0) then
          write(' | ');
        if (next > 0) then
        begin
          write('( ',next,' ');
          dumptree(next);
          write(' )');
        end;
      end;
  writeln;
end;

*)

function ValidRule(RuleNum : Integer; S : string) : integer;
var
  i,j : integer;
  empty : boolean;
  count : integer;
  x     : integer;
  next  : integer;
  done  : boolean;
  zz    : string;
begin
  count := 0;
  if s = '' then
  begin
    ValidRule := 0;
    exit;
  end;
  WriteLn('ValidRule(',RuleNum,',"',s,'"');
  With MatchRule[RuleNum] do
  begin
    If MatchChar <> #0 then
    begin
      WriteLn('Character match "',MatchChar,'", [',s,']');
      if (s[1] = MatchChar) then
        count := 1;
    end
    else
    begin
      i := 1;
      repeat
        count := 0;
        done := false;
        j := 1;
        repeat
          next := SubRule[i,j];
          if next >= 0 then
          begin
            zz := copy(s,1+count,999);
            x := ValidRule(next,zz);
            if x <> 0 then
              count := count + x
            else
            begin
              done := true;
              count := 0;
            end;
          end
          else
            j := 10;  // if blank, skip the rest of J
          inc(j);
        until (j > 10) OR (done);
        inc(i);

      until (count = length(s)) or (i > 10);
      if count < length(s) then count := 0;
    end;
  end; // with MatchRule
  Writeln('Got ',count,' should be ',length(s),' from [',s,']');
  validrule := count;
end;


var
  StartTime : TDateTime;
  rulecount,
  datacount,
  matchcount: integer;
  done      : boolean;
  s,t       : string;
  i,j,k,n   : integer;
  matchsize : integer;

begin
  StartTime := Now;
  Rulecount := 0;

  for i := 0 to 999 do
  begin
    MatchRule[i].MatchChar := #0;
    for j := 1 to 10 do
      for k := 1 to 10 do
        MatchRule[i].SubRule[j,k] := -1;  // sentinal value
  end;
  done := false;
  writeln('Rules Section');
  repeat
    readln(s);
    if s = '' then done := true
    else
    begin
      Inc(RuleCount);
//      writeln(s);
      ReadRule(S);
    end;
  until done or eof;
  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');

  DumpRules;

  DataCount := 0;
  MatchCount := 0;
  done := false;
  writeln('Data Section');
  repeat
    readln(s);
    if s = '' then done := true
    else
    begin
      Inc(DataCount);
      WriteLn('S = [',s,']');
      matchsize := ValidRule(0,s);
      if matchsize = length(s) then
      begin
        Inc(MatchCount);
        writeln('Matched ',MatchSize,' bytes');
      end;
//      writeln(s);
    end;
  until done or eof;

  writeln;
  writeln(RuleCount,' rules, ',DataCount,' values, ',MatchCount,' matches');
  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
//  DumpRules;


//  DumpTree(0);
  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
end.

