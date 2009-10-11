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
' ÉÍÍÍ»  ',
'É¼   È» ',
'º     º ',
'º     º ',
'º     º ',
'º     º ',
'È»   É¼ ',
' ÈÍÍÍ¼  '),
(
'     Ë  ',
'    É¹  ',
'    ¼º  ',
'     º  ',
'     º  ',
'     º  ',
'     º  ',
'     Ê  '),
(
' ÉÍÍÍÍ» ',
' º    º ',
' Ê    º ',
'    ÉÍ¼ ',
'  ÉÍ¼   ',
' É¼     ',
' º      ',
' ÈÍÍÍÍ¼ '),
(
' ÉÍÍÍÍ» ',
'      º ',
'     É¼ ',
'   ÌÍ¹  ',
'     È» ',
'      º ',
'      º ',
' ÈÍÍÍÍ¼ '),
(
' Ë    Ë ',
' º    º ',
' º    º ',
' ÈÍÍÍÍ¹ ',
'      º ',
'      º ',
'      º ',
'      Ê '),
(
' ÉÍÍÍÍ» ',
' º      ',
' ÈÍÍÍ»  ',
'     È» ',
'      º ',
'      º ',
' È»  É¼ ',
'  ÈÍÍ¼  '),
(
'  ÉÍÍÍ» ',
' É¼   º ',
' º      ',
' ºÉÍÍ»  ',
' Ì¼  È» ',
' º    º ',
' È»  É¼ ',
'  ÈÍÍ¼  '),
(
' ÉÍÍÍÍ» ',
' º    º ',
'      º ',
'    ÉÍ¼ ',
'    º   ',
'  ÈËÊ»  ',
'   º    ',
'   Ê    '),
(
'  ÉÍÍ»  ',
'  È»É¼  ',
'  ÉÊÊ»  ',
' É¼  È» ',
' º    º ',
' º    º ',
' È»  É¼ ',
'  ÈÍÍ¼  '),
(
' ÉÍÍÍ»  ',
'É¼   È» ',
'º     º ',
'È»   É¹ ',
' ÈÍÍÍ¼º ',
'      º ',
'È»   É¼ ',
' ÈÍÍÍ¼  '));



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