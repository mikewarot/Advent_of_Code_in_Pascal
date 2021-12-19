program advent2021_18b;
(* Cleaned up the next day, once I'd gotten some rest
   Much debugging code is commented out, but left in place
   just in case.

   this program parses snailnumbers from Adent of Code 2021, Day 18
   it puts them in a list
     d[]  stores the depth of brackets
     n[]  stores the actual number in that node

   once normalized, there are a maximum of 16 nodes, but ram is cheap, so
   we use 1-whatver, and make it zero based to allow for N-1 to not crash

   Once working,the hard part was recreating the text from the numbers, which
   was accomplished by keeping a list of element counts per depth level

   Scoring was computed in parallel with decoding the numbers back to a string
*)
uses Sysutils, MyStrings;

var
  depth,NodeCount : integer;
  d,n : array[0..1000] of integer;  // these could be put into a record, but why?

  procedure Dump(msg : String);     // shows the internal status of depth/value pairs
  var
    i : integer;
  begin
    if msg <> '' then WriteLn(msg);
    for i := 1 to NodeCount do
      write(d[i],',',n[i],'  ');
    writeln;
  end;

  procedure AddSnailNumber(S : String);
  // adds a new snail number to the existing one
  // does NOT explode/split nodes (use Crunch to do that)
  var
    i : integer;
  begin
//    WriteLn('AddSnailNumber(',S,')');
    for i := 1 to NodeCount do
      inc(d[i]);

    if NodeCount <> 0 then
      depth := 1;

    while s <> '' do
      Case S[1] of
        '['    : begin
                   inc(depth);
                   delete(s,1,1);
                 end;
        ']'    : begin
                   dec(depth);
                   delete(s,1,1);
                 end;
        ','    : begin
                   delete(s,1,1);
                 end;
        '0'..'9' : begin
                     inc(NodeCount);
                     n[NodeCount] := grabnumber(s);
                     d[NodeCount] := depth;
                   end; // case digit
        else
          begin
            WriteLn('Unexpected String : ',S);
            S := '';
          end; // case - else
        end; // case
    d[NodeCount+1] := 0;
    n[NodeCount+1] := 0;
//    Dump('End of AddSnailNumber');
  end;

  procedure ReadSnailNumber(S : String);
  // initializes everything to empty list
  // then calls add against the empty list
  begin
    d[0] := 0; // we use nodes 1 up, 0 is to make some code easier to write
    n[0] := 0;
    depth := 0;
    NodeCount := 0;
//    WriteLn('ReadSnailNumber(',S,')');
    AddSnailNumber(s);
//    Dump('End of ReadSnailNumber');
  end;

  procedure Crunch;
  var
    f5    : integer;  // which node is the leftmost with a depth >= 5?
    split : integer;  // which node has a value > 9
    i     : integer;
  begin
    repeat
      f5 := 0;
      split := 0;
      for i := 1 to NodeCount do
        if (d[i] >= 5) and (f5 = 0) then
          f5 := i;

      if f5 <> 0 then
      begin
        if f5 > 1 then inc(n[f5-1],n[f5]);
        if f5+2 <= NodeCount then inc(n[f5+2],n[f5+1]);
        dec(d[f5]);
        n[f5] := 0;
        for i := f5+1 to NodeCount-1 do
        begin
          n[i] := n[i+1];
          d[i] := d[i+1];
        end;
        dec(NodeCount);
//        Dump('after f5');
      end // if f5
      else
      begin
        // you get here ONLY if there weren't any nodes 5 or deeper anywhere
        // a crucial sequencing detail if you want right answers
        split := 0;
        for i := 1 to NodeCount do
          if (n[i] > 9) and (split = 0) then
            split := i;

        if split <> 0 then
        begin
          inc(NodeCount);
          for i := NodeCount downto split+1 do
          begin
            n[i] := n[i-1];
            d[i] := d[i-1];
          end;
          inc(d[split]);
          inc(d[split+1]);
          n[split] := n[split] div 2;
          n[split+1] := n[split+1] - n[split];

//          Dump('after split');
        end; // if split
      end; // if f5 else
    until (f5 = 0) AND (split = 0);
    // put it all in a loop, avoids recursion, and gets it all done in one call
  end;

  function Show:int64;  // it was quick and easy to return the "magnitude" from here
  var
    i   : integer;
    sd  : integer; // showdepth, tracks the state of [] levels
    s   : string;
    paren : array[1..10] of integer; // left/right element# in a node at given depth
    mag   : array[1..10] of int64;   // magnitude of current node
  begin
    sd := 0;              // clear out all the values (which might be initialized by compiler??)
    s := '';
    for i := 1 to 10 do
      paren[i] := 0;
    for i := 1 to 10 do
      mag[i] := 0;

    for i := 1 to NodeCount do
    begin
      while sd < d[i] do
      begin
        s := s + '[';
        inc(sd);
        paren[sd] := 0;
      end;
      s := s + IntToStr(n[i]);
      inc(paren[sd]);
      if paren[sd] = 1 then
        mag[sd] := mag[sd] + (3 * n[i])
      else
        mag[sd] := mag[sd] + (2 * n[i]);

      while (paren[sd]) = 2 do
      begin
        paren[sd] := 0;
        s := s + ']';
        dec(sd);
        if sd <> 0 then
        begin
          inc(paren[sd]);
          if paren[sd] = 1 then
            mag[sd] := mag[sd] + (3 * mag[sd+1])
          else
            mag[sd] := mag[sd] + (2 * mag[sd+1]);
          mag[sd+1] := 0;
        end;
      end;

      if i <> NodeCount then
        s := s + ',';
    end;
    while sd > 0 do
    begin
      s := s + ']';
      dec(sd);
    end;

    WriteLn('Show(',S,')');
    WriteLn('Mag = ',Mag[1]);
    show := Mag[1];
  end;

var
  src : text;
  s   : array[1..1000] of string;
  lines : integer;
  i,j,k : int64;
  maxsum : int64;

begin
  lines := 0;                       // read the input into a string list
  assign(src,'Advent2021_18_input.txt');
  reset(src);
  while not eof(src) do
  begin
    inc(lines);
    readln(src,s[lines]);
  end;
  close(src);

  maxsum := 0;                          // initialize maximum to zero
  writeln(lines,' lines loaded');
  for i := 1 to lines do                // try all orders, except self+self
    for j := 1 to lines do
      if (i <> j) then
      begin
        ReadSnailNumber(s[i]);          // read first value
        crunch;                         // normalize it
        AddSnailNumber(s[j]);           // add second value
        crunch;                         // normalize it
        k := Show;                      // get Magnitude, use K to prevent
        if k > MaxSum then MaxSum := k; // computing it twice
      end;

  writeln('Max Sum = ',MaxSum);         // show answer
  readln;                               // wait for user to hit enter, otherwise window goes away
end.
