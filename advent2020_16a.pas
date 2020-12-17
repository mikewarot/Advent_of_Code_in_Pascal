program advent2020_16a;
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
  FieldCount : Integer;
  InputCount : integer;
  s          : string;
  Turn,i,j,k,l,n   : uint64;
  Number     : uint64;
  LastUsed   : array[0..30000000] of integer;
  spoken     : integer;
  Sum        : integer;
  valid      : Boolean;

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
    WriteLn(i:3,' ',FieldName[i],' : ',Limits[i,1],'-',Limits[i,2],' OR ',Limits[i,3],'-',Limits[i,4]);

  readln(s);  writeln('Your Ticket - ',s);
  readln(s);  writeln('My Ticket: ',s);
  readln(s);
  readln(s);  writeln('Nearby tickets ',s);

  sum := 0;
  repeat
    readln(s);
    for i := 1 to fieldcount do
    begin
      n := getnum(s);
      valid := false;
      for j := 1 to fieldcount do
        if ((n >= limits[j,1]) AND (n <= limits[j,2])) OR
           ((n >= limits[j,3]) AND (n <= limits[j,4])) then
          valid := true;

      if valid then
        write(n,',')
      else
         begin
           write('*',n,'*,');
           sum := sum+n;
         end;
    end; // for all fields
    writeln;
  until eof;

  writeln('Sum of all errors = ',sum);
  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
end.

