program advent2020_21a;
uses
  classes, sysutils, dateutils;
type
  charset = set of char;
const
  whitespace : charset = [' ',#9,#10,#13];

procedure eat(var s : string;  whattoeat : charset);
begin
  while (length(s) <> 0) and (s[1] in whattoeat) do
    delete(s,1,1);
end;

procedure Expect(var s : string; c : char);
begin
  if (s='') OR (s[1] <> c) then
    writeln('Error : Expected [',c,'], Got [',s,']')
  else
    delete(s,1,1);
end;

function getnum(var s : string):integer;
var
  c : char;
  value : integer;
begin
  value := 0;
  eat(s,whitespace);
  while (length(s) <> 0) and (s[1] in ['0'..'9']) do
  begin
    value := value * 10 + (ord(s[1])-ord('0'));
    delete(s,1,1);
  end;
  eat(s,whitespace);
  getnum := value;
end;

function getinteger(var s : string):integer;
var
  value : integer;
  sign  : integer;
begin
  value := 0;
  sign := 1;
  eat(s,whitespace);
  if s <> '' then
    if s[1] = '+' then
      delete(s,1,1)
    else
      if s[1] = '-' then
      begin
        sign := -1;
        delete(s,1,1);
      end;
  while (s <> '') AND (s[1] in ['0'..'9']) do
  begin
    value := (value * 10) + (ord(s[1])-ord('0'));
    delete(s,1,1);
  end;
  value := value * sign;
  getinteger := value;
end;

function getword(var s : string):string;
var
  c : char;
  value : string;
begin
  value := '';
  while (length(s) <> 0) and (s[1] in [' ']) do
    delete(s,1,1);
  while (length(s) <> 0) and (s[1] in ['0'..'9','a'..'z','A'..'Z']) do
  begin
    value := value + s[1];
    delete(s,1,1);
  end;
  while (s <> '') AND (s[1] = ' ') do
    delete(s,1,1);
  getword := value;
end;

  Function Reverse(T : String):String;
  var
    i : integer;
    s : string;
  begin
    s := '';
    for i := length(t) downto 1 do
      s := s + t[i];
    Reverse := s;
  end;

var
  linecount : integer;
  toxincount : integer;
  toxin      : array[1..100] of string;
  ToxinLines : array[1..100] of set of byte;
  ingredientcount : integer;
  ingredient : array[1..1000] of string;
  IngredientLines : array[1..1000] of set of byte;

  function AddIngredient(s : string) : Integer;
  var
    i : integer;
  begin
    i := 1;
    while (i <= IngredientCount) AND (Ingredient[i] <> s) do
      inc(i);
    if i > IngredientCount then
      begin
        IngredientCount := i;
        ingredient[IngredientCount] := s;
      end;
    AddIngredient := i;
  end;

  function AddToxin(s : string) : Integer;
  var
    i : integer;
  begin
    i := 1;
    while (i <= toxincount) AND (toxin[i] <> s) do
      inc(i);
    if i > ToxinCount then
      begin
        ToxinCount := i;
        Toxin[ToxinCount] := s;
      end;
    AddToxin := i;
  end;

  function AcceptLine(S : String):boolean;
  var
    i : integer;
    x : string;
  begin
    if s <> '' then
      begin
        inc(linecount);
        while (s <> '') AND (s[1] <> '(') do
          begin
            x := getword(s);
            i := AddIngredient(x);
            Include(IngredientLines[i],LineCount);
            writeln('Ingredient[',i,']: ',X);
          end;
        expect(s,'(');
        if getword(s) <> 'contains' then
          begin
            WriteLn('( without contains');
            halt;
          end;
        while (s <> '') AND (s[1] <> ')') do
          begin
            x := getword(s);
            i := AddToxin(x);
            Include(ToxinLines[i],LineCount);
            writeln('Toxin[',i,']: ',X);
            Eat(s,[',']); // eat any commas
          end;
        expect(s,')');
        AcceptLine := True;
      end
    else
      Acceptline := False;
  end;

var
  StartTime : TDateTime;
  done      : boolean;
  s,t       : string;
  i,j,k,m,n : integer;
  matchsize : integer;
  MatchedIngredient,UnMatchedIngredient : Set of Byte;
  MatchedCount,UnMatchedCount : Integer;
  ToxinCandidateCount : array[1..100] of integer;
  ToxinLastMatch : array[1..100] of integer;

begin
  StartTime := Now;
  done := false;
  linecount := 0;
  ToxinCount := 0;        for i := 1 to 100 do ToxinLines[i] := [];       for i := 1 to 100 do ToxinCandidateCount[i] := 0;
  IngredientCount := 0;   for i := 1 to 1000 do IngredientLines[i] := [];

  writeln('Input Section');
  repeat
    readln(s);
    if Acceptline(s) then
      writeln(s);
  until done or eof;

  WriteLn(linecount,' lines accepted');
  WriteLn(IngredientCount,' ingredients accepted');
  WriteLn(ToxinCount,' toxins accepted');

  writeln;
  writeln('Ouput Section');
  writeln;

  for i := 1 to IngredientCount do
    begin
      Write('Ingredient[',i:4,'] ',Ingredient[i],' : ');
      for j in IngredientLines[i] do
        Write(j,' ');
      WriteLn;
    end;

  for i := 1 to ToxinCount do
    begin
      Write('Toxin[',i:4,'] ',Toxin[i],' : ');
      for j in ToxinLines[i] do
        Write(j,' ');
      WriteLn;
    end;

  writeln;
  writeln('Deductions Section');
  writeln;

  UnMatchedIngredient := [1..IngredientCount];
  MatchedIngredient :=  [];

  for j := 1 to ToxinCount do
    for i := 1 to IngredientCount do
      if IngredientLines[i] >= ToxinLines[j] then
        begin
          WriteLn('Ingredient[',i,'] ',Ingredient[i],' >= Toxin[',j,'] ',Toxin[j]);
          Exclude(UnMatchedIngredient,i);
          Include(MatchedIngredient,i);
          Inc(ToxinCandidateCount[j]);
          ToxinLastMatch[j] := i;
        end;

  writeln;
  UnMatchedCount := 0;
  for i in UnMatchedIngredient do
    begin
      WriteLn('Ingredient[',i,'] ',Ingredient[i],' not matched');
      for j in IngredientLines[i] do
        Inc(UnMatchedCount);
    end;
  Writeln('Unmatched Count : ',UnMatchedCount);

  Writeln('Possible Toxins');
  for i in MatchedIngredient do
    begin
      WriteLn('Ingredient[',i,'] ',Ingredient[i]);
    end;

  writeln;
  writeln('Toxic Candidate Counts');
  writeln;
  for i := 1 to ToxinCount do
    WriteLn('Toxin[',i,']: ',Toxin[i],'  Count = ',ToxinCandidateCount[i]);

  while MatchedIngredient <> [] do
    begin
      writeln;
      WriteLn('Do an elimination');
      writeln;

      for i := 1 to ToxinCount do
        if ToxinCandidateCount[i] = 1 then
          begin
            WriteLn('Eliminate ',Toxin[i],' ',Ingredient[ToxinLastMatch[i]]);
            Exclude(MatchedIngredient,ToxinLastMatch[i]);
          end;

      writeln('++++++++++++++++++');

      for i := 1 to IngredientCount do
        ToxinCandidateCount[i] := 0;

      for i in MatchedIngredient do
        begin
          for j := 1 to ToxinCount do
            if IngredientLines[i] >= ToxinLines[j] then
              begin
//                WriteLn('Ingredient[',i,'] ',Ingredient[i],' >= Toxin[',j,'] ',Toxin[j]);
                Inc(ToxinCandidateCount[j]);
                ToxinLastMatch[j] := i;
              end;
        end;
(*
      writeln;
      writeln('Toxic Candidate Counts');
      writeln;
      for i := 1 to ToxinCount do
        WriteLn('Toxin[',i,']: ',Toxin[i],'  Count = ',ToxinCandidateCount[i]);
*)

    end; // while MatchedIngredient <> [] do

  for j := 1 to ToxinCount do
    for i in MatchedIngredient do
      if IngredientLines[i] >= ToxinLines[j] then
        begin
          WriteLn('Ingredient[',i,'] ',Ingredient[i],' >= Toxin[',j,'] ',Toxin[j]);
        end;


  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
end.

