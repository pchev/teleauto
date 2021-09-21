unit pu_anal_modele;

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
  StdCtrls, ExtCtrls, u_class, u_modele_pointage,
  CheckLst, tagraph;

type
  Tpop_anal_modele = class(TForm)
    RadioGroup1: TRadioGroup;
    CheckBox1: TCheckBox;
    CheckListBox1: TCheckListBox;
    Label1: TLabel;
    TAChart1: TTAChart;
    procedure FormShow(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckListBox1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    AHPointe,DeltaPointe,AHReel,DeltaReel,ErreurAH,ErreurDelta,AHCorrige,DeltaCorrige:PLigDouble;
    ErreurAHCorrige,ErreurDeltaCorrige:PLigDouble;
    NData:Integer;
    Covar:DoubleArray;
    Chisq:Double;

    TASerie1:TTASerie;
        
    procedure MAJ;
  end;

var
   Correction:TCorrection;  

implementation

{$R *.DFM}

uses u_lang,
     u_general,
     math,
     pu_main,
     u_constants,
     pu_scope;

procedure Tpop_anal_modele.MAJ;
var
   T:TextFile;
   Name,Line:string;
   i,PosEsp:Integer;
   F:TStringList;
begin
   if TraductionEnCours then Exit;
   TASerie1.Clear;
//   Memo1.Clear;
//   Memo2.Clear;

   F:=TStringList.Create;

   try

   Name:='TPoint.txt'; //nolang
   AssignFile(T,Name);
   Reset(T);
   try
   i:=0;
   while not Eof(T) do
      begin
      Readln(T,Line);
      F.Add(Line);
      Inc(i);
      end;
   finally
   System.Close(T);
   end;

   NData:=F.Count;

   Getmem(AHPointe,8*NData);
   Getmem(DeltaPointe,8*NData);
   Getmem(AHReel,8*NData);
   Getmem(DeltaReel,8*NData);
   Getmem(ErreurAH,8*NData);
   Getmem(ErreurDelta,8*NData);
   Getmem(AHCorrige,8*NData);
   Getmem(DeltaCorrige,8*NData);
   Getmem(ErreurAHCorrige,8*NData);
   Getmem(ErreurDeltaCorrige,8*NData);

   try

   for i:=0 to NData-1 do
      begin
//   ListBox1.Items.Add(AlphaToStr(AHPointe)+' '+DeltaToStr(DeltaPointe)+AlphaToStr(AHReel)+' '+DeltaToStr(DeltaReel));
      Line:=F[i];

      PosEsp:=Pos(' ',Line);
      AHPointe[i+1]:=StrToAlpha(Copy(Line,1,PosEsp-1));
      Delete(Line,1,PosEsp);

      PosEsp:=Pos(' ',Line);
      DeltaPointe[i+1]:=StrToDelta(Copy(Line,1,PosEsp-1));
      Delete(Line,1,PosEsp);

      PosEsp:=Pos(' ',Line);
      AHReel[i+1]:=StrToAlpha(Copy(Line,1,PosEsp-1));
      Delete(Line,1,PosEsp);

      PosEsp:=Pos(' ',Line);
      DeltaReel[i+1]:=StrToDelta(Trim(Line));

      ErreurAH[i+1]:=(AHReel[i+1]-AHPointe[i+1])*15;
      ErreurDelta[i+1]:=(DeltaReel[i+1]-DeltaPointe[i+1]);
//      Memo1.Lines.Add(MyFloatToStr(ErreurAH[i+1],2)+'/'+MyFloatToStr(ErreurDelta[i+1],2));

      if not CheckBox1.Checked then
         begin
         TASerie1.AddXY(ErreurAH[i+1]*60,ErreurDelta[i+1]*60,clBlack);
//         Series1.AddPolar(ArcTan2(ErreurDelta[i+1],ErreurAH[i+1])*180/pi
//            ,Sqrt(Sqr(ErreurAH[i+1])+Sqr(ErreurDelta[i+1]))*60);
         end;
      end;

   Correction.DoCH:=False;
   Correction.DoNP:=False;
   Correction.DoMA:=False;
   Correction.DoME:=False;
   Correction.DoTF:=False;
   Correction.DoFO:=False;
   Correction.DoDAF:=False;

   Correction.DoPHH1D0:=False;
   Correction.DoPDH1D0:=False;
   Correction.DoPHH0D1:=False;
   Correction.DoPDH0D1:=False;

   Correction.DoPHH2D0:=False;
   Correction.DoPDH2D0:=False;
   Correction.DoPHH1D1:=False;
   Correction.DoPDH1D1:=False;
   Correction.DoPHH0D2:=False;
   Correction.DoPDH0D2:=False;

   if CheckListBox1.Checked[0] then Correction.DoCH:=True;
   if CheckListBox1.Checked[1] then Correction.DoNP:=True;
   if CheckListBox1.Checked[2] then Correction.DoMA:=True;
   if CheckListBox1.Checked[3] then Correction.DoME:=True;
   if CheckListBox1.Checked[4] then Correction.DoTF:=True;
   if CheckListBox1.Checked[5] then Correction.DoFO:=True;
   if CheckListBox1.Checked[6] then Correction.DoDAF:=True;

   if CheckListBox1.Checked[7] then Correction.DoPHH1D0:=True;
   if CheckListBox1.Checked[8] then Correction.DoPDH1D0:=True;
   if CheckListBox1.Checked[9] then Correction.DoPHH0D1:=True;
   if CheckListBox1.Checked[10] then Correction.DoPDH0D1:=True;

   if CheckListBox1.Checked[11] then Correction.DoPHH2D0:=True;
   if CheckListBox1.Checked[12] then Correction.DoPDH2D0:=True;
   if CheckListBox1.Checked[13] then Correction.DoPHH1D1:=True;
   if CheckListBox1.Checked[14] then Correction.DoPDH1D1:=True;
   if CheckListBox1.Checked[15] then Correction.DoPHH0D2:=True;
   if CheckListBox1.Checked[16] then Correction.DoPDH0D2:=True;

   for i:=1 to MaxArray do Correction.Modele[i]:=0;

   Correction.Latitude:=Config.Lat/180*Pi;
   FitModelePointage(AHPointe,DeltaPointe,ErreurAH,ErreurDelta,NData,Correction,Covar,Chisq);
   Config.ModelePointageCalibre:=True;
   pop_scope.Checkbox2.Enabled:=True;

   for i:=1 to NData do
      begin
      AppliqueModele(AHPointe[i],DeltaPointe[i],AHCorrige[i],DeltaCorrige[i],Correction);

      ErreurAHCorrige[i]:=(AHReel[i]-AHCorrige[i])*15;
      ErreurDeltaCorrige[i]:=(DeltaReel[i]-DeltaCorrige[i]);
//      Memo2.Lines.Add(MyFloatToStr(ErreurAHCorrige[i]*3600,2)+'/'+MyFloatToStr(ErreurDeltaCorrige[i]*3600,2));

      if CheckBox1.Checked then
         begin
         TASerie1.AddXY(ErreurAHCorrige[i]*60,ErreurDeltaCorrige[i]*60,clBlack);
//         Series1.AddPolar(ArcTan2(ErreurDeltaCorrige[i],ErreurAHCorrige[i])*180/pi
//            ,Sqrt(Sqr(ErreurAHCorrige[i])+Sqr(ErreurDeltaCorrige[i]))*60);
         end;

      end;

   finally
   Freemem(AHPointe,8*NData);
   Freemem(DeltaPointe,8*NData);
   Freemem(AHReel,8*NData);
   Freemem(DeltaReel,8*NData);
   Freemem(ErreurAH,8*NData);
   Freemem(ErreurDelta,8*NData);
   Freemem(AHCorrige,8*NData);
   Freemem(DeltaCorrige,8*NData);
   Freemem(ErreurAHCorrige,8*NData);
   Freemem(ErreurDeltaCorrige,8*NData);
   end;

   finally
   F.Free;
   end;
end;

procedure Tpop_anal_modele.FormShow(Sender: TObject);
begin
   Left:=Screen.Width-Width;
   UpDateLang(Self);

   TASerie1:=TTASerie.Create(TAChart1);
   TAChart1.AddSerie(TASerie1);
   TASerie1.ShowPoints:=True;
   TASerie1.ShowLines:=False;

   MAJ;
end;

procedure Tpop_anal_modele.CheckBox1Click(Sender: TObject);
begin
   MAJ;
end;

procedure Tpop_anal_modele.CheckListBox1Click(Sender: TObject);
begin
   MAJ;
end;

procedure Tpop_anal_modele.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
TASerie1.Free;
Action:=caFree;
end;

end.
