program advent2021_22b;
uses sysutils, dateutils, mystrings;
const
  limit = 1700;

var
  NumberCount   : Array[1..3] of Integer;
  NumberValue   : Array[1..3] of Array[0..10000] of Int64;

  procedure SetupTranslate;
  var
    i : integer;
  begin
    for i := 1 to 3 do
    begin
      NumberCount[i] := 1;
      NumberValue[i,1] := 0;
    end;
  end;

  procedure AddNumber(Dimension : Integer; NewNumber : Int64);
  var
    NewPos,i : Integer;
  begin
    NewPos := 1;
    While (NewNumber > NumberValue[Dimension,NewPos]) AND (NewPos <= NumberCount[Dimension]) do
      inc(NewPos);
    If NewPos > NumberCount[Dimension] then                 // larger than highest value
    begin
      inc(NumberCount[Dimension]);
      NumberValue[Dimension,NewPos] := NewNumber;
    end
    else
      If NumberValue[Dimension,NewPos] = NewNumber then
      begin
//        WriteLn('Already Inserted');
      end
      else
      begin
        for i := NumberCount[Dimension] downto NewPos do
          NumberValue[Dimension,i+1] := NumberValue[Dimension,i];
        inc(NumberCount[Dimension]);
        NumberValue[Dimension,NewPos] := NewNumber;
      end;

//    WriteLn('New Number[',Dimension,'] = ',NewNumber,' = ',NewPos,' of ',NumberCount[Dimension]);
  end;

  function Compress(Dimension : Integer; N:Int64):integer;
  var
    i : integer;
    found : integer;
  begin
    found := 0;
    for i := 1 to NumberCount[Dimension] do
      if N = NumberValue[Dimension,i] then
        Found := i;
    if Found=0 then
    begin
      writeln('Missing value in dimension ',Dimension,' --> ',N);
      Exit;
    end
    else
      Compress := Found;
  end;

var
  StartTime   : TDateTime;
  Src : Text;
  S : String;

  rulec : integer;
  rules : array[1..1000] of string;

  grid : array[1..limit]
      of array[1..limit]
      of bitpacked array[1..limit] of 0..1;

  i,j,k : int64;
  x,y,z : int64;
  x1,x2,y1,y2,z1,z2 : int64;
  T,count : qword;
  Volume : qword;

begin
  StartTime := Now;

//  fillchar(grid,sizeof(grid),0);
  WriteLn('Size of Grid = ',SizeOf(Grid));

  write('Initializing');
  for x := 1 to limit do
  begin
    write(x,' ',#13);
    for y := 1 to limit do
      for z := 1 to limit do
        grid[x,y,z] := 0;
  end;

  writeln;
  rulec := 0;

//  assign(src,'advent2021_22_sample.txt');
//  assign(src,'advent2021_22_sample2.txt');

  assign(src,'advent2021_22.txt');
  reset(src);
  while not eof(src) do
  begin
    readln(src,s);
    inc(rulec);
    rules[rulec] := s;
  end;
  close(src);
  writeln(RuleC,' rules loaded');

  SetupTranslate;
  for i := 1 to rulec do
  begin
    s := rules[i];
    t := 0;
    if GrabString(s) = 'on' then t := 1;
    Expect(' x=',s); x1 := grabnumber(S);  expect('..',s);  x2 := grabnumber(s);
    Expect(',y=',s); y1 := grabnumber(S);  expect('..',s);  y2 := grabnumber(s);
    Expect(',z=',s); z1 := grabnumber(S);  expect('..',s);  z2 := grabnumber(s);

    AddNumber(1,X1); AddNumber(1,X2);
    AddNumber(2,Y1); AddNumber(2,Y2);
    AddNumber(3,Z1); AddNumber(3,Z2);

    AddNumber(1,X1+1); AddNumber(1,X2+1);
    AddNumber(2,Y1+1); AddNumber(2,Y2+1);
    AddNumber(3,Z1+1); AddNumber(3,Z2+1);
  end;

  for i := 1 to 3 do
  begin
    inc(NumberCount[i]);
    NumberValue[i,NumberCount[i]] := NumberValue[i,NumberCount[i]-1]+1;  // append the next integer up to make code easier later
  end;

  for i := 1 to 3 do
    writeln(i,' ',NumberCount[i],' values');

(*
  for j := 1 to 3 do
  begin
    for i := 1 to numbercount[j] do
      write(NumberValue[j,i],',');
    writeln;
  end;
*)

  for i := 1 to rulec do
  begin
    s := rules[i];
    t := 0;
    if GrabString(s) = 'on' then t := 1;
    Expect(' x=',s); x1 := Compress(1,grabnumber(S));  expect('..',s);  x2 := Compress(1,grabnumber(s));
    Expect(',y=',s); y1 := Compress(2,grabnumber(S));  expect('..',s);  y2 := Compress(2,grabnumber(s));
    Expect(',z=',s); z1 := Compress(3,grabnumber(S));  expect('..',s);  z2 := Compress(3,grabnumber(s));

    writeln(X1,' ',X2,' ',Y1,' ',Y2,' ',Z1,' ',Z2);

    for x := x1 to x2 do
      for y := y1 to y2 do
        for z := z1 to z2 do
          grid[x,y,z] := t;

  end;

  count := 0;
  for x := 1 to limit do
    for y := 1 to limit do
      for z := 1 to limit do
      begin
        Volume := (NumberValue[1,x+1] - NumberValue[1,x]) *
                  (NumberValue[2,y+1] - NumberValue[2,y]) *
                  (NumberValue[3,z+1] - NumberValue[3,z]);
        if grid[x,y,z] = 1 then
          inc(count,Volume)
      end;
  writeln('Count = ',count);

  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
  readln;
end.
