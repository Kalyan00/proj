unit bmpsav;
INTERFACE
function  writebmp(s:string):boolean;

IMPLEMENTATION
uses graph;
const bmpheap:array[1..118]of byte=
 ($42 ,$4D           {         bfType :             Word;        { Метка файла BM }
 ,$76 ,$58 ,$02 ,$00 {153718   bfSize :             LongInt;     { Длина файла в байтах }
 ,$00 ,$00 ,$00 ,$00 {         bfReserved :         LongInt;     { Резервные должны быть = 0 }
 ,$76 ,$00 ,$00 ,$00 {118      bfOffBits :          LongInt;     { Смещение области данных }
 ,$28 ,$00 ,$00 ,$00 {40       biSize :             LongInt;     { Длина BITMAP_INFO заголовка }
 ,$80 ,$02 ,$00 ,$00 {640      biWidth :            LongInt;     { Ширина изображения в пикселах }
 ,$E0 ,$01 ,$00 ,$00 {480      biHeight :           LongInt;     { Высота изображения в пикселах }
 ,$01 ,$00           {1        biPlanes :           Word;        { Цветовые плоскости = 1 }
 ,$04 ,$00           {4        biBitCount :         Word;        { Количество битов на пиксел 1,4,8,24 }
 ,$00 ,$00 ,$00 ,$00 {         biCompression :      LongInt;     { Тип сжатия данных }
 ,$00 ,$58 ,$02 ,$00 {153600   biSizeImage :        LongInt;     { Размер изображения в байтах }
 ,$C4 ,$0E ,$00 ,$00 {3780     biXPelsPerMeter :    LongInt;     { Разрешение по горизонтали }
 ,$C4 ,$0E ,$00 ,$00 {3780     biYPelsPerMeter :    LongInt;     { Разрешение по вертикали }
 ,$00 ,$00 ,$00 ,$00 {         biClrUsed :          LongInt;     { Количество используемых цветов }
 ,$00 ,$00 ,$00 ,$00 {         biClrImportant :     LongInt;     { Количество основных цветов }

 {palette}
  {R    G    B }
 ,$00 ,$00 ,$00 ,$00   {0}
 ,$CC ,$00 ,$00 ,$00   {4}
 ,$00 ,$CC ,$00 ,$00   {2}
 ,$CC ,$CC ,$00 ,$00   {6}
 ,$00 ,$00 ,$CC ,$00   {1}
 ,$CC ,$00 ,$CC ,$00   {5}
 ,$00 ,$CC ,$CC ,$00   {3}
 ,$CC ,$CC ,$CC ,$00   {7}
 ,$44 ,$44 ,$44 ,$00   {8}
 ,$FF ,$44 ,$44 ,$00   {12}
 ,$44 ,$FF ,$44 ,$00   {10}
 ,$FF ,$FF ,$44 ,$00   {14}
 ,$44 ,$44 ,$FF ,$00   {9}
 ,$FF ,$44 ,$FF ,$00   {13}
 ,$44 ,$FF ,$FF ,$00   {11}
 ,$FF ,$FF ,$FF ,$00   {15}
);


function  writebmp(s:string):boolean;
          var f:file of byte;
              i,j:integer;d:byte;
          begin
          writebmp:=false;
          if pos('.',s)<>0 then s[0]:=chr(pos('.',s));s:=s+'.bmp';
          {$i-}
          assign(f,s);
          rewrite(f);
          {$i+}
          if ioresult<>0 then exit;
          for i:=1 to 118 do write(f,bmpheap[i]);
          for i:=480 downto 1 do
          begin d:=0;write(f,d);
          for j:=2 to 320 do
          begin
          d:=getpixel(j*2-1,i)*16+getpixel(j*2,i);
          write(f,d);

          end;
          end;

          close(f);
          writebmp:=true;
          end;


end.