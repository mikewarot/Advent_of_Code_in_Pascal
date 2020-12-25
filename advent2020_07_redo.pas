program advent2020_07_redo;
uses
  sysutils, dateutils;

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

function getnum(var s : string):integer;
var
  c : char;
  value : integer;
begin
  value := 0;
  while (length(s) <> 0) and NOT (S[1] in ['0'..'9']) do
    delete(s,1,1);
  while (length(s) <> 0) and (s[1] in ['0'..'9']) do
  begin
    value := value * 10 + (ord(s[1])-ord('0'));
    delete(s,1,1);
  end;
  eat(s,whitespace);
  getnum := value;
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



type
  TBag    = record
    name            : string;
    other           : string;
    itemcount       : extended;
    subitemcount    : integer;
    subitemid       : array[1..10] of integer;
    subitemquantity : array[1..10] of extended;
  end;

var
  StartTime   : TDateTime;
  s           : string;
  name        : string;
  Bag         : array[1..1000] of tBag;
  BagCount    : integer;
  i,j,k        : integer;
  num         : extended;
  Done        : Boolean;
  ThisOneSum  : extended;
  PointsTo    : integer;

  Function BagNumber(S : String) : integer;
  var
    i,j,k,match : integer;
  begin
    match := 0;
    for i := 1 to bagCount do
      if S = Bag[i].name then
        match := i;
    if match <> 0 then
      BagNumber := match
    else
      begin
        WriteLn('Unmatched name : ',s);
        halt;
      end;
  end;

begin
  StartTime := Now;
  BagCount := 0;
  repeat
    readln(s);
    name := copy(s,1,pos(' contain',s));
    delete(s,1,length(name));
    delete(name,pos(' bag',name),999);  // get rid of bag and bags
    while (s[1] <> ' ') do
      delete(s,1,1);
    delete(s,1,1);

    inc(BagCount);
    Bag[BagCount].name:= name;
    Bag[BagCount].other := s;
    Bag[BagCount].itemcount := -1;
    Bag[BagCount].subitemcount:= 0;
    if pos('no',s) <> 0 then
      begin
        Bag[BagCount].itemcount:= 1;
        Bag[BagCount].other:= '';
        writeln(name,' : ',s);
      end;
  until eof or (s='');

  writeln;
  writeln('Processing Section');
  writeln;
  for i := 1 to BagCount do
    begin
      Write(Bag[i].name,' : ',Bag[i].other);
      If Bag[i].ItemCount >= 1 then
        writeln(Bag[i].itemcount,' items total')
      else
        begin
          repeat
            writeln(' other --> ',Bag[i].other);
            num := GetNum(Bag[i].other);
            if num > 0 then
              begin
                Inc(Bag[i].subitemcount);
                Bag[i].subitemQuantity[Bag[i].subitemcount] := num;
                s := getword(Bag[i].other)+' '+getword(Bag[i].other);
//                WriteLn('SubItem : [',Bag[i].other,']');
                Bag[i].subitemid[Bag[i].subitemcount] := BagNumber(s);
                WriteLn('Subitem registered : (',Bag[i].subitemQuantity[Bag[i].subitemcount],')',Bag[Bag[i].subitemid[Bag[i].subitemcount]].Name);
                WriteLn('Other : [',Bag[i].other,']');
              end;
          until Bag[i].other = '';
        end

    end;
  repeat
    done := true;
    writeln;
    writeln;
    for i := 1 to BagCount do
      begin
        ThisOneSum := 1;
//        Write(Bag[i].name,' : ');
        If (Bag[i].ItemCount >= 1) OR (Bag[i].subitemcount = 0) then
          begin
//            writeln(Bag[i].itemcount,' items total')
          end
        else
          begin
            for j := 1 to Bag[i].subitemcount do
              begin
                PointsTo := Bag[i].subitemid[j];
                if (Bag[PointsTo].itemcount < 1) OR (ThisOneSum < 1) then
                  begin
                    ThisOneSum := -1;
                    Done := false;
                  end
                else
                  begin
                    ThisOneSum := ThisOneSum + Bag[PointsTo].itemcount * Bag[i].subitemquantity[j];
  //              WriteLn(Bag[i].subitemquantity[j],' of item # ',Bag[i].subitemID[j]);
                end; // if else
              end; // for j
            Bag[i].itemcount := ThisOneSum;
            If ThisOneSum < 1 then
              WriteLn('Not Done Yet : ',Bag[i].Name);
            done := done AND (ThisOneSum >= 1);
          end; // if - else
      end; // for i
  until done;

  WriteLn;
  WriteLn('Output Stage');
  WriteLn;

  for i := 1 to BagCount do
    begin
      ThisOneSum := 1;
      WriteLn(Bag[i].name,' : ',Bag[i].itemcount:1:0,' items total');
      for j := 1 to Bag[i].subitemcount do
        begin
          PointsTo := Bag[i].subitemid[j];
          WriteLn(' ',Bag[i].subitemquantity[j]:1:0,' of [',Bag[PointsTo].name,']  (',Bag[PointsTo].itemcount:1:0,') items');
        end; // for j
    end; // for i

  WriteLn;
  WriteLn('Output Stage');
  WriteLn;

  i := BagNumber('shiny gold');
  if i > 0 then
    begin
      ThisOneSum := 1;
      WriteLn(Bag[i].name,' : ',Bag[i].itemcount:1:0,' items total');
      for j := 1 to Bag[i].subitemcount do
        begin
          PointsTo := Bag[i].subitemid[j];
          WriteLn(' ',Bag[i].subitemquantity[j]:1:0,' of [',Bag[PointsTo].name,']  (',Bag[PointsTo].itemcount:1:0,') items');
        end; // for j
    end; // for i


  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
end.

