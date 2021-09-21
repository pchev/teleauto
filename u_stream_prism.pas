unit u_stream_prism;

interface

uses sysutils, u_class;

const CompressionMethod_SimpleHuffman=1;
      CompressionMethod_HuffmanDiff=2;

type
     EDataExtractionError=class(Exception);

     TProcessProgress=class
     private
      Gain,Offset:Single;
     public
      constructor Create;
      procedure progress(ProgressValue,ProgressMax:Integer); virtual; abstract;
      procedure SetProgressPonderation(Gain,Offset:Single); virtual;
     end;

     EStreamError=class(Exception);

     TStreamWrite=class
     public
      function GetPosition:LongWord; virtual; abstract;
      procedure AddBit(Value:Boolean); virtual; abstract;
      procedure AddArrayOfBit(const value:array of byte;NbBit:LongWord);  virtual; abstract;
      procedure AddByte(Value:Byte); virtual; abstract;
      procedure AddBuffer(var Value;NbByte:LongWord); virtual; abstract;
     end;

     EFileStreamError=class(EStreamError);
     type TTabBuffer=array[0..MaxInt-1] of byte;
     PTabBuffer=^TTabBuffer;

     TStreamWriteFile=class(TStreamWrite)
     private
      F:File;
      Filename:String;
      FileOpened:Boolean;
      BufferSize,BufferPointer,BufferSizeBit:LongWord;
      Buffer:PTabBuffer;
      procedure flush;
     public
      function GetPosition:LongWord;  override;
      procedure AddBit(Value:Boolean); override;
      procedure AddArrayOfBit(const value:array of byte;NbBit:LongWord); override;
      procedure AddByte(Value:Byte); override;
      procedure AddBuffer(var Value;NbByte:LongWord); override;

      constructor Create(FileName:String;BufferSize:LongWord);
      procedure Init;
      procedure Close;
      destructor Destroy; override;
     end;

     TStreamRead=class
     public
      function getPosition:LongWord; virtual; abstract;
      procedure setPosition(Position:LongWord); virtual; abstract;
      function ReadBit:Integer; virtual; abstract;
      function ReadByte:Byte; virtual; abstract;
      procedure ReadBuffer(var Value;NbByte:LongWord); virtual; abstract;
     end;

     TStreamReadFile=class(TStreamRead)
     private
      F:File;
      Filename:String;
      FileOpened:Boolean;
      BufferSize,BufferPointer,BufferFilled:LongWord;
      Buffer:PTabBuffer;
      procedure read;
     public
      function getPosition:LongWord; override;
      procedure setPosition(Position:LongWord); override;
      function ReadBit:Integer; override;
      function ReadByte:Byte; override;
      procedure ReadBuffer(var Value;NbByte:LongWord); override;

      constructor Create(FileName:String;BufferSize:LongWord);
      procedure Init;
      procedure Close;
      destructor Destroy; override;
     end;

procedure HuffmanDiffUnCompression(InputStream:TStreamRead;LargX,LargY:Integer;TypeData:Integer;Image:Pointer;X1,Y1,X2,Y2:Integer;ProcessProgress:TProcessProgress);
procedure HuffmanDiffCompression(LargX,LargY:Integer;TypeData:Integer;Image:Pointer;OutPutStream:TStreamWrite;ProcessProgress:TProcessProgress);

implementation

uses u_lang;

constructor TProcessProgress.Create;
begin
 inherited Create;
 Gain:=1;
 Offset:=0;
end;
procedure TProcessProgress.SetProgressPonderation(Gain,Offset:Single);
begin
 Self.Gain:=Gain;
 Self.Offset:=Offset;
end;

function  Min(Int1,Int2:Integer):Integer;
begin
 if Int1>Int2 then
  Result:=Int2
 else
  Result:=Int1;
end;

constructor TStreamWriteFile.Create(FileName:String;BufferSize:LongWord);
begin
 inherited Create;
 Self.FileName:=FileName;
 Self.BufferSize:=BufferSize;
 BufferSizeBit:=BufferSize shl 3;
 Buffer:=Nil;
 FileOpened:=False;
end;

