uses
 crt;
const
 na=4;
 color:array[-1..na] of byte=(13,7,11,9,14,12);
 way:array[1..4,1..2] of integer=((-1,0),(0,1),(0,-1),(1,0));
var
 map:array[0..51,0..51] of byte;
 own:array[1..50,1..50] of byte;
 house:array[1..50,1..50] of byte;
 bust:array[1..na] of boolean;
 pos:array[1..na,1..2] of byte;
 turn:array[1..na] of byte;
 money:array[1..na] of longint;
 buy:array[1..26] of byte;
 improve:array[1..26] of byte;
 rent:array[1..26,0..9] of integer;
 temp:array[0..3] of byte;
 p,x,y,bustn,np:byte;
 i,j,k,add:integer;
 ch,mapn:char;
 f:text;
function cal(w,u:byte):integer;
var
 i,j:byte;
begin
 cal:=0;
 for i:=1 to x do
 for j:=1 to y do
   if (map[i,j]=w) and (own[i,j]=u) then inc(cal,rent[w,house[i,j]]);
end;
procedure newgame;
begin
 writeln('Map no:(1-4) ');
 readln(mapn);
 assign(f,'d:\little games\monopoly\map\'+mapn+'.txt'); reset(f);
 read(f,x); read(f,y); readln(f);
 for i:=1 to x do
  begin
   for j:=1 to y do
    begin
     read(f,ch);
     if ch in['A'..'Z'] then map[i,j]:=ord(ch)-64;
    end;
   readln(f);
  end;
 read(f,j);
 for i:=1 to na do money[i]:=j;
 readln(f,add);
 i:=0;
 while not eof(f) do
  begin
   inc(i);
   read(f,buy[i]); read(f,improve[i]);
   for j:=0 to 9 do read(f,rent[i,j]);
  end;
 close(f);
 for p:=1 to na do
  repeat
   pos[p,1]:=random(x)+1; pos[p,2]:=random(y)+1;
   turn[p]:=random(4)+1;
  until (map[pos[p,1],pos[p,2]]>0) and (map[pos[p,1]+way[turn[p],1],pos[p,2]+way[turn[p],2]]>0);
 for p:=1 to na do bust[p]:=false;
 write('Players No'); readln(np);
 p:=0;
end;
procedure load;
begin
 write('Load from No'); readln(mapn);
 assign(f,'d:\little games\monopoly\save\'+mapn+'.txt'); reset(f);
 readln(f,x); readln(f,y); readln(f,np); readln(f,p);
 for i:=1 to x do
 for j:=1 to y do readln(f,map[i,j]);
 for i:=1 to x do
 for j:=1 to y do readln(f,own[i,j]);
 for i:=1 to x do
 for j:=1 to y do readln(f,house[i,j]);
 readln(f,j);
 for i:=1 to j do readln(f,buy[i]);
 for i:=1 to j do readln(f,improve[i]);
 for i:=1 to j do
 for k:=0 to 9 do readln(f,rent[i,k]);
 for i:=1 to na do readln(f,money[i]);
 for i:=1 to na do readln(f,turn[i]);
 for i:=1 to na do
 for j:=1 to 2 do readln(f,pos[i,j]);
 readln(f,bustn);
 for i:=1 to na do
  begin
   readln(f,j);
   if j=0 then bust[i]:=false else bust[i]:=true;
  end;
 readln(f,add);
 close(f);
end;
procedure save;
begin
 write('Save to No'); readln(mapn);
 assign(f,'d:\little games\monopoly\save\'+mapn+'.txt'); rewrite(f);
 writeln(f,x); writeln(f,y); writeln(f,np); writeln(f,p-1);
 for i:=1 to x do
 for j:=1 to y do writeln(f,map[i,j]);
 for i:=1 to x do
 for j:=1 to y do writeln(f,own[i,j]);
 for i:=1 to x do
 for j:=1 to y do writeln(f,house[i,j]);
 j:=0;
 repeat inc(j); until buy[j]=0;
 writeln(f,j);
 for i:=1 to j do writeln(f,buy[i]);
 for i:=1 to j do writeln(f,improve[i]);
 for i:=1 to j do
 for k:=0 to 9 do writeln(f,rent[i,k]);
 for i:=1 to na do writeln(f,money[i]);
 for i:=1 to na do writeln(f,turn[i]);
 for i:=1 to na do
 for j:=1 to 2 do writeln(f,pos[i,j]);
 writeln(f,bustn);
 for i:=1 to na do if bust[i]=false then writeln(f,0) else writeln(f,1);
 writeln(f,add);
 close(f);
 writeln('Save successfully');
end;
procedure print;
var
 i,j:integer;
function pler:integer;
var
 p:byte;
begin
 for p:=1 to na do if (pos[p,1]=i) and (pos[p,2]=j) then begin pler:=p; exit; end;
 pler:=0;
end;
begin
 clrscr;
 for i:=1 to x do
  begin
   for j:=1 to y do
     if (pler>0) and (bust[pler]=false) then begin textattr:=color[-1]; write(pler); end
     else if map[i,j]=0 then write(' ')
     else if own[i,j]=0 then begin textattr:=color[0]; write('*'); end
     else begin textattr:=color[own[i,j]]; write(house[i,j]); end;
   writeln;
  end;
end;
begin
 randomize;
 writeln('1.new game');
 writeln('2.load');
 writeln('3.exit');
 while not keypressed do continue; ch:=readkey;
 if ch='1' then newgame else if ch='2' then load else if ch='3' then halt;
  repeat
   inc(p); if p=na+1 then p:=1;
   if bust[p]=false then
    begin
     textattr:=color[p];
     writeln('Player ',p,'    Money: ',money[p]);
     if p<=np then
      begin
       print;
       textattr:=color[p];
       writeln('Player ',p,'    Money: ',money[p]);
       textattr:=color[0];
       writeln('Press any key to go except ''s'' to save');
        repeat
         while not keypressed do continue;
         ch:=readkey;
         if ch='s' then save;
        until ch<>'s';
      end;
     j:=random(6)+1;
     if p<=np then begin writeln(j); readln; end;
      repeat
       fillchar(temp,sizeof(temp),0);
       for i:=1 to 4 do if (i<>5-turn[p]) and (map[pos[p,1]+way[i,1],pos[p,2]+way[i,2]]>0) then
        begin
         inc(temp[0]); temp[temp[0]]:=i;
        end;
       turn[p]:=temp[random(temp[0])+1];
       inc(pos[p,1],way[turn[p],1]); inc(pos[p,2],way[turn[p],2]);
       dec(j);
       print; delay(500);
      until j=0;
     textattr:=color[p];
     i:=map[pos[p,1],pos[p,2]];
     j:=own[pos[p,1],pos[p,2]];
     k:=house[pos[p,1],pos[p,2]];
     if j=0 then
      begin
       writeln('BUY $',buy[i]);
       dec(money[p],buy[i]); own[pos[p,1],pos[p,2]]:=p;
      end
     else if j=p then
      begin
       if k<9 then
        begin
         writeln('IMPROVE');
         dec(money[p],improve[i]); inc(house[pos[p,1],pos[p,2]]);
        end;
      end
     else
      begin
       k:=cal(i,j);
       writeln('->',j,' $',k);
       dec(money[p],k); inc(money[j],k);
      end;
     writeln('Player ',p,'    Money: ',money[p]);
     if money[p]<=0 then
      begin
       bust[p]:=true; inc(bustn);
       for i:=1 to x do
       for j:=1 to y do
         if own[i,j]=p then own[i,j]:=0;
       for i:=1 to na do if bust[i]=false then inc(money[i],add);
       writeln('Player ',p,' is busted');
      end;
     readln;
    end;
  until bustn=na-1;
 for i:=1 to na do if bust[i]=false then break;
 writeln('The final winner is player ',i);
 readln;
end.
