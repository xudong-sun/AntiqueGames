uses crt;
type
 recl=record
       all,green,now,pos:integer;
      end;
 recs=record
       nam:string;
       pos,geton,getoff,people:integer;
      end;
 recb=record
       pos,speed,acce,dece,dela:real;
       topspeed:array[1..3] of real;
       pall,pnow,poff,time,nextstop,style,stop:integer;
       off:array[1..100] of integer;
       skipstop:boolean;
      end;
 recr=record
       len,stop,fre,ltime,atime:integer;
       terminal:string;
      end;
const
 st='123456789>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>';
 menu3:array[1..2] of string=('全真路线','模拟路线');
 menu4:array[1..4] of string=('简单','中等','困难','随机');
 maxcar=15;
 carlevel:array[1..4,1..2] of integer=((1,9),(5,13),(8,15),(1,maxcar));
 acce:array[1..maxcar] of real=(0.3,0.2,0.3,0.8,0.5,1.0,1.5,0.8,0.7,0.6,1.2,0.5,1.3,3.0,2.0);
 dece:array[1..maxcar] of real=(0.5,1.5,0.9,1.0,0.6,1.0,2.0,0.8,0.7,0.8,1.5,1.0,1.3,1.0,1.0);
 sp1: array[1..maxcar] of real=(2.5,5.0,4.0,2.5,3.0,2.8,2.2,3.0,3.5,3.7,4.0,4.8,5.0,4.0,5.0);
 dela:array[1..maxcar] of real=(0.3,0.5,1.8,1.3,0.2,1.5,0.4,0.2,0.8,1.0,2.0,0.6,1.5,0.5,0.7);
var
 map:array[-15..5000] of integer;
 light:array[0..1000] of recl;
 stop:array[0..100] of recs;
 bus:array[0..100] of recb;
 route:array[1..10] of recr;
 menuch:array[2..4] of integer;
 i,j,k,fre,score,long,m,n,pon1,pon2,time,nextstop,ltime,tscore,skipcount,nnotice,mapn:integer;
 safedis,cona,cond:real;
 ch,mapp:char;
 ok,atstop,pause,fastforward:boolean;
 notice:array[-4..100] of string;
 f:text;
procedure readmapinfo(j:integer);
var
 i:integer;
begin
 assign(f,'e:\game\bus-driving\mapinfo'+chr(j+48)+'.dll'); reset(f);
 readln(f,mapn);
 for i:=1 to mapn do
  begin
   readln(f,route[i].len,route[i].stop,route[i].fre,route[i].ltime,route[i].atime);
   readln(f,route[i].terminal);
  end;
 close(f);
end;
procedure control;
begin
 clrscr; cursoron;
 write('加速：'); readln(cona);
 write('减速：'); readln(cond);
 cursoroff;
end;
procedure initmenu;
begin
 assign(f,'e:\game\bus-driving\default.ini'); reset(f);
 for i:=2 to 4 do readln(f,menuch[i]);
 readln(f,cona,cond); close(f);
 readmapinfo(menuch[3]);
end;
procedure menu(j:integer);
var
 i:integer;
 ch:char;
begin
 textattr:=7; clrscr;
 for i:=1 to 7 do
  begin
   if i=j then textattr:=13;
    case i of
     1: writeln('开  始');
     2: writeln('路  线：',menuch[2]);
     3: writeln('模  式：',menu3[menuch[3]]);
     4: writeln('难  度：',menu4[menuch[4]]);
     5: writeln('操  作：',cona:0:1,' ; ',cond:0:1);
     6: writeln('高  分');
     7: writeln('退  出');
    end;
   if i=j then textattr:=7;
  end;
 writeln; textattr:=4;
 writeln('路线详情：'); textattr:=7;
 writeln('路线全长：',route[menuch[2]].len);
 writeln('总 站 数：',route[menuch[2]].stop);
 writeln('终 点 站：',route[menuch[2]].terminal);
 writeln('发车间隔：',route[menuch[2]].fre);
 writeln('限定时间：',route[menuch[2]].ltime);
 writeln('平均时间：',route[menuch[2]].atime);
 while not keypressed do continue;
 ch:=#0; ch:=readkey;
  case ch of
   #72: if j>1 then dec(j);
   #80: if j<7 then inc(j);
   #75:  case j of
          2: if menuch[2]>1 then dec(menuch[2]);
          3: begin menuch[3]:=3-menuch[3]; readmapinfo(menuch[3]); end;
          4: if menuch[4]>1 then dec(menuch[4]);
         end;
   #77:  case j of
          2: if menuch[2]<mapn then inc(menuch[2]);
          3: begin menuch[3]:=3-menuch[3]; readmapinfo(menuch[3]); end;
          4: if menuch[4]<4 then inc(menuch[4]);
         end;
   #13,#28:case j of
          1: begin
              if menuch[3]=1 then mapp:=chr(menuch[2]+48) else mapp:=chr(menuch[2]+96);
              assign(f,'e:\game\bus-driving\default.ini'); rewrite(f);
              for i:=2 to 4 do writeln(f,menuch[i]);
              writeln(f,cona:0:1,' ',cond:0:1); close(f);
              exit;
             end;
          5: control;
          7: halt;
         end;
  end;
 menu(j);