procedure TStreamWriteFile.Init;
begin
 if FileOpened then
  Close;
 assignFile(F,FileName);
 try
 rewrite(F,1);
 FileOpened:=True;
 if Buffer=Nil then
  getmem(Buffer,BufferSize);
 fillchar(Buffer^,BufferSize,0);
 BufferPointer:=0;
 except
  on E:EOutOfMemory do
   raise EFileStreamError.Create(lang('Pas assez de mémoire disponible')); 
  on E:EInOutError do
   raise EFileStreamError.Create(E.Message);
 end;
end;

procedure TStreamWriteFile.Close;
begin
 flush;
 if FileOpened then
 begin
  closeFile(F);
  FileOpened:=False;
 end;
end;

procedure TStreamWriteFile.flush;
begin
 try
 if BufferPointer>0 then
 begin
  BlockWrite(F,Buffer^,((BufferPointer+7) shr 3));
  BufferPointer:=0;
  fillchar(Buffer^,BufferSize,0);
 end;
 except
  on E:EInOutError do
   raise EFileStreamError.Create(E.Message);
 end;
end;

function TStreamWriteFile.GetPosition:LongWord;
var FileP:LongWord;
begin
 try
 FileP:=FilePos(F);
 result:=FileP+BufferPointer;
 except
  on E:EInOutError do
   raise EFileStreamError.Create(E.Message);
 end;
end;

procedure TStreamWriteFile.AddBit(Value:Boolean);
var BytePos,BitPos:LongWord;
begin
 if BufferPointer>=BufferSizeBit then
  flush;
 if Value then
 begin
  BytePos:=BufferPointer shr 3;
  BitPos:=BufferPointer and $00000007;
  Buffer[BytePos]:=Buffer[BytePos] or (1 shl BitPos);
 end;          
 inc(BufferPointer);
end;

procedure TStreamWriteFile.AddArrayOfBit(const value:array of byte;NbBit:LongWord);
var I:LongWord;
begin                               
 for I:=0 to NbBit-1 do
 begin
  if BufferPointer>=BufferSizeBit then
   flush;
  if boolean((Value[I shr 3] shr (I and $00000007)) and 1) then
   Buffer[BufferPointer shr 3]:=Buffer[BufferPointer shr 3] or (1 shl (BufferPointer and $00000007));
  inc(BufferPointer);
 end;
end;

procedure TStreamWriteFile.AddByte(Value:Byte);
begin
 BufferPointer:=(BufferPointer+7) and $FFFFFFF8;
 if BufferPointer>=BufferSizeBit then
  flush;
 Buffer[BufferPointer shr 3]:=Value;
 inc(BufferPointer,8);
end;

procedure TStreamWriteFile.AddBuffer(var Value;NbByte:LongWord);
var InterI,NbByteToWrite:LongWord;
begin
 NbByteToWrite:=NbByte;
 while NbByteToWrite>0 do
 begin
  BufferPointer:=(BufferPointer+7) and $FFFFFFF8;
  if BufferPointer>=BufferSizeBit then
   flush;
  InterI:=min(NbByteToWrite,((BufferSizeBit-BufferPointer) shr 3));
  move(TTabBuffer(Value)[NbByte-NbByteToWrite],Buffer[BufferPointer shr 3],InterI);
  NbByteToWrite:=NbByteToWrite-InterI;
  BufferPointer:=BufferPointer+InterI shl 3;
 end; 
end;

destructor TStreamWriteFile.Destroy;
begin
 if Buffer<>Nil then
  freemem(Buffer,BufferSize);
 inherited Destroy;
end;







constructor TStreamReadFile.Create(FileName:String;BufferSize:LongWord);
begin
 inherited Create;
 Self.Filename:=Filename;
 Self.BufferSize:=BufferSize;
 Buffer:=Nil;
 FileOpened:=False;
end;
procedure TStreamReadFile.Init;
begin
 if FileOpened then
  Close;
 assignFile(F,FileName);
 try
 reset(F,1);
 FileOpened:=True;

 if Buffer=Nil then
  getmem(Buffer,BufferSize);
 BufferPointer:=0;
 BufferFilled:=0;

 except
  on E:EOutOfMemory do
   raise EFileStreamError.Create(lang('Pas assez de mémoire disponible')); 
  on E:EInOutError do
   raise EFileStreamError.Create(E.Message);
 end;
