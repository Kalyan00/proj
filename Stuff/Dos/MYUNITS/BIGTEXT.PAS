uses crt;
var i:byte;s:string;
const cudiap_min=48;cudiap_max=57;
type cudiap=cudiap_min..cudiap_max;
type bchar=array[1..8]of string[8];
const a:bchar=

(
'   ..   ',
'  .  .  ',
' .    . ',
'.      .',
'. . . ..',
'.      .',
'.      .',
'.      .');
const bcharr:array[cudiap]of bchar=(
(
' ���ͻ  ',
'ɼ   Ȼ ',
'�     � ',
'�     � ',
'�     � ',
'�     � ',
'Ȼ   ɼ ',
' ���ͼ  '),
(
'     �  ',
'    ɹ  ',
'    ��  ',
'     �  ',
'     �  ',
'     �  ',
'     �  ',
'     �  '),
(
' ����ͻ ',
' �    � ',
' �    � ',
'    �ͼ ',
'  �ͼ   ',
' ɼ     ',
' �      ',
' ����ͼ '),
(
' ����ͻ ',
'      � ',
'     ɼ ',
'   �͹  ',
'     Ȼ ',
'      � ',
'      � ',
' ����ͼ '),
(
' �    � ',
' �    � ',
' �    � ',
' ����͹ ',
'      � ',
'      � ',
'      � ',
'      � '),
(
' ����ͻ ',
' �      ',
' ���ͻ  ',
'     Ȼ ',
'      � ',
'      � ',
' Ȼ  ɼ ',
'  ��ͼ  '),
(
'  ���ͻ ',
' ɼ   � ',
' �      ',
' ���ͻ  ',
' ̼  Ȼ ',
' �    � ',
' Ȼ  ɼ ',
'  ��ͼ  '),
(
' ����ͻ ',
' �    � ',
'      � ',
'    �ͼ ',
'    �   ',
'  ��ʻ  ',
'   �    ',
'   �    '),
(
'  ��ͻ  ',
'  Ȼɼ  ',
'  ��ʻ  ',
' ɼ  Ȼ ',
' �    � ',
' �    � ',
' Ȼ  ɼ ',
'  ��ͼ  '),
(
' ���ͻ  ',
'ɼ   Ȼ ',
'�     � ',
'Ȼ   ɹ ',
' ���ͼ� ',
'      � ',
'Ȼ   ɼ ',
' ���ͼ  '));



procedure wr(c:char);
var i:byte;
begin
for i:=1 to 8 do
begin
gotoxy(wherex-8,wherey+1);
if ord(c) in [cudiap_min..cudiap_max] then
write(bcharr[ord(c)][i]);
end;
gotoxy(wherex+10,wherey-8);
end;



procedure bigwrite(s:string);
begin
for i:=1 to ord(s[0])do
begin
if ord(s[i]) in [cudiap_min..cudiap_max] then
wr(s[i]);
end;
end;


begin

s:='';
for i:=1 to paramcount do
s:=ParamStr(i)+' ';
bigwrite(s);
end.