end;
procedure initgame;
begin
 assign(f,'e:\game\bus-driving\map\'+mapp+'.txt'); reset(f);
 readln(f,long,m,n); readln(f,fre,pon1,pon2,ltime,tscore);
 for i:=1 to m do
  begin
   read(f,light[i].pos,light[i].all);
   dec(light[i].pos);
   if light[i].all<>0 then begin read(f,light[i].green); light[i].now:=random(light[i].all-1)+1; end;
   map[light[i].pos]:=i;
  end;
 readln(f);
 for i:=1 to n do
  begin
   readln(f,stop[i].nam);
   readln(f,stop[i].pos,stop[i].geton,stop[i].getoff);
   map[stop[i].pos]:=1000+i;
   stop[i].people:=0;
  end;
 close(f);
 assign(f,'e:\game\bus-driving\journal.txt'); rewrite(f); close(f);
 pause:=false; fastforward:=false; nnotice:=0;
end;
procedure whoff(x,y,r:integer);
var
 i,j,p:integer;
 c:array[0..100] of integer;
begin
 fillchar(c,sizeof(c),0);
 for i:=y+1 to n do c[i]:=c[i-1]+stop[i].getoff;
 for j:=1 to r do
  begin
   p:=random(c[n])+1;
   for i:=n downto y+1 do if p>c[i-1] then begin inc(bus[x].off[i]); break; end;
  end;
end;
procedure initbus(x,y:integer);
var
 j:integer;
begin
 for i:=x to y do
  begin
   j:=random(carlevel[menuch[4],2]-carlevel[menuch[4],1]+1)+carlevel[menuch[4],1];
   bus[i].style:=j;
   bus[i].pos:=0; bus[i].speed:=0; bus[i].acce:=acce[j]; bus[i].dece:=dece[j]; bus[i].topspeed[1]:=sp1[j]; bus[i].dela:=0;
   bus[i].pall:=random(pon2-pon1+1)+pon1; bus[i].pnow:=0; bus[i].poff:=0; bus[i].time:=0; bus[i].skipstop:=false;
   fillchar(bus[i].off,sizeof(bus[i].off),0); whoff(i,0,bus[i].pall); bus[i].stop:=1;
  end;
end;
function oklight(x:integer):boolean;
var
 y:integer;
begin
 y:=map[trunc(bus[x].pos)];
 if (y>0) and (y<1000) and (light[y].now>light[y].green) then
  begin
   oklight:=false; bus[x].speed:=0; exit;
  end;
 oklight:=true;
end;
procedure prelight;
var
 x:integer;
begin
 for x:=1 to m do if light[x].all<>0 then
  begin
   inc(light[x].now); if light[x].now>light[x].all then light[x].now:=1;
  end;
end;
procedure nextlight;
var
 x:integer;
begin
 for x:=1 to m do if light[x].all<>0 then
  begin
   dec(light[x].now); if light[x].now=0 then light[x].now:=light[x].all;
  end;
end;
procedure calsafedis(p:real; x:integer);
begin
 if p<0 then exit;
 safedis:=safedis+p;
 calsafedis(p-bus[x].dece,x);
end;
procedure okbus(x:integer; p,spe:real);
var
 sp:real;
 i,y:integer;
 b:boolean;
begin
 if p>bus[x].pos+safedis then begin ok:=true; exit; end;
 if not odd(time) then nextlight; inc(time);
 sp:=spe+bus[x].acce;
 if sp>bus[x].topspeed[1] then sp:=bus[x].topspeed[1];
  repeat
   b:=true;
   for i:=trunc(p)+1 to trunc(p+sp) do
   if (i<>trunc(p+sp)) or (sp>bus[x].dece) then
    begin
     y:=map[i];
     if (y>0) and (y<1000) and (light[y].now>light[y].green) then
      begin
       b:=false; break;
      end;
     if (y>1000) and ((y=1000+n) or (bus[x].skipstop=false)) then begin b:=false; break; end;
    end;
   if b then okbus(x,p+sp,sp);
   sp:=sp-0.1;
  until (sp<0) or (sp<spe-bus[x].dece) or ok;
 dec(time); if not odd(time) then prelight;
end;
procedure gobus(x:integer);
var
 b:boolean; y:integer;
begin
 bus[x].speed:=bus[x].speed+bus[x].acce;
 if bus[x].speed>bus[x].topspeed[1] then bus[x].speed:=bus[x].topspeed[1];
  repeat
   b:=true;
   for i:=trunc(bus[x].pos)+1 to trunc(bus[x].pos+bus[x].speed) do
   if (i<>trunc(bus[x].pos+bus[x].speed)) or (bus[x].speed>bus[x].dece) then
    begin
     y:=map[i];
     if (y>0) and (y<1000) and (light[y].now>light[y].green) then
      begin
       b:=false; break;
      end;
     if (y>1000) and ((y=1000+n) or (bus[x].skipstop=false)) then begin b:=false; break; end;
    end;
   ok:=false;
   if b then begin safedis:=0; calsafedis(bus[x].speed,x); okbus(x,bus[x].speed,bus[x].acce); end;
   if ok then break;
   bus[x].speed:=bus[x].speed-0.1;
  until bus[x].speed<0;
 ok:=true;
 for i:=trunc(bus[x].pos)+1 to trunc(bus[x].pos+bus[x].speed) do
  begin
   y:=map[i];
   if (y>0) and (y<1000) and (light[y].now>light[y].green) then begin ok:=false; break; end;
   if (y>1000) and ((y=1000+n) or (bus[x].skipstop=false)) then begin ok:=false; break; end;
   if y>1000 then bus[x].skipstop:=false;
  end;
 if ok then bus[x].pos:=bus[x].pos+bus[x].speed else begin bus[x].pos:=i; bus[x].speed:=0; end;
 y:=map[trunc(bus[x].pos)];
 if (y>1000) and (y-1000=bus[x].stop) then begin bus[x].dela:=dela[bus[x].style]+1; bus[x].speed:=0; end;
 if (stop[bus[x].nextstop].pos-trunc(bus[x].pos) in [1..5]) and (bus[x].nextstop<>n) and (stop[bus[x].nextstop].people=0) and (bus[x].off[bus[x].nextstop]=0) then bus[x].skipstop:=true;
end;
procedure nexttime;
var
 y,i,j:integer;
begin
 nextlight;
 for i:=1 to n do
  begin
   y:=random(500)+1;
   if y<=stop[i].geton then inc(stop[i].people);
  end;
 for i:=1 to 20 do
  begin
   if bus[i].pnow>0 then dec(bus[i].pnow,3);
   if bus[i].pnow<0 then bus[i].pnow:=0;
   if bus[i].poff>0 then dec(bus[i].poff,3);
   if bus[i].poff<0 then bus[i].poff:=0;
  end;
 dec(skipcount); if skipcount=0 then bus[11].skipstop:=false;
end;
procedure ddelay(i:integer);
var
 y:integer;
begin
 if bus[i].dela>=1 then
  begin
   bus[i].dela:=bus[i].dela-1;
   if bus[i].dela<1 then
    begin
     y:=map[trunc(bus[i].pos)];
     bus[i].pall:=bus[i].pall+stop[y-1000].people;
     bus[i].pnow:=stop[y-1000].people;
     whoff(i,y-1000,stop[y-1000].people);
     stop[y-1000].people:=0;
     bus[i].poff:=bus[i].off[bus[i].nextstop];
     bus[i].off[bus[i].nextstop]:=0;
     if not odd(time) then begin inc(bus[i].pnow,3); inc(bus[i].poff,3); end;
     inc(bus[i].stop);
     if bus[i].pos>=long then bus[i].time:=time;
    end;
  end;
end;
procedure getnextstop;
var
 i,j:integer;
begin
 for i:=1 to 20 do
  begin
   for j:=1 to n do if stop[j].pos>=trunc(bus[i].pos) then break;
   bus[i].nextstop:=j;
   if bus[i].stop<j then bus[i].stop:=j;
  end;
end;
function findbus(x:integer):integer;
var
 i,j:integer;
begin
 j:=0;
 for i:=1 to 20 do if trunc(bus[i].pos)=x then inc(j);
 exit(j);
end;
procedure print;
var
 i,y,j:integer;
begin
 clrscr; textattr:=7;
 write('速度:',bus[11].speed:0:1); write('   ');
 if atstop then writeln(stop[nextstop-1].nam,' 到了') else writeln('下一站:',stop[nextstop].nam);
 write('时间:',time div 2,'   ');
 if atstop then writeln(bus[11].pnow,'人上车 ',bus[11].poff,'人下车')
 else if bus[11].skipstop=true then writeln('可以跳站')
 else writeln(stop[nextstop].people,'人上车');
 writeln;
 for i:=trunc(bus[11].pos)-10 to trunc(bus[11].pos)+15 do
  begin
   j:=findbus(i);
   if i=trunc(bus[11].pos) then begin textattr:=11; write('*'); end
   else if map[i]>1000 then
    begin
     textattr:=13;
     if j=0 then write('@') else if j=1 then write('*') else write(st[j]);
    end
   else if (map[i-1]>0) and (map[i-1]<=1000) then
    begin
     if light[map[i-1]].all=0 then begin textattr:=10; write('>'); end
     else
      begin
       y:=light[map[i-1]].now;
       if y<=light[map[i-1]].green then begin textattr:=10; write(st[y]); end
       else begin textattr:=12; write(st[y-light[map[i-1]].green]); end;
      end;
    end
   else if j>0 then begin textattr:=9; if j=1 then write('*') else write(st[j]); end
   else begin textattr:=7; write('-'); end;
  end;
 writeln;
 textattr:=7;
 for i:=nnotice downto nnotice-4 do writeln(notice[i]);
end;
procedure newnotice(s:string);
begin
 inc(nnotice); notice[nnotice]:=s;
end;
procedure printjournal;
var
 i:integer;
begin
 assign(f,'e:\game\bus-driving\journal.txt'); rewrite(f);
 for i:=1 to nnotice do writeln(f,notice[i]);
 close(f);
end;
procedure initscreen;
var
 s:string;
begin
 str(bus[11].pall,s);
 newnotice('起点站'+s+'人上车'); print;
 delay(1000); newnotice('3秒'); print;
 delay(1000); newnotice('2秒'); print;
 delay(1000); newnotice('1秒'); print;
 delay(1000); newnotice('出发!'); print;
end;
procedure key;
var
 ch:char;
 i:integer;
 s:string;
begin
 str(time div 2,s);
 for i:=1 to 5 do
  begin
   ch:=#0; delay(100);
   while keypressed do ch:=readkey;
    case ch of
     #75: begin bus[11].speed:=bus[11].speed-bus[11].dece; if bus[11].speed<0 then bus[11].speed:=0; end;
     #77: begin bus[11].speed:=bus[11].speed+bus[11].acce; if bus[11].speed>5 then bus[11].speed:=5; end;
     'z': begin
           newnotice(s+'秒：'+stop[nextstop].nam+' 到了');
           bus[11].skipstop:=false;
           if map[trunc(bus[11].pos)]<=1000 then begin newnotice(s+'秒：未靠站停车！ -30分'); dec(score,30); end;
           if nextstop=n then begin newnotice('游戏结束'); bus[11].time:=time; end;
           bus[11].pnow:=stop[nextstop].people;
           inc(bus[11].pall,bus[11].pnow);
           whoff(11,nextstop,bus[11].pnow);
           stop[nextstop].people:=0;
           bus[11].poff:=bus[11].off[nextstop];
           atstop:=true; inc(nextstop);
           if not odd(time) then begin inc(bus[11].pnow,3); inc(bus[11].poff,3); end;
          end;
     'x': begin
           if (bus[11].pnow>0) or (bus[11].poff>0) then begin newnotice(s+'秒：提前离站！-50分'); dec(score,50); end;
           atstop:=false;
          end;
     's': begin
           newnotice(s+'秒：'+stop[nextstop].nam+' 跳站');
           if bus[11].skipstop=false then begin newnotice(s+'秒：非法跳站！ -50分'); dec(score,50); end;
           if nextstop<n then inc(nextstop); bus[11].skipstop:=false;
          end;
     'c': fastforward:=not fastforward;
     #32: pause:=not pause;
     #27: halt;
    end;
  end;
end;
procedure testgo;
var
 i:integer;
 s:string;
begin
 str(time div 2,s);
 for i:=trunc(bus[11].pos)+1 to trunc(bus[11].pos+bus[11].speed) do
  begin
   if (map[i-1]>0) and (map[i-1]<1000) and (light[map[i-1]].now>light[map[i-1]].green) then
    begin
     newnotice(s+'秒：闯红灯！ -200分'); dec(score,200);
    end;
   if atstop then
    begin
     newnotice(s+'秒：启动未关门！ -20分'); dec(score,20);
    end;
  end;
end;
function finish:boolean;
var
 i:integer;
begin
 for i:=1 to 20 do if bus[i].time=0 then exit(false);
 exit(true);
end;
procedure printresult;
var
 i,j:integer;
begin
 clrscr; j:=0;
 for i:=1 to 20 do if ((i<11) and (bus[i].time+4<bus[11].time)) or ((i>11) and (bus[i].time-4<=bus[11].time)) then inc(j);
 writeln('  乘客总数  行车时间  超车统计  超时罚分  行车规范  总分');
 write(bus[11].pall*2:7);
 if bus[11].time<ltime*2 then write((ltime*2-bus[11].time) div 6:10) else write(0:10);
 write((10-j)*30:10);
 if bus[11].time>ltime*2 then write((ltime*2-bus[11].time) div 10*tscore:10) else write(0:10);
 write(score:10);
 score:=score+bus[11].pall*2+(10-j)*30;
 if bus[11].time<ltime*2 then score:=score+(ltime*2-bus[11].time) div 6 else score:=score+(ltime*2-bus[11].time) div 10*tscore;
 writeln(score:8);
 writeln;
 for i:=1 to 20 do writeln(bus[i].style,' ',bus[i].time div 2,' ',trunc(bus[i].pos));
end;
begin
 randomize; cursoroff;
 initmenu; menu(1);
 initgame; clrscr;
 writeln('游戏载入中...');
 initbus(1,20); time:=0;
  repeat
   inc(time); getnextstop;
   for k:=1 to 20 do
    begin
     if (time>=(k-1)*fre*2) and oklight(k) and (bus[k].pnow=0) and (bus[k].poff=0) and (bus[k].time=0) and (bus[k].pos<long) and (bus[k].dela<1) then gobus(k);
     ddelay(k);
    end;
   if not odd(time) then nexttime;
  until time=fre*2*20;
{ for i:=1 to 20 do writeln(bus[i].style,' ',bus[i].time,' ',(bus[i].time-fre*2*(i-1)) div 2);}
 for i:=1 to 10 do
  begin
   bus[i]:=bus[i+10];
   if bus[i].time>0 then bus[i].time:=1;
  end;
 initbus(11,20); bus[11].acce:=cona; bus[11].dece:=cond; time:=0; score:=0;
 nextstop:=1; atstop:=false; skipcount:=0; initscreen;
  repeat
   if pause=false then
    begin
     inc(time); getnextstop;
     for k:=1 to 20 do
      begin
       if k=11 then
        begin
         if (bus[11].time=0) and (fastforward=false) then
          begin
           key;
           if bus[11].speed>0 then testgo;
           bus[k].pos:=bus[k].pos+bus[k].speed;
           if (stop[nextstop].pos-trunc(bus[k].pos) in [1..5]) and (nextstop<>n) and (stop[nextstop].people=0) and (bus[k].off[nextstop]=0) then begin bus[k].skipstop:=true; skipcount:=4; end;
          end;
         if fastforward=true then
          begin
           delay(200); ch:=#0;
           while keypressed do ch:=readkey;
           if ch='c' then fastforward:=false;
          end;
        end
       else if (time>=(k-11)*fre*2) and oklight(k) and (bus[k].pnow=0) and (bus[k].poff=0) and (bus[k].time=0) and (bus[k].pos<long) and (bus[k].dela<1) then gobus(k);
       ddelay(k);
      end;
     if not odd(time) then nexttime;
     if bus[11].time=0 then print;
    end
   else
    repeat
     ch:=#0;
     while not keypressed do continue;
     ch:=readkey;
     if ch=#32 then pause:=false;
    until ch=#32;
  until finish;
 print; delay(1000); printjournal; printresult; readln;
end.
