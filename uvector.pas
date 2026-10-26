unit uvector;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Dialogs;
const
  max_elem=1000;
type
    tvector=class
      private
        dim:integer;
        elem:array[1..max_elem] of integer;
      public
        constructor crear();
        procedure limpiar();
        function getdim():integer;
        procedure setdim(dimen:integer);
        function getelem(pos:integer):integer;
        procedure setelem(pos,ele:integer);
        procedure addelem(ele:integer);
        procedure remelem(pos:integer);
        procedure inselem(pos,ele:integer);
        function busqsec(x: integer): integer;
        function busqbin(ele:integer):integer;
        procedure cargar(n, a, b: integer);
        procedure cargadefinida(nombre: string);
        function comostring(): string;
        function tostring():string;
        procedure invertir();
        procedure rotarizquierda();
        procedure rotarderecha();
        procedure ordburbuja();
        procedure ordseleccion();
        procedure ordinsercion();
        procedure ordshell();
        procedure ordquicksort();
        procedure ord_inter();
        procedure eliminarrep();
        procedure ordenarfrec();
        procedure purgar();
        function esprimo(n: integer): boolean;
        procedure dividirparimpar(var a, b: tvector);
        procedure dividirprimosnoprimos(var a, b: tvector);
        procedure dividirmultiplos(var a, b, c: tvector);
        procedure intercalar(a, b: tvector);
        function cantidaddecortes(): integer;
        function elementosentrecortestexto(): string;
      end;
implementation

constructor tvector.crear();
var
  pos:integer;
begin
  dim:=0;
  pos:=1;
  while(pos<=max_elem)do
  begin
    elem[pos]:=0;
    pos:=pos+1;
  end;
end;

procedure tvector.limpiar();
begin
  dim := 0;
end;

function tvector.getdim(): integer;
begin
  result:=dim;
end;

procedure tvector.setdim(dimen: integer);
begin
  if(dimen>=0)and(dimen<=max_elem)then
    dim:=dimen
  else
    showmessage('TVector.setDim: Dimension fuera de rango... ');
end;

function tvector.getelem(pos: integer): integer;
begin
  if(pos>=1)and(pos<=dim)then
    result:=elem[pos]
  else
    result:=-999;
end;

procedure tvector.setelem(pos, ele: integer);
begin
  if(pos>=1)and(pos<=dim)then
    elem[pos]:=ele
  else
    showmessage('TVector.setElem: Posicion fuera de rango... ');
end;

procedure tvector.addelem(ele: integer);
begin
  if(dim<max_elem)then
  begin
    dim:=dim+1;
    elem[dim]:=ele;
  end
  else
    showmessage('TVector.addElem: Almacenamiento lleno... ');
end;

procedure tvector.remelem(pos: integer);
var
  d:integer;
begin
  if(pos>=1)and(pos<=dim)then
  begin
    d:=pos;
    while(d<dim)do
    begin
      elem[d]:=elem[d+1];
      d:=d+1;
    end;
    dim:=dim-1;
  end
  else
    showmessage('TVector.remElem: Posicion fuera de rango...');
end;

procedure tvector.inselem(pos, ele: integer);
var
  d:integer;
begin
  if(dim<max_elem)then
  begin
    if(pos>=1)and(pos<=dim)then
    begin
      d:=dim;
      while(d>=pos)do
      begin
        elem[d+1]:=elem[d];
        d:=d-1;
      end;
      elem[pos]:=ele;
      dim:=dim+1;
    end
    else
      showmessage('TVector.insElem: Posicion fuera de rango...');
  end
  else
    showmessage('TVector.insElem: Almacenamiento lleno...');
end;

function tvector.busqsec(x: integer): integer;
var
  i, pos: integer;
begin
  pos := -1;
  i := 1;
  while (i <= dim) and (pos = -1) do
  begin
    if elem[i] = x then
      pos := i;
    inc(i);
  end;
  result := pos;
end;

function tvector.busqbin(ele: integer): integer;
var
  ini,fin,medio:integer;
  sw:boolean;
begin
  ini:=1;
  fin:=dim;
  sw:=false;
  while(ini<=fin)and (not sw)do
  begin
    medio:=(fin+ini)div 2;
    if(elem[medio]=ele)then
      sw:=true
    else
      if(elem[medio]>ele)then
        fin:=medio-1
      else
        ini:=medio+1;
  end;
  if(sw)then
    result:=medio
  else
    result:=-1;
end;

procedure tvector.cargar(n, a, b: integer);
var
  i: integer;
