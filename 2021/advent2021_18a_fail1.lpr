program advent2021_18a_fail1;
uses MyStrings;

  Procedure AssertEqual(Actual,Expected : String; Description : String);
  begin
    if Expected = Actual then
      WriteLn(Description,' passed!')
    else
    begin
      WriteLn(Description,' failed!');
      WriteLn(' Expected : ',Expected);
      WriteLn(' Got      : ',Actual);
    end; // if
    WriteLn;
    WriteLn;
  end; // AssertEqual


  function reduce(s : string):string;
  var
    depth,left,right : int64;
    a,b,i,j,k : int64;
    start5 : int64;
    t : string;
  begin
    repeat
      left := 0;
      right := 0;
      depth := 0;
      start5 := 0;
      a := 0;
      b := 0;
      for i := 1 to length(s) do
        case s[i] of
          '[' : begin
                  inc(depth);
                  if (depth>=5) and (start5=0) then
                    start5 := i;
                end;
          ']' : dec(depth);
          '0'..'9' : if (start5 = 0) then
                       left := i
                     else
                       if (right = 0) AND (depth < 5) then
                         right := i;
        end; // case

      if start5 <> 0 then
      begin
        a := ord(s[start5+1])-ord('0');
        b := ord(s[start5+3])-ord('0');

        writeln('Left   = ',Left);     if left <> 0 then Write('Left-->',S[Left]);
        writeln('Start5 = ',Start5);
        Writeln('A      = ',A);
        WriteLn('B      = ',B);
        WriteLn('Right  = ',Right);    if right<> 0 then Write('Right->',S[Right]);

        delete(s,start5,5);
        insert('0',s,start5);

        if left <> 0 then
        begin
          a := a + ord(s[left])-ord('0');
          writeln('New A = ',A);
          s[left] := chr(A+ord('0'));
        end;  // if left

        if right <> 0 then
        begin
          dec(right,4); // adjust for above delete and addition
          b := b + ord(s[right])-ord('0');
          writeln('New B = ',b);
          s[right] := chr(b+ord('0'));
        end; // if right

        if b >= 10 then  // do right side first, otherwise left would move it
        begin
          delete(s,right,1);
          t := '['+chr((b div 2)+ord('0'))+','+chr(((b+1)div 2)+ord('0'))+']';
          writeln('B was ',B,'  becomes ',t);
          insert(t,s,right);
        end; // if b

        if a >= 10 then
        begin
          delete(s,left,1);
          t := '['+chr((a div 2)+ord('0'))+','+chr(((a+1)div 2)+ord('0'))+']';
          writeln('A was ',A,'  becomes ',t);
          insert(t,s,left);
        end;  // if a
      end; // if Start5
      WriteLn('After Start5, S = ',S);
    until (Start5 = 0);
    reduce := s;
  end;

  function AddSnail(a, b : string): string;
  var
    t : string;
  begin
    t := '['+A+','+B+']';
    WriteLn('After Addition, before reduction');
    WriteLn('    --> ',t);
    AddSnail := reduce(t);
  end;

var
  src : text;
  s,t : string;

begin
  AssertEqual(
    AddSnail('[1,2]','[[3,4],5]'),
    '[[1,2],[[3,4],5]]',
    'Snail Addition');
  AssertEqual(
    Reduce('[[[[[9,8],1],2],3],4]'),
    '[[[[0,9],2],3],4]',
    'Snail Reduction');
  AssertEqual(
    Reduce('[7,[6,[5,[4,[3,2]]]]]'),
    '[7,[6,[5,[7,0]]]]',
    'Snail Reduction');
  AssertEqual(
    Reduce('[[6,[5,[4,[3,2]]]],1]'),
    '[[6,[5,[7,0]]],3]',
    'Snail Reduction');
  AssertEqual(
    Reduce('[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]'),
    '[[3,[2,[8,0]]],[9,[5,[7,0]]]]',
    'Snail Reduction');

  AssertEqual(
    Reduce('[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]'),
    '[[[[0,7],4],[[7,8],[6,0]]],[8,1]]',
    'Snail Reduction');

  AssertEqual(
    AddSnail('[[[[4,3],4],4],[7,[[8,4],9]]]','[1,1]'),
    '[[[[0,7],4],[[7,8],[6,0]]],[8,1]]',
    'Snail Addition');

  Assign(Src,'Advent2021_18.txt');
  Reset(Src);
  ReadLn(Src,S);
  While Not Eof(Src) do
  begin
    ReadLn(Src,T);
    S := AddSnail(S,T);
    S := Reduce(S);
  end;
  Close(Src);
  WriteLn('S = ',S);

  readln;
end.

