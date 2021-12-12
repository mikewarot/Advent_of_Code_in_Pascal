program advent2021_12a;
uses Classes, Math, MyStrings, fgl;

type
  tByteSet = Set of Byte;

var
  src : text;
  s,t : string;
  i,j,k : integer;
  x,y,z : integer;
  Name  : tStringList;
  StartNode, EndNode : Integer;
  Connections : Array[0..200] of tByteSet;
  OneTime : tByteSet;
  Node1,Node2 : integer;
  Routes : Integer;

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

  procedure Explore(N : Integer;  NodesLeft : tByteSet; PathSoFar : String);
  var
    a,b,c : integer;
  begin
//    WriteLn('Exploring Node "',Name[n],'"');
    If N in OneTime then
      Exclude(NodesLeft,N);

    If PathSoFar <> '' then PathSoFar := PathSoFar + ',';
    PathSoFar := PathSoFar + Name[n];

    If N = EndNode then
    begin
      WriteLn('Path = ',PathSoFar);
      inc(routes);
    end
    else
      for a := 0 to Name.Count-1 do
        If (N <> a) AND (a in Connections[N]) AND (a in NodesLeft) then
          Explore(a,NodesLeft,PathSoFar);
  end; // explore

begin
  Name := tStringList.Create;
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
      include(OneTime,i);

  for i := 0 to Name.Count-1 do
  begin
    Write(Name[i]);
    for j := 0 to Name.Count-1 do
      If (i <> j) AND (J in Connections[i]) then
        Write(' ',Name[j]);
    if i in OneTime then
      Write('*');
    WriteLn;
  end;

  Routes := 0;
  Explore(StartNode,[0..Name.Count-1],'');
  WriteLn(Routes,' routes found');

  readln;
end.

