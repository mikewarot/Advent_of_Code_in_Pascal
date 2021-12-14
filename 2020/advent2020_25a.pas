program advent2020_25a;
uses
  sysutils, dateutils;


const
  Modulus = 20201227;
var
  StartTime   : TDateTime;
  subject     : Longint;
  result      : Longint;
  iteration   : Longint;

begin
  StartTime := Now;
(*
  subject := 7;
  result := 1;
  for iteration := 1 to maxlongint do
    begin
      result := (result * subject) mod modulus;
      if result = 14222596 then
        WriteLn('Match 1 ==> ',iteration);
      if result = 4057428 then
        WriteLn('Match 2 --> ',iteration);
//      writeln(iteration,' ',result);
      if (iteration mod 1000) = 0 then
        write(iteration,#13);
    end;
*)
  subject := 14222596;
  result := 1;
  for iteration := 1 to 2918888 do
    begin
      result := (result * subject) mod modulus;
      if result = 14222596 then
        WriteLn('Match 1 ==> ',iteration);
      if result = 4057428 then
        WriteLn('Match 2 --> ',iteration);
//      writeln(iteration,' ',result);
      if (iteration mod 1000) = 0 then
        write(iteration,#13);
    end;
  writeln('Result --> ',result);



  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
end.