end;

procedure TStreamReadFile.Close;
begin
 if FileOpened then
 begin
  closeFile(F);
  FileOpened:=False;
 end;
end;

procedure TStreamReadFile.read;
var FileS,FileP:LongWord;
begin                  
 try
 BufferFilled:=0;
 if EOF(F) then Exit;
//  raise EFileStreamError.Create(lang('Lecture au delà de la fin du fichier !'));
 FileP:=FilePos(F);
 FileS:=FileSize(F);
 BufferFilled:=Min(BufferSize,FileS-FileP);
 BlockRead(F,Buffer^,BufferFilled);
 BufferFilled:=BufferFilled shl 3;
 BufferPointer:=0;

 except
  on E:EInOutError do
   raise EFileStreamError.Create(E.Message);
 end;
end;
       
function TStreamReadFile.getPosition:LongWord;
var FileP:LongWord;                                                            
begin
 try
 FileP:=FilePos(F); 
 FileP:=(FileP shl 3)-BufferFilled;
 Result:=BufferPointer+FileP;
 except
  on E:EInOutError do
   raise EFileStreamError.Create(E.Message);
 end;
end;

procedure TStreamReadFile.setPosition(Position:LongWord);
begin
 try
 Seek(F,Position shr 3);
 Read;
 BufferPointer:=Position and $00000007;
 except
  on E:EInOutError do
   raise EFileStreamError.Create(E.Message);
 end;
end;

function TStreamReadFile.ReadBit:Integer;
begin
 if BufferPointer>=BufferFilled then
  read;
 result:=(Buffer[BufferPointer shr 3] shr (BufferPointer and $00000007)) and 1;
 inc(BufferPointer);
end;

function TStreamReadFile.ReadByte:Byte;
begin
 BufferPointer:=(BufferPointer+7) and $FFFFFFF8;
 if BufferPointer>=BufferFilled then
  Read;
 Result:=Buffer[BufferPointer shr 3];
 inc(BufferPointer,8);
end;

procedure TStreamReadFile.ReadBuffer(var Value;NbByte:LongWord); 
var InterI,NbByteToRead:LongWord;
begin
 NbByteToRead:=NbByte;
 while NbByteToRead>0 do
 begin
  BufferPointer:=(BufferPointer+7) and $FFFFFFF8;
  if BufferPointer>=BufferFilled then
   Read;
  InterI:=min(NbByteToRead,((BufferFilled-BufferPointer) shr 3));
  move(Buffer[BufferPointer shr 3],TTabBuffer(Value)[NbByte-NbByteToRead],InterI);
  NbByteToRead:=NbByteToRead-InterI;
  BufferPointer:=BufferPointer+InterI shl 3;
 end;
end;


destructor TStreamReadFile.Destroy;
begin
 if Buffer<>Nil then
  freemem(Buffer,BufferSize);
 inherited Destroy;
end;

procedure HuffmanDiffUnCompression(InputStream:TStreamRead;LargX,LargY:Integer;TypeData:Integer;Image:Pointer;X1,Y1,X2,Y2:Integer;ProcessProgress:TProcessProgress);
type PNode=^TNode;
     TNode=record
      NodeChild:array[0..1] of PNode;
      Value:Byte;
     end;
     TTree=array[0..511] of TNode;


var I,J,InterI,InterI2:Integer;
    InterLW:LongWord;
    InterS:Single;
    Tree:TTree;
    SizeCompressed:Longword;
    CompressionMethod:Integer;

    Img_Byt:PImgByte;
    Img_Int:PImgInt;
    Img_Single:PImgSingle;


    LinePosition:PLigLongWord;

    Y1CurrentPosition:Integer;

    EndOfStreamPosition:LongWord;


procedure CreateTree;
var I,J:Integer;
    BitValue:Integer;
    SizeBitRepresentation:array[0..255] of byte;

    CurrentNode:PNode;
    LastFreeNode:Integer;
