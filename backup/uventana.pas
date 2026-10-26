unit uventana;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids, uvector;

type

  { tform1 }

  tform1 = class(tform)
    button1: tbutton;
    busqbin: tbutton;
    button10: tbutton;
    button11: tbutton;
    button12: tbutton;
    button13: tbutton;
    button14: tbutton;
    button15: tbutton;
    button16: tbutton;
    button17: tbutton;
    button18: tbutton;
    button19: tbutton;
    button20: tbutton;
    button21: tbutton;
    button22: tbutton;
    button23: tbutton;
    button24: tbutton;
    button25: tbutton;
    button26: tbutton;
    button27: tbutton;
    button28: tbutton;
    button29: tbutton;
    button30: tbutton;
    button31: tbutton;
    cargar: tbutton;
    ele2: tedit;
    label2: tlabel;
    label3: tlabel;
    label4: tlabel;
    label5: tlabel;
    label6: tlabel;
    label7: tlabel;
    ordinter: tbutton;
    button2: tbutton;
    button3: tbutton;
    button4: tbutton;
    button5: tbutton;
    button6: tbutton;
    button7: tbutton;
    button8: tbutton;
    button9: tbutton;
    pos: tedit;
    ele: tedit;
    label1: tlabel;
    sg: tstringgrid;
    procedure button1click(sender: tobject);
    procedure button2click(sender: tobject);
    procedure button3click(sender: tobject);
    procedure button4click(sender: tobject);
    procedure button5click(sender: tobject);
    procedure button6click(sender: tobject);
    procedure button7click(sender: tobject);
    procedure button8click(sender: tobject);
    procedure button9click(sender: tobject);
    procedure cargarclick(sender: tobject);
    procedure busqbinclick(sender: tobject);
    procedure button15click(sender: tobject);
    procedure button10click(sender: tobject);
    procedure button11click(sender: tobject);
    procedure button12click(sender: tobject);
    procedure button13click(sender: tobject);
    procedure button14click(sender: tobject);
    procedure button16click(sender: tobject);
    procedure button17click(sender: tobject);
    procedure button18click(sender: tobject);
    procedure button19click(sender: tobject);
    procedure button20click(sender: tobject);
    procedure label7Click(Sender: TObject);
    procedure ordinterclick(sender: tobject);
    procedure button21click(sender: tobject);
    procedure button22click(sender: tobject);
    procedure button23click(sender: tobject);
    procedure button24click(sender: tobject);
    procedure button25click(sender: tobject);
    procedure button26click(sender: tobject);
    procedure button27click(sender: tobject);
    procedure button28click(sender: tobject);
    procedure button29click(sender: tobject);
    procedure button30click(sender: tobject);
    procedure button31click(sender: tobject);
    procedure formclick(sender: tobject);
  private
    v,a,b,c:tvector;
    procedure updatesg();
  public

  end;

var
  form1: tform1;

implementation

{$R *.lfm}

procedure tform1.updatesg();
var
  des:integer;
begin
  sg.colcount:=v.getdim();
  for des:=1 to v.getdim() do
    sg.cells[des-1,0]:=inttostr(v.getelem(des));
end;

procedure tform1.button1click(sender: tobject);
begin
  v:=tvector.crear();
  a:= tvector.crear();
  b:= tvector.crear();
  c:= tvector.crear();
  updatesg();
  showmessage('Vector inicializado...');
end;

procedure tform1.button31click(sender: tobject);
begin
  v.limpiar();
  a.limpiar();
  b.limpiar();
  c.limpiar();
  pos.text := '';
  ele.text := '';
  ele2.text := '';
  updatesg();
  showmessage('Todo limpio y reiniciado.');
end;

procedure tform1.button9click(sender: tobject);
begin
  close();
end;

procedure tform1.button3click(sender: tobject);
begin
  pos.text:=inttostr(v.getdim());
end;

procedure tform1.button2click(sender: tobject);
begin
  v.setdim(strtoint(pos.text));
  updatesg();
  pos.text:='';
end;

procedure tform1.button5click(sender: tobject);
begin
  ele.text:=inttostr(v.getelem(strtoint(pos.text)));
  pos.text:='';
end;

procedure tform1.button4click(sender: tobject);
begin
  v.setelem(strtoint(pos.text),strtoint(ele.text));
  updatesg();
  pos.text:='';
  ele.text:='';
end;

procedure tform1.button6click(sender: tobject);
begin
  v.addelem(strtoint(ele.text));
  updatesg();
  ele.text:='';
end;

procedure tform1.button8click(sender: tobject);
begin
  v.remelem(strtoint(pos.text));
  updatesg();
  pos.text:='';
end;

procedure tform1.button7click(sender: tobject);
begin
  v.inselem(strtoint(pos.text),strtoint(ele.text));
  updatesg();
  pos.text:='';
  ele.text:='';
end;

procedure tform1.cargarclick(sender: tobject);
var
  cant: integer;
begin
  if pos.text <> '' then
  begin
    cant := strtoint(pos.text);
    v.cargar(cant, 1, 100);
    updatesg();
    pos.text := '';
    showmessage('Vector cargado con ' + inttostr(cant) + ' elementos aleatorios.');
  end
  else
    showmessage('Ingresa la cantidad de elementos en la casilla Posicion.');
