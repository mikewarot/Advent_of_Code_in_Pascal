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
  StartTime  : TDateTime;
  InputCount : integer;
  s          : string;
  Turn,i     : uint64;
  Number     : uint64;
  LastUsed   : array[0..30000000] of integer;
  spoken     : integer;

begin
  for i := 0 to 30000000 do      // clear our LastUsed of values
    LastUsed[i] := 0;
  readln(s);                     // read the string of values from standard input
  StartTime := Now;
  InputCount := 0;
  repeat                         // this handles the numbers from the input list
    inc(InputCount);
    Number := getnum(s);
    spoken := LastUsed[Number];
    if spoken <> 0 then
      spoken := InputCount-spoken;
    LastUsed[Number] := InputCount;          // for each of the starting numbers, post the turn it was "spoken" to it's buffer
    write(Number,',');
  until s = '';

  for Turn := InputCount+1 to 30000000 do
  begin
    Number := spoken;            // Number is now the last "spoken" number
    //    write(Number,',');     // debug = write value
    spoken := LastUsed[Number];  // when was Number last said?
    LastUsed[Number] := Turn;    // update the InputCount of the last "spoken" number to now
    if spoken <> 0 then          // 0 --> we'll say zeronever;
      spoken := Turn-spoken;     // else  say Turn-(last time it was said)
  end;
  writeln(Number);                    // display the last spoken number, not this one
  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
end.