begin
 try
 for I:=0 to 255 do
  SizeBitRepresentation[I]:=InputStream.ReadByte;
 except
  on E:EFileStreamError do
   raise EDataExtractionError.create('6');
 end;

 fillchar(Tree,SizeOf(Tree),0);
 LastFreeNode:=1;
 try
 for I:=0 to 255 do
 begin
  CurrentNode:=@Tree[0];
  for J:=1 to SizeBitRepresentation[I] do
  begin
   BitValue:=InputStream.ReadBit;
   if CurrentNode.NodeChild[BitValue]=Nil then
   begin
    if LastFreeNode>=512 then
     raise EDataExtractionError.create('5');
    CurrentNode.NodeChild[BitValue]:=@Tree[LastFreeNode];
    inc(LastFreeNode);
   end;
   CurrentNode:=CurrentNode.NodeChild[BitValue];
  end;
  CurrentNode.Value:=I;
 end;
 except
  on E:EFileStreamError do
   raise EDataExtractionError.create('4');
 end;
end;


function ExtractValue:Integer;
var BitValue:Integer;
    CurrentNode:PNode;
begin
 CurrentNode:=@Tree[0];
 while (CurrentNode.NodeChild[0]<>Nil) or (CurrentNode.NodeChild[1]<>Nil) do
 begin
  BitValue:=InputStream.ReadBit;
  CurrentNode:=CurrentNode.NodeChild[BitValue];
  if CurrentNode=Nil then
   raise EDataExtractionError.create('3');
 end;
 Result:=CurrentNode.Value;
end;

