program advent2020_16b;
uses
  classes, sysutils, dateutils;

// given a string, eats delimiters and gets a positive integer
// string is shorter after call

function getnum(var s : string):integer;
var
  value : integer;
begin
  value := 0;
  while (length(s) <> 0) and NOT(s[1] in ['0'..'9']) do
    delete(s,1,1);  // skip preceding non-numbers
  while (length(s) <> 0) and (s[1] in ['0'..'9']) do
  begin
    value := value * 10 + (ord(s[1])-ord('0'));
    delete(s,1,1);
  end;
  getnum := value;
end;

var
  StartTime  : TDateTime;
  FieldName  : Array[1..100] of String;
  Limits     : Array[1..100] of Array[1..4] of Integer;
  Fields,
  MyFields   : Array[1..100] of integer;
  FieldCount : Integer;
  InputCount : integer;
  s          : string;
  Turn,i,j,k,n  : uint64;
  Number     : uint64;
  spoken     : integer;
  valid      : set of byte;
  AllValid,
  ThisOne    : array[1..100] of set of byte;

procedure Validate(var x : string);
var
  BadTicket : Boolean;
  InputCol  : Integer;
  MatchedRule : Integer;
begin
  badticket := false;
  for InputCol := 1 to fieldcount do
  begin
    ThisOne[InputCol] := [];
    n := getnum(x);
    fields[InputCol] := n;  // save the field values in case we need them
    valid := [];
    for MatchedRule := 1 to fieldcount do
      if ((n >= limits[MatchedRule,1]) AND (n <= limits[MatchedRule,2])) OR
         ((n >= limits[MatchedRule,3]) AND (n <= limits[MatchedRule,4])) then
        valid := valid + [MatchedRule];

    ThisOne[InputCol] := valid;
    If Valid = [] then
      BadTicket := true;
  end; // for all fields
  if not badticket then
    for InputCol := 1 to fieldcount do
      AllValid[InputCol] := AllValid[InputCol] * ThisOne[InputCol];  // AND of the sets
end;

var
  last : uint64;
  product : extended;
  LL : byte;
  DataCol : integer;
  RuleNum : integer;
begin
  StartTime := Now;

  FieldCount := 0;
  readln(s);
  repeat
    inc(fieldcount);
    i := pos(':',s)-1;
    FieldName[FieldCount] := copy(s,1,i);
    Delete(s,1,i+1);
    for i := 1 to 4 do
      Limits[FieldCOunt,i] := GetNum(s);
    readln(s);
  until eof or (s='');

  for i := 1 to fieldcount do
  begin
    WriteLn(i:3,' ',FieldName[i],' : ',Limits[i,1],'-',Limits[i,2],' OR ',Limits[i,3],'-',Limits[i,4]);
    AllValid[i] := [1..FieldCount]; // all are valid, until they get elimiated
  end;

  readln(s);  writeln('Your Ticket - ',s);
  readln(s);  writeln('My Ticket: ',s);
  Validate(s); // do our own ticket as well for part B
  MyFields := Fields;
  for i := 1 to fieldcount do
    write(MyFields[i],' ');
  Writeln;
  readln(s);
  readln(s);  writeln('Nearby tickets ',s);

  repeat
    readln(s);
    Validate(s);
    if s <> '' then
      writeln('UNVALIDATED EXTRA: ',S);
  until eof;

  for i := 1 to fieldcount do
  begin
    write(i,' ',FieldName[i],' : ');
    for j in AllValid[i] do
      write(j,' ');
    writeln;
  end;


  for i := 1 to fieldcount do
    for j := 1 to fieldcount do
      begin
        k := 0;
        for LL in AllValid[j] do
          begin
            inc(k);
            last := LL;
          end;
        if k = 1 then
        begin
//          WriteLn(FieldName[j],' : ',last);
          for LL := 1 to fieldcount do
            if (LL <> j) then
//              Exclude(AllValid[LL],last);
              AllValid[LL] := AllValid[LL]-AllValid[j];  // bug fix???
        end;
      end;


  writeln;
  writeln('done processing');
  product := 1;
  for DataCol := 1 to fieldcount do
  begin
    write(FieldName[DataCol],' : ');
    for RuleNum in AllValid[DataCol] do
    begin
      write(RuleNum,' ');
      last := RuleNum;
    end;
    writeln;
    if pos('departure',FieldName[Last]) <> 0 then
    begin
       product := product * MyFields[DataCol];
       writeln(last,' ',MyFields[DataCol],' ',product:30:0);
    end;

  end;

  Writeln('The Product is ',product:30:0);

  for i := 1 to fieldcount do
    for j := 1 to fieldcount do
      if i in AllValid[j] then
        WriteLn(FieldName[j],' ',MyFields[i]);

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
end.

