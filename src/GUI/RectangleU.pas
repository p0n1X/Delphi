unit RectangleU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DialogProcessorU, ShapesU, DisplayProcessorU, StdCtrls, MainFormU, ColorGrd,RectangleShapeU;

type
  TRectForm = class(TForm)
    Width: TLabel;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Button2: TButton;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RectForm: TRectForm;

implementation

{$R *.dfm}


procedure TRectForm.Button2Click(Sender: TObject);

begin
      MainForm.BorderColorClick(sender);

end;

procedure TRectForm.Button3Click(Sender: TObject);
begin
 MainForm.FillColorClick(sender);
end;

procedure TRectForm.Button1Click(Sender: TObject);
var wid:integer;
hei:integer;
fc:TColor;
bc:tcolor;
k :TDialogProcessor;
begin
hei := 300;
wid := 100;
fc := clRed;
bc := clblue;
k := TDialogProcessor.Create;
k.AddRandomRectangle(300,100,clRed,clblue);
k.Free;
end;

end.
