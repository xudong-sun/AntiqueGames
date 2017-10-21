uses
 crt;
type
 arr=array[0..20] of integer;
const
 mode:array[1..5] of string=('1-9','1-K','1-M','1-S','自定义');
var
 player:array[1..5,1..4] of integer;
 score:array[1..5] of integer;
 card:arr;
 tempb:array[1..4] of boolean;
 tempa:array[0..80] of boolean;
 c:array[1..4] of integer;
 total:integer;
 i,k,c2,c3,c4,c5,dd,uu,high:integer;
 gameover:boolean;
 key:char;
 f:text;

procedure initscreen;
begin
 clrscr; textattr:=7;
end;

function nc(i:integer):char;
begin
  case i of
   0..9: exit(chr(i+48));
   10: exit('T');
   11: exit('J');
   12: exit('Q');
   13: exit('K');
   14: exit('L');
   15: exit('M');
   20: exit('S');
  end;
end;

function cn(c:char):integer;
begin
  case c of
   '0'..'9': exit(ord(c)-48);
   'T': exit(10);
   'J': exit(11);
   'Q': exit(12);
   'K': exit(13);
   'L': exit(14);
   'M': exit(15);
   'S': exit(20);
  end;
end;

procedure highscore;
var
 a:array[1..4,1..3] of integer;
 i,j:integer;
 key:char;
begin
 initscreen;
 assign(f,'e:\game\card arranging\highscore.dll'); reset(f);
 for i:=1 to 4 do
 for j:=1 to 3 do read(f,a[i,j]);
 close(f);
 writeln('高分榜：');
 writeln('     3人组  4人组  5人组');
 for i:=1 to 4 do
  begin
   write(mode[i]); write(a[i,1]:5);
   for j:=2 to 3 do write(a[i,j]:7);
   writeln;
  end;
  repeat
   while not keypressed do continue; key:=upcase(readkey);
   if key='C' then
    begin
     writeln('清空高分榜？ Y/N');
     repeat while not keypressed do continue; key:=upcase(readkey); until key in['Y','N'];
     if key='Y' then
      begin
       assign(f,'e:\game\card arranging\highscore.dll'); rewrite(f);
       for i:=1 to 12 do writeln(f,0); close(f); high:=0;
       writeln('清空成功！');
       while not keypressed do continue; key:=readkey;
      end;
     highscore; break;
    end;
  until key=#27;
end;

procedure mainmenu(j:integer; var c2,c3,c4,c5:integer);
var
 key:char;
begin
 initscreen;
 if j=1 then textattr:=13 else textattr:=7; writeln('开始游戏');
 if j=2 then textattr:=13 else textattr:=7; writeln('游戏模式：',mode[c2]);
 if j=3 then textattr:=13 else textattr:=7; writeln('游戏人数：',c3);
 if j=4 then textattr:=13 else textattr:=7; writeln('玩家人数：',c4);
 if j=5 then textattr:=13 else textattr:=7; writeln('零的张数：',c5);
 if j=6 then textattr:=13 else textattr:=7; writeln('高 分 榜');
 if j=7 then textattr:=13 else textattr:=7; writeln('退出游戏');
 while not keypressed do continue;
 key:=readkey;
  case key of
   #72: if j>1 then dec(j);
   #80: if j<7 then inc(j);
   #75: case j of
         2: if c2>1 then dec(c2);
         3: if c3>3 then dec(c3);
         4: if c4>1 then dec(c4);
         5: if c5>0 then dec(c5);
        end;
   #77: case j of
         2: if c2<5 then inc(c2);
         3: if c3<5 then inc(c3);
         4: if c4<c3 then inc(c4);
         5: if c5<10 then inc(c5);
        end;
   #13,#28,#32: case j of
                 1: exit;
                 6: highscore;
                 7: halt;
                end;
  end;
 mainmenu(j,c2,c3,c4,c5);
end;

procedure initgame;
var
 f:text;
 i:integer;
begin
 assign(f,'e:\game\card arranging\default.dll'); reset(f);
 for i:=1 to 3*c2+c3-6 do readln(f);
 for i:=1 to 20 do read(f,card[i]); read(f,total,dd,uu); close(f);
 card[0]:=c5; inc(total,c5);
end;

procedure randominit(j,l:integer; var C1,C2,C3,c11,c12,c31,c32,c41,c42,c51,c52:integer; var c21:arr);
const
 cardnum:array[1..2] of string=('设定','随机');
