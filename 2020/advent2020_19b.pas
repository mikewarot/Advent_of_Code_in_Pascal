program advent2020_19b;
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

type
  TMatchRule = record
                MatchChar  : Char;
                SubRule    : Array[1..10] of Array[1..10] of Integer;
                MaxSubRule : Integer;
                MaxSubRuleStep : Array[1..10] of Integer;

  end;
var
  MatchRule : array[0..999] of TMatchRule;
  MaxRule   : Integer;
  MaxPos    : Integer; // how long is the current string we want to match?

  procedure ReadRule(Var S : String);
  var
    i,j,k,l     : integer;
    t           : string;
    RuleNumber  : integer;
    ListNumber  : integer;
    LinkNumber  : integer;
  begin
    RuleNumber := getnum(s);
    If RuleNumber > MaxRule then
      MaxRule := RuleNumber;
    ListNumber := 1;
    LinkNumber := 1;
    MatchRule[RuleNumber].MaxSubRule := 1;  // unless otherwise modified
    expect(s,':');
    Eat(s,WhiteSpace);
    If S = '' then
    begin
      WriteLn('Unexepected End of Rule');
      Halt;
    end;
    If S[1] = '"' then
    begin
      Expect(s,'"');
      MatchRule[RuleNumber].MatchChar := S[1];
      MatchRule[RuleNumber].MaxSubRule := 0; // there are no subrules to follow
      delete(s,1,1);
      Expect(s,'"');
    end
    else
    while s <> '' do
    begin
      case s[1] of
        '0'..'9' : begin
                     MatchRule[RuleNumber].SubRule[ListNumber,LinkNumber] := GetNum(s);
                     MatchRule[RuleNumber].MaxSubRuleStep[ListNumber] := LinkNumber;
                     Inc(LinkNumber);
                     If LinkNumber > 10 then
                     begin
                       writeln('Too many links in list');
                       halt;
                     end;
                   end; // case '0'..'9'
        '|'      : begin
                     Expect(s,'|');
                     Inc(ListNumber);
                     If ListNumber > 10 then
                     begin
                       WriteLn('Too many sub lists');
                       Halt;
                     end;
                     LinkNumber := 1;
                     MatchRule[RuleNumber].MaxSubRule:=ListNumber;
                     MatchRule[RuleNumber].MaxSubRuleStep[ListNumber] := 0;
                   end;
      end; // case s[1]
      Eat(s,WhiteSpace);
    end;

    If S <> '' then
      WriteLn('Rule Left ==> [',s,']');
  end;

  procedure dumpRules;
  var
    i,j,k,l : integer;
  begin
    for i := 0 to MaxRule do
    begin
      If MatchRule[i].MatchChar <> #0 then
        writeln(i,' : "',MatchRule[i].MatchChar,'"')
      else
      begin
        Write(i, ' : ');
        for j := 1 to MatchRule[i].MaxSubRule do
        begin
          if j > 1 then write(' | ');
          for k := 1 to MatchRule[i].MaxSubRuleStep[j] do
            write(MatchRule[i].Subrule[j,k],' ');
        end;
        writeln;
      end; // else
    end; // for i
  end;

var
  RuleYMatchedAtX : Array[0..999] of Array[0..999] of Set of Byte;

  Procedure ResetMatches;
  var
    x,y : integer;
  begin
    for x := 0 to 999 do
      for y := 0 to 999 do
        RuleYMatchedAtX[x,y] := [];
  end;

  Procedure InitialCharacterMatch(S : String);   // does the single character match pass, only need it once
  var
    CharacterPos,
    RuleNumber    : integer;
  begin
    MaxPos := Length(s);
    for CharacterPos := 1 to length(s) do
      for RuleNumber := 0 to MaxRule do
        if MatchRule[RuleNumber].MatchChar = S[CharacterPos] then
          RuleYMatchedAtX[RuleNumber,CharacterPos] := [1];
  end;

  procedure BuildLinkInChain;
  var
    CharacterPos,
    RuleNumber,
    SubRule,
    RuleToMatch,
    StepNumber   : integer;
    Length       : Byte;
    StartingPos  : Byte;
    EndPos       : Byte;
    NextPlace    : integer;
    MatchStarting,
    MatchEnding,
    NextStarting : Set of Byte;

  begin
    for RuleNumber := 0 to MaxRule do
      for SubRule := 1 to MatchRule[RuleNumber].MaxSubRule do
        for StartingPos := 1 to MaxPos do
          begin
            NextStarting := [StartingPos];
            MatchEnding  := [];
            For StepNumber := 1 to MatchRule[RuleNumber].MaxSubRuleStep[SubRule] do
              begin
                MatchStarting := NextStarting;
                MatchEnding := [];
                NextStarting := [];
                RuleToMatch := MatchRule[RuleNumber].SubRule[SubRule,StepNumber];
                if MatchStarting = [] then
                  Break;
                For CharacterPos in MatchStarting do
                  if (CharacterPos >= StartingPos) AND (RuleYMatchedAtX[RuleToMatch,CharacterPos] <> []) then
                  begin