end;

procedure tform1.button23click(sender: tobject);
begin
  v.cargadefinida('Vector V');
  updatesg();
end;

procedure tform1.busqbinclick(sender: tobject);
var
  pose:integer;
begin
  pose:= v.busqbin(strtoint(ele.text));
  pos.text:=inttostr(pose);
  ele.text:='';
  sg.row:=0;
  sg.col:=pose-1;
  sg.setfocus;
end;

procedure tform1.button15click(sender: tobject);
var
  elembuscado, posencontrada: integer;
begin
  if ele.text <> '' then
  begin
    elembuscado := strtoint(ele.text);
    posencontrada := v.busqsec(elembuscado);
    if posencontrada <> -1 then
    begin
      pos.text := inttostr(posencontrada);
      showmessage('Elemento ' + inttostr(elembuscado) + ' encontrado en la posición: ' + inttostr(posencontrada));
    end
    else
      showmessage('El elemento ' + inttostr(elembuscado) + ' no existe en el vector.');
  end
  else
    showmessage('Ingresa el elemento a buscar en la casilla ELE.');
end;

procedure tform1.button10click(sender: tobject);
begin
  updatesg();
  showmessage('Vector actual: ' + v.comostring());
end;

procedure tform1.button11click(sender: tobject);
begin
  showmessage('Vector en String: ' + v.comostring());
end;

procedure tform1.button12click(sender: tobject);
begin
  if v.getdim() > 0 then
  begin
    v.invertir();
    updatesg();
  end
  else
    showmessage('El vector está vacío. Carga o adiciona elementos primero.');
end;

procedure tform1.button14click(sender: tobject);
begin
  if v.getdim() > 0 then
  begin
    v.rotarizquierda();
    updatesg();
  end
  else
    showmessage('El vector está vacío.');
end;

procedure tform1.button13click(sender: tobject);
begin
  if v.getdim() > 0 then
  begin
    v.rotarderecha();
    updatesg();
  end
  else
    showmessage('El vector está vacío.');
end;

procedure tform1.button16click(sender: tobject);
begin
  v.ordburbuja();
  updatesg();
end;

procedure tform1.button17click(sender: tobject);
begin
  v.ordseleccion();
  updatesg();
end;

procedure tform1.button18click(sender: tobject);
begin
  v.ordinsercion();
  updatesg();
end;

procedure tform1.button20click(sender: tobject);
begin
  v.ordshell();
  updatesg();
end;

procedure tform1.label7Click(Sender: TObject);
begin

end;

procedure tform1.button19click(sender: tobject);
begin
  v.ordquicksort();
  updatesg();
end;

procedure tform1.ordinterclick(sender: tobject);
begin
  v.ord_inter();
  updatesg();
end;

procedure tform1.button21click(sender: tobject);
begin
  if v.getdim() > 0 then
  begin
    v.eliminarrep();
    updatesg();
  end
  else
    showmessage('El vector está vacío.');
end;

procedure tform1.button22click(sender: tobject);
begin
  if v.getdim() > 0 then
  begin
    v.ordenarfrec();
    updatesg();
  end
  else
    showmessage('El vector está vacío.');
end;

procedure tform1.button24click(sender: tobject);
begin
  v.purgar();
  updatesg();
end;

procedure tform1.button25click(sender: tobject);
begin
  v.dividirparimpar(a,b);
  pos.text:='A='+a.tostring();
  ele.text:='B='+b.tostring();
end;

procedure tform1.button29click(sender: tobject);
begin
  if v.getdim() > 0 then
  begin
    v.dividirprimosnoprimos(a, b);
    pos.text := 'Primos = ' + a.comostring();
    ele.text := 'No Primos = ' + b.comostring();
    showmessage('Vector dividido en Primos y No Primos con éxito.');
  end
  else
    showmessage('El vector principal V está vacío. Cárgalo primero.');
end;

procedure tform1.button30click(sender: tobject);
begin
  if v.getdim() > 0 then
  begin
    v.dividirmultiplos(a, b, c);
    pos.text  := 'Mul. 2 = ' + a.comostring();
    ele.text  := 'Mul. 3 = ' + b.comostring();
    ele2.text := 'Mul. 5 = ' + c.comostring();
  end
  else
    showmessage('El vector principal V está vacío.');
end;

procedure tform1.button28click(sender: tobject);
begin
  a.cargadefinida('Vector A');
  pos.text := a.comostring();
  b.cargadefinida('Vector B');
  ele.text := b.comostring();
  v.intercalar(a, b);
  updatesg();
end;

procedure tform1.button26click(sender: tobject);
begin
  if v.getdim() > 0 then
    showmessage('La cantidad de cortes es: ' + inttostr(v.cantidaddecortes()))
  else
    showmessage('El vector está vacío.');
end;

procedure tform1.button27click(sender: tobject);
begin
  if v.getdim() > 0 then
    showmessage(v.elementosentrecortestexto())
  else
    showmessage('El vector está vacío.');
end;

procedure tform1.formclick(sender: tobject);
begin
  showmessage('Cantidad de cortes: ' + inttostr(v.cantidaddecortes()));
end;

end.
