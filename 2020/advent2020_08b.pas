program advent2020_08b;
uses
  classes, sysutils;
type
  charset = set of char;
const
  whitespace : charset = [' ',#9,#10,#13];

procedure eat(var s : string;  whattoeat : charset);
begin
  while (length(s) <> 0) and (s[1] in whattoeat) do
    delete(s,1,1);
end;

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
  instruction = record
                  kind  : string;
                  count : integer;
                  param : integer;
                end;

var
  code,original  : array[1..1000] of instruction;
  accumulator : integer;
  pc : integer;

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
      writeln('S = [',s,']');
      code[linecount].kind := getword(s);
      code[linecount].param := getinteger(s);
      code[linecount].count := 0;
      readln(s);
    end;
    inc(groupcount);
    WriteLn('Group had ',GroupMembers,' members');
    readln(s);
  until s = '';
  writeln('Lines  : ',linecount);
  writeln('Groups : ',GroupCount);

  writeln;
  writeln('--------------- Code as loaded ---------------');
  writeln;

  for i := 1 to linecount do
  begin
    writeln(Code[i].kind,' ',Code[i].param:6,' : ',Code[i].count);
  end;

  Original := Code;  // Save the original


  for i := 1 to linecount do
  begin
    Code := Original;
    s := code[i].kind;
    case s of
      'nop'   : s := 'jmp';
      'jmp'   : s := 'nop';
    end;
    code[i].kind := s;

    // run loop from part A
    pc := 1;
    accumulator := 0;
    repeat
      inc(code[pc].count);  // bump count before executing
      writeln(Code[pc].kind,' ',Code[pc].param:6,' : ',Code[pc].count:6,' Acc = ',Accumulator:6);

      case code[pc].kind of
        'nop'  : inc(pc);
        'acc'  : begin
                   inc(accumulator,code[pc].param);
                   inc(pc);
                 end;
        'jmp'  : inc(pc,code[pc].param);
      end;
    until (code[pc].count <> 0) OR (pc < 1) OR (pc > linecount);
    if pc = (linecount+1) then
    begin
      writeln('Patch at address ',i,' new instruction = ',s,' accumulator at end = ',accumulator);
      break;
    end;
  end;
end.

