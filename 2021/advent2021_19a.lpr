program advent2021_19a;
uses Sysutils, MyStrings, Classes, fgl;

type
  tpoint = record
    x,y,z : int64;
  end;

  tSounding = record
    scanner,x,y,z : int64;
  end;

const
  rotation : array[1..24] of array[1..3] of integer =
  (( 1, 2, 3),( 2, 3, 1),( 3, 1, 2),
   ( 1, 3,-2),( 2, 1,-3),( 3, 2,-1),
   ( 1,-3, 2),( 2,-1, 3),( 3,-2, 1),
   ( 1,-2,-3),( 2,-1,-3),( 3,-2,-1),
   (-1, 3, 2),(-2, 1, 3),(-3, 2, 1),
   (-1, 2,-3),(-2, 3,-1),(-3, 1,-2),
   (-1,-2, 3),(-2,-3, 1),(-3,-1, 2),
   (-1,-3,-2),(-2,-1,-3),(-3,-2,-1));


var
  deltas : tStringList;
  d      : integer;
  src : text;
  s,t   : string;
  soundings : array[1..1000] of tSounding;
  scancount,
  soundcount : integer;

  match : array[1..1000] of array[1..1000] of integer;

  i,j,k,l,n,x,y,z : integer;
  first,last  : integer;
  dx,dy,dz,r2 : int64;

  old_r2,zzc : int64;
  zz         : array[1..100] of int64;
  qq         : array[1..3] of int64;
  r          : integer;

  spun       : array[1..100] of tSounding;
  spuncount  : integer;

  known      : array[1..1000] of tPoint;
  knownCount : integer;
  hits       : integer;
  scann      : integer;
  newp,goodp : tpoint;
  good,aa,bb : integer;

begin
  deltas := tStringList.Create;  deltas.Sorted := True;

  scancount  := -1;
  soundcount := 0;
  assign(src,'Advent2021_19_sample.txt');
//  assign(src,'Advent2021_19.txt');
  reset(src);
  while not eof(src) do
  begin
    readln(src,s);
    if s<> '' then
    begin
      if s[2]='-' then
        inc(scancount)
      else
      begin
        inc(soundcount);
        soundings[soundcount].scanner:=scancount;
        soundings[soundcount].x := grabnumber(s);
        soundings[soundcount].y := grabnumber(s);
        soundings[soundcount].z := grabnumber(s);
      end;
    end;
  end;
  close(src);
  WriteLn(Soundcount,' soundings from ',scancount,' scanners loaded');

  knownCount := 0;
  for i := 1 to Soundcount do
    if Soundings[i].Scanner = 0 then
    begin
      Inc(KnownCount);
      Known[KnownCount].x := Soundings[i].x;
      Known[KnownCount].y := Soundings[i].y;
      Known[KnownCount].z := Soundings[i].z;

    end;

  for scann := 1 to ScanCount do
  begin
    writeln('Starting scan for ',scann);
    for r := 1 to 24 do
    begin
      spuncount := 0;
      for i := 1 to Soundcount do
        if Soundings[i].scanner = scann then
        begin
          qq[1] := soundings[i].x;
          qq[2] := soundings[i].y;
          qq[3] := soundings[i].z;
          inc(spuncount);
          spun[spuncount].scanner:= soundings[i].scanner;
          if rotation[r][1] > 0 then spun[spuncount].x := qq[rotation[r][1]] else spun[spuncount].x := -qq[-rotation[r][1]];
          if rotation[r][2] > 0 then spun[spuncount].y := qq[rotation[r][2]] else spun[spuncount].y := -qq[-rotation[r][2]];
          if rotation[r][3] > 0 then spun[spuncount].z := qq[rotation[r][3]] else spun[spuncount].z := -qq[-rotation[r][3]];
        end;

  //    WriteLn(rotation[r][1],',',rotation[r][2],',',rotation[r][3]);
  //    writeln(Spun[1].x,',',Spun[1].y,',',Spun[1].z);

      hits := 0;
      for i := 1 to Knowncount do
        for j := 1 to KnownCount do
          if i<>j then
            for k := 1 to SpunCount do
              for l := 1 to SpunCount do
                if k<>l then
                begin
                  if ((known[i].x-known[j].x) = (spun[k].x-spun[l].x)) AND
                     ((known[i].y-known[j].y) = (spun[k].y-spun[l].y)) AND
                     ((known[i].z-known[j].z) = (spun[k].z-spun[l].z)) then
                  begin
                    inc(hits);
                    newp.x := known[i].x-spun[k].x;
                    newp.y := known[i].y-spun[k].y;
                    newp.z := known[i].z-spun[k].z;

                    good := 0;
                    for aa := 1 to KnownCount do
                      for bb := 1 to SpunCount do
                        if (known[aa].x = newp.x + Spun[bb].x) AND
                           (known[aa].y = newp.y + Spun[bb].y) AND
                           (known[aa].z = newp.z + Spun[bb].z) then
                           inc(good);

                    if good >= 2 then
                    begin
                      goodp := newp;
                    end; // if good

                  end; // if matching delta
                end;
      If Hits > 2 then
        WriteLn('Match found ',r,',',hits);
      If Hits > 10 then
      begin
        WriteLn('New scanner location = ',
          goodp.x,',',
          goodp.y,',',
          goodp.z);
      end;

    end;
    writeln('Scan done');
  end; // for scann
(*

  last := 0;
  for k := 0 to scancount-1 do
  begin
    first := last+1;
    for i := 1 to soundcount do
      if soundings[i].scanner=k then last := i;

    for i := first to last-1 do
      for j := i+1 to last do
        begin
          dx := soundings[i].x-soundings[j].x;
          dy := soundings[i].y-soundings[j].y;
          dz := soundings[i].z-soundings[j].z;
          r2 := (dx*dx) + (dy*dy) + (dz*dz);

          s := IntToStr(r2)+','+
               IntToStr(k) +','+
               IntToStr(i) +','+
               IntToStr(j) +','+
               IntToStr(dx)+','+
               IntToStr(dy)+','+
               IntToStr(dz);
//          writeln(r2,',',k,',',i,',',j,',',dx,',',dy,',',dz);
           deltas.Add(s);
//           writeln(s);
        end; // for i,j
  end; // for k

  for i := 1 to 1000 do
    for j := 1 to 1000 do
      match[i,j] := 0;

  old_r2 := 0;
  zzc := 0;
  for d := 0 to deltas.Count-1 do
  begin;
    s := deltas[d];
    r2 := grabnumber(s);
    grabnumber(s); // toss scanner #
    if r2 <> old_r2 then
    begin
      if zzc > 2 then
      for i := 1 to zzc do
        for j := 1 to zzc do
          if i <> j then
            inc(match[zz[i],zz[j]]);

      zzc := 2;
      zz[1] := grabnumber(s);
      zz[2] := grabnumber(s);
    end
    else
    begin
      inc(zzc);  zz[zzc] := grabnumber(s);
      inc(zzc);  zz[zzc] := grabnumber(s);
    end;
    old_r2 := r2;
  end; // for i

  for i := 1 to soundcount do
  begin
    write(i:4);
    for j := 1 to soundcount do
      if match[i,j] > 2 then
        write('  ',j,':',match[i,j]);
    writeln;
  end; // for i
*)


  readln;  // wait for user to hit enter, otherwise window goes away
end.
