program advent2021_16a;
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

  Procedure DoPacket(Var S: String);
  var
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
    case pktType of
      4 : begin
            Write('Literal ');
            literalval := 0;
            Repeat
              Z := GrabBits(S,1);
              Y := GrabBits(S,4);
              literalval := (literalval * 16) + Y;
            until z = 0;
            WriteLn(LiteralVal);
          end;
      else
      begin
        WriteLn('Operator Packet Type : ',pktType);
        pktLengthType := GrabBits(S,1);
        case pktLengthType of
          0 : begin
                z := GrabBits(S,15);
                T := PullBits(S,z);
                While T <> '' do
                begin
                  WriteLn('Subpacket(',z,')');
                  DoPacket(T);
                end;
              end;
          1 : begin
                z := GrabBits(S,11);
                for i := 1 to z do
                begin
                  WriteLn('SubPacket[',i,'] of ',z);
                  DoPacket(S);
                end;
              end;
        end;

      end;
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
  DoPacket(t);

  WriteLn('Remaining bits --> ',T);
  WriteLn('Version Sum : ',VersionSum);

  readln;
end.

