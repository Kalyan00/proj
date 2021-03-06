unit bmpsav;
INTERFACE
function  writebmp(s:string):boolean;

IMPLEMENTATION
uses graph;
const bmpheap:array[1..118]of byte=
 ($42 ,$4D           {         bfType :             Word;        { ��⪠ 䠩�� BM }
 ,$76 ,$58 ,$02 ,$00 {153718   bfSize :             LongInt;     { ����� 䠩�� � ����� }
 ,$00 ,$00 ,$00 ,$00 {         bfReserved :         LongInt;     { ����ࢭ� ������ ���� = 0 }
 ,$76 ,$00 ,$00 ,$00 {118      bfOffBits :          LongInt;     { ���饭�� ������ ������ }
 ,$28 ,$00 ,$00 ,$00 {40       biSize :             LongInt;     { ����� BITMAP_INFO ��������� }
 ,$80 ,$02 ,$00 ,$00 {640      biWidth :            LongInt;     { ��ਭ� ����ࠦ���� � ���ᥫ�� }
 ,$E0 ,$01 ,$00 ,$00 {480      biHeight :           LongInt;     { ���� ����ࠦ���� � ���ᥫ�� }
 ,$01 ,$00           {1        biPlanes :           Word;        { ���⮢� ���᪮�� = 1 }
 ,$04 ,$00           {4        biBitCount :         Word;        { ������⢮ ��⮢ �� ���ᥫ 1,4,8,24 }
 ,$00 ,$00 ,$00 ,$00 {         biCompression :      LongInt;     { ��� ᦠ�� ������ }
 ,$00 ,$58 ,$02 ,$00 {153600   biSizeImage :        LongInt;     { ������ ����ࠦ���� � ����� }
 ,$C4 ,$0E ,$00 ,$00 {3780     biXPelsPerMeter :    LongInt;     { ����襭�� �� ��ਧ��⠫� }
 ,$C4 ,$0E ,$00 ,$00 {3780     biYPelsPerMeter :    LongInt;     { ����襭�� �� ���⨪��� }
 ,$00 ,$00 ,$00 ,$00 {         biClrUsed :          LongInt;     { ������⢮ �ᯮ��㥬�� 梥⮢ }
 ,$00 ,$00 ,$00 ,$00 {         biClrImportant :     LongInt;     { ������⢮ �᭮���� 梥⮢ }

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