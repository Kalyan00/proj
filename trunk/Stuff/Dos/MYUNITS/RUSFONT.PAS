{***********************************************************************}
{*                 Copyright (C) by SoftWeyr  , 1991                   *}
{*                             Rusfont.Pas                             *}
{*            Модуль,русифицирующий все графические режимы             *}
{*                             Version 1.0                             *}
{*                           CGA, EGA и VGA                            *}
{*         русифицируются процедуры OutText,OutTextXY                  *}
{***********************************************************************}

{Этот модуль позволяет иметь на экране русские буквы при выводе на экран
 процедурой OutText/OutTextXY в графических режимах CGA,EGA,VGA и при
 выводе на экран средствами DOS и BIOS в графических режимах CGA, независимо
 от русификации машины. На некоторых старых EGA не работает.
  Интерфейсных процедур не содержит. Его надо просто подключить в uses и все}
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

