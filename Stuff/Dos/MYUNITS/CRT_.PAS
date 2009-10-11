unit crt_;
INTERFACE
function readkey:char;
function keypressed:boolean;
procedure gotoxy(y,x:byte);
function wherex:byte;
function wherey:byte;
procedure clrscr;
IMPLEMENTATION
var readk:char;

procedure clrscr;
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
readk:=#0;
end.