begin
 Img_Byt:=Nil;
 Img_Int:=Nil;
 Img_Single:=Nil;

 case TypeData of
  1:Img_Byt:=Image;
  2:Img_Int:=Image;
  4:Img_Single:=Image;
 end;
 CompressionMethod:=InputStream.ReadByte;
 InputStream.ReadBuffer(SizeCompressed,4);

 case TypeData of
  1:if not (CompressionMethod in [CompressionMethod_SimpleHuffman]) then
     raise EDataExtractionError.create('2');
  2:if not (CompressionMethod in [CompressionMethod_SimpleHuffman,CompressionMethod_HuffmanDiff]) then
     raise EDataExtractionError.create('2');
  4:if not (CompressionMethod in [CompressionMethod_SimpleHuffman]) then
     raise EDataExtractionError.create('2');
  6:if not (CompressionMethod in [CompressionMethod_SimpleHuffman]) then
     raise EDataExtractionError.create('2');
 end;

 try

 getmem(LinePosition,((LargY shr 3)+1)*SizeOf(LongWord));
 try

 if Y1<>1 then
 begin
  //Find the line number Y1 position
  InterLW:=InputStream.getPosition;
  InputStream.setPosition(InterLW+SizeCompressed shl 3);
  //Line positions every each 8 lines
  InterI:=((LargY shr 3)+1)*SizeOf(LongWord);
  InputStream.ReadBuffer(LinePosition^,InterI);
  InputStream.setPosition(InterLW);
 end;

 EndOfStreamPosition:=InputStream.getPosition+SizeCompressed shl 3+((((LongWord(LargY) shr 3)+1)*SizeOf(LongWord)) shl 3);
 


 CreateTree;
 Y1CurrentPosition:=1;
 if Y1<>1 then
 begin
  //seek the line number Y1
  InterLW:=InputStream.getPosition;
  //Line positions every each 8 lines
  InterI:=(Y1-1) and $FFFFFFF8;
  InputStream.setPosition(InterLW+LinePosition[(InterI shr 3)+1]);
  Y1CurrentPosition:=InterI;
 end;

 if CompressionMethod=CompressionMethod_SimpleHuffman then
 begin
  case TypeData of
   1:begin
      for I:=Y1CurrentPosition to Y1-1 do
       for J:=1 to LargX do
        ExtractValue;

      for I:=Y1 to Y2 do
      begin
       if assigned(ProcessProgress) then
        ProcessProgress.progress(I-1,LargY-Y1);

       for J:=1 to X1-1 do
        ExtractValue;
       for J:=X1 to X2 do
        Img_Byt[I-Y1+1][J-X1+1]:=ExtractValue;
       for J:=X2+1 to LargX do
        ExtractValue;
      end;
     end;
   2:begin
      for I:=Y1CurrentPosition to Y1-1 do
       for J:=1 to LargX do
       begin
        ExtractValue;
        ExtractValue;
       end;

      for I:=Y1 to Y2 do
      begin
       if assigned(ProcessProgress) then
        ProcessProgress.progress(I-1,LargY-Y1);

       for J:=1 to X1-1 do
       begin
        ExtractValue;
        ExtractValue;
       end;
       for J:=1 to LargX do
       begin
        InterI:=ExtractValue;
        InterI:=(InterI or (ExtractValue shl 8))-32768;
        Img_Int[I-Y1+1][J-X1+1]:=InterI;
       end;

       for J:=X2+1 to LargX do
       begin
        ExtractValue;
        ExtractValue;
       end;
      end;
     end;
   4:begin
      for I:=Y1CurrentPosition to Y1-1 do
       for J:=1 to LargX do
       begin
        ExtractValue;
        ExtractValue;
        ExtractValue;
        ExtractValue;
       end;

      for I:=Y1 to Y2 do
      begin
       if assigned(ProcessProgress) then
        ProcessProgress.progress(I-1,LargY-Y1);


       for J:=1 to X1-1 do
       begin
        ExtractValue;
        ExtractValue;
        ExtractValue;
        ExtractValue;
       end;

       for J:=1 to LargX do
       begin
        InterI:=ExtractValue;
        InterI:=InterI or (ExtractValue shl 8);
        InterI:=InterI or (ExtractValue shl 16);
        InterI:=InterI or (ExtractValue shl 24);
        asm
         mov eax,InterI
         mov InterS,eax
        end;
        Img_Single[I-Y1+1][J-X1+1]:=InterS;
       end;

       for J:=X2+1 to LargX do
       begin
        ExtractValue;
        ExtractValue;
        ExtractValue;
        ExtractValue;
       end;
     end;
     end;
  6:begin
      for I:=Y1CurrentPosition to Y1-1 do
       for J:=1 to LargX do
       begin
        ExtractValue;
        ExtractValue;
        ExtractValue;
        ExtractValue;
        ExtractValue;
        ExtractValue;
        ExtractValue;
        ExtractValue;
       end;

      for I:=Y1 to Y2 do
      begin
       if assigned(ProcessProgress) then
        ProcessProgress.progress(I-1,LargY-Y1);

       for J:=1 to X1-1 do
       begin
        ExtractValue;
        ExtractValue;
        ExtractValue;
        ExtractValue;
        ExtractValue;
        ExtractValue;
        ExtractValue;
        ExtractValue;
       end;

       for J:=1 to LargX do
       begin
        InterI:=ExtractValue;
        InterI:=InterI or (ExtractValue shl 8);
        InterI:=InterI or (ExtractValue shl 16);
        InterI:=InterI or (ExtractValue shl 24);
        asm
         mov eax,InterI
         mov InterS,eax
        end;
        InterI:=ExtractValue;
        InterI:=InterI or (ExtractValue shl 8);
        InterI:=InterI or (ExtractValue shl 16);
        InterI:=InterI or (ExtractValue shl 24);
        asm
         mov eax,InterI
         mov InterS,eax
        end;
       end;

       for J:=X2+1 to LargX do
       begin
        ExtractValue;
        ExtractValue;
        ExtractValue;
        ExtractValue;
        ExtractValue;
        ExtractValue;
        ExtractValue;
        ExtractValue;
       end;

      end;
     end;
  end;
 end
 else
 begin
  for I:=Y1CurrentPosition to Y1-1 do
  begin
   InterI2:=ExtractValue;
   InterI:=(InterI2 or (ExtractValue shl 8))-32768;
   for J:=2 to LargX do
   begin
    InterI2:=ExtractValue;
    if InterI2<>0 then
     InterI:=InterI2-128+InterI
    else
    begin
     InterI2:=ExtractValue;
     InterI:=(InterI2 or (ExtractValue shl 8))-32768;
    end;
   end;
  end;

  for I:=Y1 to Y2 do
  begin
   if assigned(ProcessProgress) then
    ProcessProgress.progress(I-1,LargY-Y1);

   InterI2:=ExtractValue;
   InterI:=(InterI2 or (ExtractValue shl 8))-32768;

   if X1=1 then
    Img_Int[I-Y1+1][1]:=InterI;
   for J:=2 to LargX do
   begin
    InterI2:=ExtractValue;
    if InterI2<>0 then
     InterI:=InterI2-128+InterI
    else
    begin
     InterI2:=ExtractValue;
     InterI:=(InterI2 or (ExtractValue shl 8))-32768;
    end;
    if (J>=X1) and (J<=X2) then
     Img_Int[I-Y1+1][J-X1+1]:=InterI;
   end;
  end;
 end;

 //Go to the end of the file if possible  (Stream principle)
 try
 InputStream.setPosition(EndOfStreamPosition);
 except
  on E:EFileStreamError do;
 end;

 finally
 freemem(LinePosition,((LargY shr 3)+1)*SizeOf(LongWord));
 end;
 except
  on E:EFileStreamError do
   raise EDataExtractionError.create('1');
 end;

