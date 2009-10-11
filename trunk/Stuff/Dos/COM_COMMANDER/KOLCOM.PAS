unit kolCom;

interface

uses Dos;

const
  DATA = $01; (* Interrupt enable bits (IntBits) *)
  THRE = $02;
  LINE = $04;
  MODEM = $08;

  COM1 = 0;
  COM2 = 1;
  COM3 = 2;
  COM4 = 3;

  B115200 = $0001; (* Baud rate divisors *)
  B57600 = $0002;
  B38400 = $0003;
  B19200 = $0006;
  B14400 = $0008;
  B9600 = $000C;
  B2400 = $0030;

  SPACE = $38; (* Parity bits *)
  ODD = $08;
  MARK = $28;
  EVEN = $18;
  NONE = $00;

  D8 = $03; (* Data bits *)
  D7 = $02;
  D6 = $01;
  D5 = $00;

  S2 = $04; (* Stop bits *)
  S1 = $00;

  DLL = $00; (* UART registers *)
  DLH = $01;
  IER = $01;
  IIR = $02;
  LCR = $03;
  MCR = $04;
  LSR = $05;
  MSR = $06;

  CMD = $20;
  IMR = $21;

  BUFF_SIZE=16383;

const
  ComPort: array[0..3] of Word = ($3f8, $2f8, $3e8, $2e8);
  ComInt: array[0..3] of Byte = ($0c, $0b, $0c, $0b);
  IntMask: array[0..3] of Byte = ($10, $08, $10, $08);

  ACTIVE = $01;
  SENDIT = $02;
  DATARECEIVED = $04;

var
  ComStatus, ReadData, SendData: Byte;
  OldInt: array[COM1..COM4] of Pointer;
  InputBuffer:array[0..BUFF_SIZE] of Byte;
  InputBufferPos:Word;
  ActivePort: Word;
  comno:byte;

procedure  openCom(Com: Byte; Speed: Word; Parity, Data, Stop, IntBits: Byte);
procedure  closeCom(Com: Byte);
function  read(var Data: Byte): Boolean;
procedure  send(Value: Byte);
procedure comWrite(s:string);
procedure comWriteLn(s:string);
function comRead:string;
function comReadLn:string;
procedure ClearInputBuffer;
procedure hangUp(Com:Byte);
function comReadCh: char;
procedure comWriteCh (c:char);

implementation

function  getabstime:longint; {sec100}
          var a,b,c,d,e:byte;
          begin
          asm
          MOV   AH,2CH
          INT   $21
          MOV   a,CH            {; HOURS}
          MOV   b,CL            {; MINUTES}
          MOV   c,DH            {; SECONDS }
          MOV   d,DL            {; HUNDREDTHS}
          end;
          getabstime:=((a*60+b)*60+c)*100+d;
          end;

procedure  comInterrupt; interrupt; var
  Data: Byte;
  j:Word;
begin
  Data := Port[ActivePort+IIR];
  while (Data and $01 = $00) do
  begin
    case Data of
      0: (* Modem status changed *)
        Data := Port[ActivePort+MSR];

      2: (* THRE *)
      begin
        if (ComStatus and SENDIT = SENDIT) then
        begin
          Port[ActivePort] := SendData;
          ComStatus := ComStatus and not SENDIT;
        end
        else
        begin
          ComStatus := ComStatus and not ACTIVE;
          Data := Port[ActivePort+IIR];
        end;
      end;

      4: (* Data received *)
      begin
        ReadData := Port[ActivePort];
        if (InputBufferPos < BUFF_SIZE) then
          begin
        InputBuffer[InputBufferPos] := ReadData;
            InputBufferPos := InputBufferPos + 1;
          end
        else
          begin
            for j := 0 to BUFF_SIZE-1 do
              InputBuffer[j] := InputBuffer[j+1];
            InputBuffer[InputBufferPos] := ReadData;
          end;
        ComStatus := ComStatus or DATARECEIVED;
        (* Old UARTs lose THRE-interrupts without this *)
          Data := Port[ActivePort+IER];
          Port[ActivePort+IER] := Data and not 2;
          Port[ActivePort+IER] := Data;
      end;

      6: (* Line status changed *)
      begin
        Data := Port[ActivePort+LSR];
        (* Old UARTs lose THRE-interrupts without this *)
          Data := Port[ActivePort+IER];
          Port[ActivePort+IER] := Data and not 2;
          Port[ActivePort+IER] := Data;
      end;
    end;
    Data := Port[ActivePort+IIR];
  end;
  Port[CMD] := $20;