begin
  randomize;
  if (n >= 1) and (n <= max_elem) then
  begin
    dim := n;
    for i := 1 to dim do
      elem[i] := a + random(b - a + 1);
  end
  else
    showmessage('TVector.cargar: Cantidad fuera de rango...');
end;

procedure tvector.cargadefinida(nombre: string);
var
  pos: integer;
begin
  dim := strtoint(inputbox('Cargar ' + nombre, 'Dimension de ' + nombre + ':', '0'));
  for pos := 1 to dim do
    elem[pos] := strtoint(inputbox('Cargar ' + nombre, nombre + '[' + inttostr(pos) + '] = ', '0'));
end;

function tvector.comostring(): string;
var
  i: integer;
  s: string;
begin
  s := '[';
  for i := 1 to dim do
  begin
    s := s + inttostr(elem[i]);
    if i < dim then
      s := s + ', ';
  end;
  s := s + ']';
  result := s;
end;

function tvector.tostring(): string;
var
  des: integer;
  cad: string;
begin
  cad := '[ ';
  for des := 1 to dim - 1 do
    cad := cad + inttostr(elem[des]) + ', ';
  cad := cad + inttostr(elem[dim]) + ' ]';
  result := cad;
end;

procedure tvector.invertir();
var
  i, aux: integer;
begin
  for i := 1 to (dim div 2) do
  begin
    aux := elem[i];
    elem[i] := elem[dim - i + 1];
    elem[dim - i + 1] := aux;
  end;
end;

procedure tvector.rotarizquierda();
var
  i, primero: integer;
begin
  if dim > 1 then
  begin
    primero := elem[1];
    for i := 1 to dim - 1 do
      elem[i] := elem[i + 1];
    elem[dim] := primero;
  end;
end;

procedure tvector.rotarderecha();
var
  i, ultimo: integer;
begin
  if dim > 1 then
  begin
    ultimo := elem[dim];
    for i := dim downto 2 do
      elem[i] := elem[i - 1];
    elem[1] := ultimo;
  end;
end;

procedure tvector.ordburbuja();
var
  i, j, aux: integer;
begin
  for i := 1 to dim - 1 do
  begin
    for j := 1 to dim - i do
    begin
      if elem[j] > elem[j + 1] then
      begin
        aux := elem[j];
        elem[j] := elem[j + 1];
        elem[j + 1] := aux;
      end;
    end;
  end;
end;

procedure tvector.ordseleccion();
var
  i, j, minpos, aux: integer;
begin
  for i := 1 to dim - 1 do
  begin
    minpos := i;
    for j := i + 1 to dim do
    begin
      if elem[j] < elem[minpos] then
        minpos := j;
    end;
    if minpos <> i then
    begin
      aux := elem[i];
      elem[i] := elem[minpos];
      elem[minpos] := aux;
    end;
  end;
end;

procedure tvector.ordinsercion();
var
  i, j, clave: integer;
begin
  for i := 2 to dim do
  begin
    clave := elem[i];
    j := i - 1;
    while (j >= 1) and (elem[j] > clave) do
    begin
      elem[j + 1] := elem[j];
      dec(j);
    end;
    elem[j + 1] := clave;
  end;
end;

procedure tvector.ordshell();
var
  i, j, salto, aux: integer;
begin
  salto := dim div 2;
  while salto > 0 do
  begin
    for i := salto + 1 to dim do
    begin
      aux := elem[i];
      j := i;
      while (j > salto) and (elem[j - salto] > aux) do
      begin
        elem[j] := elem[j - salto];
        j := j - salto;
      end;
      elem[j] := aux;
    end;
    salto := salto div 2;
  end;
end;

procedure tvector.ordquicksort();
  procedure quick(izq, der: integer);
  var
    i, j, pivote, aux: integer;
  begin
    i := izq;
    j := der;
    pivote := elem[(izq + der) div 2];
    repeat
      while elem[i] < pivote do inc(i);
      while elem[j] > pivote do dec(j);
      if i <= j then
      begin
        aux := elem[i];
        elem[i] := elem[j];
        elem[j] := aux;
        inc(i);
        dec(j);
      end;
    until i > j;
    if izq < j then quick(izq, j);
    if i < der then quick(i, der);
  end;
begin
  if dim > 1 then
    quick(1, dim);
end;

procedure tvector.ord_inter();
var
  p,d,aux:integer;
begin
  for p:=1 to dim-1 do
  begin
    for d:=p+1 to dim do
    begin
      if(elem[d]<elem[p])then
      begin
        aux:=elem[d];
        elem[d]:=elem[p];
        elem[p]:=aux;
      end;
    end;
  end;
