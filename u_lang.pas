unit u_lang;

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

uses Forms, StdCtrls, ExtCtrls, ComCtrls, Classes, Controls, Dialogs;

procedure SplitLangLine(Word:string; var Gauche,Droite:string);
procedure CreerDico(CreateCheck:Boolean;Application:TApplication);
procedure ModifSources;
function  Lang(Msg:string):string;
procedure ReturnToFrench(Fiche:TComponent);
procedure UpDateLang(Fiche:TComponent);
procedure UpdateAllDico;
procedure CreerDicoTest(Name:string);
procedure ModifSourcesTest(Name:string);
procedure UpdateWithOldDico(NewDico,OldDico:string);

implementation

uses SysUtils,
     typInfo,
     pu_rapport,     
     pu_main,
     u_general;

//True if prop property exists for comp component
function HasProperty(Comp:TComponent;Prop:string):boolean;
begin
Result:=(GetPropInfo(Comp.ClassInfo,Prop)<>nil) and (comp.name<>'');
end;

//Backs up the prop property value of the comp component
function GetProp(comp:TComponent;prop:string):string;
var
ppi:PPropInfo;
begin
ppi:=getPropInfo(comp.classInfo,prop);
if ppi<>nil then result:=getStrProp(comp,ppi)
else result:='';
end;

//Backs up the prop property value of the comp component
procedure SetProp(Comp:TComponent;Prop:string;Value:string);
var
ppi:PPropInfo;
begin
ppi:=getPropInfo(comp.classInfo,prop);
if ppi<>nil then SetStrProp(Comp,ppi,Value);
end;

procedure SplitLangLine(Word:string; var Gauche,Droite:string);
var
PosEsp:Integer;
begin
PosEsp:=Pos('''=''',Word); //nolang
Gauche:=Copy(Word,2,PosEsp-2);
Droite:=Copy(Word,PosEsp+3,Length(Word)-PosEsp-3);
end;

procedure CreerDico(CreateCheck:Boolean;Application:TApplication);
var
   i,j,k,l,m:integer;
   fiche,cmpt:TComponent;
   val,comp,nomComp:string;

   Path:string;
	sr:TSearchRec;
   FIn,F:TextFile;
   ligne,temp,tempL,SaveLine:string;
   Line,LineResult,Item:ShortString;
   x,y:integer;
   State:Byte;
   Valid,ReadIt:Boolean;