var
 i:integer;
 key:char;
 ch1,ch2:char;
begin
 initscreen;
 writeln('自定义'); writeln;
 if j=1 then textattr:=13 else textattr:=7; writeln('完成设定');
 if (j=2) and (l=0) then textattr:=13 else textattr:=7; write('牌的张数：',cardnum[c2]);
 if (j=2) and (c2=2) then write('  ') else writeln;
 if (j=2) and (c2=1) then
  begin
   total:=0;
   for i:=1 to 20 do inc(total,c21[i]);
   for i:=1 to 15 do begin if l=i then textattr:=13 else textattr:=7; write(nc(i):4); end;
   if l=16 then textattr:=13 else textattr:=7; write('S':4); writeln('  TOTAL');
   for i:=1 to 15 do begin if l=i then textattr:=13 else textattr:=7; write(c21[i]:4); end;
   if l=16 then textattr:=13 else textattr:=7; write(c21[20]:4); writeln('   ',total);
  end;
 if (j=2) and (c2=2) then
  begin
   if l>0 then textattr:=13 else textattr:=7; write('牌的总数：',cardnum[c1]); if c1=1 then writeln(c11,c12) else writeln;
  end;
 if j=3 then textattr:=13 else textattr:=7; write('零的张数：',cardnum[c3]); if c3=1 then writeln(c31,c32) else writeln;
 if j=4 then textattr:=13 else textattr:=7; writeln('目标下限：',c41,c42);
 if j=5 then textattr:=13 else textattr:=7; writeln('目标上限：',c51,c52);
 while not keypressed do continue; key:=readkey;
  case key of
   #72: begin
         if (j=2) and (c2=1) and (l>0) then inc(c21[l])
         else if (j=2) and (c2=2) and (l>0) then
          begin
           if c1=1 then
            begin
             if (c11<9) or (c12<9) then inc(c12);
             if c12=10 then begin inc(c11); c12:=0; end;
             l:=1;
            end;
          end
         else if j>1 then begin dec(j); if j=2 then l:=0 else l:=1; end;
        end;
   #80: begin
         if (j=2) and (c2=1) and (l>0) then begin if c21[l]>0 then dec(c21[l]) end
         else if (j=2) and (c2=2) and (l>0) then
          begin
           if c1=1 then
            begin
             if (c11>0) or (c12>0) then dec(c12);
             if c12=-1 then begin dec(c11); c12:=9; end;
             l:=1;
            end;
          end
         else if j<5 then begin inc(j); if j=2 then l:=0 else l:=1; end;
        end;
   #75: case j of
         2: if (c2=1) and (l>0) then begin if l>1 then dec(l); end
            else if l=0 then c2:=1
            else if (c2=2) and (l=1) then c1:=1;
         3: c3:=1;
         4: begin if (c41>0) or (c42>0) then dec(c42); if c42=-1 then begin dec(c41); c42:=9; end; l:=1; end;
         5: begin if (c51>0) or (c52>0) then dec(c52); if c52=-1 then begin dec(c51); c52:=9; end; l:=1; end;
        end;
   #77: case j of
         2: if (c2=1) and (l>0) then begin if l<16 then inc(l); end
            else if l=0 then c2:=2
            else if (c2=2) and (l=1) then c1:=2;
         3: c3:=2;
         4: begin if (c41<9) or (c42<9) then inc(c42); if c42=10 then begin inc(c41); c42:=0; end; l:=1; end;
         5: begin if (c51<9) or (c52<9) then inc(c52); if c52=10 then begin inc(c51); c52:=0; end; l:=1; end;
        end;
   #13,#28,#32: case j of
                 1: exit;
                 2: if l=0 then l:=1;
                end;
   #27: if (j=2) and (l>0) then l:=0;
   '0'..'9': case j of
              2: if (c2=1) and (l>0) then begin if l=16 then c21[20]:=ord(key)-48 else c21[l]:=ord(key)-48; end
                 else if (c2=2) and (l>0) and (c1=1) then begin if l=1 then begin c11:=ord(key)-48; l:=2; end else begin c12:=ord(key)-48; l:=1; end; end;
              3: if l=1 then begin c31:=ord(key)-48; l:=2; end else begin c32:=ord(key)-48; l:=1; end;
              4: if l=1 then begin c41:=ord(key)-48; l:=2; end else begin c42:=ord(key)-48; l:=1; end;
              5: if l=1 then begin c51:=ord(key)-48; l:=2; end else begin c52:=ord(key)-48; l:=1; end;
             end;
  end;
 randominit(j,l,c1,c2,c3,c11,c12,c31,c32,c41,c42,c51,c52,c21);
