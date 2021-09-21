unit pu_ondelettes;

{
Copyright (C) Philippe Martinole

http://www.teleauto.org/
philippe.martinole@teleauto.org

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, Editnbre, pu_image, u_class, Spin;

type
  Tpop_ondelettes = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    NbreEdit1: NbreEdit;
    NbreEdit2: NbreEdit;
    NbreEdit3: NbreEdit;
    NbreEdit4: NbreEdit;
    NbreEdit5: NbreEdit;
    NbreEdit6: NbreEdit;
    NbreEdit7: NbreEdit;
    NbreEdit8: NbreEdit;
    NbreEdit9: NbreEdit;
    NbreEdit10: NbreEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    SpinButton1: TSpinButton;
    SpinButton2: TSpinButton;
    SpinButton3: TSpinButton;
    SpinButton4: TSpinButton;
    SpinButton5: TSpinButton;
    SpinButton6: TSpinButton;
    SpinButton7: TSpinButton;
    SpinButton8: TSpinButton;
    SpinButton9: TSpinButton;
    SpinButton10: TSpinButton;
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure SpinButton2DownClick(Sender: TObject);
    procedure SpinButton3DownClick(Sender: TObject);
    procedure SpinButton4DownClick(Sender: TObject);
    procedure SpinButton5DownClick(Sender: TObject);
    procedure SpinButton6DownClick(Sender: TObject);
    procedure SpinButton7DownClick(Sender: TObject);
    procedure SpinButton8DownClick(Sender: TObject);
    procedure SpinButton9DownClick(Sender: TObject);
    procedure SpinButton10DownClick(Sender: TObject);
    procedure SpinButton2UpClick(Sender: TObject);
    procedure SpinButton3UpClick(Sender: TObject);
    procedure SpinButton4UpClick(Sender: TObject);
    procedure SpinButton5UpClick(Sender: TObject);
    procedure SpinButton6UpClick(Sender: TObject);
    procedure SpinButton7UpClick(Sender: TObject);
    procedure SpinButton8UpClick(Sender: TObject);
    procedure SpinButton9UpClick(Sender: TObject);
    procedure SpinButton10UpClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    pop_image:Tpop_image;
    NbOnd,LargX,LargY:Integer;
    ImgOut:PTabTabImgDouble;
    TypeData,NbPlans:Integer;
    ImgIntNil:PTabImgInt;
    procedure FreeImgOut;
  end;

var
  pop_ondelettes: Tpop_ondelettes;

implementation

{$R *.DFM}

uses u_lang,
     u_filtrage,
     u_arithmetique,
     u_general;

procedure Tpop_ondelettes.FormShow(Sender: TObject);
var
   i:Integer;
   Compo:TComponent;
begin
   if TraductionEnCours then Exit;
   Left:=Screen.Width-Width;
   UpDateLang(Self);
   pop_image.SaveUndo;
   ExtractOndelettes(pop_image.DataInt,pop_image.DataDouble,ImgOut,pop_image.ImgInfos.NbPlans,pop_image.ImgInfos.TypeData,
      pop_image.ImgInfos.Sx,pop_image.ImgInfos.Sy,NbOnd);
   GetmemImg(pop_image.DataInt,pop_image.DataDouble,LargX,LargY,TypeData,NbPlans);
   pop_image.ImgInfos.TypeData:=TypeData;
   pop_image.ImgInfos.NbPlans:=NbPLans;

   for i:=NbOnd+1 to 10 do
      begin
      Compo:=FindComponent('NbreEdit'+IntToStr(i)); //nolang
      (Compo as NbreEdit).Visible:=False;

      Compo:=FindComponent('Button'+IntToStr(i)); //nolang
      (Compo as TButton).Visible:=False;

      Compo:=FindComponent('Label'+IntToStr(i)); //nolang
      (Compo as TLabel).Visible:=False;

      Compo:=FindComponent('SpinButton'+IntToStr(i)); //nolang
      (Compo as TSpinButton).Visible:=False;
      end;

   Button11.Top:=4+24*NbOnd;
   BitBtn1.Top:=Button11.Top+29;
   BitBtn2.Top:=Button11.Top+29;
   ClientHeight:=Button11.Top+58;
end;

procedure Tpop_ondelettes.FreeImgOut;
var
   j,k,l:Integer;
begin
   for l:=1 to NbOnd+1 do
      begin
      for k:=1 to NbPlans do
         begin
         for j:=1 to LargY do Freemem(ImgOut^[l]^[k]^[j],LargX*8);
         Freemem(ImgOut^[l]^[k],4*LargY);
         end;
      Freemem(ImgOut^[l],4*NbPlans);
      end;
   Freemem(ImgOut,4*NbOnd+1);
end;

procedure Tpop_ondelettes.BitBtn2Click(Sender: TObject);
begin
   pop_image.RestaureUndo;
   FreeImgOut;
   Close;
end;

procedure Tpop_ondelettes.BitBtn1Click(Sender: TObject);
begin
   FreeImgOut;
   Close;
end;

procedure Tpop_ondelettes.Button1Click(Sender: TObject);
begin
   Transfert(ImgIntNil,ImgIntNil,ImgOut^[1],pop_image.DataDouble,TypeData,NbPlans,pop_image.ImgInfos.Sx,pop_image.ImgInfos.Sy);
   pop_image.AjusteFenetre;
   pop_image.VisuAutoEtoiles;
end;

procedure Tpop_ondelettes.Button2Click(Sender: TObject);
begin
   Transfert(ImgIntNil,ImgIntNil,ImgOut^[2],pop_image.DataDouble,TypeData,NbPlans,pop_image.ImgInfos.Sx,pop_image.ImgInfos.Sy);
   pop_image.AjusteFenetre;
   pop_image.VisuAutoEtoiles;
end;

procedure Tpop_ondelettes.Button3Click(Sender: TObject);
begin
   Transfert(ImgIntNil,ImgIntNil,ImgOut^[3],pop_image.DataDouble,TypeData,NbPlans,pop_image.ImgInfos.Sx,pop_image.ImgInfos.Sy);
   pop_image.AjusteFenetre;
   pop_image.VisuAutoEtoiles;
end;

procedure Tpop_ondelettes.Button4Click(Sender: TObject);
begin
   Transfert(ImgIntNil,ImgIntNil,ImgOut^[4],pop_image.DataDouble,TypeData,NbPlans,pop_image.ImgInfos.Sx,pop_image.ImgInfos.Sy);
   pop_image.AjusteFenetre;
   pop_image.VisuAutoEtoiles;
end;

procedure Tpop_ondelettes.Button5Click(Sender: TObject);
begin
   Transfert(ImgIntNil,ImgIntNil,ImgOut^[5],pop_image.DataDouble,TypeData,NbPlans,pop_image.ImgInfos.Sx,pop_image.ImgInfos.Sy);
   pop_image.AjusteFenetre;
   pop_image.VisuAutoEtoiles;
end;

procedure Tpop_ondelettes.Button6Click(Sender: TObject);
begin
   Transfert(ImgIntNil,ImgIntNil,ImgOut^[6],pop_image.DataDouble,TypeData,NbPlans,pop_image.ImgInfos.Sx,pop_image.ImgInfos.Sy);
   pop_image.AjusteFenetre;
   pop_image.VisuAutoEtoiles;
end;

procedure Tpop_ondelettes.Button7Click(Sender: TObject);
begin
   Transfert(ImgIntNil,ImgIntNil,ImgOut^[7],pop_image.DataDouble,TypeData,NbPlans,pop_image.ImgInfos.Sx,pop_image.ImgInfos.Sy);
   pop_image.AjusteFenetre;
   pop_image.VisuAutoEtoiles;
end;

procedure Tpop_ondelettes.Button8Click(Sender: TObject);
begin
   Transfert(ImgIntNil,ImgIntNil,ImgOut^[8],pop_image.DataDouble,TypeData,NbPlans,pop_image.ImgInfos.Sx,pop_image.ImgInfos.Sy);
   pop_image.AjusteFenetre;
   pop_image.VisuAutoEtoiles;
end;

procedure Tpop_ondelettes.Button9Click(Sender: TObject);
begin
   Transfert(ImgIntNil,ImgIntNil,ImgOut^[9],pop_image.DataDouble,TypeData,NbPlans,pop_image.ImgInfos.Sx,pop_image.ImgInfos.Sy);
   pop_image.AjusteFenetre;
   pop_image.VisuAutoEtoiles;
end;

procedure Tpop_ondelettes.Button10Click(Sender: TObject);
begin
   Transfert(ImgIntNil,ImgIntNil,ImgOut^[10],pop_image.DataDouble,TypeData,NbPlans,pop_image.ImgInfos.Sx,pop_image.ImgInfos.Sy);
   pop_image.AjusteFenetre;
   pop_image.VisuAutoEtoiles;
end;

procedure Tpop_ondelettes.Button11Click(Sender: TObject);
var
   i,j,k,l:Integer;
   Compo:TComponent;
   Mult:Double;
begin
   // On efface l'image
   for k :=1 to NbPlans do
      for j:=1 to LargY do FillChar(pop_image.DataDouble[k]^[j]^,LargX*8,0);

   // On additionne les plans
   for l:=1 to NbOnd+1 do
      begin
      Compo:=FindComponent('NbreEdit'+IntToStr(l)); //nolang
      Mult:=MyStrToFloat((Compo as NbreEdit).Text);
      for k:=1 to NbPlans do
         for j:=1 to LargY do
            for i:=1 to LargX do
               pop_image.DataDouble[k]^[j]^[i]:=pop_image.DataDouble[k]^[j]^[i]+
                  ImgOut^[l]^[k]^[j]^[i]*Mult;
      end;

   pop_image.AjusteFenetre;
   pop_image.VisuAutoEtoiles;
end;

procedure Tpop_ondelettes.SpinButton1DownClick(Sender: TObject);
var
   Valeur:Double;
begin
   Valeur:=MySTrToFloat(NbreEdit1.Text);
   if Valeur>=1 then Valeur:=Valeur-1;
   NbreEdit1.Text:=FloatToStr(Valeur);
end;

procedure Tpop_ondelettes.SpinButton1UpClick(Sender: TObject);
var
   Valeur:Double;
begin
   Valeur:=MySTrToFloat(NbreEdit1.Text);
   Valeur:=Valeur+1;
   NbreEdit1.Text:=FloatToStr(Valeur);
end;

procedure Tpop_ondelettes.SpinButton2DownClick(Sender: TObject);
var
   Valeur:Double;
begin
   Valeur:=MySTrToFloat(NbreEdit2.Text);
   if Valeur>=1 then Valeur:=Valeur-1;
   NbreEdit2.Text:=FloatToStr(Valeur);
end;

procedure Tpop_ondelettes.SpinButton3DownClick(Sender: TObject);
var
   Valeur:Double;
begin
   Valeur:=MySTrToFloat(NbreEdit3.Text);
   if Valeur>=1 then Valeur:=Valeur-1;
   NbreEdit3.Text:=FloatToStr(Valeur);
end;

procedure Tpop_ondelettes.SpinButton4DownClick(Sender: TObject);
var
   Valeur:Double;
begin
   Valeur:=MySTrToFloat(NbreEdit4.Text);
   if Valeur>=1 then Valeur:=Valeur-1;
   NbreEdit4.Text:=FloatToStr(Valeur);
end;

procedure Tpop_ondelettes.SpinButton5DownClick(Sender: TObject);
var
   Valeur:Double;
begin
   Valeur:=MySTrToFloat(NbreEdit5.Text);
   if Valeur>=1 then Valeur:=Valeur-1;
   NbreEdit5.Text:=FloatToStr(Valeur);
end;

procedure Tpop_ondelettes.SpinButton6DownClick(Sender: TObject);
var
   Valeur:Double;
begin
   Valeur:=MySTrToFloat(NbreEdit6.Text);
   if Valeur>=1 then Valeur:=Valeur-1;
   NbreEdit6.Text:=FloatToStr(Valeur);
end;

procedure Tpop_ondelettes.SpinButton7DownClick(Sender: TObject);
var
   Valeur:Double;
begin
   Valeur:=MySTrToFloat(NbreEdit7.Text);
   if Valeur>=1 then Valeur:=Valeur-1;
   NbreEdit7.Text:=FloatToStr(Valeur);
end;

procedure Tpop_ondelettes.SpinButton8DownClick(Sender: TObject);
var
   Valeur:Double;
begin
   Valeur:=MySTrToFloat(NbreEdit8.Text);
   if Valeur>=1 then Valeur:=Valeur-1;
   NbreEdit8.Text:=FloatToStr(Valeur);
end;

procedure Tpop_ondelettes.SpinButton9DownClick(Sender: TObject);
var
   Valeur:Double;
begin
   Valeur:=MySTrToFloat(NbreEdit9.Text);
   if Valeur>=1 then Valeur:=Valeur-1;
   NbreEdit9.Text:=FloatToStr(Valeur);
end;

procedure Tpop_ondelettes.SpinButton10DownClick(Sender: TObject);
var
   Valeur:Double;
begin
   Valeur:=MySTrToFloat(NbreEdit10.Text);
   if Valeur>=1 then Valeur:=Valeur-1;
   NbreEdit10.Text:=FloatToStr(Valeur);
end;

procedure Tpop_ondelettes.SpinButton2UpClick(Sender: TObject);
var
   Valeur:Double;
begin
   Valeur:=MySTrToFloat(NbreEdit2.Text);
   Valeur:=Valeur+1;
   NbreEdit2.Text:=FloatToStr(Valeur);
end;

procedure Tpop_ondelettes.SpinButton3UpClick(Sender: TObject);
var
   Valeur:Double;
begin
   Valeur:=MySTrToFloat(NbreEdit3.Text);
   Valeur:=Valeur+1;
   NbreEdit3.Text:=FloatToStr(Valeur);
end;

procedure Tpop_ondelettes.SpinButton4UpClick(Sender: TObject);
var
   Valeur:Double;
begin
   Valeur:=MySTrToFloat(NbreEdit4.Text);
   Valeur:=Valeur+1;
   NbreEdit4.Text:=FloatToStr(Valeur);
end;

procedure Tpop_ondelettes.SpinButton5UpClick(Sender: TObject);
var
   Valeur:Double;
begin
   Valeur:=MySTrToFloat(NbreEdit5.Text);
   Valeur:=Valeur+1;
   NbreEdit5.Text:=FloatToStr(Valeur);
end;

procedure Tpop_ondelettes.SpinButton6UpClick(Sender: TObject);
var
   Valeur:Double;
begin
   Valeur:=MySTrToFloat(NbreEdit6.Text);
   Valeur:=Valeur+1;
   NbreEdit6.Text:=FloatToStr(Valeur);
end;

procedure Tpop_ondelettes.SpinButton7UpClick(Sender: TObject);
var
   Valeur:Double;
begin
   Valeur:=MySTrToFloat(NbreEdit7.Text);
   Valeur:=Valeur+1;
   NbreEdit7.Text:=FloatToStr(Valeur);
end;

procedure Tpop_ondelettes.SpinButton8UpClick(Sender: TObject);
var
   Valeur:Double;
begin
   Valeur:=MySTrToFloat(NbreEdit8.Text);
   Valeur:=Valeur+1;
   NbreEdit8.Text:=FloatToStr(Valeur);
end;

procedure Tpop_ondelettes.SpinButton9UpClick(Sender: TObject);
var
   Valeur:Double;
begin
   Valeur:=MySTrToFloat(NbreEdit9.Text);
   Valeur:=Valeur+1;
   NbreEdit9.Text:=FloatToStr(Valeur);
end;

procedure Tpop_ondelettes.SpinButton10UpClick(Sender: TObject);
var
   Valeur:Double;
begin
   Valeur:=MySTrToFloat(NbreEdit10.Text);
   Valeur:=Valeur+1;
   NbreEdit10.Text:=FloatToStr(Valeur);
end;

procedure Tpop_ondelettes.Label1Click(Sender: TObject);
var
   i:Integer;
   Val:Double;
   Compo:TComponent;
begin
   Val:=MyStrToFloat(NbreEdit1.text);
   if Val<>0 then
      for i:=2 to NbOnd do
         begin
         Val:=Val/2;
         if Val<1 then Val:=1;
         Compo:=FindComponent('NbreEdit'+IntToStr(i)); //nolang
         (Compo as NbreEdit).Text:=FloatToStr(Val);
         end;
end;

procedure Tpop_ondelettes.Label2Click(Sender: TObject);
var
   i:Integer;
   Val:Double;
   Compo:TComponent;
begin
   Val:=MyStrToFloat(NbreEdit2.text);
   if Val<>0 then
      for i:=3 to NbOnd do
         begin
         Val:=Val/2;
         if Val<1 then Val:=1;
         Compo:=FindComponent('NbreEdit'+IntToStr(i)); //nolang
         (Compo as NbreEdit).Text:=FloatToStr(Val);
         end;
end;

procedure Tpop_ondelettes.Label3Click(Sender: TObject);
var
   i:Integer;
   Val:Double;
   Compo:TComponent;
begin
   Val:=MyStrToFloat(NbreEdit3.text);
   if Val<>0 then
      for i:=4 to NbOnd do
         begin
         Val:=Val/2;
         if Val<1 then Val:=1;
         Compo:=FindComponent('NbreEdit'+IntToStr(i)); //nolang
         (Compo as NbreEdit).Text:=FloatToStr(Val);
         end;
end;

procedure Tpop_ondelettes.Label4Click(Sender: TObject);
var
   i:Integer;
   Val:Double;
   Compo:TComponent;
begin
   Val:=MyStrToFloat(NbreEdit4.text);
   if Val<>0 then
      for i:=5 to NbOnd do
         begin
         Val:=Val/2;
         if Val<1 then Val:=1;
         Compo:=FindComponent('NbreEdit'+IntToStr(i)); //nolang
         (Compo as NbreEdit).Text:=FloatToStr(Val);
         end;
end;

procedure Tpop_ondelettes.Label5Click(Sender: TObject);
var
   i:Integer;
   Val:Double;
   Compo:TComponent;
begin
   Val:=MyStrToFloat(NbreEdit5.text);
   if Val<>0 then
      for i:=6 to NbOnd do
         begin
         Val:=Val/2;
         if Val<1 then Val:=1;
         Compo:=FindComponent('NbreEdit'+IntToStr(i)); //nolang
         (Compo as NbreEdit).Text:=FloatToStr(Val);
         end;
end;

procedure Tpop_ondelettes.Label6Click(Sender: TObject);
var
   i:Integer;
   Val:Double;
   Compo:TComponent;
begin
   Val:=MyStrToFloat(NbreEdit6.text);
   if Val<>0 then
      for i:=7 to NbOnd do
         begin
         Val:=Val/2;
         if Val<1 then Val:=1;
         Compo:=FindComponent('NbreEdit'+IntToStr(i)); //nolang
         (Compo as NbreEdit).Text:=FloatToStr(Val);
         end;
end;

procedure Tpop_ondelettes.Label7Click(Sender: TObject);
var
   i:Integer;
   Val:Double;
   Compo:TComponent;
begin
   Val:=MyStrToFloat(NbreEdit7.text);
   if Val<>0 then
      for i:=8 to NbOnd do
         begin
         Val:=Val/2;
         if Val<1 then Val:=1;
         Compo:=FindComponent('NbreEdit'+IntToStr(i)); //nolang
         (Compo as NbreEdit).Text:=FloatToStr(Val);
         end;
end;

procedure Tpop_ondelettes.Label8Click(Sender: TObject);
var
   i:Integer;
   Val:Double;
   Compo:TComponent;
begin
   Val:=MyStrToFloat(NbreEdit8.text);
   if Val<>0 then
      for i:=9 to NbOnd do
         begin
         Val:=Val/2;
         if Val<1 then Val:=1;
         Compo:=FindComponent('NbreEdit'+IntToStr(i)); //nolang
         (Compo as NbreEdit).Text:=FloatToStr(Val);
         end;
end;

procedure Tpop_ondelettes.Label9Click(Sender: TObject);
var
   i:Integer;
   Val:Double;
   Compo:TComponent;
begin
   Val:=MyStrToFloat(NbreEdit9.text);
   if Val<>0 then
      for i:=10 to NbOnd do
         begin
         Val:=Val/2;
         if Val<1 then Val:=1;
         Compo:=FindComponent('NbreEdit'+IntToStr(i)); //nolang
         (Compo as NbreEdit).Text:=FloatToStr(Val);
         end;
end;

end.
