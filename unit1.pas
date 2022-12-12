unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, BASS;

type

  { TForm1 }

  TForm1 = class(TForm)
    ComboBox1: TComboBox;
    ListBox1: TListBox;
    procedure ComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
  private

  public
     channel:HSTREAM;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ListBox1Click(Sender: TObject);
var
  fileserver:string;
  reader:string;
  lastpart:String;   //string variable
begin
  case ComboBox1.ItemIndex of    //choose reader index start with 0
  0:
  begin
      fileserver:=IntToStr(10);
      reader:='ajm';
  end;
  1:
  begin
     fileserver:=IntToStr(10);
      reader:='minsh';
  end;
  2:
  Begin
      fileserver:=IntToStr(8);
      reader:='ahmad_huth';
  end;
  3:
  begin
      fileserver:=IntToStr(11);
      reader:='shatri';
  end;
   4:
   begin
      fileserver:=IntToStr(7);
      reader:='Almusshaf-Al-Mojawwad';
   end;
   5:
   begin
      fileserver:=IntToStr(8);
      reader:='ayyub';
   end;
   end;
  case ListBox1.ItemIndex of    //choose surah name index start with 0
   0..9:    // o to 9
  begin
     lastpart:='00'+IntToStr(ListBox1.ItemIndex+1)+'.mp3'; // 0+1=1 001
  end;
   10..99:  //10 to 99
   Begin
      lastpart:='0'+IntToStr(ListBox1.ItemIndex+1)+'.mp3';   //ex: 74+1 =75 075
   end;
   100..114:        //100 to 114
   begin
      lastpart:=IntToStr(ListBox1.ItemIndex+1)+'.mp3';   // 110+1 =111
   end;
   end;
   //ShowMessage('https://server'+fileserver+'.mp3quran.net/'+ reader + '/' + lastpart);
   if channel>0 then  // if channel lrunning then stop it
  begin
    BASS_StreamFree(channel);
    channel:=0;
  end;
  //filename:=;
channel:= BASS_StreamCreateURL(PAnsiChar('https://server'+fileserver+'.mp3quran.net/'+ reader + '/' + lastpart), 0,BASS_STREAM_STATUS,nil,nil);
BASS_ChannelPlay(channel,false);  // play file from begining
  end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   if not BASS_Init(-1, 44100, 0, Handle, nil) then      //intiate bass
  showmessage('Error initializing audio!');
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
     BASS_ChannelStop(channel,false);     //close the channel
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin

end;


end.

