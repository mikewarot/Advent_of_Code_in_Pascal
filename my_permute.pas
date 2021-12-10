unit my_permute;

interface

  procedure permute(ValueCount,N : integer;  var Dst : Array of integer);

  function Factorial(N : integer): int64;

implementation

  procedure permute(ValueCount,N : integer;  var Dst : Array of integer);
  var
    i,j,k : integer;
    a,b,z : integer;
    q : array[1..100] of integer;
    p : array[1..100] of integer;
    available : set of byte;
    pcount : integer;

  begin
    pCount := ValueCount;
    a := N-1;
    z := a;
    for b := 2 to PCount do
    begin
      j := z div b; k := z mod b;
      q[(Pcount+1)-b] := k;
      z := j;
    end;
    q[PCount] := 0;

//    for b := 1 to PCount do
//      write(q[b],' ');

    available := [1..PCount];
    for i := 1 to PCount do
    begin
      k := q[i]+1;
      j := 0;
      repeat
        inc(j);
        if j in available then dec(k);
      until k=0;
      p[i] := j;
      available := available - [j];
    end;

//    Write('Output : ');
    for i := 1 to PCount do
    begin
//      Write(p[i],' ');
      dst[i-1] := p[i];
    end;
//    Writeln;
  end; // permute

  function Factorial(N : integer): int64;
  var
    z : int64;
  begin
    z := 1;
    while n > 1 do
    begin
      z := z * n;
      dec(n);
    end;
    Factorial := z;
  end;

(*

var
  i,j,k : integer;
  a,b,z : integer;

  q : array[1..10] of integer;
  p : array[1..10] of integer;
  available : set of byte;
  pcount : integer;

begin
  Write('How many to permute? :'); ReadLn(Pcount);
  for a := 0 to 100 do
  begin
    z := a;
    for b := 2 to PCount do
    begin
      j := z div b; k := z mod b;
      q[(Pcount+1)-b] := k;
      z := j;
    end;
    q[PCount] := 0;

    for b := 1 to PCount do
      write(q[b],' ');

    available := [1..PCount];
    for i := 1 to PCount do
    begin
      k := q[i]+1;
      j := 0;
      repeat
        inc(j);
        if j in available then dec(k);
      until k=0;
      p[i] := j;
      available := available - [j];
    end;


    Write('Output : ');
    for i := 1 to PCount do
      Write(p[i],' ');
    Writeln;
  end;


  readln;
end.
*)

initialization

end. // initialization
