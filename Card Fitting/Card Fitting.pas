uses
 crt;
const
 gamemode:array[1..3] of string=('标准6配3','标准7配4','自定义');
 menusign:array[1..9] of string=('开始游戏','游戏模式','手牌张数','模式长度','模式数量','游戏人数','牌的套数','高 分 榜','退出游戏');
var
 cardrem:array[1..13] of integer;
 cardtotal:integer;
 pattern:array[1..7,1..5] of integer;
 patternnum:integer;
 card:array[1..5,1..9] of integer;
 cardnum:integer;
 patternsize:integer;
 playernum:integer;
 normalizedptn:array[1..7] of string[10];
 score:array[1..5] of integer;
 menuenabled:array[1..9] of boolean;
 select:array[1..9] of boolean;
 selectnum:integer;
 f:text;
 key:char;
 c2,c3,c4,c5,c6,c7:integer;
 tc3,tc4,tc5,tc6,tc7:integer;

procedure initscreen;
begin
 clrscr; textattr:=7;
end;

procedure showhighscore;
var
 h1,h2:integer;
 ch:char;
begin
 assign(f,'e:\game\Card Fitting\highscore.dll'); reset(f);
 readln(f,h1,h2); close(f);
  repeat
   initscreen;
   writeln('高分榜');
   writeln;
   writeln('标准6配3：',h1);
   writeln('标准7配4：',h2);
   writeln;
   while not keypressed do continue; key:=upcase(readkey);
    case key of
     'C': begin
           writeln('清空高分榜？ Y/N');
           while not keypressed do continue; ch:=upcase(readkey);
           if ch='Y' then
            begin
             assign(f,'e:\game\Card Fitting\highscore.dll'); rewrite(f);
             writeln(f,0,' ',0); close(f);
             writeln('清空成功'); h1:=0; h2:=0;
             while not keypressed do continue; ch:=readkey;
            end;
          end;
     #27: exit;
    end;
  until false;
end;

procedure printmenu(j:integer);
var
 i:integer;
begin
 initscreen;
 if (c2=1) or (c2=2) then
  begin
   for i:=3 to 7 do menuenabled[i]:=false;
  end
 else
   for i:=3 to 7 do menuenabled[i]:=true;
 for i:=1 to 9 do
  begin
   if menuenabled[i]=false then textattr:=8
   else
    begin
     if j=i then textattr:=13 else textattr:=7;
    end;
   write(menusign[i]);
    case i of
     2: writeln(': ',gamemode[c2]);
     3: writeln(': ',c3);
     4: writeln(': ',c4);
     5: writeln(': ',c5);
     6: writeln(': ',c6);
     7: writeln(': ',c7);
     1,8,9: writeln;
    end;
  end;
 while not keypressed do continue; key:=readkey;
  case key of
   #72: begin if (j>1) then dec(j); while menuenabled[j]=false do dec(j); end;
   #80: begin if (j<9) then inc(j); while menuenabled[j]=false do inc(j); end;
   #75: case j of
         2: if (c2>1) then
             begin
              dec(c2);
              if c2=2 then
               begin
                tc3:=c3; tc4:=c4; tc5:=c5; tc6:=c6; tc7:=c7;
                c3:=7; c4:=4; c5:=5; c6:=4; c7:=4;
               end
              else if c2=1 then
               begin
                c3:=6; c4:=3; c5:=4; c6:=3; c7:=3;
               end;
             end;
         3: if (c3>5) then dec(c3);
         4: if (c4>3) then dec(c4);
         5: if (c5>1) then dec(c5);
         6: if (c6>3) then dec(c6);
         7: if (c7>1) then dec(c7);
        end;
   #77: case j of
         2: if (c2<3) then
             begin
              inc(c2);
              if c2=2 then
               begin
                c3:=7; c4:=4; c5:=5; c6:=4; c7:=4;
               end
              else if c2=3 then
               begin
                c3:=tc3; c4:=tc4; c5:=tc5; c6:=tc6; c7:=tc7;
               end;
             end;
         3: if (c3<9) then inc(c3);
         4: if (c4<5) then inc(c4);
         5: if (c5<7) then inc(c5);
         6: if (c6<5) then inc(c6);
         7: if (c7<7) then inc(c7);
        end;
   #13,#28,#32: case j of
                 1: exit;
                 8: showhighscore;
                 9: halt;
                end;
   #27: j:=1;
  end;
 printmenu(j);
end;

function num2card(x:integer):char;
begin
  case x of
   0: exit(' ');
   1..9: exit(chr(48+x));
   10: exit('T');
   11: exit('J');
   12: exit('Q');
   13: exit('K');
  end;