function GetNextItem:ShortString;
var
PosEsp:Integer;
UpLine:string;
begin
if Length(Line)=0 then
   begin
   Readln(FIn,Line);
   SaveLine:=Line;
   Line:=Trim(Line);
   UpLine:=UpperCase(Line);
   while  ((pos('''',Line)=0) and (pos('{',Line)=0) and (pos('}',Line)=0)   //nolang
      and (pos('(*',Line)=0) and (pos('*)',Line)=0) and not Eof(FIn))       //nolang
      or  (pos('WRITESTRING',UpLine)<>0) or (pos('READSTRING',UpLine)<>0)   //nolang
      or  ((pos('NOLANG',UpLine)<>0) and (State<>2))                        //nolang
      do
      begin
      Readln(FIn,Line);
      SaveLine:=Line;
      Line:=Trim(Line);
      UpLine:=UpperCase(Line);
      end;
   end;

if Length(Line)>1 then
   begin
   if (Line[1]='/') and (Line[2]='/') and (State=1) then
      begin
      Delete(Line,1,2);
      Exit;
      end;
   if (Line[1]='/') and (Line[2]='/') and (State=2) then
      begin
      Delete(Line,1,2);
      Exit;
      end;
   if (Line[1]='/') and (Line[2]='/') and (State=0) then
      begin
      Line:=Copy(Line,1,PosEsp-1)+'{'+Copy(Line,PosEsp+2,Length(Line)-PosEsp-1)+'}';
      Result:='DebCom'; //nolang
      Delete(Line,1,1);
      Exit;
      end;
{   if (Line[1]='(') and (Line[2]='*') then
      begin
      Result:='DebCom'; //nolang
      Delete(Line,1,2);
      Exit;
      end;}
   if (Line[1]='(') and (Line[2]<>'*') then
      begin
      Result:=Line[1];
      Delete(Line,1,1);
      Exit;
      end;
{   if (Line[1]='*') and (Line[2]=')') then
      begin
      Result:='FinCom'; //nolang
      Delete(Line,1,2);
      Exit;
      end;}
   if (Line[1]='*') and (Line[2]<>')') then
      begin
      Result:=Line[1];
      Delete(Line,1,1);
      Exit;
      end;
   if (State=1) and (Line[1]='''')  and (Line[2]='''') then //nolang
      begin
      Result:='DoubleApos'; //nolang
      Delete(Line,1,2);
      Exit;
      end;
   if (State=1) and (Line[1]='''')  and (Line[2]<>'''') then //nolang
      begin
      Result:='Apos'; //nolang
      Delete(Line,1,1);
      Exit;
      end;
   end;

if Length(Line)>0 then
   begin
   if (State=0) and (Line[1]='''') then //nolang
      begin
      Result:='Apos'; //nolang
      Delete(Line,1,1);
      Exit;
      end;
   if (State=1) and (Line[1]='''') then //nolang
      begin
      Result:='Apos'; //nolang
      Delete(Line,1,1);
      Exit;
      end;
   if (Line[1]='{') and (State<>1) then
      begin
      Result:='DebCom'; //nolang
      Delete(Line,1,1);
      Exit;
      end;
   if (Line[1]='}') and (State<>1)  then
      begin
      Result:='FinCom'; //nolang
      Delete(Line,1,1);
      Exit;
      end;
//   if (Line[1]<>'(') and (Line[1]<>'*') then
//      begin
   Result:=Line[1];
   Delete(Line,1,1);
//      end;
   end;
end;

function WordNotInFile(Word:string):Boolean;
var
WordDico,Path:string;
PosEsp:Integer;
begin
   Path:=ExtractFileDir(Application.ExeName);
   Word:=''''+Word+'''='; //nolang
   Result:=True;
   if CreateCheck then AssignFile(F,Path+'\Check.lng') //nolang
   else AssignFile(F,Path+'\Model.lng'); //nolang
   Reset(F);
   while not Eof(F) do
      begin
      Readln(F,WordDico);
      WordDico:=Copy(WordDico,1,Length(Word));
      if WordDico=Word then //nolang
         begin
         Result:=False;
         CloseFile(F);
         Exit;
         end;
      end;
   CloseFile(F);
end;

procedure AddWord(Word:string);
var
   PosApos:Integer;
begin
// Supprimer les '' de la chaine
PosApos:=Pos('''''',Word);
while PosApos<>0 do
   begin
   Delete(Word,PosApos,1);
   PosApos:=Pos('''''',Word);
   end;

if Length(Word)>1 then
   if WordNotInFile(Word) then
      begin
      if CreateCheck then AssignFile(F,Path+'\Check.lng') //nolang
      else AssignFile(F,Path+'\Model.lng'); //nolang
      Append(F);
      Writeln(F,''''+Word+'''='); //nolang
//      Writeln(F,sr.name+'*** '+Word);
//      Writeln(F,SaveLine);
//      Writeln(F,' ');
      CloseFile(F);
      end;
end;

begin
   Path:=ExtractFileDir(Application.ExeName);

   // On cree le fichier
   if CreateCheck then
      AssignFile(F,Path+'\Check.lng') //nolang
   else
      AssignFile(F,Path+'\Model.lng'); //nolang

   Rewrite(F);
   CloseFile(F);

   // First search the properties that will be translated
   for i := 0 to application.ComponentCount - 1 do
      begin
   	fiche:=application.Components[i];
      nomComp:=fiche.Name;
      if CreateCheck then AddWord('*********** '+nomComp+' ***********'); //nolang
      if nomComp<>'pop_main' then //nolang
      if copy(nomComp,1,3)<>'out' then //nolang
    	if HasProperty(fiche,'Caption') then //nolang
         AddWord(getProp(fiche,'Caption')); //nolang

      for j:=0 to fiche.componentCount-1 do
         begin
      	cmpt:=fiche.Components[j];
         nomComp:=cmpt.name;
         if CreateCheck then AddWord('*********** '+nomComp+' ***********'); //nolang
         //use a 'out' prefixed name if you want the component won't appear
         //in the list (ie : outLabel6:TLabel) so as the list won't be too big
         if copy(nomComp,1,3)='out' then continue; //nolang
         if HasProperty(cmpt,'Caption') and //nolang
         not (nomComp=getProp(cmpt,'Caption')) and //nolang
         not (getProp(cmpt,'Caption')='-') and //nolang
         not (getProp(cmpt,'Caption')='') then //nolang
            AddWord(getProp(cmpt,'Caption')); //nolang
         if HasProperty(cmpt,'Hint') and (getProp(cmpt,'Hint')<>'')then //nolang
            AddWord(getProp(cmpt,'Hint')); //nolang
         if HasProperty(cmpt,'Filter') and (getProp(cmpt,'Filter')<>'')then //nolang
            AddWord(getProp(cmpt,'Filter')); //nolang

      	if (cmpt is TMemo) then
            for k:=0 to TMemo(cmpt).Lines.count-1 do
               begin
         	   val:=TMemo(cmpt).Lines[k];
               if val=nomComp then break;
               AddWord(val);
               end;

         if (cmpt is TRadioGroup) then
            for l:= 0 to TRadioGroup(cmpt).Items.Count-1 do
               begin
               val:=TRadioGroup(cmpt).Items[l];
               AddWord(val);
               end;

         if (cmpt is TComboBox) then
            for m:=0 to TComboBox(cmpt).Items.Count-1 do
               begin
               val:=TComboBox(cmpt).Items[m];
               AddWord(val);
               end;

         if (cmpt is TListView) then
            for m:=0 to TListView(cmpt).Columns.Count-1 do
               begin
               val:=TListView(cmpt).Column[m].Caption;
               AddWord(val);
               end;

         if (cmpt is TTreeView) then
            for m:=0 to TTreeView(cmpt).Items.Count-1 do
               begin
               val:=TTreeView(cmpt).Items[m].Text;
               AddWord(val);
               end;

         end;
      end;

   // Recherche des chaines a traduire dans le code
	if FindFirst(Path+'\*.pas',faAnyFile,sr)=0 then  //nolang
   	repeat
      	AssignFile(FIn,Path+'\'+sr.name);
         if CreateCheck then AddWord('*********** '+Path+'\'+sr.name+' ***********'); //nolang
         reset(FIn);
         Line:='';
         LineResult:='';
         State:=0;
         // Automate à états
         // Etat=0 Normal = pas dans une chaine ni dans un commentaire
         // Etat=1 Dans une chaine
         // Etat=2 Dans un commentaire
			while not eof(FIn) do
            begin
            Item:=GetNextItem;
            // Etat normal et { => on passe en commentaire
            if (State=0) and (Item='DebCom') then //nolang
               State:=2;
            // Etat normal et ' => on passe en chaine
            if (State=0) and (Item='Apos') then //nolang
               begin
               State:=1;
               LineResult:='';
               Item:='';
               end;
            // Etat commentaire et } => on passe en normal
            if (State=2) and (Item='FinCom') then //nolang
               State:=0;
            if (State=1) and (Item='DoubleApos') then LineResult:=LineResult+''''''; //nolang
            // Etat chaine et ' => on passe en normal
            if (State=1) and (Item='Apos') then //nolang
               begin
               State:=0;
               AddWord(LineResult);
               end;
            if (State=1) and (Item<>'DoubleApos') then LineResult:=LineResult+Item; //nolang
            end;
         CloseFile(FIn);
//         fileClose(sr.findHandle);
      until FindNext(sr)<>0;
   FindClose(sr);
end;

// Ajoute les lang() qui manquent dans toutes les sources de TA
procedure ModifSources;
var
   FIn,FOut,FLang:TextFile;
   WordDico,LineCode,Rep:String;
   PosWordDico:Integer;
 	sr:TSearchRec;
begin
   // search for error or information messages stored as
   // const or resourcestring - see below
	Rep:=extractFileDir(application.exeName)+'\';

   // Search string resources in pas files}
	if FindFirst(Rep+'*.pas',faAnyFile,sr)=0 then  //nolang
   	repeat
      	AssignFile(FIn,Rep+sr.name);
         Reset(FIn);

      	AssignFile(FOut,Rep+'tmp.pas'); //nolang
         Rewrite(FOut);

         while not(Eof(FIn)) do
            begin
            Readln(FIn,LineCode);
//            NewLine:=LineCode;

         	AssignFile(FLang,Rep+'Model.lng'); //nolang
            Reset(FLang);

            while not(Eof(FLang)) do
               begin
               Readln(FLang,WordDico);
               WordDico:=Copy(WordDico,1,Length(WordDico)-1);
               PosWordDico:=Pos(WordDico,LineCode);
               if (PosWordDico<>0)
                  and (Pos('nolang',LineCode)=0)                  //nolang
                  and (Pos('READSTRING',UpperCase(LineCode))=0)   //nolang
                  and (Pos('WRITESTRING',UpperCase(LineCode))=0)  //nolang
//                  and (Pos('lang(',LineCode)>0) //nolang
                  and (Pos('lang(',LineCode)<>PosWordDico-5) //nolang // Garder ce lang( la !!!!
                  and (Pos('lang(',LineCode)<>PosWordDico-4) then //nolang // Garder ce lang( la !!!!
                     begin
                     LineCode:=Copy(LineCode,1,PosWordDico-1)+'lang('+WordDico+')' //nolang // Garder ce lang( la !!!!
                        +Copy(LineCode,PosWordDico+Length(WordDico),
                        Length(LineCode)-PosWordDico-Length(WordDico)+1);
//                     LineCode:=NewLine; // Pour traduire les autres chaines
                     end;
               end;

            CloseFile(FLang);

            Writeln(FOut,LineCode);
            end;

         CloseFile(FIn);
         CloseFile(FOut);
         DeleteFile(Rep+sr.name);
         RenameFile(Rep+'tmp.pas',Rep+sr.name); //nolang
//         FileClose(sr.findHandle);
      until findNext(sr)<>0;
   FindClose(sr);
end;

// Fonction de base de traduction
function Lang(Msg:string):string;
var
i,j,Debut:Integer;
Word,WordDico,Traduction:string;
F:TextFile;
Pos1,Pos2,Pos3,Pos4,Pos5,Pos6,pos7:Integer;
begin
Word:=''''+Msg+'''='; //nolang
if (Config.Language<>'Francais') and (Msg<>'') then //nolang
   begin
   j:=Ord(Msg[1])-Ord('A');
   if (j<0) or (j>27) then Debut:=0 else Debut:=IndexDic[j];
   for i:=Debut to Dico.Count-1 do
      begin
      Traduction:=Dico.Strings[i];
      WordDico:=Copy(Traduction,1,Length(Word));
      Traduction:=Copy(Traduction,Length(Word)+2,Length(Traduction)-Length(Word)-2);
//      if (Uppercase(WordDico)=UpperCase(Word)) and (Length(Traduction)<>0) then //nolang
      if (WordDico=Word) and (Length(Traduction)<>0) then //nolang
         begin
         Result:=Traduction;
         Exit;
         end;
      end;

   Pos1:=Pos('é',Msg);
   Pos2:=Pos('è',Msg);
   Pos3:=Pos('à',Msg);
   Pos4:=Pos('ç',Msg);
   Pos5:=Pos('ê',Msg);
   Pos6:=Pos('ù',Msg);
   Pos7:=Pos('ï',Msg);   

   // On recommence sans les accents
   if Pos1+Pos2+Pos3+Pos4+Pos5+Pos6<>0 then
      begin
      while Pos1>0 do
         begin
         Msg[Pos1]:='e';
         Pos1:=Pos('é',Msg);
         end;
      while Pos2>0 do
         begin
         Msg[Pos2]:='e';
         Pos2:=Pos('è',Msg);
         end;
      while Pos3>0 do
         begin
         Msg[Pos3]:='a';
         Pos3:=Pos('à',Msg);
         end;
      while Pos4>0 do
         begin
         Msg[Pos4]:='c';
         Pos4:=Pos('ç',Msg);
         end;
      while Pos5>0 do
         begin
         Msg[Pos5]:='e';
         Pos5:=Pos('ê',Msg);
         end;
      while Pos6>0 do
         begin
         Msg[Pos6]:='u';
         Pos6:=Pos('ù',Msg);
         end;
      while Pos7>0 do
         begin
         Msg[Pos7]:='i';
         Pos7:=Pos('ï',Msg);
         end;

      j:=Ord(Msg[1])-Ord('A');
      if (j<0) or (j>27) then Debut:=0 else Debut:=IndexDic[j];
      for i:=Debut to Dico.Count-1 do
         begin
         Traduction:=Dico.Strings[i];
         WordDico:=Copy(Traduction,1,Length(Word));
         Traduction:=Copy(Traduction,Length(Word)+2,Length(Traduction)-Length(Word)-2);
         if (WordDico=Word) and (Length(Traduction)<>0) then //nolang
            begin
            Result:=Traduction;
            Exit;
            end;
         end;
      end;
   end;

Result:=Msg;
end;

// Fonction de base de retour au francais
// Sans accent pour l'instant -> à corriger plus tard
function LangInverse(Msg:string):string;
var
Word,WordDico,Traduction:string;
F:TextFile;
i:Integer;
begin
if Config.Language<>'Francais' then //nolang
   begin
   for i:=0 to Dico.Count-1 do
      begin
      Word:=Dico.Strings[i];
      SplitLangLine(Word,WordDico,Traduction);
      if Traduction=Msg then //nolang
         begin
         Result:=WordDico;
         Exit;
         end;
      end;
   end;
Result:=Msg;
end;

// On revient au francais
procedure ReturnToFrench(Fiche:TComponent);
var
NomComp,Val,NomDebug:string;
j,k:Integer;
Cmpt:TComponent;
begin
NomComp:=fiche.Name;
if NomComp<>'pop_main' then                      //nolang
   if Copy(nomComp,1,3)<>'out' then              //nolang
      if HasProperty(Fiche,'Caption') then       //nolang
         (Fiche as TForm).Caption:=LangInverse((Fiche as TForm).Caption);

for j:=0 to Fiche.ComponentCount-1 do
   begin
   Cmpt:=Fiche.Components[j];
   NomComp:=Cmpt.Name;
   //use a 'out' prefixed name if you want the component won't appear
   //in the list (ie : outLabel6:TLabel) so as the list won't be too big
   if Copy(NomComp,1,3)='out' then Continue;                            //nolang
   if HasProperty(Cmpt,'Caption') and                                   //nolang
      not (NomComp=GetProp(Cmpt,'Caption')) and                         //nolang
      not (GetProp(Cmpt,'Caption')='-') and                             //nolang
      not (GetProp(Cmpt,'Caption')='') then                             //nolang
         begin
         NomDebug:=GetProp(Cmpt,'Caption');                             //nolang
         NomDebug:=LangInverse(GetProp(Cmpt,'Caption'));                //nolang
         SetProp(Cmpt,'Caption',LangInverse(GetProp(Cmpt,'Caption')));  //nolang
         end;

   if HasProperty(Cmpt,'Hint') and (getProp(cmpt,'Hint')<>'') then      //nolang
      SetProp(Cmpt,'Hint',LangInverse(GetProp(Cmpt,'Hint')));           //nolang

   if (cmpt is TCustomMemo) then
      for k:=0 to TCustomMemo(cmpt).Lines.count-1 do
         begin
         Val:=TCustomMemo(cmpt).Lines[k];
         TCustomMemo(cmpt).Lines[k]:=LangInverse(Val);
         end;

   if (cmpt is TRadioGroup) then
      for k:= 0 to TRadioGroup(cmpt).Items.Count-1 do
         begin
         val:=TRadioGroup(cmpt).Items[k];
         TRadioGroup(cmpt).Items[k]:=LangInverse(Val);
         end;

   if (cmpt is TComboBox) then
      for k:=0 to TComboBox(cmpt).Items.Count-1 do
         begin
         val:=TComboBox(cmpt).Items[k];
         TComboBox(cmpt).Items[k]:=LangInverse(Val);
         end;

   if (cmpt is TListView) then
      for k:=0 to TListView(cmpt).Columns.Count-1 do
         begin
         val:=TListView(cmpt).Column[k].Caption;
         TListView(cmpt).Column[k].Caption:=LangInverse(Val);
         end;

   if (cmpt is TTreeView) then
      for k:=0 to TTreeView(cmpt).Items.Count-1 do
         begin
         val:=TTreeView(cmpt).Items[k].Text;
         TTreeView(cmpt).Items[k].Text:=LangInverse(Val);
         end;
   end;
end;

// A mettre dans le Onshow de toutes les unités
// Traduit les chaînes des compsants de la fenêtre
procedure UpDateLang(Fiche:TComponent);
var
NomComp,Val,NomDebug:string;
j,k:Integer;
Cmpt:TComponent;
begin
NomComp:=fiche.Name;
if NomComp<>'pop_main' then                      //nolang
   if Copy(nomComp,1,3)<>'out' then              //nolang
      if HasProperty(Fiche,'Caption') then       //nolang
         (Fiche as TForm).Caption:=lang((Fiche as TForm).Caption);

for j:=0 to Fiche.ComponentCount-1 do
   begin
   Cmpt:=Fiche.Components[j];
   NomComp:=Cmpt.Name;
   //use a 'out' prefixed name if you want the component won't appear
   //in the list (ie : outLabel6:TLabel) so as the list won't be too big
   if Copy(NomComp,1,3)='out' then Continue;                            //nolang
   if HasProperty(Cmpt,'Caption') and                                   //nolang
      not (NomComp=GetProp(Cmpt,'Caption')) and                         //nolang
      not (GetProp(Cmpt,'Caption')='-') and                             //nolang
      not (GetProp(Cmpt,'Caption')='') then                             //nolang
         begin
         NomDebug:=GetProp(Cmpt,'Caption');                             //nolang
         NomDebug:=Lang(GetProp(Cmpt,'Caption'));                       //nolang
         SetProp(Cmpt,'Caption',Lang(GetProp(Cmpt,'Caption')));         //nolang
         end;

   if HasProperty(Cmpt,'Hint') and (getProp(cmpt,'Hint')<>'') then      //nolang
      SetProp(Cmpt,'Hint',Lang(GetProp(Cmpt,'Hint')));                  //nolang

   if HasProperty(Cmpt,'Filter') and (getProp(cmpt,'Filter')<>'') then      //nolang
      SetProp(Cmpt,'Filter',Lang(GetProp(Cmpt,'Filter')));                  //nolang

   if (cmpt is TCustomMemo) then
      for k:=0 to TCustomMemo(cmpt).Lines.count-1 do
         begin
         Val:=TCustomMemo(cmpt).Lines[k];
         TCustomMemo(cmpt).Lines[k]:=Lang(Val);
         end;

   if (cmpt is TMemo) then
      for k:=0 to TMemo(cmpt).Lines.count-1 do
         begin
         Val:=TMemo(cmpt).Lines[k];
         TMemo(cmpt).Lines[k]:=Lang(Val);
         end;

   if (cmpt is TRadioGroup) then
      for k:= 0 to TRadioGroup(cmpt).Items.Count-1 do
         begin
         val:=TRadioGroup(cmpt).Items[k];
         TRadioGroup(cmpt).Items[k]:=Lang(Val);
         end;

   if (cmpt is TComboBox) then
      for k:=0 to TComboBox(cmpt).Items.Count-1 do
         begin
         val:=TComboBox(cmpt).Items[k];
         TComboBox(cmpt).Items[k]:=Lang(Val);
         end;

   if (cmpt is TListView) then
      for k:=0 to TListView(cmpt).Columns.Count-1 do
         begin
         val:=TListView(cmpt).Column[k].Caption;
         TListView(cmpt).Column[k].Caption:=Lang(Val);
         end;

   if (cmpt is TTreeView) then
      for k:=0 to TTreeView(cmpt).Items.Count-1 do
         begin
         val:=TTreeView(cmpt).Items[k].Text;
         TTreeView(cmpt).Items[k].Text:=Lang(Val);
         end;
   end;
end;

// Mise a jour des dicos
// Utilisé par le programmeur
procedure UpdateAllDico;
var
sr:TSearchRec;
FModel,FLang,FTemp:TextFile;
WordDico,NewWord,NewWordRef,NewWordTrad,Path:string;
Trouve:Boolean;
begin
Path:=extractFileDir(application.exeName);
// Pour tous les fichiers *.lng
if findFirst(Path+'\*.lng',faAnyFile,sr)=0 then  //nolang
   repeat
   // sauf Model.lng !
   if sr.name<>'Model.lng' then                         //nolang
      begin
      // On cree le dico temporaire vide
      AssignFile(FTemp,Path+'\Temp.lng');        //nolang
      Rewrite(FTemp);
      try

      // On ouvre le dico modele en lecture
      AssignFile(FModel,Path+'\Model.lng');      //nolang
      Reset(FModel);
      try

      // Pour tous les items du modele
      while not Eof(FModel) do
         begin
         Readln(FModel,WordDico);

         Trouve:=False;
         // On ouvre le dico de la langue en lecture
         AssignFile(FLang,Path+'\'+sr.Name);
         Reset(FLang);
         try
         // On cherche l'item de la langue qui corresponds au modele
         while not Eof(FLang) do
            begin
            Readln(FLang,NewWord);
            NewWordRef:=Copy(NewWord,1,Length(WordDico));
            NewWordTrad:=Copy(NewWord,Length(WordDico)+1,Length(NewWord)-Length(WordDico));
            if NewWordRef=WordDico then
               begin
               // Si on l'a trouvé on le réecrit dans le dico temporaire avec sa traduction
               Trouve:=True;
               Writeln(FTemp,NewWord);
               Break;
               end;
            end;

         finally
         CloseFile(FLang);
         end;

         // Si on l'a pas trouvé on l'ecrit le dico temporaire dans avec la traduction vide
         if not(Trouve) then //nolang
            begin
            NewWordRef:=Copy(NewWordRef,2,Length(NewWordRef)-3);
            Writeln(FTemp,WordDico+''''''); //nolang
            end;

         end;

      finally
      CloseFile(FModel);
      end;

      finally
      CloseFile(FTemp);
      end;

      // On remplace le dico de la langue par le temporaire
      // Les chaines inutiles du dico initial de la langue sont effacees
      DeleteFile(Path+'\'+sr.name);
      RenameFile(Path+'\Temp.lng',Path+'\'+sr.name); //nolang

      end;

//   FileClose(sr.findHandle);
   until findNext(sr)<>0;
end;

//******************************************************************************

procedure CreerDicoTest(Name:string);
var
   i,j,k,l,m:integer;
   fiche,cmpt:TComponent;
   val,comp,nomComp:string;

   Path:string;
   FIn,F:TextFile;
   ligne,temp,tempL,SaveLine:string;
   Line,LineResult,Item:ShortString;
   x,y:integer;
   State:Byte;
   Valid,ReadIt:Boolean;

function GetNextItem:ShortString;
var
PosEsp:Integer;
UpLine:string;
begin
if Length(Line)=0 then
   begin
   Readln(FIn,Line);
   SaveLine:=Line;
   Line:=Trim(Line);
   UpLine:=UpperCase(Line);
   while  ((pos('''',Line)=0) and (pos('{',Line)=0) and (pos('}',Line)=0)   //nolang
      and (pos('(*',Line)=0) and (pos('*)',Line)=0) and not Eof(FIn))       //nolang
      or  (pos('WRITESTRING',UpLine)<>0) or (pos('READSTRING',UpLine)<>0)   //nolang
      or  ((pos('NOLANG',UpLine)<>0) and (State<>2))                        //nolang
      do
      begin
      Readln(FIn,Line);
      SaveLine:=Line;
      Line:=Trim(Line);
      UpLine:=UpperCase(Line);
      end;
   end;

if Length(Line)>1 then
   begin
   if (Line[1]='/') and (Line[2]='/') and (State=1) then
      begin
      Delete(Line,1,2);
      Exit;
      end;
   if (Line[1]='/') and (Line[2]='/') and (State=2) then
      begin
      Delete(Line,1,2);
      Exit;
      end;
   if (Line[1]='/') and (Line[2]='/') and (State=0) then
      begin
      Line:=Copy(Line,1,PosEsp-1)+'{'+Copy(Line,PosEsp+2,Length(Line)-PosEsp-1)+'}';
      Result:='DebCom'; //nolang
      Delete(Line,1,1);
      Exit;
      end;
{   if (Line[1]='(') and (Line[2]='*') then
      begin
      Result:='DebCom'; //nolang
      Delete(Line,1,2);
      Exit;
      end;}
   if (Line[1]='(') and (Line[2]<>'*') then
      begin
      Result:=Line[1];
      Delete(Line,1,1);
      Exit;
      end;
{   if (Line[1]='*') and (Line[2]=')') then
      begin
      Result:='FinCom'; //nolang
      Delete(Line,1,2);
      Exit;
      end;}
   if (Line[1]='*') and (Line[2]<>')') then
      begin
      Result:=Line[1];
      Delete(Line,1,1);
      Exit;
      end;
   if (State=1) and (Line[1]='''')  and (Line[2]='''') then //nolang
      begin
      Result:='DoubleApos'; //nolang
      Delete(Line,1,2);
      Exit;
      end;
   if (State=1) and (Line[1]='''')  and (Line[2]<>'''') then //nolang
      begin
      Result:='Apos'; //nolang
      Delete(Line,1,1);
      Exit;
      end;
   end;

if Length(Line)>0 then
   begin
   if (State=0) and (Line[1]='''') then //nolang
      begin
      Result:='Apos'; //nolang
      Delete(Line,1,1);
      Exit;
      end;
   if (State=1) and (Line[1]='''') then //nolang
      begin
      Result:='Apos'; //nolang
      Delete(Line,1,1);
      Exit;
      end;
   if (Line[1]='{') and (State<>1) then
      begin
      Result:='DebCom'; //nolang
      Delete(Line,1,1);
      Exit;
      end;
   if (Line[1]='}') and (State<>1)  then
      begin
      Result:='FinCom'; //nolang
      Delete(Line,1,1);
      Exit;
      end;
//   if (Line[1]<>'(') and (Line[1]<>'*') then
//      begin
   Result:=Line[1];
   Delete(Line,1,1);
//      end;
   end;
end;

function WordNotInFile(Word:string):Boolean;
var
WordDico,Path:string;
PosEsp:Integer;
begin
   Path:=ExtractFileDir(Application.ExeName);
   Word:=''''+Word+'''='; //nolang
   Result:=True;
   AssignFile(F,Path+'\Test.lng'); //nolang
   Reset(F);
   while not Eof(F) do
      begin
      Readln(F,WordDico);
      WordDico:=Copy(WordDico,1,Length(Word));
      if WordDico=Word then //nolang
         begin
         Result:=False;
         CloseFile(F);
         Exit;
         end;
      end;
   CloseFile(F);
end;

procedure AddWord(Word:string);
var
   PosApos:Integer;
begin
// Supprimer les '' de la chaine
PosApos:=Pos('''''',Word);
while PosApos<>0 do
   begin
   Delete(Word,PosApos,1);
   PosApos:=Pos('''''',Word);
   end;

if Length(Word)>1 then
   if WordNotInFile(Word) then
      begin
      AssignFile(F,Path+'\Test.lng'); //nolang
      Append(F);
      Writeln(F,''''+Word+'''='); //nolang
//      Writeln(F,sr.name+'*** '+Word);
//      Writeln(F,SaveLine);
//      Writeln(F,' ');
      CloseFile(F);
      end;
end;

begin
   Path:=ExtractFileDir(Application.ExeName);

   AssignFile(F,Path+'\Test.lng'); //nolang

   Rewrite(F);
   CloseFile(F);

   AssignFile(FIn,Path+'\'+Name);
   reset(FIn);
   Line:='';
   LineResult:='';
   State:=0;
   // Automate à états
   // Etat=0 Normal = pas dans une chaine ni dans un commentaire
   // Etat=1 Dans une chaine
   // Etat=2 Dans un commentaire
   while not eof(FIn) do
      begin
      Item:=GetNextItem;
      // Etat normal et { => on passe en commentaire
      if (State=0) and (Item='DebCom') then //nolang
         State:=2;
      // Etat normal et ' => on passe en chaine
      if (State=0) and (Item='Apos') then //nolang
         begin
         State:=1;
         LineResult:='';
         Item:='';
         end;
      // Etat commentaire et } => on passe en normal
      if (State=2) and (Item='FinCom') then //nolang
         State:=0;
      if (State=1) and (Item='DoubleApos') then LineResult:=LineResult+''''''; //nolang
      // Etat chaine et ' => on passe en normal
      if (State=1) and (Item='Apos') then //nolang
         begin
         State:=0;
         AddWord(LineResult);
         end;
      if (State=1) and (Item<>'DoubleApos') then LineResult:=LineResult+Item; //nolang
      end;
   CloseFile(FIn);
end;

// Ajoute les lang() qui manquent dans toutes les sources de TA
procedure ModifSourcesTest(Name:string);
var
   FIn,FOut,FLang:TextFile;
   WordDico,LineCode,Rep:String;
   PosWordDico:Integer;
 	sr:TSearchRec;
begin
	Rep:=extractFileDir(application.exeName)+'\';

   AssignFile(FIn,Rep+Name);
   Reset(FIn);

   AssignFile(FOut,Rep+'TestResult.pas'); //nolang
   Rewrite(FOut);

   while not(Eof(FIn)) do
      begin
      Readln(FIn,LineCode);

      AssignFile(FLang,Rep+'Model.lng'); //nolang
      Reset(FLang);

      while not(Eof(FLang)) do
         begin
         Readln(FLang,WordDico);
         WordDico:=Copy(WordDico,1,Length(WordDico)-1);
         PosWordDico:=Pos(WordDico,LineCode);
         if (PosWordDico<>0)
            and (Pos('nolang',LineCode)=0)                  //nolang
            and (Pos('READSTRING',UpperCase(LineCode))=0)   //nolang
            and (Pos('WRITESTRING',UpperCase(LineCode))=0)  //nolang
//                  and (Pos('lang(',LineCode)>0) //nolang
            and (Pos('LANG(',Uppercase(LineCode))<>PosWordDico-5) //nolang // Garder ce lang( la !!!!
            and (Pos('LANG(',Uppercase(LineCode))<>PosWordDico-4) then //nolang // Garder ce lang( la !!!!
               begin
               LineCode:=Copy(LineCode,1,PosWordDico-1)+'lang('+WordDico+')' //nolang // Garder ce lang( la !!!!
                  +Copy(LineCode,PosWordDico+Length(WordDico),
                  Length(LineCode)-PosWordDico-Length(WordDico)+1);
               end;
         end;

      CloseFile(FLang);

      Writeln(FOut,LineCode);
      end;

   CloseFile(FIn);
   CloseFile(FOut);
//   DeleteFile(Rep+Name);
//   RenameFile(Rep+'tmp.pas',Name); //nolang
end;

function Same(S1,S2:string):Boolean;
var
   PosS:Integer;
begin
PosS:=Pos('é',S1);
while PosS>0 do
   begin
   S1[PosS]:='e';
   PosS:=Pos('é',S1);
   end;

PosS:=Pos('è',S1);
while PosS>0 do
   begin
   S1[PosS]:='e';
   PosS:=Pos('è',S1);
   end;

PosS:=Pos('à',S1);
while PosS>0 do
   begin
   S1[PosS]:='a';
   PosS:=Pos('à',S1);
   end;

PosS:=Pos('ç',S1);
while PosS>0 do
   begin
   S1[PosS]:='c';
   PosS:=Pos('ç',S1);
   end;

PosS:=Pos('ê',S1);
while PosS>0 do
   begin
   S1[PosS]:='e';
   PosS:=Pos('ê',S1);
   end;

PosS:=Pos('ù',S1);
while PosS>0 do
   begin
   S1[PosS]:='u';
   PosS:=Pos('ù',S1);
   end;

PosS:=Pos('è',S2);
while PosS>0 do
   begin
   S2[PosS]:='e';
   PosS:=Pos('è',S2);
   end;

PosS:=Pos('é',S2);
while PosS>0 do
   begin
   S2[PosS]:='e';
   PosS:=Pos('é',S2);
   end;

PosS:=Pos('à',S2);
while PosS>0 do
   begin
   S2[PosS]:='a';
   PosS:=Pos('à',S2);
   end;

PosS:=Pos('ç',S2);
while PosS>0 do
   begin
   S2[PosS]:='c';
   PosS:=Pos('ç',S2);
   end;

PosS:=Pos('ê',S2);
while PosS>0 do
   begin
   S2[PosS]:='e';
   PosS:=Pos('ê',S2);
   end;

PosS:=Pos('ù',S2);
while PosS>0 do
   begin
   S2[PosS]:='u';
   PosS:=Pos('ù',S2);
   end;

Result:=S1=S2;
end;

// Mise a jour a partir d'un ancien dico
// Utilisé par le programmeur
procedure UpdateWithOldDico(NewDico,OldDico:string);
var
   sr:TSearchRec;
   FNew,FOld,FTemp,FModel:TextFile;
   WordDico,OldWord,OldWordRef,OldWordTrad,NewWord,NewWordRef,NewWordTrad,Path:string;
   TrouveNew,TrouveOld:Boolean;
   Rapport:tpop_rapport;
   Value,Part:String;
begin
Path:=extractFilePath(application.exeName);

Rapport:=tpop_rapport.Create(Application);
Rapport.top:=0;
Rapport.width:=1000;
Rapport.Show;
try

// On cree le dico temporaire vide en ecriture
AssignFile(FTemp,Path+'Temp.lng');        //nolang
Rewrite(FTemp);
try

// On ouvre le nouveau dico en lecture
AssignFile(FModel,Path+'Model.lng');      //nolang
Reset(FModel);
try

// Pour tous les items du nouveau
while not Eof(FModel) do
   begin
   Readln(FModel,WordDico);

   // On ouvre le nouveau dico en lecture
   AssignFile(FNew,NewDico);      //nolang
   Reset(FNew);
   try

   // On cherche la traduction dans le nouveau dico
   TrouveNew:=False;
   while not Eof(FNew) do
      begin
      Readln(FNew,NewWord);
      NewWordRef:=Copy(NewWord,1,Length(WordDico));
      NewWordTrad:=Copy(NewWord,Length(WordDico)+1,Length(NewWord)-Length(WordDico));
//      if NewWordRef=WordDico then
      if Same(NewWordRef,WordDico) then
         begin
         TrouveNew:=True;
         Break;
         end;
      end;

   if not(TrouveNew) then
      begin Showmessage('Erreur !'); continue; end;      
   finally
   CloseFile(FNew);
   end;

   // On ouvre l'ancien dico en lecture
   AssignFile(FOld,OldDico);      //nolang
   Reset(FOld);
   try

   // On cherche la traduction dans l'ancien dico
   TrouveOld:=False;
   while not Eof(FOld) do
      begin
      Readln(FOld,OldWord);
      OldWordRef:=Copy(OldWord,1,Length(WordDico));
      OldWordTrad:=Copy(OldWord,Length(WordDico)+1,Length(OldWord)-Length(WordDico));
      if Same(OldWordRef,WordDico) then
//      if OldWordRef=WordDico then
         begin
         TrouveOld:=True;
         Break;
         end;
      end;

   finally
   CloseFile(FOld);
   end;

   // Si la traduction est vide
   Part:=Copy(NewWord,Length(NewWord)-1,2);
   if Part='''''' then
      begin
      // Si on l'a pas trouvé  dans l'ancien, on l'ecrit le dico temporaire dans avec la traduction vide
      if not(TrouveOld) then //nolang
         Writeln(FTemp,NewWord) //nolang
      else
      // Sinon on ecrit l'ancienne traduction
         Writeln(FTemp,OldWord);
      end
   // Si la, traduction existe
   else
      begin
      // Si on l'a pas trouvé dasn l'ancien on ecrit le nouveau dans le dico temporaire
      if not(TrouveOld) then //nolang
         Writeln(FTemp,NewWord) //nolang
      else
      // Sinon on demande laquelle est la mieux
         begin
          if NewWordTrad<>OldWordTrad then
            begin
            Rapport.AddLine('1) '+NewWord); //nolang
            Rapport.AddLine('Autre )'+OldWord); //nolang
            Rapport.AddLine('');
            Value:='2';
            MyInputQuery('','Choix ?',Value); //nolang
            if StrToInt(Value)=1 then
               Writeln(FTemp,NewWord) //nolang
            else
               Writeln(FTemp,OldWord);
            end
         else Writeln(FTemp,OldWord);
         end;
      end

   end;

finally
CloseFile(FModel);
end;

finally
CloseFile(FTemp);
end;

// On remplace le dico de la langue par le temporaire
// Les chaines inutiles du dico initial de la langue sont effacees
DeleteFile(NewDico);
RenameFile(Path+'\Temp.lng',NewDico); //nolang

finally
Rapport.Quitter.Enabled:=True;
Rapport.BitBtn1.Enabled:=True;
Rapport.BitBtn2.Enabled:=True;
Rapport.BitBtn3.Enabled:=True;
end;

end;


end.