//                    Write('Subrule match found - RuleNumber = ',RuleNumber,' - SubRule ',SubRule,' -- Rule To Match ',RuleToMatch,' - Position ',CharacterPos,' - Length(s) ');
                    for Length in RuleYMatchedAtX[RuleToMatch,CharacterPos] do
                    begin
//                      Write(Length,' ');
                      Include(MatchEnding,CharacterPos+Length-1);
                      If CharacterPos+Length <= MaxPos then
                        Include(NextStarting,CharacterPos+Length);
                    end;
//                    WriteLn;
                  end; // if RuleYMatchedAtX
              end; // for StepNumber
            for EndPos in MatchEnding do
              begin
//                WriteLn('New Match for Rule ',RuleNumber,'[',SubRule,'] at Position ',StartingPos,' Length ',EndPos-StartingPos+1);
                include(RuleYMatchedAtX[RuleNumber,StartingPos],(EndPos-StartingPos+1));
              end; // for endpos
          end; // for StartingPos
  end;

  Procedure DumpMatchesSoFar;
  var
    CharacterPos,
    RuleNumber : integer;
    Length     : Byte;
  begin
    for RuleNumber := 0 to MaxRule do
      for CharacterPos := 1 to 255 do
        If RuleYMatchedAtX[RuleNumber,CharacterPos] <> []then
        begin
          Write('Rule: ',RuleNumber:4,' Pos: ',CharacterPos:4,' Length(s): ');
          for length in RuleYMatchedAtX[RuleNumber,CharacterPos] do
            Write(Length,' ');
          WriteLn;
        end;
  end;

var
  StartTime : TDateTime;
  rulecount,
  datacount,
  matchcount: integer;
  done      : boolean;
  s,t       : string;
  i,j,k,n   : integer;
  matchsize : integer;

begin
  StartTime := Now;
  Rulecount := 0;

  MaxRule := 0;
  for i := 0 to 999 do
  begin
    MatchRule[i].MatchChar := #0;
    MatchRule[i].MaxSubRule := 0;
    for j := 1 to 10 do
      for k := 1 to 10 do
        MatchRule[i].SubRule[j,k] := -1;  // sentinal value
  end;
  done := false;
  writeln('Rules Section');
  repeat
    readln(s);
    if s = '' then done := true
    else
    begin
      Inc(RuleCount);
//      writeln(s);
      ReadRule(S);
    end;
  until done or eof;
  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');

  DumpRules;

  DataCount := 0;
  MatchCount := 0;
  done := false;
  writeln('Data Section');
  repeat
    readln(s);
    if s = '' then done := true
    else
    begin
      Inc(DataCount);
      WriteLn('S = [',s,']');
      ResetMatches;
      InitialCharacterMatch(S);
//      DumpMatchesSoFar;
      for i := 0 to Length(s)+1 do
        begin
//          Writeln('Building a link');
          BuildLinkInChain;
        end;
//      WriteLn('Dumping Matches');
//      DumpMatchesSoFar;
      If (Length(S) in RuleYMatchedAtX[0,1]) then
        begin
          writeln('Match Found! [',s,']');
          inc(MatchCount);
        end;

(*
      matchsize := ValidRule(0,s);
      if matchsize = length(s) then
      begin
        Inc(MatchCount);
        writeln('Matched ',MatchSize,' bytes');
      end;
*)
//      writeln(s);
    end;
  until done or eof;

  writeln;
  writeln(RuleCount,' rules, ',DataCount,' values, ',MatchCount,' matches');
  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
//  DumpRules;


//  DumpTree(0);
  writeln((MilliSecondsBetween(Now,StartTime)*0.001):10:3,' seconds');
end.