end;

function card2num(x:char):integer;
begin
  case x of
   '1'..'9': exit(ord(x)-48);
   'T': exit(10);
   'J': exit(11);
   'Q': exit(12);
   'K': exit(13);
  end;
end;

procedure normalize(var s:string[10]);
var
 i,j:integer;
 c:char;
begin
 for i:=1 to patternsize-1 do
 for j:=i+1 to patternsize do
   if s[i]>s[j] then
    begin
     c:=s[i]; s[i]:=s[j]; s[j]:=c;
    end;
end;

function getcard:integer;
var
 z:integer;
begin
  repeat
   z:=random(13)+1;
  until cardrem[z]>0;
 dec(cardrem[z]); dec(cardtotal); exit(z);
end;

function getpattern:integer;
const
 x:array[3..13] of integer=(50,50,50,50,25,25,25,5,20,12,8);
var
 z,i:integer;
begin
 z:=random(320);
 for i:=3 to 13 do
   if z<x[i] then break else dec(z,x[i]);
 exit(i);
end;

procedure newpattern(i:integer);
var
 j,k:integer;
 b:boolean;
begin
 normalizedptn[i]:='         ';
  repeat
   for j:=1 to patternsize do
    begin
      repeat
       pattern[i,j]:=getpattern;
       b:=true;
       for k:=1 to j-1 do if pattern[i,k]=pattern[i,j] then b:=false;
      until b;
     normalizedptn[i,j]:=num2card(pattern[i,j]);
    end;
   normalize(normalizedptn[i]);
   b:=true;
   for k:=1 to patternnum do if (k<>i) and (normalizedptn[k]=normalizedptn[i]) then b:=false;
  until b;
end;

procedure initgame;
var
 i,j:integer;
begin
 cardnum:=c3; patternsize:=c4; patternnum:=c5; playernum:=c6;
 for i:=1 to 13 do cardrem[i]:=4*c7; cardtotal:=52*c7;
 fillchar(score,sizeof(score),0); fillchar(card,sizeof(card),0);
 for i:=1 to playernum do
 for j:=1 to cardnum do card[i,j]:=getcard;
 for i:=1 to patternnum do newpattern(i);
end;

procedure printtitle(k:integer);
var
 i,j:integer;
begin
 initscreen;
 write('当前比分：',score[1]);
 for i:=2 to playernum do write(' : ',score[i]);
 writeln('  剩余牌数：',cardtotal);
 if k=1 then writeln('玩家1：玩家') else writeln('玩家',k,'：电脑');
 for i:=1 to patternnum do
  begin
   write('匹配目标',i,'：');
   for j:=1 to patternsize do write(num2card(pattern[i,j]));
   writeln;
  end;
 writeln;
end;

function discard(k:integer):integer;
const
 z:array[3..13] of integer=(50,50,50,50,25,25,25,5,20,12,8);
var
 x:array[0..13] of integer;
 y:array[1..9] of longint;
 b:array[0..13] of boolean;
 f,s:array[1..7] of integer;
 w,l,i,j,m:longint;
begin
 for i:=3 to 13 do x[i]:=1000 div z[i];
 fillchar(b,sizeof(b),false);
 for i:=1 to patternnum do
 for j:=1 to patternsize do b[pattern[i,j]]:=true;
 for i:=3 to 13 do if b[i] then x[i]:=x[i] div 20;
 fillchar(b,sizeof(b),false);
 for i:=1 to cardnum do b[card[k,i]]:=true;
 fillchar(f,sizeof(f),0);
 fillchar(s,sizeof(s),0);
 for i:=1 to patternnum do
 for j:=1 to patternsize do
  begin
   if b[pattern[i,j]] then inc(f[i]);
    case pattern[i,j] of
     11: begin inc(s[i]); if b[1] then inc(s[i]); end;
     12: begin inc(s[i],2); if b[2] then inc(s[i],2); end;
     13: inc(s[i],3);
    end;
  end;
 m:=1;
 for i:=2 to patternnum do
   if (f[i]>f[m]) or ((f[i]=f[m]) and (s[i]>s[m])) then m:=i;
 for i:=1 to patternsize do x[pattern[m,i]]:=0;
 if b[11] then x[1]:=x[11] else x[1]:=1000 div z[11];
 if b[12] then x[2]:=x[12] else x[2]:=1000 div z[12];
 if b[1] then x[11]:=0; if b[2] then x[12]:=0;
 for i:=1 to cardnum-1 do
 for j:=i+1 to cardnum do
   if (card[k,i]=card[k,j]) then
    begin
     if card[k,i]>2 then x[card[k,i]]:=10000
     else if card[k,i]=1 then x[1]:=3
     else if card[k,i]=2 then x[2]:=2;
    end;
 w:=0;
 for i:=1 to cardnum do begin y[i]:=x[card[k,i]]; inc(w,y[i]); end;
 if w=0 then
  begin
   for i:=1 to cardnum do if card[k,i]=1 then exit(i);
   for i:=1 to cardnum do if card[k,i]=2 then exit(i);
   exit(random(cardnum)+1);
  end;
 l:=random(w);
 for i:=1 to cardnum do
   if l<y[i] then exit(i) else dec(l,y[i]);
