unit RMK;

INTERFACE
uses crt;
procedure ramka(x,y,xx,yy:byte);
var RAMKA_MODE:byte;

IMPLEMENTATION
const hor         :string=  '�Ͱ���    ';
      vert        :string=  '������    ';
      leftup      :string=  'ټ����    ';
      rightup     :string=  '�Ȱ���    ';
      leftdown    :string=  '������    ';
      rightdown   :string=  '�ɰ���    ';



procedure ramka(x,y,xx,yy:byte);
var i:byte;
begin
for i:=x+1 to xx-1 do begin
gotoxy(i,y);write(hor[RAMKA_MODE]) ;
gotoxy(i,yy);write(hor[RAMKA_MODE]) ;
end;
for i:=y+1 to yy-1 do begin
gotoxy(x,i);write(vert[RAMKA_MODE]) ;
gotoxy(xx,i);write(vert[RAMKA_MODE]);
end;
gotoxy(x,y);write(rightdown[RAMKA_MODE]) ;
gotoxy(xx,y);write(leftdown[RAMKA_MODE]) ;
gotoxy(xx,yy);write(leftup[RAMKA_MODE]) ;
gotoxy(x,yy);write(rightup[RAMKA_MODE]) ;

end;
begin
RAMKA_MODE:=2
end.