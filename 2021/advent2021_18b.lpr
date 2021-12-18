program advent2021_18b;
uses Sysutils, MyStrings;

Procedure AssertEqual(Actual,Expected : String; Description : String);
begin
  if Expected = Actual then
    WriteLn(Description,' passed!')
  else
  begin
    WriteLn(Description,' failed!');
    WriteLn(' Expected : ',Expected);
    WriteLn(' Got      : ',Actual);
    WriteLn;
    WriteLn;
  end; // if
end; // AssertEqual


procedure Expect(Var S : String; Expected : String);
begin
  If (S = '') or (Pos(Expected,S)<>1) then
    WriteLn('Expected ',Expected,'  got ',s,' instead!')
  else
    Delete(S,1,Length(Expected));
end;


var
  left,right,depth,count : integer;

  d,n : array[0..1000] of integer;

  procedure Dump(msg : String);
  var
    i : integer;
  begin
    if msg <> '' then WriteLn(msg);
    for i := 1 to count do
      write(d[i],',',n[i],'  ');
    writeln;
  end;

  procedure AddSnailNumber(S : String);
  var
    i : integer;
  begin
    WriteLn('AddSnailNumber(',S,')');
    for i := 1 to count do
      inc(d[i]);

    if count <> 0 then
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
                     inc(count);
                     n[count] := grabnumber(s);
                     d[count] := depth;
                   end; // case digit
        else
          begin
            WriteLn('Unexpected String : ',S);
            S := '';
          end; // case - else
        end; // case
    d[count+1] := 0;
    n[count+1] := 0;
    Dump('End of AddSnailNumber');
  end;

  procedure ReadSnailNumber(S : String);
  begin
    d[0] := 0;
    n[0] := 0;
    depth := 0;
    count := 0;
    WriteLn('ReadSnailNumber(',S,')');
    AddSnailNumber(s);
    Dump('End of ReadSnailNumber');
  end;

  procedure Crunch;
  var
    f5    : integer;
    split : integer;
    i     : integer;
  begin
    repeat
      f5 := 0;
      split := 0;
      for i := 1 to count do
        if (d[i] >= 5) and (f5 = 0) then
          f5 := i;

      if f5 <> 0 then
      begin
        if f5 > 1 then inc(n[f5-1],n[f5]);
        if f5+2 <= count then inc(n[f5+2],n[f5+1]);
        dec(d[f5]);
        n[f5] := 0;
        for i := f5+1 to count-1 do
        begin
          n[i] := n[i+1];
          d[i] := d[i+1];
        end;
        dec(count);


        Dump('after f5');
      end // if f5
      else
      begin
        split := 0;
        for i := 1 to count do
          if (n[i] > 9) and (split = 0) then
            split := i;

        if split <> 0 then
        begin
          inc(count);
          for i := count downto split+1 do
          begin
            n[i] := n[i-1];
            d[i] := d[i-1];
          end;
          inc(d[split]);
          inc(d[split+1]);
          n[split] := n[split] div 2;
          n[split+1] := n[split+1] - n[split];

          Dump('after split');
        end; // if split
      end; // if f5 else
    until (f5 = 0) AND (split = 0);

  end;

  function Show:int64;
  var
    i,j,k : integer;
    sd  : integer; // showdepth
    s : string;
    paren : array[1..10] of integer;
    mag   : array[1..10] of int64;
  begin
    sd := 0;
    s := '';
    for i := 1 to 10 do
      paren[i] := 0;
    for i := 1 to 10 do
      mag[i] := 0;

    for i := 1 to count do
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

      if i <> count then
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
  lines := 0;
  assign(src,'Advent2021_18_input.txt');
  reset(src);
  while not eof(src) do
  begin
    inc(lines);
    readln(src,s[lines]);
  end;
  close(src);

  maxsum := 0;
  writeln(lines,' lines loaded');
  for i := 1 to lines do
    for j := 1 to lines do
      if (i <> j) then
      begin
        ReadSnailNumber(s[i]);
        crunch;
        AddSnailNumber(s[j]);
        crunch;
        k := Show;
        if k > MaxSum then MaxSum := k;
      end;

  writeln('Max Sum = ',MaxSum);
  readln;
end.
