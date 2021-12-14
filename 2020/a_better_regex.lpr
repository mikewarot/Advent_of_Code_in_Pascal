program a_better_regex;
(*
  This grew out of the disaster that was the Advent of code 2020, day 4

  Obviously I need a regex, but the traditional one sucks

Design decisions
  1. Don't use TRegExpr, built something more suitable for my needs
  2. New syntax, with a way of spitting out the old one, where applicable

  3. Use set syntax from Pascal as much as possible
    ['0'..'9'] - all digits
    ['0'..'9','a'..'f'] - all lowercase hex digits
    ^ -- uppercase
    v -- lowercase
    X -- either case
    :min:max
    // -- a comment until end of line
    --> fieldname   -- returns match up until now as fieldname,value entry
    Whitespace,Letter, Digit, Hex, UpperCase, LowerCase  --> sets of characters, as appropriate
    ~ Negate upcoming term
  4. Expressions build a value, default is a string, but could be Boolean, Integer, Real, etc.




One of the examples from Advent of Code
    ecl:gry pid:860033327 eyr:2020 hcl:#fffffd byr:1937 iyr:2017 cid:147 hgt:183cm

  WhiteSpace:: // matches 0-infinity instances of whitespace
  --<          // toss the whitespace
  Letter:3:3   // matches 3 letters
  --> key      // stores match to this point into "key"
  [:]          // matches only a colon
  --<          // toss match to this point
  ~WhiteSpace:1: // one or more not whitespace characters
  --> value




*)
const
  Example : String = '    ecl:gry pid:860033327 eyr:2020 hcl:#fffffd byr:1937 iyr:2017 cid:147 hgt:183cm';
var
  s : string;
  x : string;


begin
  WriteLn('The data from the example is');
  WriteLn(example);
  x := example;

  ReadLn;
end.

