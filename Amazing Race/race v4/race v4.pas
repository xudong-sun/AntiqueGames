uses
 crt;
const
 ls:string[30]='123456789>>>>>>>>>>>>>>>>>>>>>';
 score:array[1..13,1..11] of byte=((8,7,6,5,4,3,2,2,1,1,0),
                                   (8,7,6,5,4,3,2,1,1,0,0),
                                   (8,6,5,4,3,2,1,1,0,0,0),
                                   (10,8,6,5,4,3,2,1,0,0,0),
                                   (0,0,0,0,0,0,0,0,0,0,0),
                                   (12,9,7,5,3,2,1,0,0,0,0),
                                   (0,0,0,0,0,0,0,0,0,0,0),
                                   (12,9,6,4,2,1,0,0,0,0,0),
                                   (0,0,0,0,0,0,0,0,0,0,0),
                                   (12,8,5,3,1,0,0,0,0,0,0),
                                   (0,0,0,0,0,0,0,0,0,0,0),
                                   (0,0,0,0,0,0,0,0,0,0,0),
                                   (30,20,12,6,1,0,0,0,0,0,0));
 pl:array[1..13] of byte=(11,10,9,8,8,8,7,7,6,6,5,5,5);
var
 w:array[1..11] of integer;
 u:array[1..11] of integer;
 g:array[1..11] of byte;
 sp:array[1..11] of byte;
 sc:array[1..11] of integer;
 re:array[1..11] of byte;
 b:array[1..11] of boolean;
 c:array[1..11] of boolean;
 q:array[1..11] of byte;
 yi:array[1..11] of integer;
 a:array[-10..1015] of byte;
 de,de0:array[-10..1015] of byte;
 p:array[1..11] of integer;
 w0:array[1..10] of byte;
 l:array[1..100,1..6] of integer;
 rb:array[1..9] of integer;
 r,k,o,rr:byte;
 z,n,n1,n2,n3,t,x,y,i,j,h,sn:integer;
 rec:array[1..10] of integer;
 nam:array[1..10] of string;
 soc:array[1..5000] of integer;
 ss:array[1..5000] of integer;
 bs:array[1..5000] of boolean;
 s,sr:string;
 f:text;
procedure print;
var
 i:integer;
function op:boolean;
begin
 op:=true;
 for j:=2 to 11 do if b[j] and c[j] and (i=p[j]) then exit;
 op:=false;
end;
function os:boolean;
begin
 os:=true;
 for j:=1 to sn do if bs[j] and (i=soc[j]) then exit;
 os:=false;
end;
function ol:boolean;
begin
 ol:=true;
 for j:=1 to n do if l[j,1]=i then exit;
 ol:=false;
end;
begin
 clrscr;
 for i:=p[1]-9 to p[1]+15 do
   if i=p[1] then begin textattr:=11; write('*'); end
   else if ol then
    begin
     for j:=1 to n do if l[j,1]=i then break;
     if l[j,4]>l[j,3] then begin textattr:=12; write(ls[l[j,4]-l[j,3]]); end
     else begin textattr:=10; write(ls[l[j,4]]); end;
    end
   else if a[i]=101 then begin textattr:=14; write('?'); end
   else if a[i]=102 then begin textattr:=13; write('Y'); end
   else if a[i]=103 then begin textattr:=6; write('B'); end
   else if i=z then begin textattr:=7; write('|'); end
   else if op then begin textattr:=9; write('*'); end
   else if os then begin textattr:=1; write('+'); end
   else begin textattr:=7; write('-'); end;
 writeln;
end;
function ok:boolean;
begin
 ok:=false;
 for i:=1 to 11 do if b[i] and c[i] then exit;
 ok:=true;
