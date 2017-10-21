uses
 crt;
const
 q:array[1..4,1..2] of integer=((0,1),(0,-1),(-1,0),(1,0));
 mapn=10;
var
 map:array[0..21,0..41] of char;
 direct:array[1..9] of integer;
 pos:array[1..9,1..2] of integer;
 score:array[1..9] of integer;
 get:array[1..9] of integer;
 bonus:array[1..9] of integer;
 drop:array[1..9] of boolean;
 finish:array[1..9] of boolean;
 r,n,i,j,p,x,y,k,m,time:integer;
 s:string;
 f:text;
procedure print;
var
 i,j,m:integer;
 a,n:array[1..9] of integer;
function player(x,y:integer):integer;
var
 i:integer;
begin
 for i:=1 to 9 do if (pos[i,1]=x) and (pos[i,2]=y) then exit(i);
 exit(0);
end;
begin
 clrscr;
 for i:=1 to 9 do begin a[i]:=score[i]+get[i]+bonus[i]; n[i]:=i; end;
 for i:=1 to 8 do
 for j:=i+1 to 9 do
   if a[i]<a[j] then
    begin
     m:=a[i]; a[i]:=a[j]; a[j]:=m;
     m:=n[i]; n[i]:=n[j]; n[j]:=m;
    end;
 writeln('Round: ',r,'   Map: ',k,'   Time Left: ',time);
 for i:=1 to x do
  begin
   for j:=1 to y do
     if player(i,j)=1 then begin textattr:=11; write(1); end
     else if map[i,j] in ['A'..'F'] then begin textattr:=12; write(map[i,j]); end
     else if map[i,j] in ['a'..'f'] then begin textattr:=6; write(ord(map[i,j])-96); end
     else if player(i,j)>1 then begin textattr:=9; write(player(i,j)); end
     else if map[i,j] in ['0'..'4'] then begin textattr:=15; write(map[i,j]); end
     else if map[i,j] in ['5'..'7'] then begin textattr:=14; write(map[i,j]); end
     else if map[i,j] in ['8','9'] then begin textattr:=10; write(map[i,j]); end
     else write(' ');
   if i<=9 then begin if n[i]=1 then textattr:=13 else textattr:=7; write('     ',n[i],':',score[n[i]]:3,'+',get[n[i]]:2,'+',bonus[n[i]]:2,'=',a[i]:3); end;
   writeln;
  end;
end;
begin
 randomize;
 textattr:=13;
 writeln('***** *   * *****     ****   ***   ***  *****');
 writeln('  *   *   * *         *   * *   * *   * *    ');
 writeln('  *   ***** *****     ****  ***** *     *****');
 writeln('  *   *   * *         *  *  *   * *   * *    ');
 writeln('  *   *   * *****     *   * *   *  ***  *****');
 writeln;
 textattr:=7;
 write('Input Rounds: '); readln(n);
 fillchar(score,sizeof(score),0);
 for r:=1 to n do
  begin
   fillchar(map,sizeof(map),' ');
   k:=random(mapn)+1;
   str(k,s);
   assign(f,'d:\little games\race\map\map'+s+'.txt'); reset(f);
   readln(f,x,y);
   for i:=1 to x do
    begin
     for j:=1 to y do read(f,map[i,j]);
     readln(f);
    end;
   readln(f,pos[1,1],pos[1,2],direct[1]);
   for i:=2 to 9 do begin pos[i,1]:=pos[1,1]; pos[i,2]:=pos[1,2]; direct[i]:=direct[1]; end;
   readln(f,time);
   close(f);
   fillchar(get,sizeof(get),0); fillchar(bonus,sizeof(bonus),0); fillchar(finish,sizeof(finish),false); fillchar(drop,sizeof(drop),false);
   print;
    repeat
     dec(time);
     for i:=1 to 9 do if finish[i]=false then
      begin
       if i=1 then begin write('Enter to Go'); readln; end;
       j:=random(6)+1; p:=j;
       if i=1 then begin write(j); readln; end;
        repeat
         dec(p);
         if map[pos[i,1]+q[direct[i],1],pos[i,2]+q[direct[i],2]]<>' ' then
          begin
           inc(pos[i,1],q[direct[i],1]); inc(pos[i,2],q[direct[i],2]);
          end
         else
          begin
           for m:=1 to 4 do
             if ((m+direct[i]<>3) or ((drop[i]) and (p=j-1))) and (map[pos[i,1]+q[m,1],pos[i,2]+q[m,2]]<>' ') then
              begin
               direct[i]:=m; inc(pos[i,1],q[direct[i],1]); inc(pos[i,2],q[direct[i],2]); break;
              end;
          end;
        until p=0;
       if (map[pos[i,1],pos[i,2]] in ['0'..'9','A'..'F']) and (ord(map[pos[i,1],pos[i,2]])-48>get[i]) then
        begin
         if (get[i]<9) and (map[pos[i,1],pos[i,2]] in ['9','A'..'F']) then inc(bonus[i],time);
         if map[pos[i,1],pos[i,2]] in ['0'..'9'] then get[i]:=ord(map[pos[i,1],pos[i,2]])-48
         else begin finish[i]:=true; get[i]:=ord(map[pos[i,1],pos[i,2]])-54; end;
        end;
       if map[pos[i,1],pos[i,2]] in ['a'..'e'] then inc(bonus[i],ord(map[pos[i,1],pos[i,2]])-96);
      end;
     fillchar(drop,sizeof(drop),false);
     for i:=1 to 9 do
       while map[pos[i,1]+1,pos[i,2]]<>' ' do begin inc(pos[i,1]); drop[i]:=true; end;
     for i:=1 to 9 do
       if (map[pos[i,1],pos[i,2]] in ['0'..'9','A'..'F']) and (ord(map[pos[i,1],pos[i,2]])-48>get[i]) then
        begin
         if (get[i]<9) and (map[pos[i,1],pos[i,2]] in ['9','A'..'F']) then inc(bonus[i],time);
         if map[pos[i,1],pos[i,2]] in ['0'..'9'] then get[i]:=ord(map[pos[i,1],pos[i,2]])-48
         else begin finish[i]:=true; get[i]:=ord(map[pos[i,1],pos[i,2]])-54; end;
        end;
       if map[pos[i,1],pos[i,2]] in ['a'..'e'] then inc(bonus[i],ord(map[pos[i,1],pos[i,2]])-96);
     print;
    until time=0;
   writeln('Time''s Out');
   if r<n then writeln('Enter to Go to Next Round') else writeln('Game Over');
   readln;
   for i:=1 to 9 do score[i]:=score[i]+get[i]+bonus[i];
  end;
end.
