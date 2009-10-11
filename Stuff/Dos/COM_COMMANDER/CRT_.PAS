unit crt_;
INTERFACE
var textbuffer:array[0..24,0..79,0..1] of byte absolute $b800:0;
var wx,wy:byte;
    textattr:byte;
function readkey:char;
function keypressed:boolean;
procedure gotoxy(y,x:byte);
function wherex:byte;
function wherey:byte;
procedure cls;
procedure cwrite(s:string);
procedure cwritexy(x,y:byte;s:string);
IMPLEMENTATION
var readk:char;

procedure cwritexy(x,y:byte;s:string);
          var a,w,d,f:byte;
          begin
          a:=wherex;
          w:=wherey;
          d:=wx;
          f:=wy;
          gotoxy(x,y);
          cwrite(s);
          gotoxy(a,w);
          wx:=d;
          wy:=f;
          end;

procedure cwrite(s:string);
          var k,j,i:byte;
          begin
          for k:=1 to ord(s[0]) do
          begin
          case s[k] of
          #0:;
          #8:wx:=wx+7;
          #9:wx:=wx-2;
          #13:wx:=79;
          else begin
          textbuffer[wy,wx,0]:=ord(s[k]);
          textbuffer[wy,wx,1]:=textattr;
          end;
          end;
          inc(wx); if wx>=80 then begin wx:=0; inc(wy); end;
                    if wy>=24 then
                     begin dec(wy);
                      for j:=0 to 23 do
                       for i:=0 to 79 do
                        textbuffer[j,i]:=textbuffer[j+1,i];
                      for i:=0 to 79 do begin
                       textbuffer[21,i,0]:=32;
                       textbuffer[21,i,1]:=7;
                       end;
                     end;

          end;
          end;
procedure cls;
          var i:integer;
          begin
          for i:=0 to 4000 do write(' ');
          gotoxy(1,1);
          end;

function wherex:byte;
         var a:byte;
         begin
         asm
         mov ah,3
         mov bh,0
         int 10h
         inc dl
         mov a,dl
         end;
         wherex:=a;
         end;

function wherey:byte;
         var a:byte;
         begin
         asm
         mov ah,3
         mov bh,0
         int 10h
         inc dh
         mov a,dh
         end;
         wherey:=a;
         end;

procedure gotoxy(y,x:byte);
          begin
          x:=x-1;y:=y-1;
          wx:=x; wy:=y;
          asm
          mov ah,02
          mov bh,00
          mov dh,x
          mov dl,y
          int 10h
          end;
          end;

function keypressed:boolean;
         label net;
         begin
         keypressed:= true;
         if readk<>#0 then exit;
         keypressed:= false;
         asm
         mov ah,01
         int  16h
         jz   net
         end;
         keypressed:= true;
         net:
         end;

function readkey:char;
         var a:char;
         begin
              if readk=#0 then
                 begin
                 asm
                    mov ax,0
                    int 16h
                    mov a,al
                 end;
                 if a=#0 then asm mov readk,ah end;
                 end
                 else begin a:=readk;readk:=#0;end;
              readkey:=a;
         end;


begin
wx:=0;
wy:=0;
readk:=#0;
textattr:=7;
end.

