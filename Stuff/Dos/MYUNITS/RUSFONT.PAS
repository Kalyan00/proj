{***********************************************************************}
{*                 Copyright (C) by SoftWeyr  , 1991                   *}
{*                             Rusfont.Pas                             *}
{*            �����,��������騩 �� ����᪨� ०���             *}
{*                             Version 1.0                             *}
{*                           CGA, EGA � VGA                            *}
{*         ����������� ��楤��� OutText,OutTextXY                  *}
{***********************************************************************}

{��� ����� �������� ����� �� ��࠭� ���᪨� �㪢� �� �뢮�� �� ��࠭
 ��楤�ன OutText/OutTextXY � ����᪨� ०���� CGA,EGA,VGA � ��
 �뢮�� �� ��࠭ �।�⢠�� DOS � BIOS � ����᪨� ०���� CGA, ������ᨬ�
 �� ���䨪�樨 ��設�. �� �������� ����� EGA �� ࠡ�⠥�.
  ����䥩��� ��楤�� �� ᮤ�ন�. ��� ���� ���� ��������� � uses � ��}
unit rusfont;
interface
implementation
uses DOS;
var SaveInt1f:Pointer;
    OldExit:Pointer ;
Procedure Font;External;
{$L Rus8x8}
{$F+}
Procedure Quit;
begin
 SetIntVec($1f,SaveInt1F);
 ExitProc:=OldExit
end;
{$F-}
begin
 GetIntVec($1F,SaveInt1F);
 SetIntVec($1f,@Font);
 OldExit := ExitProc;
 ExitProc:=@Quit;
end.

