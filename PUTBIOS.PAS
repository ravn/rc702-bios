program PutBios;

(* Modifikation af TRACK0 910223/ Thorbj|rn *)

const 
  BiosSize=78;
  FilNavn='B:C.COM';
  Skipsectors= 5;

var
  check, x:	integer;
  trans:	array[1..26] of byte;
  buffer:	array[1..BiosSize,1..128] of byte; (* 128 sektorer l{ses *)
  indfil:	file;
  compare,teststr:  	
                array[8..$D] OF CHAR;

PROCEDURE WriteSector( track, sector, dmaindex: BYTE);
begin
  write('*');
  bios(11,addr(buffer[dmaindex]));	(* Set DMA	*)
  bios(9,track);			(* Read track0	*)
  bios(10,sector);
  if biosb(13)<>0 then
  begin
    mem[$da37]:=8;
    write('WRITE ERROR ON SECTOR ',SECTOR,1/0)
  end;
end;

begin
  WriteLn('Dette program l{gger en Rc700 bios ned p} system sporet p}');
  WriteLn('drev A.  Da dette er en testversion skal filen hedde ',FilNavn);
  WriteLn;
  
  IF Port(.20.) AND $80<> 0 THEN
  BEGIN
    WriteLn('Denne version KUN for 8" disketter');
    HALT;
  END;
  
  for x:=0 to 25 do 
    trans[(x*6) mod 26+1+x div 13]:=x;	(* Beregn SKEW faktor *)
  Fill(Buffer, Size(buffer), '+');
    
  assign(indfil, filnavn);
  reset(indfil);
  
  Write('L{ser bios fil...');
  BlockRead(indfil, buffer, BiosSize, x);
  
  IF NOT Eof(indfil) THEN
  BEGIN
    WriteLn('Bios for lang');
    Close(Indfil);
    halt;
  END;
  Close(indfil);
  
  Move(Buffer[1,$9], teststr, 6);
  compare:= ' RC702';
  IF TestStr<>compare THEN
  BEGIN
    WriteLn('Not for Rc702 ');
    Halt;
  END;
  
  WriteLn('Ok');
  WriteLn;
  FOR x:=1+skipsectors to BiosSize DO Write('.');
  Write(^M);
  
  buffer[($383 div 128)-1,($383 mod 128)+1]:=0; (* Ny base adresse *)

  mem[$da37]:=0;	(* Set SS	*)
  bios(8,0);		(* Sel dsk a:	*)

  for x:= 1+ skipsectors to 26 do 
    writesector(0,trans[x],x);	(* Skip configuration sektors *)
  mem[$da37]:=24;	(* Set SD/DD	*)
  bios(8,0);
  for x:=52 to 103 do writesector(0,x,x-25);
  
  mem[$da37]:=8;
  bios(8,0);

  writeln;
  write('Bios lagt ned.  Resetter CP/M...');
  Bdos(13);
  writeln('F{rdig.');
end.