end;

procedure randominitmain;
var
 f:text;
 i,j,c1,c2,c3,c11,c12,c31,c32,c41,c42,c51,c52:integer;
 c21:arr;
begin
 assign(f,'e:\game\card arranging\randominit.ini'); reset(f);
 read(f,c1,c2,c3,c11,c12,c31,c32,c41,c42,c51,c52);
 for i:=1 to 15 do read(f,c21[i]); read(f,c21[20]); close(f);
 randominit(1,0,c1,c2,c3,c11,c12,c31,c32,c41,c42,c51,c52,c21);
 assign(f,'e:\game\card arranging\randominit.ini'); rewrite(f);
 write(f,' ',c1,' ',c2,' ',c3,' ',c11,' ',c12,' ',c31,' ',c32,' ',c41,' ',c42,' ',c51,' ',c52,' ');
 for i:=1 to 15 do write(f,c21[i],' '); write(f,c21[20]); close(f);
 dd:=c41*10+c42; uu:=c51*10+c52;
 total:=0;
 if (c2=2) and (c1=2) then total:=random(40)+60
 else if c2=1 then for i:=1 to 20 do inc(total,c21[i])
 else if (c2=2) and (c1=1) then total:=c11*10+c12;
 if c3=1 then card[0]:=c31*10+c32 else card[0]:=random(total div 10);
 inc(total,card[0]);
 if c2=1 then
   for i:=1 to 20 do card[i]:=c21[i]
 else
   for i:=1 to total do
    begin
     j:=random(16); if j=0 then j:=20;
     inc(card[j]);
    end;
end;

function getcard:integer;
var
 j,k:integer;
begin
 if total=0 then begin gameover:=true; exit(0); end;
 k:=random(total)+1;
 j:=0;
 while card[j]<k do begin dec(k,card[j]); inc(j); end;
 dec(card[j]); dec(total); exit(j);
end;

procedure initcard;
var
 i,j,k:integer;
begin
 for i:=1 to c3 do
 for j:=1 to 4 do
   player[i,j]:=getcard;
end;

procedure inithigh;
var
 f:text;
 i:integer;
begin
 assign(f,'e:\game\card arranging\highscore.dll'); reset(f);
 for i:=1 to 3*c2+c3-6 do readln(f); read(f,high); close(f);
end;

procedure showhighscore;
var
 key:char;
begin
 writeln;
 writeln('当前模式最高得分：',high);
 writeln('任意键返回');
 while not keypressed do continue; key:=readkey;
end;

function ok(k:integer; c:char):boolean;
var
 i:integer;
begin
 for i:=1 to 4 do if (tempb[i]=false) and (player[k,i]=cn(c)) then exit(true);
 exit(false);
end;

procedure setb(k,z:integer);
var
 i:integer;
begin
 for i:=1 to 4 do if (player[k,i]=z) and (tempb[i]=false) then begin tempb[i]:=true; exit; end;
end;

procedure unset(k,z:integer);
var
 i:integer;
begin
 for i:=1 to 4 do if (player[k,i]=z) and (tempb[i]=true) then begin tempb[i]:=false; exit; end;
end;

procedure pinput(k,z,j:integer);
var
 i,x:integer;
 key:char;
