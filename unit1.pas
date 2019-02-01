unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

const maxpocet=20;
type
  zoznam=record
         nazov:String;
         kod,mnozstvo,cena:Integer;
         end;
  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Memo1: TMemo;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  polozka:array[1..8]of zoznam;
  subor:textfile;
  hladane:Boolean;
  poradievt,cislopolozky,pocet:Integer;
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
  var j:Integer;
begin

 // Image3.Picture.LoadfromFile('pozadie2.jpg');
  Image2.Picture.LoadfromFile('pozadie1.jpg');
  Image1.Canvas.Fillrect(ClientRect);
  Edit1.Clear;
  Edit2.Text:='0';
  Edit3.Text:='0';
  Edit4.Text:='0';
  Edit5.Text:='0';
  Edit6.Text:='0';
  Edit7.Text:='0';
  Memo1.Clear;

  cislopolozky:=0;

  Assignfile(subor,'tovar.txt');
  Reset(subor);

  while not eof(subor) do
    begin
      inc(cislopolozky);
      Readln(subor,polozka[cislopolozky].nazov);
      Readln(subor,polozka[cislopolozky].cena);
      Readln(subor,polozka[cislopolozky].kod);
      Readln(subor,polozka[cislopolozky].mnozstvo);

    end;
  Closefile(subor);  //cim skor zavriet subor
    pocet:=cislopolozky;

    for j:=1 to cislopolozky do
    begin
    Image1.Canvas.TextOut(50,30+35*j,polozka[j].nazov);
    Image1.Canvas.TextOut(140,30+35*j,InttoStr(polozka[j].cena));
    Image1.Canvas.TextOut(220,30+35*j,InttoStr(polozka[j].kod));
    Image1.Canvas.TextOut(320,30+35*j,InttoStr(polozka[j].mnozstvo));
    end;

    end;

procedure TForm1.Image1Click(Sender: TObject);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  {if  RadioButtonnazov.Checked =true then
    hladane:='nazov'
    else hladane:='kod';

 Memo1.Append(hladane);    }
  Timer1.Enabled:=false; //zastavenie updatovania zoznamu

  cislopolozky:=0;

  repeat
    inc(cislopolozky);
  until
       Edit1.Text=polozka[cislopolozky].nazov;


  { repeat
    inc(i);
   until
       Edit1.Text=InttoStr(polozka[i].kod);   }



  Image1.Canvas.Fillrect(Clientrect);

  Image1.Canvas.TextOut(50,30+30,polozka[cislopolozky].nazov);
  Image1.Canvas.TextOut(140,30+30,InttoStr(polozka[cislopolozky].cena));
  Image1.Canvas.TextOut(220,30+30,InttoStr(polozka[cislopolozky].kod));
  Image1.Canvas.TextOut(320,30+30,InttoStr(polozka[cislopolozky].mnozstvo));

 // if cislopolozky=1 then
  Edit3.Visible:=false;      //vypnutie moznosti objednavania
  Edit4.Visible:=false;
  Edit5.Visible:=false;
  Edit6.Visible:=false;
  Edit7.Visible:=false;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  hladane:=true;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  hladane:=false;
end;

procedure TForm1.Button4Click(Sender: TObject);
  var i:Integer;