end;

procedure HuffmanDiffCompression(LargX,LargY:Integer;TypeData:Integer;Image:Pointer;OutPutStream:TStreamWrite;ProcessProgress:TProcessProgress);
type TTabBuffer=array[0..MaxInt-1] of byte;
     PTabBuffer=^TTabBuffer;

     TRepresentation=record
      Value:array[0..31] of byte;
      NbBit:Byte;
     end;
     TTabRepresentation=array[0..255] of TRepresentation;

var I,J,K,InterI,InterI2:Integer;
    InterS:Single;

    BitPointer:LongWord;
    Histo:array[0..255] of LongWord;
    HistoIndex:array[0..255] of LongWord;

    TabRepresentation:TTabRepresentation;

    CompressionMethod:Integer;
    ImageSize,SizeCompressed:LongWord;

    Img_Byt:PImgByte;
    Img_Int:PImgInt;
    Img_Single:PImgSingle;

    LinePosition:PLigLongWord;

procedure AddBit(Buffer:Pointer;BitPointer:LongWord;BitValue:Boolean);
begin
 if BitValue then
  PTabBuffer(Buffer)[BitPointer shr 3]:=PTabBuffer(Buffer)[BitPointer shr 3] or (1 shl (BitPointer and $00000007));
end;

procedure AddHuffmanValue(Value:Integer);
begin
 OutPutStream.AddArrayOfBit(TabRepresentation[Value].Value,TabRepresentation[Value].NbBit);
 inc(BitPointer,TabRepresentation[Value].NbBit);
end;

procedure CreateTree(K:LongWord;I1,I2:Integer);
var I,J:Integer;
    Sum:LongWord;
begin
 I:=I1;
 Sum:=Histo[I];
 while Sum<(K shr 1) do
 begin
  inc(I);
  Sum:=Sum+Histo[I];
 end;

 //"Arrondi"
 if I<>I1 then
  if abs(Sum-(K shr 1))>abs(Sum-Histo[I]-(K shr 1)) then
  begin
   Sum:=Sum-Histo[I];
   dec(I);
  end;

 for J:=I1 to I do
 begin
  addBit(@TabRepresentation[HistoIndex[J]].Value,TabRepresentation[HistoIndex[J]].NbBit,False);
  inc(TabRepresentation[HistoIndex[J]].NbBit);
 end;
 for J:=I+1 to I2 do
 begin
  addBit(@TabRepresentation[HistoIndex[J]].Value,TabRepresentation[HistoIndex[J]].NbBit,True);
  inc(TabRepresentation[HistoIndex[J]].NbBit);
 end;

 if I>I1 then
  CreateTree(Sum,I1,I);
 if I+1<I2 then
  CreateTree(K-Sum,I+1,I2);
end;