end;

procedure tvector.eliminarrep();
var
  i, j, k: integer;
begin
  i := 1;
  while i < dim do
  begin
    j := i + 1;
    while j <= dim do
    begin
      if elem[j] = elem[i] then
      begin
        for k := j to dim - 1 do
          elem[k] := elem[k + 1];
        dec(dim);
      end
      else
        inc(j);
    end;
    inc(i);
  end;
end;

procedure tvector.ordenarfrec();
  function contarfrecuencia(x: integer): integer;
  var
    k, cant: integer;
  begin
    cant := 0;
    for k := 1 to dim do
    begin
      if elem[k] = x then
        inc(cant);
    end;
    result := cant;
  end;

var
  i, j, aux: integer;
  freci, frecj: integer;
begin
  for i := 1 to dim - 1 do
  begin
    for j := i + 1 to dim do
    begin
      freci := contarfrecuencia(elem[i]);
      frecj := contarfrecuencia(elem[j]);
      if (frecj > freci) or ((frecj = freci) and (elem[j] < elem[i])) then
      begin
        aux := elem[i];
        elem[i] := elem[j];
        elem[j] := aux;
      end;
    end;
  end;
end;

procedure tvector.purgar();
var
  pos, des: integer;
begin
  pos := 1;
  while (pos <= dim) do
  begin
    des := pos + 1;
    while (des <= dim) do
    begin
      if (elem[pos] = elem[des]) then
        remelem(des)
      else
        des := des + 1;
    end;
    pos := pos + 1;
  end;
end;

function tvector.esprimo(n: integer): boolean;
var
  i, c: integer;
begin
  if n <= 1 then
    result := false
  else
  begin
    c := 0;
    for i := 1 to n do
    begin
      if (n mod i = 0) then
        c := c + 1;
    end;
    result := (c = 2);
  end;
end;

procedure tvector.dividirparimpar(var a, b: tvector);
var
  i: integer;
begin
  i := 1;
  a.setdim(0);
  b.setdim(0);
  while (i <= dim) do
  begin
    if (elem[i] mod 2 = 0) then
      a.addelem(elem[i])
    else
      b.addelem(elem[i]);
    i := i + 1;
  end;
end;

procedure tvector.dividirprimosnoprimos(var a, b: tvector);
var
  i: integer;
begin
  i := 1;
  a.setdim(0);
  b.setdim(0);
  while (i <= dim) do
  begin
    if esprimo(elem[i]) then
      a.addelem(elem[i])
    else
      b.addelem(elem[i]);
    i := i + 1;
  end;
end;

procedure tvector.dividirmultiplos(var a, b, c: tvector);
var
  i: integer;
begin
  i := 1;
  a.setdim(0);
  b.setdim(0);
  c.setdim(0);
  while (i <= dim) do
  begin
    if (elem[i] mod 2 = 0) then
      a.addelem(elem[i]);
    if (elem[i] mod 3 = 0) then
      b.addelem(elem[i]);
    if (elem[i] mod 5 = 0) then
      c.addelem(elem[i]);
    i := i + 1;
  end;
end;

procedure tvector.intercalar(a, b: tvector);
var
  i, j: integer;
begin
  setdim(0);
  i := 1;
  j := 1;
  while (i <= a.getdim()) or (j <= b.getdim()) do
  begin
    if (i <= a.getdim()) then
    begin
      addelem(a.getelem(i));
      i := i + 1;
    end;
    if (j <= b.getdim()) then
    begin
      addelem(b.getelem(j));
      j := j + 1;
    end;
  end;
end;

function tvector.cantidaddecortes(): integer;
var
  i, c: integer;
begin
  i := 1;
  c := 0;
  while (i < dim) do
  begin
    if (elem[i] <> elem[i + 1]) then
      c := c + 1;
    i := i + 1;
  end;
  result := c;
end;

function tvector.elementosentrecortestexto(): string;
var
  i, cont: integer;
  cad: string;
begin
  cad := '';
  if dim > 0 then
  begin
    i := 1;
    while (i <= dim) do
    begin
      cont := 1;
      while (i < dim) and (elem[i] = elem[i + 1]) do
      begin
        cont := cont + 1;
        i := i + 1;
      end;
      cad := cad + 'El elemento ' + inttostr(elem[i]) + ' se repite ' + inttostr(cont) + ' veces.' + slinebreak;
      i := i + 1;
    end;
  end;
  result := cad;
end;

end.
