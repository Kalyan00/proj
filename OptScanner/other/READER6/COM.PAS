Unit Com;

Interface

Const
  B_110     = 1040;
  B_150     =  768;
  B_300     =  384;
  B_600     =  192;
  B_1200    =   96;
  B_2400    =   48;
  B_4800    =   24;
  B_9600    =   12;
  B_19200   =    6;
  B_38400   =    3;
  B_57600   =    2;
  B_115200  =    1;

  Bits_5      =    0;
  Bits_6      =    1;
  Bits_7      =    2;
  Bits_8      =    3;
  Stops_1     =    0;
  Stops_2     =    4;
  Parity_No   =    0;
  Parity_Even =  $18;
  Parity_Odd  =    8;

Var
  ComBasePort : Array [1..4] of Word;

Function OpenCom (ComNo : Byte; BaudRate : Word; Config : Byte;
                  BufSize : Word) : Boolean;
Function CloseCom (ComNo : Byte) : Boolean;
Function ReadCom (ComNo : Byte; Var Value) : Boolean;
Function BlockReadCom (ComNo : Byte; Var Buf; Size : Word) : Boolean;
Function WriteCom (ComNo : Byte; Var Value) : Boolean;
Function BlockWriteCom (ComNo : Byte; Var Buf; Size : Word) : Boolean;
Function ReceivedFromCOM (ComNo : Byte) : Word;
function dsr(ComNo : Byte):boolean;

Implementation

Uses DOS,crt;

Type
  TComBuf = Array [0..65527] of Byte;
  PComBuf = ^TComBuf;

Const
  IO_Reg  = 0;
  Lo_Div  = 0;
  Hi_Div  = 1;
  Int_Reg = 1;
  Int_Id  = 2;
  Control = 3;
  Modem   = 4;
  Status  = 5;
  MStatus = 6;
  IRQAlreadyUsed : Array [3..4] of Boolean = (False, False);

Var
  OldIRQHandler : Array [3..4] of Pointer;
  IntMask : Array [3..4] of Byte;
  BasePort : Array [3..4] of Word;

  PComBufs : Array [3..4] of PComBuf;
  ComBufSize : Array [3..4] of Word;

  Head, Tail, _Received : Array [3..4] of Word;


Procedure NewIRQ3Handler; Interrupt;
Var
  X : Byte;
Label
  LEnd;
Begin
  If _Received[3] = ComBufSize[3] then Goto LEnd;
  X := Port[BasePort[3]+IO_Reg];
  (PComBufs[3])^[Tail[3]] := X;
  Inc (Tail[3]);
  If Tail[3] = ComBufSize[3] then Tail[3] := 0;
  Inc (_Received[3]);
LEnd:
  Port[$20] := $20
End;

Procedure NewIRQ4Handler; Interrupt;
Var
  X : Byte;
Label
  LEnd;
Begin
  If _Received[4] = ComBufSize[4] then Goto LEnd;
  X := Port[BasePort[4]+IO_Reg];
  (PComBufs[4])^[Tail[4]] := X;
  Inc (Tail[4]);
  If Tail[4] = ComBufSize[4] then Tail[4] := 0;
  Inc (_Received[4]);
LEnd:
  Port[$20] := $20
End;

Function OpenCom (ComNo : Byte; BaudRate : Word; Config : Byte;
                  BufSize : Word) : Boolean;
Var
  Result : Boolean;
  Base : Word;
  IRQ : Byte;
Label
  LEnd;
Begin
  Result := False;
  If not ComNo In [1..4] then Goto LEnd;
  Base := ComBasePort[ComNo];
  If Base = 0 then Goto LEnd;
  If ComNo and 1 = 0 then IRQ := 3
  Else IRQ := 4;
  If IRQAlreadyUsed[IRQ] then Goto LEnd;

  Port[Base+Control] := $80;
  Port[Base+Lo_Div] := BaudRate and $FF;
  Port[Base+Hi_Div] := BaudRate shr 8;
  Port[Base+Control] := Config;
  Port[Base+Modem] := 8;
  Port[Base+Int_Reg] := 1;

  BasePort[IRQ] := Base;
  Head[IRQ] := 0;
  Tail[IRQ] := 0;
  _Received[IRQ] := 0;
  ComBufSize[IRQ] := BufSize;
  GetMem (PComBufs[IRQ], BufSize);

  GetIntVec (8+IRQ, OldIRQHandler[IRQ]);
  If IRQ=3 then SetIntVec (8+IRQ, @NewIRQ3Handler)
  Else SetIntVec (8+IRQ, @NewIRQ4Handler);

  IntMask[IRQ] := Port[$21];
  If IRQ=3 then Port[$21] := IntMask[3] and $F7
  Else Port[$21] := IntMask[4] and $EF;

  IRQAlreadyUsed[IRQ] := True;
  Result := True;
LEnd:
  OpenCom := Result
End;

Function CloseCom (ComNo : Byte) : Boolean;
Var
  Result : Boolean;
  IRQ : Byte;
  Base : Word;
Label
  LEnd;
