program advent2021_24a;
uses sysutils, dateutils, Classes, mystrings, fgl;

const
  regname : string = 'wxyz';
var
  register : array[1..4] of int64;
  serialnumber : string;

  procedure process(s : string);
  var
    dest : integer;
    src  : integer;
    srcval : int64;
    opcode : string;
    i : integer;
  begin
//    writeln(s);
    opcode := grabstring(s);
    dest := pos(grabstring(s),regname);
    skipspace(s);
    src := pos(s,regname);
//    writeln('S = [',s,']');
    if src = 0 then
      srcval := grabnumber(s)
    else
      srcval := register[src];

//    writeln('Opcode : ',OpCode,' dst: ',dest,' src: ',src,' srcval: ',srcval);
    case opcode of
      'inp'  : begin
//                 write('Input : '); ReadLn(srcval);
                 if serialnumber = '' then
                 begin
                   For i := 1 to 4 do
                     write(Regname[i],' : ',Register[i]:12,' ');
                   writeln;


                   Write('Input ');
                   readln(serialnumber);
                 end;
                 srcval := ord(serialnumber[1])-ord('0');
                 delete(serialnumber,1,1);
                 register[dest] := srcval;
               end;
      'add'  : register[dest] := register[dest] + srcval;
      'mul'  : register[dest] := register[dest] * srcval;
      'div'  : register[dest] := register[dest] div srcval;
      'mod'  : register[dest] := register[dest] mod srcval;
      'eql'  : if register[dest] = srcval then
                 register[dest] := 1
               else
                 register[dest] := 0;
      else
        WriteLn('Unknown opcode [',opcode,']');
    end;
(*
    For i := 1 to 4 do
      write(Regname[i],' : ',Register[i]:12,' ');
    writeln;
*)
  end;

var
  StartTime   : TDateTime;
  Src : Text;
  S : String;

  lines : array[1..1000] of string;
  linec : integer;

  i,j,k : int64;
  N : int64;
  SaveSerial : String;
  fubar : int64;
begin
  StartTime := Now;

  linec := 0;
  Assign(Src,'Advent2021_24.txt');
  reset(src);
  while not eof(src) do
  begin
    readln(src,s);
    inc(linec);
    lines[linec] := s;
//    writeln(s);
  end;
  close(src);

  N := 99999999999999+1;

  repeat
(*
    N := 0;
    for i := 1 to 14 do
      n := n*10 + trunc(random*9.0)+1;
*)
    repeat
      dec(N);
      SerialNumber := IntToStr(N);
    until Pos('0',SerialNumber) = 0;
//    Writeln(SerialNumber);

    serialnumber := '';
    Write('SerialNumber : ');
    ReadLn(SerialNumber);
    SaveSerial := SerialNumber;

    for i := 1 to 4 do
      register[i] := 0;

//    SerialNumber := '13579246899999';

    for i := 1 to linec do
      process(lines[i]);

    For i := 1 to 4 do
      write(Regname[i],' : ',Register[i]:12,' ');
    writeln;
    WriteLn('Serial : ',SaveSerial);

    fubar := Register[4];
    for i := 1 to 7 do
    begin
      Write(fubar mod 26,',');
      fubar := fubar div 26;
    end;

  until Register[4] = 0;


  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
  readln;
end.