end;

function computer(k:integer):boolean;
var
 i,j,z,y,add:integer;
 c:char;
 flag:boolean;
 b:array[0..13] of boolean;
 f:array[1..7] of boolean;
 s:array[1..7] of integer;
begin
 printtitle(k); delay(500);
 flag:=false; z:=0;
 fillchar(b,sizeof(b),false);
 for i:=1 to cardnum do b[card[k,i]]:=true;
 for i:=1 to patternnum do
  begin
   f[i]:=true; s[i]:=0;
   for j:=1 to patternsize do
    begin
     if b[pattern[i,j]]=false then f[i]:=false;
      case pattern[i,j] of
       11: begin inc(s[i]); if b[1] then inc(s[i]); end;
       12: begin inc(s[i],2); if b[2] then inc(s[i],2); end;
       13: inc(s[i],3);
      end;
    end;
  end;
 z:=0; y:=-1;
 for i:=1 to patternnum do
   if (f[i]) and (s[i]>y) then begin z:=i; y:=s[i]; end;
 if z>0 then
  begin
   add:=patternsize;
   for i:=1 to patternsize do
    begin
     for j:=1 to cardnum do if card[k,j]=pattern[z,i] then break;
     write(num2card(card[k,j])); card[k,j]:=0;
     if pattern[z,i]=11 then
      begin
       inc(add,1);
       for j:=1 to cardnum do if card[k,j]=1 then begin write(num2card(card[k,j])); card[k,j]:=0; inc(add); end;
      end
     else if pattern[z,i]=12 then
      begin
       inc(add,2);
       for j:=1 to cardnum do if card[k,j]=2 then begin write(num2card(card[k,j])); card[k,j]:=0; inc(add,2); end;
      end
     else if pattern[z,i]=13 then inc(add,3);
    end;
   textattr:=10;
   writeln('  匹配目标',z,'  +',add); delay(2000);
   inc(score[k],add); newpattern(z);
   flag:=true;
  end
 else if cardtotal>0 then
  begin
   z:=discard(k);
   textattr:=13;
   writeln('丢弃',num2card(card[k,z])); delay(1000);
   card[k,z]:=0;
  end
 else
  begin
   textattr:=14;
   writeln('PASS'); delay(1000);
  end;
 for i:=1 to cardnum do if (card[k,i]=0) and (cardtotal>0) then card[k,i]:=getcard;
 exit(flag);
end;

function pos(x:integer):integer;
var
 i:integer;
 b1,b2:boolean;
begin
 b1:=false; b2:=false;
 for i:=1 to cardnum do
  begin
   if card[1,i]=11 then b1:=true;
   if card[1,i]=12 then b2:=true;
  end;
 if (selectnum>1) and (((b1=false) and (x=1)) or ((b2=false) and (x=2))) then exit(0);
 for i:=1 to cardnum do
   if (select[i]=false) and (card[1,i]=x) then exit(i);
 exit(0);
end;

procedure treat12;
var
 i:integer;
 b1,b2,b3,b4:boolean;
begin
 b1:=false; b2:=false; b3:=false; b4:=false;
 for i:=1 to cardnum do
   if select[i]=true then
     case card[1,i] of
      1: b1:=true;
      2: b2:=true;
      11:b3:=true;
      12:b4:=true;
     end;
 if b1 and not b3 then
   for i:=1 to cardnum do if select[i] and (card[1,i]=1) then
    begin
     select[i]:=false; dec(selectnum);
    end;
 if b2 and not b4 then
   for i:=1 to cardnum do if select[i] and (card[1,i]=2) then
    begin
     select[i]:=false; dec(selectnum);
    end;
end;

function printgame:boolean;
var
 i,j,z,add,h1,h2:integer;
 s:string[10];
 flag:integer;
 key,ch:char;
