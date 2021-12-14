program advent2015_09a;
uses
  Classes, SysUtils, fgl;

type
  tfal = set of Byte;

procedure skipspace(var s : string);
begin
  while (s <> '') and (S[1] in [' ',#9,#10,#13]) do
    delete(s,1,1);
end;

function getnum(var s : string):integer;
var
  c : char;
  value : integer;
begin
  value := 0;
  while (length(s) <> 0) and NOT(s[1] in ['0'..'9']) do
    delete(s,1,1);
  while (length(s) <> 0) and (s[1] in ['0'..'9']) do
  begin
    value := value * 10 + (ord(s[1])-ord('0'));
    delete(s,1,1);
  end;
  skipspace(s);
  getnum := value;
end;

function getname(var s : string): string;
var
  value : string;
begin
  value := '';
  while (length(s) <> 0) and NOT(s[1] in ['a'..'z','A'..'Z']) do
    delete(s,1,1);
  while (length(s) <> 0) and (s[1] in ['a'..'z','A'..'Z']) do
  begin
    value := value+s[1];
    delete(s,1,1);
  end;
  skipspace(s);
  getname := value;
end;


var
  s,original : string;
  src,dst : string;
  srcnum,dstnum : integer;
  d : integer;

  locations : tstringlist;
  routelength : array[0..100] of array[0..100] of integer;
  i,j,k : integer;
  minroute : integer;
  maxroute : integer;


  function AddUnsorted(S : String): integer;
  var
    key : integer;
  begin
    key := locations.IndexOf(s);   // if it's already there, find it
    if key = -1 then
      key := locations.Add(s);  // otherwise add it
    AddUnsorted := key;
  end;

  procedure permute(s : string; q : tfal);
  var
    x : byte;
    distance : integer;
  begin
    if q <> [] then
      for x in q do
        permute(s+' ' + locations[x],q-[x])
    else
    begin
      Write(s);
      src := getname(s);
      srcnum := locations.IndexOf(src);
      distance := 0;
      while s <> '' do
      begin
        dst := getname(s);
        dstnum := locations.IndexOf(dst);
        if (routelength[srcnum,dstnum] < 0) then
        begin
          s := '';
          distance := -1;
        end
        else
        begin
          distance := distance + routelength[srcnum,dstnum];
          src := dst;
          srcnum := dstnum;
        end;

      end;

      if distance < 0 then
        WriteLn(' - Impossible route')
      else
      begin
        WriteLn(' = ',distance);
        if distance < minroute then
          minroute := distance;
        if distance > maxroute then
          maxroute := distance;
      end;
    end;
  end;


begin
  locations := tstringlist.Create;
  locations.Sorted:= false;
  locations.Duplicates:= dupIgnore;   // don't worry about duplicate location names
    // BUG - doesn't handle duplicates correctly if unsorted, which is dumb
  for i := 0 to 100 do
    for j := 0 to 100 do
      routelength[i,j] := -1;

  while not eof do
  begin
    readln(s);
    original := s;
    src := getname(s);
    srcnum := AddUnsorted(src);  // add it to the locations list
    getname(s);  // toss the "to"
    dst := getname(s);
    dstnum := AddUnsorted(dst);  // add it to the locations list
    delete(s,1,1); // toss the = 2
    d := getnum(s);

    routelength[srcnum,dstnum] := d;
    routelength[dstnum,srcnum] := d;  // assume reciprical direct route is the same length
    writeln(original,' -->  ',src,'(',srcnum,') - ',dst,'(',dstnum,') - ',d);
  end;
  WriteLn;
  for s in locations do
    WriteLn('[',S,']');
  WriteLn(locations.Count);

  minroute := 9999999;
  maxroute := 0;
  permute('',[0..locations.count-1]);
  writeln('Minroute = ',minroute);
  writeln('Maxroute = ',maxroute);
end.

