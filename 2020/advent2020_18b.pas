program advent2020_18b;
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

function getnum(var s : string):extended;
var
  c : char;
  value : extended;
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

function getextended(var s : string):extended;
var
  value : extended;
  sign  : extended;
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
  getextended := value;
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

function getexpression(var s : string):extended;  forward;

function getterm(var s : string): extended;
var
  value : extended;
  initial : string;
begin
  initial := s;
  eat(s,whitespace);
  value := 0;
  case s[1] of
    '0'..'9' : value := getnum(s);
    '(' : begin
            Expect(s,'(');
            value := getexpression(s);
            Expect(s,')');
          end;
  else
    Writeln('Unknown term : [',s,']');
  end;
//  writeln('GetTerm[',initial,'] = ',value:1:0);
  getterm := value;
end;

function getsum(var s : string):extended;
var
  value : extended;
  c     : char;
  done  : boolean;
  t     : string;
begin
  t := s;
  value := 0;
  eat(s,whitespace);
  value := getterm(s);
  eat(s,whitespace);
//  writeln('GetSum - so far = ',value,'  left = [',s,']');
  done := false;
  while (NOT done) AND (s <> '') do
  begin
    case s[1] of
      '+' : begin delete(s,1,1); value := value + getterm(s);   end;
      '-' : begin delete(s,1,1); value := value - getterm(s);   end;
//      '*' : begin delete(s,1,1); value := value * getterm(s);   end;
//      '/' : begin delete(s,1,1); value := value / getterm(s);   end;
    else
      done := true;
    end;
    eat(s,whitespace);
//    writeln('GetSum - so far = ',value:1:0,'  left = [',s,']');
  end; // while (NOT done) AND (s <> '');
//  writeln('Sum[',t,'] = ',value:1:0);
  getSum := value;
end;

function getexpression(var s : string):extended;
var
  value : extended;
  c     : char;
  done  : boolean;
  t     : string;
begin
  t := s;
  value := 0;
  eat(s,whitespace);
  value := getsum(s);
  eat(s,whitespace);
//  writeln('GetExpression - so far = ',value,'  left = [',s,']');
  done := false;
  while (NOT done) AND (s <> '') do
  begin
    case s[1] of
//      '+' : begin delete(s,1,1); value := value + getproduct(s);   end;
//      '-' : begin delete(s,1,1); value := value - getproduct(s);   end;
      '*' : begin delete(s,1,1); value := value * getsum(s);   end;
      '/' : begin delete(s,1,1); value := value / getsum(s);   end;
    else
      done := true;
    end;
    eat(s,whitespace);
//    writeln('GetExpression - so far = ',value:1:0,'  left = [',s,']');
  end; // while (NOT done) AND (s <> '');
//  writeln('Expression[',t,'] = ',value:1:0);
  getexpression := value;
end;

var
  StartTime : TDateTime;
  c         : char;
  count     : extended;
  done      : boolean;
  s,t       : string;
  i,j,k,n   : extended;
  address   : extended;
  ea,old_ea : extended;
  sum      : extended;

begin
  StartTime := Now;
  sum := 0;
  done := false;
  repeat
    readln(s);
    if s = '' then done := true
    else
    begin
//    writeln(s);
      i := GetExpression(s);
      sum := sum + i;
      if s <> '' then
      begin
        WriteLn('Value      --> ',i:1:0);
        writeln('Leftover   --> [',s,']');
      end
      else
        writeln(i:30:0,' ',sum:30:0);
    end;
  until done or eof;

  writeln('Sum of all terms --> ',sum:1:0);

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
end.