begin
 initscreen; x:=0;
 write('当前比分：',score[1]);
 for i:=2 to c3 do write(' : ',score[i]); writeln('  剩余牌数：',total);
 writeln('玩家',k,'：玩家  目标和：',z);
 writeln;
 write('你手中的牌：');
 for i:=1 to 4 do write(nc(player[k,i])); writeln;
 write('你的选择：');
 for i:=1 to j-1 do begin write(nc(c[i])); x:=x+c[i]; end;
 writeln('TOTAL:':12-j,x);
 while not keypressed do continue; key:=upcase(readkey);
 if key=#27 then begin fillchar(tempb,sizeof(tempb),false); pinput(k,z,1); end
 else if key in[#13,#28,#32] then begin if (x<>z) and (x<>0) then pinput(k,z,j); end
 else if (key in['0'..'9','T','J','Q','K','L','M','S']) and (j<=4) and ok(k,key) then begin c[j]:=cn(key); setb(k,c[j]); pinput(k,z,j+1); end
 else if (key=#8) and (j>1) then begin unset(k,c[j-1]); pinput(k,z,j-1); end
 else if (key=#9) and (c2<5) then begin showhighscore; pinput(k,z,j); end
 else pinput(k,z,j);
end;

procedure pinputmain(k,z:integer);
var
 i:integer;
 b:boolean;
begin
 pinput(k,z,1); b:=false;
 for i:=1 to 4 do if tempb[i]=true then begin b:=true; player[k,i]:=getcard; end;
 if b then inc(score[k]);
end;

function testok(k,z:integer):boolean;
var
 i,j:integer;
 a:array[1..3] of integer;
begin
 if z=0 then exit(true);
 j:=0;
 for i:=1 to 4 do if tempb[i]=false then begin inc(j); a[j]:=player[k,i]; end;
 if j<=1 then exit(true);
 if j=2 then
  begin
   if (a[1]=z) or (a[2]=z) or (a[1]+a[2]=z) then exit(true) else exit(false);
  end;
 if j=3 then
  begin
   if (a[1]=z) or (a[2]=z) or (a[3]=z) or (a[1]+a[2]=z) or (a[1]+a[3]=z) or (a[2]+a[3]=z) or (a[1]+a[2]+a[3]=z) then exit(true) else exit(false);
  end;
end;

procedure cinputmain(k,z:integer);
var
 i,j,l:integer;
 b:array[0..20] of integer;
begin
 delay(500); write('玩家',k,'：电脑  ');
 fillchar(tempa,sizeof(tempa),false); tempa[0]:=true;
 for i:=1 to 4 do
 for j:=80 downto 0 do
   if tempa[j] then tempa[j+player[k,i]]:=true;
 if tempa[z] then
  begin
   fillchar(b,sizeof(b),0);
   for i:=1 to 4 do inc(b[player[k,i]]);
   for i:=1 to b[0] do setb(k,0);
   for j:=4 downto 1 do
   for i:=20 downto 1 do if b[i]=j then
    begin
     if (z>=i) and tempa[z-i] then
      begin
       setb(k,i);
       if testok(k,z-i) then begin dec(z,i); dec(b[i]); end else unset(k,i);
      end;
    end;
   inc(score[k]);
   for i:=1 to 4 do if tempb[i] then
    begin
     write(nc(player[k,i]));
     player[k,i]:=getcard;
    end;
   writeln;
  end
 else writeln('PASS');
end;

procedure resethighscore;
var
 a:array[1..4,1..3] of integer;
 i,j:integer;
 key:char;
begin
 j:=0;
 for i:=1 to c3 do if score[i]>j then j:=score[i];
 if j>high then
  begin
   writeln('NEW HIGHSCORE: ',j); high:=j;
   assign(f,'e:\game\card arranging\highscore.dll'); reset(f);
   for i:=1 to 4 do
   for j:=1 to 3 do read(f,a[i,j]);
   close(f); a[c2,c3-2]:=high;
   assign(f,'e:\game\card arranging\highscore.dll'); rewrite(f);
   for i:=1 to 4 do
   for j:=1 to 3 do writeln(f,a[i,j]);
   close(f);
  end;
end;

begin
 randomize; cursoroff;
repeat
 gameover:=false;
 fillchar(player,sizeof(player),0); fillchar(card,sizeof(card),0); fillchar(score,sizeof(score),0);
 assign(f,'e:\game\card arranging\default.ini'); reset(f);
 read(f,c2,c3,c4,c5); close(f);
 mainmenu(1,c2,c3,c4,c5);
 assign(f,'e:\game\card arranging\default.ini'); rewrite(f);
 writeln(f,c2,' ',c3,' ',c4,' ',c5); close(f);
 if c2=5 then randominitmain else initgame;
 initcard; inithigh;
  repeat
   k:=random(uu-dd+1)+dd;
   for i:=1 to c3 do
    begin
     fillchar(tempb,sizeof(tempb),false);
     if i<=c4 then pinputmain(i,k) else cinputmain(i,k);
    end;
   while not keypressed do continue; key:=readkey;
  until gameover;
 writeln('游戏结束');
 write('总比分：',score[1]);
 for i:=2 to c3 do write(' : ',score[i]);
 writeln;
 if c2<>5 then resethighscore;
 while not keypressed do continue; key:=readkey;
until false;
end.