end;
begin
 randomize;
 fillchar(w,sizeof(w),0); fillchar(re,sizeof(re),1); fillchar(b,sizeof(b),true);
 fillchar(yi,sizeof(yi),0); fillchar(sc,sizeof(sc),0); fillchar(g,sizeof(g),3);
 for r:=1 to 13 do
  begin
   fillchar(a,sizeof(a),0);
   fillchar(p,sizeof(p),0);
   fillchar(q,sizeof(q),3);
   fillchar(u,sizeof(u),0);
   fillchar(sp,sizeof(sp),2);
   fillchar(c,sizeof(c),true);
   o:=0;
   k:=random(7)+1;
   str(k,sr);
   s:='d:\little games\amazing race\map v4\'+sr+'.txt';
   assign(f,s); reset(f);
   for i:=1 to 10 do read(f,w0[i]);
    case r of
     1,2,3,4,5,7,9,11: for i:=1 to 11 do if b[i] then w[i]:=w0[re[i]];
    end;
   read(f,z); read(f,n); read(f,n1); read(f,n2); read(f,n3);
   for i:=1 to n do
    begin
     read(f,l[i,1],l[i,2],l[i,3],l[i,5],l[i,6]);
     a[l[i,1]]:=i;
     l[i,4]:=random(l[i,2])+1;
    end;
   for i:=1 to n1 do
    begin
     read(f,x); a[x]:=101;
    end;
   for i:=1 to n2 do
    begin
     read(f,x); a[x]:=102;
    end;
   for i:=1 to n3 do
    begin
     read(f,x); a[x]:=103;
    end;
   if n3>0 then for i:=1 to 9 do read(f,rb[i]);
   read(f,rr);
   close(f);
   s:='d:\little games\amazing race\record v4\'+sr+'.txt';
   assign(f,s); reset(f);
   for i:=1 to 10 do begin readln(f,rec[i]); readln(f,nam[i]); end;
   close(f);
   x:=maxint;
   for i:=1 to 11 do
     if b[i] and (w[i]<x) then x:=w[i];
   for i:=1 to 11 do if b[i] then w[i]:=w[i]-x;
   clrscr;
   if r=13 then writeln('Final Race') else writeln('Race No',r);
   for i:=1 to 11 do
     if b[i] then writeln(i:2,' ',w[i]);
   writeln('Track No',k);
   for i:=1 to 10 do writeln(rec[i],'  ',nam[i]);
   readln;
   for i:=1 to z do if (a[i] in [1..100]) and (l[a[i],4]>l[a[i],3]) then de[i]:=l[a[i],4]-l[a[i],3] else de[i]:=0;
   t:=-500; sn:=0;
    repeat
     inc(t);
     de0:=de;
     if t>=w[1] then begin print; if u[1]>0 then readln; end;
     for i:=1 to 11 do
       if b[i] and c[i] and (t>w[i]) and (u[i]=0) then
        begin
         if i=1 then
          begin
           textattr:=7;
           write('Enter to go');
           readln;
          end;
         k:=random(3);
         if (k=0) and (sp[i]>1) then dec(sp[i]);
         if (k=2) and (sp[i]<q[i]) then inc(sp[i]);
         k:=sp[i];
         if i=1 then begin write(k); readln; end;
          repeat
           if de0[p[i]+1]>0 then
            begin
             u[i]:=de0[p[i]+1];
             if de0[p[i]+1]>de[p[i]] then de[p[i]]:=de0[p[i]+1];
             break;
            end
           else if a[p[i]+1]=101 then
            begin
             inc(p[i]); print;
             x:=random(35);
              case x of
               0..3: begin inc(q[i]); if i=1 then begin writeln('Your speed is increased'); readln; end; end;
               4: begin dec(q[i]); if i=1 then begin writeln('Your speed is decreased'); readln; end; end;
               5..6: begin inc(yi[i],3); if i=1 then begin writeln('You get 3 rounds of yield power'); readln; end; end;
               7..8: begin inc(yi[i],5); if i=1 then begin writeln('You get 5 rounds of yield power'); readln; end; end;
               9: begin inc(yi[i],7); if i=1 then begin writeln('You get 7 rounds of yield power'); readln; end; end;
               10: begin inc(yi[i],10); if i=1 then begin writeln('You get 10 rounds of yield power'); readln; end; end;
               11,12: begin yi[i]:=0; if i=1 then begin writeln('Your yield power is lost'); readln; end; end;
               13: begin u[i]:=4; if i=1 then begin writeln('You are forced to stop for 3 rounds'); readln; end; end;
               14: begin u[i]:=6; if i=1 then begin writeln('You are forced to stop for 5 rounds'); readln; end; end;
               15: begin u[i]:=9; if i=1 then begin writeln('You are forced to stop for 8 rounds'); readln; end; end;
               16..18: begin if g[i]<9 then inc(g[i]); if i=1 then begin writeln('Your capability is increased'); readln; end; end;
               19,20: begin if g[i]>1 then dec(g[i]); if i=1 then begin writeln('Your capability is decreased'); readln; end; end;
               21,22: begin inc(p[i],5); if i=1 then begin writeln('You are forced 5 space forward'); readln; end; end;
               23,24: begin inc(p[i],10); if i=1 then begin writeln('You are forced 10 space forward'); readln; end; end;
               25: begin inc(p[i],15); if i=1 then begin writeln('You are forced 15 space forward'); readln; end; end;
               26,27: begin dec(p[i],5); if i=1 then begin writeln('You are forced 5 space backwards'); readln; end; end;
               28: begin dec(p[i],8); if i=1 then begin writeln('You are forced 8 space backwards'); readln; end; end;
               29: begin dec(p[i],12); if i=1 then begin writeln('You are forced 12 space backwards'); readln; end; end;
               30,31: begin inc(sp[i],3); if i=1 then begin writeln('Your current speed is increased by 3'); readln; end; end;
               32: begin inc(sp[i],5); if i=1 then begin writeln('Your current speed is increased by 5'); readln; end; end;
               33,34: if i=1 then begin writeln('Nothing happens'); readln; end;
              end;
             if yi[i]>30 then yi[i]:=30;
             break;
            end
           else if (a[p[i]+1]=102) and (yi[i]>0) then
            begin
             x:=0; y:=z;
             for j:=1 to 11 do
               if b[j] and c[j] and (p[j]>p[i]) and (u[j]=0) then
                begin
                 if p[j]<=y then begin x:=j; y:=p[j]; end;
                end;
             if x>0 then
              begin
               inc(p[i]);
               if i=1 then print;
               writeln('Player ',x,' is yielded for ',yi[i],' rounds'); readln;
               inc(u[x],yi[i]); if i>x then inc(u[x]); yi[i]:=0;
               break;
              end;
            end
           else if a[p[i]+1]=103 then
            begin
             inc(p[i]);
             if i=1 then
              begin
               print;
               writeln('The road block will take you ',rb[g[i]],' rounds to complete.');
               readln;
              end;
             u[i]:=rb[g[i]]+1;
             break;
            end;
           dec(k); inc(p[i]);
          until k=0;
         if p[i]>=z then
          begin
           if t-w[i]<rec[10] then
            begin
             j:=t-w[i];
             writeln(j,' rounds!');
             for k:=1 to 10 do if j<rec[k] then break;
             for x:=10 downto k+1 do begin rec[x]:=rec[x-1]; nam[x]:=nam[x-1]; end;
             rec[k]:=j;
             writeln('Player',i,' is ranked ',k,'!');
             if i=1 then begin write('Write your name here: '); readln(nam[k]); end
             else begin nam[k]:='Computer'; readln; end;
             s:='d:\little games\amazing race\record v4\'+sr+'.txt';
             assign(f,s); rewrite(f);
             for k:=1 to 10 do begin writeln(f,rec[k]); writeln(f,nam[k]); end;
             close(f);
            end;
           w[i]:=t; c[i]:=false; inc(o); re[i]:=o; inc(sc[i],score[r,o]);
           if i=1 then begin write('You are No',o); readln; end;
           if o=pl[r] then h:=i;
          end;
        end;
     for x:=z downto -10 do
     for i:=1 to 11 do
       if b[i] and (p[i]=x) and (u[i]=0) and (de0[x+1]>0) then
        begin
         u[i]:=de0[x+1];
         if de0[x+1]>de[x] then de[x]:=de0[x+1];
        end;
     x:=random(100)+1;
     if x<=rr then begin inc(sn); soc[sn]:=-10; ss[sn]:=2; bs[sn]:=true; end;
     for i:=1 to n do
       if l[i,4]>l[i,3] then
        begin
         x:=random(100)+1;
         if x<=l[i,5] then begin inc(sn); soc[sn]:=l[i,1]; ss[sn]:=2; bs[sn]:=true; end;
        end;
     for i:=1 to sn do if bs[i] then
      begin
       x:=random(3);
        case x of
         0: begin dec(ss[i]); if ss[i]=0 then ss[i]:=1; end;
         2: begin inc(ss[i]); if ss[i]=4 then ss[i]:=3; end;
        end;
       x:=ss[i];
       while (x>0) and (de[soc[i]+1]=0) do
        begin
         inc(soc[i]); dec(x);
         if (a[soc[i]] in [1..100]) and (l[a[soc[i]],4]<=l[a[soc[i]],3]) then begin x:=random(100)+1; if x<=l[a[soc[i]],6] then bs[i]:=false; break; end;
        end;
       if de[soc[i]+1]>0 then if de[soc[i]]<de[soc[i]+1] then de[soc[i]]:=de[soc[i]+1];
       if soc[i]>=z then bs[i]:=false;
      end;
     for i:=1 to n do
      begin
       dec(l[i,4]);
       if l[i,4]=0 then
        begin
         l[i,4]:=l[i,2];
         for y:=1 to z do if a[y]=i then break;
         if l[i,4]-l[i,3]+1>de[y] then de[y]:=l[i,4]-l[i,3]+1;
         for x:=y-1 downto -10 do if de[x]>0 then begin if l[i,4]-l[i,3]+1>de[x] then de[x]:=l[i,4]-l[i,3]+1; end else break;
        end;
      end;
     for i:=1 to 11 do if b[i] and (u[i]>0) then dec(u[i]);
     for i:=-10 to 1015 do if de[i]>0 then dec(de[i]);
    until o=pl[r];
   clrscr;
   for i:=1 to 11 do
     if b[i] then writeln(i:2,w[i]:4,re[i]:3,score[r,re[i]]:3,sc[i]:3);
   case r of 1,2,3,6,8,10:
    begin
     writeln('Player ',h,' has been eliminated from the race.'); b[h]:=false;
     readln;
     if h=1 then writeln('You are No ',12-r,'!');
    end else readln;
   end;
   clrscr;
   for i:=1 to 11 do
     if b[i] then writeln(i:2,' ',sc[i]);
   readln;
  end;
 y:=0; x:=0;
 for i:=1 to 11 do
   if b[i] and (sc[i]>y) then begin y:=sc[i]; x:=i; end;
 writeln('Player ',x,' is the final winner of the race!');
 readln;
end.
