uses
 crt;
var
 ans:array[1..40] of longint;
 a,b,c,d,all:longint;
 sa,sb,sc,sd:string;
 k,i,j:byte;
 wr:array[1..40] of string;
 score:array[1..40] of longint;
 s:array[1..40] of string;
 cor:array[1..40] of boolean;
 t:string;
 f:text;
procedure p1;
begin
 score[i]:=1;
 a:=random(10); str(a,sa);
 b:=random(10); str(b,sb);
 ans[i]:=a+b;
 wr[i]:=sa+' + '+sb+' =';
end;
procedure p2;
begin
 score[i]:=2;
 a:=random(990)+10; str(a,sa);
 b:=random(10); str(b,sb);
 ans[i]:=a+b;
 wr[i]:=sa+' + '+sb+' =';
end;
procedure p3;
begin
 score[i]:=4;
 a:=random(90)+10; str(a,sa);
 b:=random(90)+10; str(b,sb);
 ans[i]:=a+b;
 wr[i]:=sa+' + '+sb+' =';
end;
procedure p4;
begin
 score[i]:=9;
 a:=random(990)+10; str(a,sa);
 b:=random(900)+100; str(b,sb);
 ans[i]:=a+b;
 wr[i]:=sa+' + '+sb+' =';
end;
procedure p5;
begin
 score[i]:=21;
 a:=random(9000)+1000; str(a,sa);
 b:=random(9000)+1000; str(b,sb);
 ans[i]:=a+b;
 wr[i]:=sa+' + '+sb+' =';
end;
procedure p6;
begin
 score[i]:=45;
 a:=random(99000)+1000; str(a,sa);
 b:=random(90000)+10000; str(b,sb);
 ans[i]:=a+b;
 wr[i]:=sa+' + '+sb+' =';
end;
procedure p7;
begin
 score[i]:=1;
 a:=random(10); str(a,sa);
 b:=random(10); str(b,sb);
 c:=random(10); str(c,sc);
 ans[i]:=a+b+c;
 wr[i]:=sa+' + '+sb+' + '+sc+' =';
end;
procedure p8;
begin
 score[i]:=11;
 a:=random(10); str(a,sa);
 b:=random(90)+10; str(b,sb);
 c:=random(900)+100; str(c,sc);
 ans[i]:=a+b+c;
 wr[i]:=sa+' + '+sb+' + '+sc+' =';
end;
procedure p9;
begin
 score[i]:=19;
 a:=random(90)+10; str(a,sa);
 b:=random(990)+10; str(b,sb);
 c:=random(990)+10; str(c,sc);
 ans[i]:=a+b+c;
 wr[i]:=sa+' + '+sb+' + '+sc+' =';
end;
procedure p10;
begin
 score[i]:=74;
 a:=random(9990)+10; str(a,sa);
 b:=random(99000)+1000; str(b,sb);
 c:=random(99000)+1000; str(c,sc);
 ans[i]:=a+b+c;
 wr[i]:=sa+' + '+sb+' + '+sc+' =';
end;
procedure m1;
begin
 score[i]:=1;
 a:=random(10); str(a,sa);
 b:=random(10); str(b,sb);
 ans[i]:=a-b;
 wr[i]:=sa+' - '+sb+' =';
end;
procedure m2;
begin
 score[i]:=1;
 a:=random(90)+10; str(a,sa);
 b:=random(10); str(b,sb);
 ans[i]:=a-b;
 wr[i]:=sa+' - '+sb+' =';
end;
procedure m3;
begin
 score[i]:=23;
 a:=random(9900)+100; str(a,sa);
 b:=random(990)+10; str(b,sb);
 ans[i]:=a-b;
 wr[i]:=sa+' - '+sb+' =';
end;
procedure m4;
begin
 score[i]:=41;
 a:=random(9000)+1000; str(a,sa);
 b:=random(9000)+1000; str(b,sb);
 ans[i]:=a-b;
 wr[i]:=sa+' - '+sb+' =';
end;
procedure m5;
begin
 score[i]:=49;
 a:=random(99000)+1000; str(a,sa);
 b:=random(9000)+1000; str(b,sb);
 ans[i]:=a-b;
 wr[i]:=sa+' - '+sb+' =';
end;
procedure m6;
begin
 score[i]:=2;
 a:=random(90)+10; str(a,sa);
 b:=random(10); str(b,sb);
 c:=random(10); str(c,sc);
 ans[i]:=a-b-c;
 wr[i]:=sa+' - '+sb+' - '+sc+' =';
end;
procedure m7;
begin
 score[i]:=28;
 a:=random(900)+100; str(a,sa);
 b:=random(90)+10; str(b,sb);
 c:=random(90)+10; str(c,sc);
 ans[i]:=a-b-c;
 wr[i]:=sa+' - '+sb+' - '+sc+' =';
end;
procedure m8;
begin
 score[i]:=56;
 a:=random(90000)+10000; str(a,sa);
 b:=random(900)+100; str(b,sb);
 c:=random(990)+10; str(c,sc);
 ans[i]:=a-b-c;
 wr[i]:=sa+' - '+sb+' - '+sc+' =';