end;

procedure  openCom;
var
  P: Word;
  Temp: Byte;
begin
  comno:=com;
  ComStatus := ACTIVE;
  ActivePort := ComPort[Com];
  getIntVec(ComInt[Com], OldInt[Com]);
  setIntVec(ComInt[Com], @comInterrupt);
  Port[ActivePort+LCR] := $80;
  Port[ActivePort+DLH] := Hi(Speed);
  Port[ActivePort+DLL] := Lo(Speed);
  Port[ActivePort+LCR] := Parity or Data or Stop;
  Port[ActivePort+MCR] := $0b;
  Port[ActivePort+IER] := IntBits;
  Port[IMR] := Port[IMR] and not IntMask[Com];
  InputBufferPos := 0;
end;

procedure hangUp;
var
b:byte;

begin
  asm
  mov al, 00110011b
    mov b, al
  end;
  Port[ActivePort+MSR] := b;
end;

procedure  closeCom;
var
  P: Word;
begin
  P := ComPort[Com];
  Port[P+MCR] := 0;
  Port[IMR] := Port[IMR] or IntMask[Com];
  Port[P+IER] := 0;
  setIntVec(ComInt[Com], OldInt[Com]);
end;

function  read;
var
j:Word;

begin
  {if (ComStatus and DATARECEIVED <> 0) then}
  if (InputBufferPos > 0) then
  begin
    Data := InputBuffer[0];
    for j := 0 to InputBufferPos-1 do
      InputBuffer[j] := InputBuffer[j+1];
    InputBufferPos := InputBufferPos - 1;
    ComStatus := ComStatus and not DATARECEIVED;
    read := True;
  end
  else
    read := False;
end;
var ccoopp:integer;
procedure send;
begin
  ccoopp:=getabstime mod 200;
  repeat
  if ccoopp=((getabstime+199)mod 200) then
  begin writeln('ERROR WRITING COM');closecom(comno);halt;end;
  until (ComStatus and SENDIT = 0);
  SendData := Value;
  ComStatus := ComStatus or SENDIT;
  asm cli end;
  if (ComStatus and ACTIVE <> ACTIVE) then
  begin (* Enable THRE-interrupt *)
    Value := Port[ActivePort+IER];
    Port[ActivePort+IER] := Value and not 2;
    Port[ActivePort+IER] := Value or 2;
  end;
  asm sti end;
end;

procedure comWrite;
var
i:Byte;

begin
for i := 1 to Ord(s[0])do
    send(Ord(s[i]));
end;

procedure comWriteCh;
var
i:Byte;

begin
   send(Ord(c));
end;

procedure comWriteLn;
var
i:Byte;

begin
for i := 1 to Ord(s[0])do
    send(Ord(s[i]));
    send(13);
    send(10);
end;

function comRead;
var
s:string;
    b:byte;

begin
    s := '';
while(read(b))do
    s := s + Chr(b);
    comRead := s;
end;

function comReadCh;
var
s:char;
    b:byte;

begin
read(b);
s := chr(b);
    comReadCh := s;
end;

function comReadLn;
var
  s:string;
  b, pb:byte;

begin
    s := '';
while(read(b))do
      begin
        s := s + Chr(b);
      if (b = 10) and (pb = 13) then
          begin
        comReadLn := s;
            Exit;
          end;
        pb := b;
      end;
    comReadLn := s;
end;

procedure ClearInputBuffer;
begin
FillChar(InputBuffer, 2048, 0);
    InputBufferPos := 0;
end;

END.