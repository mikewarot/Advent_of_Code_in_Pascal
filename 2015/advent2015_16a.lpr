program advent2015_16a;
uses
  mystrings;

const
  items : array[1..10] of string = ('children: 3','cats: 7','samoyeds: 2','pomeranians: 3','akitas: 0','vizslas: 0','goldfish: 5','trees: 3','cars: 2','perfumes: 1');

var
  src : text;
  s : string;
  count : int64;
  name : string;
  a,b,c : string;
  ap,bp,cp : int64;
  i,j,k : int64;


begin
  assign(src,'Advent2015_16a_input.txt');
  reset(src);

  count := 0;
  while not eof(src) do
  begin
    readln(src,s);
    inc(count);
    name := GrabUntil(s,[':']);
    a := GrabUntil(S,[',']); ap := 0;
    b := GrabUntil(S,[',']); bp := 0;
    c := GrabUntil(S,[',']); cp := 0;

    for i := 1 to 10 do
    begin
      if items[i] = a then ap := i;
      if items[i] = b then bp := i;
      if items[i] = c then cp := i;
    end;

    if ap * bp * cp <> 0 then
      writeln(Name);

  end;
  close(src);


  Readln;
end.

