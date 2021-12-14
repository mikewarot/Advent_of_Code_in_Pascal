program advent2021_12b;
uses Classes, Math, MyStrings, fgl;

type
  tByteSet = Set of Byte;

var
  Name  : tStringList;
  Route : tStringList;
  OneTime : tByteSet;
  StartNode, EndNode : Integer;
  Connections : Array[0..200] of tByteSet;

  function AddName(S : String):Integer;
  var
    z : integer;
  begin
    z := name.IndexOf(s);
    if z <> -1 then
      AddName := z
    else
      AddName := name.Add(S);
  end;

  function AddRoute(S : String):Integer;
  var
    zz : integer;
  begin
    zz := Route.Add(S);
    write(zz,'  ',#13);
    AddRoute := zz;
  end;

  procedure Explore(N : Integer;  NodesLeft : tByteSet; PathSoFar : String; Special : Integer);
  var
    a,b,c : integer;
    nextnodes : tByteSet;
  begin
    NextNodes := NodesLeft;
//    WriteLn('Exploring Node "',Name[n],'"  Special = ',Special);

    If (Special <> 0) AND (N = Special) then
      Special := 0
    else
      begin
        If N in OneTime then
          Exclude(NextNodes,N);
      end;

    If PathSoFar <> '' then PathSoFar := PathSoFar + ',';
    PathSoFar := PathSoFar + Name[n];

    If N = EndNode then
    begin
      b := AddRoute(PathSoFar);
    end
    else
      for a := 0 to Name.Count-1 do
        If (N <> a) AND (a in Connections[N]) AND (a in NodesLeft) then
          Explore(a,NextNodes,PathSoFar,Special);
  end; // explore

var
  src : text;
  s,t : string;
  i,j,k : integer;
  x,y   : integer;
  Node1,Node2 : integer;

begin
  Name  := tStringList.Create;  Name.Sorted  := False;
  Route := tStringList.Create;  Route.Sorted := True;

  for i := 0 to 200 do
  begin
    Connections[i] := [];
  end;

  StartNode := Name.Add('start');  WriteLn('Start = ',StartNode);
  EndNode := Name.Add('end');      WriteLn('End   = ',EndNode);

  assign(src,'advent2021_12a_input.txt');
  reset(src);

  while not eof(src) do
  begin
    readln(src,s);
    node1 := AddName(GrabUntil(s,['-']));
    node2 := AddName(s);

    Include(Connections[Node1],Node2);
    Include(Connections[Node2],Node1);
  end; // while not eof(src)
  close(src);

  onetime := [0,1];
  for i := 2 to Name.Count-1 do
    if Upcase(Name[i]) <> Name[i] then
    begin
      include(OneTime,i);
      WriteLn('Onetime --> ',Name[i]);
    end;

  for i := 0 to Name.Count-1 do
  begin
    if i in OneTime then
      Write('*');
    Write(Name[i]);
    for j := 0 to Name.Count-1 do
      If (i <> j) AND (J in Connections[i]) then
        Write(' ',Name[j]);
    WriteLn;
  end;

  for i := 0 to Name.Count-1 do
  begin
    Explore(StartNode,[0..Name.Count-1],'',i);
  end;

  WriteLn('Unique Routes = ',Route.Count);
  (*
  for i := 0 to Route.Count-1 do
    WriteLn(Route[i]);
  *)
  readln;
end.