begin
   if StrtoInt(Edit2.Text)>0 then
    begin
     polozka[1].mnozstvo:=polozka[1].mnozstvo+StrtoInt(Edit2.Text);
    end;

   if StrtoInt(Edit3.Text)>0 then
    begin
     polozka[2].mnozstvo:=polozka[2].mnozstvo+StrtoInt(Edit3.Text);
    end;

   if StrtoInt(Edit4.Text)>0 then
    begin
     polozka[3].mnozstvo:=polozka[3].mnozstvo+StrtoInt(Edit4.Text);
    end;

   if StrtoInt(Edit5.Text)>0 then
    begin
     polozka[4].mnozstvo:=polozka[4].mnozstvo+StrtoInt(Edit5.Text);
    end;

   if StrtoInt(Edit6.Text)>0 then
    begin
     polozka[5].mnozstvo:=polozka[5].mnozstvo+StrtoInt(Edit6.Text);
    end;

   if StrtoInt(Edit7.Text)>0 then
    begin
     polozka[6].mnozstvo:=polozka[6].mnozstvo+StrtoInt(Edit7.Text);
    end;
 //nejde menit v subore,zapisovat
  Assignfile(subor,'tovar.txt');
  Rewrite(subor);

  for i:=1 to pocet do
    begin
      Writeln(subor,polozka[i].nazov);
      Writeln(subor,polozka[i].cena);
      Writeln(subor,InttoStr(polozka[i].kod));
      Writeln(subor,InttoStr(polozka[i].mnozstvo));
    end;
end;

procedure TForm1.Button5Click(Sender: TObject);
  var j:Integer;
begin
  Edit3.Visible:=true;      //zapnutie  moznosti objednavania
  Edit4.Visible:=true;
  Edit5.Visible:=true;
  Edit6.Visible:=true;
  Edit7.Visible:=true;

  Timer1.Enabled:=true;
  Image1.Canvas.Fillrect(Clientrect);

      for j:=1 to pocet do
    begin
    Image1.Canvas.TextOut(50,30+35*j,polozka[j].nazov);
    Image1.Canvas.TextOut(140,30+35*j,InttoStr(polozka[j].cena));
    Image1.Canvas.TextOut(220,30+35*j,InttoStr(polozka[j].kod));
    Image1.Canvas.TextOut(320,30+35*j,InttoStr(polozka[j].mnozstvo));
    end;
end;

procedure TForm1.Image3Click(Sender: TObject);
begin

end;

procedure TForm1.Label1Click(Sender: TObject);
begin

end;

procedure TForm1.Label2Click(Sender: TObject);
  var i,j,k,pocetTriedenie,najindex,pomocna:Integer;
  triedenieCena:array[1..maxpocet]of Integer;
begin
  Timer1.Enabled:=false;
  Image1.Canvas.Fillrect(Clientrect);


 for i:=1 to pocet do
   begin
     triedenieCena[i]:=i;
   end;



 for pocetTriedenie:= pocet downto 2 do
   begin
     najindex:=1;
     for j:=2 to pocetTriedenie do
       begin
         if polozka[triedenieCena[j]].cena>polozka[triedenieCena[najindex]].cena then
          begin
           najindex:=j;
          end;
         pomocna:=triedenieCena[pocetTriedenie];
         triedenieCena[pocetTriedenie]:=triedenieCena[najindex];
         triedenieCena[najindex]:=pomocna;
       end;
     end;

      for k:=1 to pocet do
        begin
          Image1.Canvas.TextOut(50,30+35*k,polozka[triedenieCena[k]].nazov);
          Image1.Canvas.TextOut(140,30+35*k,InttoStr(polozka[triedenieCena[k]].cena));
          Image1.Canvas.TextOut(220,30+35*k,InttoStr(polozka[triedenieCena[k]].kod));
          Image1.Canvas.TextOut(320,30+35*k ,InttoStr(polozka[triedenieCena[k]].mnozstvo));
        end;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
  var i,j:Integer;
begin
  for i:=1 to pocet do
    begin
    if  polozka[i].mnozstvo<10 then
      begin
        polozka[i].mnozstvo:=20;
      end;
    end;

    Image1.Canvas.Fillrect(Clientrect);

      for j:=1 to pocet do
    begin
    Image1.Canvas.TextOut(50,30+35*j,polozka[j].nazov);
    Image1.Canvas.TextOut(140,30+35*j,InttoStr(polozka[j].cena));
    Image1.Canvas.TextOut(220,30+35*j,InttoStr(polozka[j].kod));
    Image1.Canvas.TextOut(320,30+35*j,InttoStr(polozka[j].mnozstvo));
    end;
end;






end.