begin

 Img_Byt:=Nil;
 Img_Int:=Nil;
 Img_Single:=Nil;
 ImageSize:=0;

 case TypeData of
  1:begin
     Img_Byt:=Image;
     ImageSize:=LargX*LargY;
     SizeCompressed:=ImageSize;
    end;
  2:begin
     Img_Int:=Image;
     ImageSize:=LargX*LargY*2;
     SizeCompressed:=ImageSize;
    end;
  4:begin
     Img_Single:=Image;
     ImageSize:=LargX*LargY*4;
     SizeCompressed:=ImageSize;
    end;
 end;

 //Line positions every each 8 lines
 getmem(LinePosition,((LargY shr 3)+1)*SizeOf(LongWord));
 try

 case TypeData of
  2:begin
     //Image analysis and Huffman init
     fillchar(Histo,SizeOf(Histo),0);
     SizeCompressed:=0;
     for I:=1 to LargY do
     begin
      InterI:=Img_Int[I][1];
      InterI2:=InterI+32768;
      inc(Histo[byte(InterI2)]);
      inc(Histo[byte(InterI2 shr 8)]);
      inc(SizeCompressed,2);
      for J:=2 to LargX do
      begin
       InterI2:=Img_Int[I][J]-InterI;
       InterI:=Img_Int[I][J];
       if abs(InterI2)<=127 then
       begin
        inc(Histo[InterI2+128]);
        inc(SizeCompressed);
       end
       else
       begin
        InterI2:=InterI+32768;
        inc(Histo[0]);
        inc(Histo[byte(InterI2)]);
        inc(Histo[byte(InterI2 shr 8)]);
        inc(SizeCompressed,3);
       end;
      end;
     end;
    end;
 end;


 if SizeCompressed>=ImageSize then
 begin
  CompressionMethod:=CompressionMethod_SimpleHuffman;
  SizeCompressed:=ImageSize;
  //Image analysis and Huffman init
  fillchar(Histo,SizeOf(Histo),0);
  case TypeData of
   1:begin
      for I:=1 to LargY do
       for J:=1 to LargX do
        inc(Histo[Img_Byt[I][J]]);
     end;
   2:begin
      for I:=1 to LargY do
       for J:=1 to LargX do
       begin
        InterI:=Img_Int[I][J];
        InterI:=InterI+32768;
        inc(Histo[byte(InterI)]);
        inc(Histo[byte(InterI shr 8)]);
       end;
     end;
   4:begin
      for I:=1 to LargY do
       for J:=1 to LargX do
       begin
        InterS:=Img_Single[I][J];
        asm
         mov eax,InterS
         mov InterI,eax
        end;
        inc(Histo[byte(InterI)]);
        inc(Histo[byte(InterI shr 8)]);
        inc(Histo[byte(InterI shr 16)]);
        inc(Histo[byte(InterI shr 24)]);
       end;
     end;
  6:begin
      for I:=1 to LargY do
       for J:=1 to LargX do
       begin
        asm
         mov eax,InterS
         mov InterI,eax
        end;
        inc(Histo[byte(InterI)]);
        inc(Histo[byte(InterI shr 8)]);
        inc(Histo[byte(InterI shr 16)]);
        inc(Histo[byte(InterI shr 24)]);
        asm
         mov eax,InterS
         mov InterI,eax
        end;
        inc(Histo[byte(InterI)]);
        inc(Histo[byte(InterI shr 8)]);
        inc(Histo[byte(InterI shr 16)]);
        inc(Histo[byte(InterI shr 24)]);
       end;
     end;
  end;
 end
 else
  CompressionMethod:=CompressionMethod_HuffmanDiff;

 //Sort
 for I:=0 to 255 do
  HistoIndex[I]:=I;
 for I:=0 to 254 do
  for J:=255 downto I+1 do
  begin
   if Histo[I]<Histo[J] then
   begin
    InterI:=Histo[I];
    Histo[I]:=Histo[J];
    Histo[J]:=InterI;
    InterI:=HistoIndex[I];
    HistoIndex[I]:=HistoIndex[J];
    HistoIndex[J]:=InterI;
   end;
  end;


 //Tree
 fillchar(TabRepresentation,SizeOf(TabRepresentation),0);
 CreateTree(SizeCompressed,0,255);


 //Compressed size calculation
 BitPointer:=256*8;
 for I:=0 to 255 do
  inc(BitPointer,TabRepresentation[HistoIndex[I]].NbBit*Histo[I]);
 for I:=0 to 255 do
  inc(BitPointer,TabRepresentation[I].NbBit);
 SizeCompressed:=((BitPointer+7) shr 3);

 OutputStream.AddByte(CompressionMethod);
 OutputStream.AddBuffer(SizeCompressed,4);


 //Copy Tree
 //Copy nbBit tab
 for I:=0 to 255 do
  OutputStream.AddByte(TabRepresentation[I].NbBit);

 //Copy bit tab
 for I:=0 to 255 do
  AddHuffmanValue(I);

 BitPointer:=0;
 //Copy compressed data
 if CompressionMethod=CompressionMethod_SimpleHuffman then
 begin
  case TypeData of
   1:begin
      for I:=1 to LargY do
      begin
       if assigned(ProcessProgress) then
        ProcessProgress.progress(I-1,LargY-1);

       if (((I-1) and $00000007)=0) then
        LinePosition[((I-1) shr 3)+1]:=BitPointer;

       for J:=1 to LargX do
        AddHuffmanValue(Img_Byt[I][J]);
      end;
     end;
   2:begin
      for I:=1 to LargY do
      begin
       if assigned(ProcessProgress) then
        ProcessProgress.progress(I-1,LargY-1);

       if (((I-1) and $00000007)=0) then
        LinePosition[((I-1) shr 3)+1]:=BitPointer;

       for J:=1 to LargX do
       begin
        InterI:=Img_Int[I][J];
        InterI:=InterI+32768;
        AddHuffmanValue(byte(InterI));
        AddHuffmanValue(byte(InterI shr 8));
       end;
      end;
     end;
   4:begin
      for I:=1 to LargY do
      begin
       if assigned(ProcessProgress) then
        ProcessProgress.progress(I-1,LargY-1);

       if (((I-1) and $00000007)=0) then
        LinePosition[((I-1) shr 3)+1]:=BitPointer;

       for J:=1 to LargX do
       begin
        InterS:=Img_Single[I][J];
        asm
         mov eax,InterS
         mov InterI,eax
        end;
        AddHuffmanValue(byte(InterI));
        AddHuffmanValue(byte(InterI shr 8));
        AddHuffmanValue(byte(InterI shr 16));
        AddHuffmanValue(byte(InterI shr 24));
       end;
      end;
     end;
  6:begin
      for I:=1 to LargY do
      begin
       if assigned(ProcessProgress) then
        ProcessProgress.progress(I-1,LargY-1);

       if (((I-1) and $00000007)=0) then
        LinePosition[((I-1) shr 3)+1]:=BitPointer;

       for J:=1 to LargX do
       begin
        asm
         mov eax,InterS
         mov InterI,eax
        end;
        AddHuffmanValue(byte(InterI));
        AddHuffmanValue(byte(InterI shr 8));
        AddHuffmanValue(byte(InterI shr 16));
        AddHuffmanValue(byte(InterI shr 24));
        asm
         mov eax,InterS
         mov InterI,eax
        end;
        AddHuffmanValue(byte(InterI));
        AddHuffmanValue(byte(InterI shr 8));
        AddHuffmanValue(byte(InterI shr 16));
        AddHuffmanValue(byte(InterI shr 24));
       end;
      end;
     end;
  end;
 end
 else
 begin
  for I:=1 to LargY do
  begin
   if assigned(ProcessProgress) then
    ProcessProgress.progress(I-1,LargY-1);

   if (((I-1) and $00000007)=0) then
    LinePosition[((I-1) shr 3)+1]:=BitPointer;


   InterI:=Img_Int[I][1];
   InterI2:=InterI+32768;
   AddHuffmanValue(byte(InterI2));
   AddHuffmanValue(byte(InterI2 shr 8));
   for J:=2 to LargX do
   begin
    InterI2:=Img_Int[I][J]-InterI;
    InterI:=Img_Int[I][J];
    if abs(InterI2)<=127 then
     AddHuffmanValue(byte(InterI2+128))
    else
    begin
     InterI2:=InterI+32768;
     AddHuffmanValue(byte(0));
     AddHuffmanValue(byte(InterI2));
     AddHuffmanValue(byte(InterI2 shr 8));
    end;
   end;
  end;
 end;

 //Line positions
 OutputStream.AddBuffer(LinePosition^,((LargY shr 3)+1)*SizeOf(LongWord));

 finally
 freemem(LinePosition,((LargY shr 3)+1)*SizeOf(LongWord));
 end;
end;


end.
   
