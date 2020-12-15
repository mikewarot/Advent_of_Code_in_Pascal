program advent2020_15b;
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
  StartTime : TDateTime;
  count     : integer;
  s         : string;
  i,n       : uint64;
  buffer    : array[0..30000000] of integer;
  spoken    : integer;

begin
  for i := 0 to 30000000 do      // clear our buffer of values
    buffer[i] := 0;
  readln(s);                     // read the string of values from standard input
  StartTime := Now;
  count := 0;
  repeat                         // this handles the numbers from the input list
    inc(count);
    n := getnum(s);
    spoken := buffer[n];
    if spoken <> 0 then
      spoken := count-spoken;
    buffer[n] := count;          // for each of the starting numbers, post the turn it was "spoken" to it's buffer
    write(n,',');
  until s = '';

  for i := count+1 to 30000000 do
  begin
    n := spoken;                 // n is now the last "spoken" number
    //    write(n,',');            // debug = write value
    spoken := buffer[n];         // when was N last said?
    buffer[n] := i;              // update the count of the last "spoken" number to now
    if spoken <> 0 then          // 0 --> we'll say zeronever;
      spoken := i-spoken;        // else  say i-(last time it was said)
  end;
  writeln(n);                    // display the last spoken number, not this one
  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
end.