begin
 printtitle(1);
 write('你手中的牌：');
 for i:=1 to cardnum do if card[1,i]>0 then
  begin
   if select[i] then textattr:=13 else textattr:=7;
   write(num2card(card[1,i]));
  end;
 write('  ');
 flag:=0;
 if selectnum=0 then
  begin
   textattr:=14;
   if cardtotal=0 then begin flag:=-2; writeln('PASS'); end;
  end
 else if selectnum=1 then
  begin
   textattr:=13;
   if cardtotal>0 then begin flag:=-1; writeln('丢弃'); end;
  end
 else if selectnum>=patternsize then
  begin
   s:='         '; j:=0;
   for i:=1 to cardnum do
     if (select[i]) and (card[1,i]>2) then begin inc(j); s[j]:=num2card(card[1,i]); end;
   normalize(s);
   for i:=1 to patternnum do if s=normalizedptn[i] then
    begin
     add:=patternsize;
     for j:=1 to cardnum do if select[j] then
      begin
        case card[1,j] of
         1: inc(add);
         2: inc(add,2);
         11: inc(add,1);
         12: inc(add,2);
         13: inc(add,3);
        end;
      end;
     flag:=i; textattr:=10; writeln('匹配目标',i,'  +',add); break;
    end;
  end;
 while not keypressed do continue; key:=upcase(readkey);
  case key of
   '1'..'9','T','J','Q','K':
     begin
      z:=pos(card2num(key));
      if z>0 then begin select[z]:=true; inc(selectnum); end;
     end;
   #27: begin for i:=1 to cardnum do select[i]:=false; selectnum:=0; flag:=0; end;
   #13,#28,#32:
     begin
      if flag=-1 then
       begin
        for i:=1 to cardnum do if select[i] then break;
        card[1,i]:=getcard; exit(false);
       end
      else if flag=-2 then exit(false)
      else if flag>0 then
       begin
        inc(score[1],add);
        for i:=1 to cardnum do if select[i] then card[1,i]:=0;
        for i:=1 to cardnum do if (cardtotal>0) and (card[1,i]=0) then card[1,i]:=getcard;
        newpattern(flag);
        exit(true);
       end;
     end;
   #9: begin
        writeln; if flag=0 then writeln; textattr:=11;
        writeln('当前模式：',gamemode[c2]);
        if c2<3 then write('最 高 分：');
        assign(f,'e:\game\Card Fitting\highscore.dll'); reset(f);
        readln(f,h1,h2); close(f);
        if c2=1 then writeln(h1) else if c2=2 then writeln(h2);
        writeln('任意键返回');
        while not keypressed do continue; ch:=readkey;
       end;
  end;
 if selectnum=2 then treat12;
 exit(printgame());
end;

procedure startgame;
var
 player:integer;
 flag,i,h1,h2:integer;
 h:boolean;
begin
 initgame;
 flag:=0;
 player:=random(playernum)+1;
  repeat
   inc(flag);
   if cardtotal>0 then flag:=0;
   if player>1 then
    begin
     if computer(player) then flag:=0;
    end
   else
    begin
     fillchar(select,sizeof(select),0); selectnum:=0;
     if printgame then flag:=0;
    end;
   inc(player); if player>playernum then player:=1;
  until flag>=playernum;
 initscreen;
 writeln('游戏结束');
 write('总比分：',score[1]);
 for i:=2 to playernum do write(' : ',score[i]);
 while not keypressed do continue; key:=readkey;
 if c2<3 then
  begin
   assign(f,'e:\game\Card Fitting\highscore.dll'); reset(f);
   readln(f,h1,h2); close(f);
   h:=false;
   if (c2=1) and (score[1]>h1) then begin h1:=score[1]; h:=true; end;
   if (c2=2) and (score[1]>h2) then begin h2:=score[1]; h:=true; end;
   if h then
    begin
     writeln; writeln; textattr:=11;
     writeln('新纪录：',score[1]);
     assign(f,'e:\game\Card Fitting\highscore.dll'); rewrite(f);
     writeln(f,h1,' ',h2); close(f);
     while not keypressed do continue; key:=readkey;
    end;
  end;
end;

begin
 randomize; cursoroff;
 assign(f,'e:\game\Card Fitting\default.ini'); reset(f);
 readln(f,c2,c3,c4,c5,c6,c7); close(f);
 tc3:=c3; tc4:=c4; tc5:=c5; tc6:=c6; tc7:=c7;
 fillchar(menuenabled,sizeof(menuenabled),true);
  repeat
   printmenu(1);
   assign(f,'e:\game\Card Fitting\default.ini'); rewrite(f);
   writeln(f,c2,' ',c3,' ',c4,' ',c5,' ',c6,' ',c7); close(f);
   startgame;
  until false;
end.
