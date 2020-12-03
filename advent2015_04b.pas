program advent2015_04b;
uses
  md5;
var
  key,s : string;
  hash : string;
  seed : integer;
  z : string;
begin
  write('Enter a string: ');
  readln(key);
  seed := -1;
  repeat
    inc(seed);
    str(seed,z);
    s := key + z;
    hash := MDPrint(MD5String(s));
  until pos('000000',hash) = 1;;
  writeln('The MD5 is ',MDPrint(MD5String(s)));
  writeln('The seed is ',z);
end.

