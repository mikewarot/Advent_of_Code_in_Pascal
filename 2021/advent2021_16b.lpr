program advent2021_16b;
uses Classes, Math, MyStrings, fgl;
var
  VersionSum : int64;

  function GrabBits(Var S : string; N : Integer):Int64;
  var
    z : Int64;
    i : Integer;
  begin
    z := 0;
    if N > Length(S) then
      WriteLn('GrabBits - Ran out of bits!')
    else
      for i := 1 to N do
        z := z + z + (ord(s[i])-ord('0'));
    Delete(s,1,N);
    GrabBits := z;
  end;

  function PullBits(Var S : String; N : Integer):String;
  var
    t : string;
    i : integer;
  begin
    t := copy(S,1,N);
    if n > length(s) then
      WriteLn('PullBits - Out of bits!')
    else
      delete(s,1,n);
    PullBits := T;
  end;

  Function EvalPacket(Var S: String):Int64;
  var
    operand     : Array[1..1000] of int64;
    opcount     : Int64;
    t : string;
    i,j,k,x,y,z : int64;
    pktType,
    pktVer      : int64;
    literalval  : int64;
    pktLengthType : int64;
  begin
    pktVer  := GrabBits(S,3);   inc(versionsum,pktver);
    pktType := GrabBits(S,3);

    WriteLn('Packet Version : ',pktVer);
    WriteLn('Packet Type    : ',pktType);
    if pktType = 4 then
    begin
      Write('Literal ');
      literalval := 0;
      Repeat
        Z := GrabBits(S,1);
        Y := GrabBits(S,4);
        literalval := (literalval * 16) + Y;
      until z = 0;
      WriteLn(LiteralVal);
      EvalPacket := LiteralVal;
    end
    else // not a literal
    begin
      OpCount := 0;
      for i := 1 to 1000 do
        Operand[i] := 0;

      WriteLn('Operator Packet Type : ',pktType);
      pktLengthType := GrabBits(S,1);
      case pktLengthType of
        0 : begin
              z := GrabBits(S,15);
              T := PullBits(S,z);
              OpCount := 0;
              While T <> '' do
              begin
                Inc(OpCount);
                WriteLn('Subpacket(',z,')');
                Operand[OpCount] := EvalPacket(T);
              end;
            end; // case 0
        1 : begin
              z := GrabBits(S,11);
              OpCount := Z;
              for i := 1 to z do
              begin
                WriteLn('SubPacket[',i,'] of ',z);
                Operand[i] := EvalPacket(S);
              end;
            end; // case 1
      end; // case pktLengthType
      // we have the operator type, a count and list of operands
      case pktType of
        0 : begin
              WriteLn('Sum of ',OpCount,' operands');
              z := 0;
              for i := 1 to OpCount do
                inc(z,operand[i]);
              EvalPacket := Z;
            end;
        1 : begin
              WriteLn('Product of ',OpCount,' operands');
              z := 1;
              for i := 1 to OpCount do
                z := z * operand[i];
              EvalPacket := Z;
            end;
        2 : begin
              WriteLn('Minimum of ',OpCount,' operands');
              z := Operand[1];
              for i := 1 to OpCount do
                if Operand[i] < z then
                  z := Operand[i];
              EvalPacket := Z;
            end;
        3 : begin
              WriteLn('Maximum of ',OpCount,' operands');
              z := Operand[1];
              for i := 1 to OpCount do
                if Operand[i] > z then
                  z := Operand[i];
              EvalPacket := Z;
            end;
        5 : begin
              WriteLn('Greater-Than Comparison of ',OpCount,' operands');
              If OpCount <> 2 then
                WriteLn('Wrong operand count : ',OpCount);
              If Operand[1] > Operand[2] then
                EvalPacket := 1
              else
                EvalPacket := 0;
            end;
        6 : begin
              WriteLn('Less-Than Comparison of ',OpCount,' operands');
              If OpCount <> 2 then
                WriteLn('Wrong operand count : ',OpCount);
              If Operand[1] < Operand[2] then
                EvalPacket := 1
              else
                EvalPacket := 0;
            end;
        7 : begin
              WriteLn('Equality Comparison of ',OpCount,' operands');
              If OpCount <> 2 then
                WriteLn('Wrong operand count : ',OpCount);
              If Operand[1] = Operand[2] then
                EvalPacket := 1
              else
                EvalPacket := 0;
            end;
      else
        WriteLn('Unknown Packet Type : ',pktType);
        EvalPacket := -1;
      end; // case pktType

    end;
  end;

var
  s,t : string;
  i,j,k,x,y,z : int64;


begin
  VersionSum := 0;
  readln(s);
  writeln(s);

  // expand hex string S to binary string T, case statement gets it done quick and crude
  t := '';
  for i := 1 to length(s) do
  case s[i] of
    '0' : t := t + '0000';
    '1' : t := t + '0001';
    '2' : t := t + '0010';
    '3' : t := t + '0011';
    '4' : t := t + '0100';
    '5' : t := t + '0101';
    '6' : t := t + '0110';
    '7' : t := t + '0111';
    '8' : t := t + '1000';
    '9' : t := t + '1001';
    'A' : t := t + '1010';
    'B' : t := t + '1011';
    'C' : t := t + '1100';
    'D' : t := t + '1101';
    'E' : t := t + '1110';
    'F' : t := t + '1111';
  end;

  writeln('T -> ',t);
  WriteLn('EvalPacket(t) = ',EvalPacket(t));

  WriteLn('Remaining bits --> ',T);
  WriteLn('Version Sum : ',VersionSum);

  readln;
end.