end;
procedure m9;
begin
 score[i]:=137;
 a:=random(90000)+10000; str(a,sa);
 b:=random(99000)+1000; str(b,sb);
 c:=random(99000)+1000; str(c,sc);
 ans[i]:=a-b-c;
 wr[i]:=sa+' - '+sb+' - '+sc+' =';
end;
procedure t1;
begin
 score[i]:=1;
 a:=random(9)+1; str(a,sa);
 b:=random(9)+1; str(b,sb);
 ans[i]:=a*b;
 wr[i]:=sa+' x '+sb+' =';
end;
procedure t2;
begin
 score[i]:=6;
 a:=random(90)+10; str(a,sa);
 b:=random(9)+1; str(b,sb);
 ans[i]:=a*b;
 wr[i]:=sa+' x '+sb+' =';
end;
procedure t3;
begin
 score[i]:=15;
 a:=random(900)+100; str(a,sa);
 b:=random(9)+1; str(b,sb);
 ans[i]:=a*b;
 wr[i]:=sa+' x '+sb+' =';
end;
procedure t4;
begin
 score[i]:=26;
 a:=random(9000)+1000; str(a,sa);
 b:=random(9)+1; str(b,sb);
 ans[i]:=a*b;
 wr[i]:=sa+' x '+sb+' =';
end;
procedure t5;
begin
 score[i]:=51;
 a:=random(90000)+10000; str(a,sa);
 b:=random(9)+1; str(b,sb);
 ans[i]:=a*b;
 wr[i]:=sa+' x '+sb+' =';
end;
procedure t6;
begin
 score[i]:=34;
 a:=random(90)+10; str(a,sa);
 b:=random(90)+10; str(b,sb);
 ans[i]:=a*b;
 wr[i]:=sa+' x '+sb+' =';
end;
procedure t7;
begin
 score[i]:=7;
 a:=random(9)+1; str(a,sa);
 b:=random(9)+1; str(b,sb);
 c:=random(9)+1; str(c,sc);
 ans[i]:=a*b*c;
 wr[i]:=sa+' x '+sb+' x '+sc+' =';
end;
procedure t8;
begin
 score[i]:=18;
 a:=random(9)+1; str(a,sa);
 b:=random(9)+1; str(b,sb);
 c:=random(90)+10; str(c,sc);
 ans[i]:=a*b*c;
 wr[i]:=sa+' x '+sb+' x '+sc+' =';
end;
procedure t9;
begin
 score[i]:=42;
 a:=random(9)+1; str(a,sa);
 b:=random(9)+1; str(b,sb);
 c:=random(900)+100; str(c,sc);
 ans[i]:=a*b*c;
 wr[i]:=sa+' x '+sb+' x '+sc+' =';
end;
procedure t10;
begin
 score[i]:=79;
 a:=random(9)+1; str(a,sa);
 b:=random(9)+1; str(b,sb);
 c:=random(9000)+1000; str(c,sc);
 ans[i]:=a*b*c;
 wr[i]:=sa+' x '+sb+' x '+sc+' =';
end;
procedure t11;
begin
 score[i]:=138;
 a:=random(9)+1; str(a,sa);
 b:=random(9)+1; str(b,sb);
 c:=random(9000)+1000; str(c,sc);
 ans[i]:=a*b*c;
 wr[i]:=sa+' x '+sb+' x '+sc+' =';
end;

begin
 randomize;
 assign(f,'d:\little games\math\game.txt'); rewrite(f);
 for i:=1 to 40 do
  begin
   k:=random(29);
    case k of
     0:p1; 1:p2; 2:p3; 3:p4; 4:p5; 5:p6; 6:p7; 7:p8; 8:p9; 9:p10;
     10:m1; 11:m2; 12:m3; 13:m4; 14:m5; 15:m6; 16:m7; 17:m8; 18:m9; 19:t11;
     20:t1; 21:t2; 22:t3; 23:t4; 24:t5; 25:t6; 26:t7; 27:t8; 28:t9; 29:t10;
    end;
   writeln(f,wr[i]);
  end;
 close(f);
 clrscr;
 write('Time dimension: '); readln(j);
 delay(3000); sound(1000); delay(500); nosound;
 for i:=j downto 1 do
  begin
   delay(700);
   if i<=10 then begin clrscr; writeln(i); sound(1000); delay(300); nosound; end else delay(300);
  end;
 delay(100); sound(1000); delay(100); nosound;
 delay(100); sound(1000); delay(100); nosound;
 delay(100); sound(1000); delay(2500); nosound;
 delay(500); sound(1000); delay(500); nosound;
 assign(f,'d:\little games\math\game.txt'); reset(f);
 for i:=1 to 40 do
  begin
   readln(f,s[i]);
   str(ans[i],t);
   if wr[i]+t=s[i] then cor[i]:=true else cor[i]:=false;
  end;
 close(f);
 for i:=1 to 40 do
  begin
   write(i,') '); write(s[i]);
   if cor[i]=false then begin textattr:=12; writeln(' X  ',ans[i]); textattr:=7; end
   else begin textattr:=10; writeln(' V'); textattr:=7; inc(all,score[i]); end;
   if i=20 then readln;
  end;
 write('Score: ',all); readln;
end.
