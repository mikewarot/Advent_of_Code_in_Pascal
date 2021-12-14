program advent2015_12b;
type
  tNodeType = (tArray,tObject,tString,tNumber);

  tJSONnode = record
                 nodetype : tNodeType;
                 text     : string;
                 total    : int64;
              end;
const
  TypeName : Array[tNodeType] of String =  ('Array','Object','String','Number');

  Function GetNode(Var S : String): tJsonNode;     FORWARD;

  function GetString(Var S : String): tJsonNode;
  var
    t : string;
    x : tJsonNode;
  begin
    t := '"';
    Delete(S,1,1);
    While S[1] <> '"' do
    begin
      t := t + s[1];
      delete(s,1,1);
    end;
    delete(s,1,1);
    t := t + '"';
    x.nodetype := tString;
    x.text     := t;
    x.total    := 0;
    GetString := x;
  end;

  function GetNumber(Var S : String): tJsonNode;
  var
    t : string;
    sign,x : int64;
    j : tJsonNode;
  begin
    sign := 1;
    x := 0;
    if s[1] = '-' then
    begin
      sign := -1;
      delete(s,1,1);
      t := '-';
    end;
    while (s <> '') and (s[1] in ['0'..'9']) do
    begin
      x := x * 10;
      x := x + (ord(s[1])-ord('0'));
      t := t + s[1];
      delete(s,1,1);
    end;
    x := x * sign;
    j.nodetype := tNumber;
    j.text := t;
    j.total :=x;
    GetNumber := j;
  end;

  function GetArray(Var S : String): tJsonNode;
  var
    j : tJsonNode;
    x : tJsonNode;
  begin
    j.nodetype:= tArray;
    j.total := 0;
    j.text := '[';
    if (s <> '') AND (s[1] = '[') then
      delete(s,1,1);
    while (s <> '') and (s[1] <> ']') do
    begin
      x := GetNode(s);
      j.total := j.total + x.total;
      j.text  := j.text  + x.text;

      if (s <> '') AND (s[1] = ',') then
      begin
        j.text := j.text + ',';
        delete(s,1,1);
      end;
    end;

    if s[1] = ']' then
      delete(s,1,1)
    else
      WriteLn('Array missing closing ]');

    j.text := j.text + ']';
    GetArray := j;
  end;

  function GetObject(Var S : String): tJsonNode;
  var
    j : tJsonNode;
    x : tJsonNode;
    name : tJsonNode;
    dirty : boolean;
  begin
    dirty := false;
    j.nodetype:= tObject;
    j.total := 0;
    j.text := '{';
    if (s <> '') AND (s[1] = '{') then
      delete(s,1,1);
    while (s <> '') and (s[1] <> '}') do
    begin
      name := GetString(s);
      if (s <> '') AND (s[1] = ':') then
        delete(s,1,1)
      else
        WriteLn('Missing :');

      j.text := j.text + name.text + ':';

      x := GetNode(s);
      j.total := j.total + x.total;
      j.text  := j.text  + x.text;

      if (x.nodetype = tString) and (x.text = '"red"') then
        dirty := true;

      if (s <> '') AND (s[1] = ',') then
      begin
        j.text := j.text + ',';
        delete(s,1,1);
      end;
    end;

    if s[1] = '}' then
      delete(s,1,1)
    else
      WriteLn('Onject missing closing }');

    j.text := j.text + '}';

    if dirty then
      j.total := 0;
    GetObject := j;
  end;


  Function GetNode(Var S : String): tJsonNode;
  var
    t : string;
    j : tJsonNode;
  begin
    case s[1] of
      '0'..'9','-'  : j := GetNumber(s);
      '"'           : j := GetString(s);
      '{'           : j := GetObject(s);
      '['           : j := GetArray(s);
    end;
    GetNode := j;
  end;

var
  s : string;
  j : tJsonNode;
begin
  while not eof do
  begin
    readln(s);
    if s <> '' then
    begin
      j := GetNode(s);
      WriteLn('Node type : ',TypeName[j.nodetype]);
      WriteLn('     Text = ',j.text);
      WriteLn('    Total = ',j.total);
    end;

  end;
end.