Begin
  Result := False;
  If not ComNo In [1..4] then Goto LEnd;
  Base := ComBasePort[ComNo];
  If Base = 0 then Goto LEnd;
  If ComNo and 1 = 0 then IRQ := 3
  Else IRQ := 4;
  If not IRQAlreadyUsed[IRQ] then Goto LEnd;

  Port[Base+Modem] := 0;
  Port[Base+Int_Reg] := 0;

  Port[$21] := IntMask[IRQ];

  SetIntVec (8+IRQ, OldIRQHandler[IRQ]);

  FreeMem (PComBufs[IRQ], ComBufSize[IRQ]);

  IRQAlreadyUsed[IRQ] := False;
  Result := True;
LEnd:
  CloseCom := Result
End;

Function ReadCom (ComNo : Byte; Var Value) : Boolean;
Var
  Result : Boolean;
  IRQ : Byte;
Label
  LEnd;
Begin
  Result := False;
  If not ComNo In [1..4] then Goto LEnd;
  If ComNo and 1 = 0 then IRQ := 3
  Else IRQ := 4;
  If not IRQAlreadyUsed[IRQ] then Goto LEnd;
  If _Received[IRQ] = 0 then Goto LEnd;

  Byte(Value) := (PComBufs[IRQ])^[Head[IRQ]];
  Inc (Head[IRQ]);
  If Head[IRQ] = ComBufSize[IRQ] then Head[IRQ] := 0;
  Dec (_Received[IRQ]);

  Result := True;
LEnd:
  ReadCOM := Result
End;

Function BlockReadCom (ComNo : Byte; Var Buf; Size : Word) : Boolean;
Var
  Result : Boolean;
  IRQ : Byte;
  _Head,
  BufSize : Word;
  From : Pointer;
Label
  LEnd;
Begin
  Result := False;
  If not ComNo In [1..4] then Goto LEnd;
  If ComNo and 1 = 0 then IRQ := 3
  Else IRQ := 4;
  If not IRQAlreadyUsed[IRQ] then Goto LEnd;
  If _Received[IRQ] = 0 then Goto LEnd;

  _Head := Head[IRQ];
  BufSize := ComBufSize[IRQ];
  From := PComBufs[IRQ];
  Asm
    Push  DS
    LES   DI, Buf
    LDS   SI, From
    Mov   CX, Size
    Mov   BX, _Head
    Mov   DX, BufSize
    CLD
@cycle:
    Mov   AL, DS:[SI+BX]
    STOSB
    Inc   BX
    Cmp   BX, DX
    JC    @right
    Xor   BX, BX
@right:
    Loop  @cycle
    Mov   _Head, BX
    Pop   DS
  End;
  Head[IRQ] := _Head;
  Dec (_Received[IRQ], Size);

  Result := True;
LEnd:
  BlockReadCOM := Result
End;

Function WriteCom (ComNo : Byte; Var Value) : Boolean;
Var
  Result : Boolean;
  IRQ : Byte;
Label
  LEnd;
Begin
  Result := False;
  If not ComNo In [1..4] then Goto LEnd;
  If ComNo and 1 = 0 then IRQ := 3
  Else IRQ := 4;
  If not IRQAlreadyUsed[IRQ] then Goto LEnd;

  While Port[BasePort[IRQ]+Status] and $20 = 0 do;

  Asm CLI End;
  Port[BasePort[IRQ]+IO_Reg] := Byte(Value);
  Asm STI End;

  Result := True;
LEnd:
  WriteCOM := Result
End;

Function BlockWriteCom (ComNo : Byte; Var Buf; Size : Word) : Boolean;
Var
  Result : Boolean;
  IRQ : Byte;
  IOPort, StatusPort : Word;
Label
  LEnd;
Begin
  Result := False;
  If not ComNo In [1..4] then Goto LEnd;
  If ComNo and 1 = 0 then IRQ := 3
  Else IRQ := 4;
  If not IRQAlreadyUsed[IRQ] then Goto LEnd;

  StatusPort := BasePort[IRQ]+Status;
  IOPort := BasePort[IRQ]+IO_Reg;
  Asm
    LES   DI, Buf
    Mov   CX, Size
    Mov   DX, StatusPort
    Mov   BX, IOPort
@wait:
    In    AL, DX
    Test  AL, 20h
    JZ    @wait
    Xchg  DX, BX
    Mov   AL, ES:[DI]
    CLI
    Out   DX, AL
    STI
    Inc   DI
    Xchg  DX, BX
    Loop  @wait
  End;

  Result := True;
LEnd:
  BlockWriteCOM := Result
End;

Function ReceivedFromCOM (ComNo : Byte) : Word;
Var
  IRQ : Byte;
  Result : Word;
Label
  LEnd;
Begin
  Result := 0;
  If not ComNo In [1..4] then Goto LEnd;
  If ComNo and 1 = 0 then IRQ := 3
  Else IRQ := 4;
  If not IRQAlreadyUsed[IRQ] then Goto LEnd;
  Result := _Received[IRQ];
LEnd:
  ReceivedFromCOM := Result
End;



function dsr(ComNo : Byte):boolean;
Var
  q,x,y,IRQ : Byte;
Begin
dsr:=true;
  If not ComNo In [1..4] then exit;
  If ComNo and 1 = 0 then IRQ := 3
  Else IRQ := 4;
  If not IRQAlreadyUsed[IRQ] then exit;

dsr:= Port[BasePort[IRQ]+6] and $20 <>0
end;



Begin
  ComBasePort[1] := MemW[Seg0040:0];
  ComBasePort[2] := MemW[Seg0040:2];
  ComBasePort[3] := MemW[Seg0040:4];
  ComBasePort[4] := MemW[Seg0040:6]
End.
