unit types3;
interface
const maxreserved=123;
      buffsize=100;
type    id_=word;
        sex_=(male,female);

        table = record n:byte;size:word; a:array[0..80]of word;end;
        man=object
                id:id_;
                sex:sex_;
                f,i,o:string[20];
                papa,mama:id_;
                ldeti,lsupr:word;
                supr,deti:array[0..20]of id_;
                born,bornm,bornd:word;

                rezerved:array[0..maxreserved]of byte;
                constructor create(s:sex_;ooo:word);
                procedure adddeti(ik:id_);
                procedure addmama(ik:id_);
                procedure addpapa(ik:id_);
                procedure addsupr(ik:id_);
        end;
        info=array[0..sizeof(man)]of byte;

const notsex:array[male..female]of sex_=(female,male);
implementation

procedure man.addmama;
        begin
        if ik=0 then exit;
        mama:=ik;
        end;
procedure man.addpapa;
        begin
        if ik=0 then exit;
        papa:=ik;
        end;
procedure man.adddeti;
        begin
        if ik=0 then exit;
        deti[ldeti]:=ik;
        inc(ldeti);
        end;
procedure man.addsupr;
        begin
        if ik=0 then exit;
        supr[lsupr]:=ik;
        inc(lsupr);
        end;
constructor man.create;
        begin
        FillChar(self,sizeof(self),0);
        sex:=s;
        id:=ooo;
        f:='';
        i:='';
        o:='';
        born:=0;
        bornd:=0;
        bornm:=0;
        end;


end.
