unit MainFormU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, Menus, Buttons, ToolWin,
  DialogProcessorU, ShapesU, ExtDlgs, StdCtrls;

type
    
  /// ����� �������� ����� � �������� PaintBox, ����� ����� �� ����������� ��������������
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Edit1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    StatusBar1: TStatusBar;
    SpeedBar: TToolBar;
    DrawRectangleSpeedButton: TSpeedButton;
    PickUpSpeedButton: TSpeedButton;
    ViewPort: TPaintBox;
    DrawElipsesSpeedButoon: TSpeedButton;
    triagle: TSpeedButton;
    FillColor: TSpeedButton;
    ColorDialog1: TColorDialog;
    BorderColor: TSpeedButton;
    SaveAsButton: TMenuItem;
    SavePictureDialog1: TSavePictureDialog;
    Create1: TMenuItem;
    Rectangle1: TMenuItem;
    Krag1: TMenuItem;
    Triangle: TMenuItem;
    SpeedButton3: TSpeedButton;
    GroupButton: TSpeedButton;
    SaveProject1: TMenuItem;
    OpenProject1: TMenuItem;
    N1: TMenuItem;
    Rotate2: TMenuItem;
    Scale1: TMenuItem;
    BorderColor1: TMenuItem;
    BorderWidth1: TMenuItem;
    FillColor1: TMenuItem;
    N3: TMenuItem;
    ools1: TMenuItem;
    Group1: TMenuItem;
    Ungroup1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Rotate: TSpeedButton;
    UnGroup: TSpeedButton;
    NewProject1: TMenuItem;
    NewProject: TSpeedButton;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    N2: TMenuItem;
    NewRect: TSpeedButton;
    procedure Exit1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ViewPortPaint(Sender: TObject);
    procedure DrawRectangleSpeedButtonClick(Sender: TObject);
    procedure ViewPortMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ViewPortMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ViewPortMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DrawElipsesSpeedButoonClick(Sender: TObject);
    procedure triagleClick(Sender: TObject);
    procedure FillColorClick(Sender: TObject);
    procedure BorderColorClick(Sender: TObject);
    procedure SaveAsButtonClick(Sender: TObject);
    procedure GroupButtonClick(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Group1Click(Sender: TObject);
    procedure Rectangle1Click(Sender: TObject);
    procedure BorderColor1Click(Sender: TObject);
    procedure FillColor1Click(Sender: TObject);
    procedure SaveProject1Click(Sender: TObject);
    procedure TriangleClick(Sender: TObject);
    procedure Krag1Click(Sender: TObject);
    procedure RotateClick(Sender: TObject);
    procedure UnGroupClick(Sender: TObject);
    procedure NewProject1Click(Sender: TObject);
    procedure NewProjectClick(Sender: TObject);
    procedure NewRectClick(Sender: TObject);
  private
    /// ����������� �������� �������� ��� ������� �������� ������������� �� ������.
    DialogProcessor : TDialogProcessor;

    // ����� ��� �������� ����������
    B: TBitmap;

  public
    { Public declarations }
	/// ���������� Windows ��������� � ��� ��������������� ������������ �� ���� �� ���������,
	/// � ����� �� ������������� ������������ ��� ������������.
    procedure OnVMPaint(var Param: TWMEraseBkgnd); message WM_ERASEBKGND;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses contnrs, RectangleU;

/// ��� ��������� �� ������� �� ������� � ����������� ��������.
procedure TMainForm.FormCreate(Sender: TObject);
begin
  DialogProcessor := TDialogProcessor.Create;
  B := TBitmap.Create;
end;

/// ����� �� ����������. ������� �������� �����, � � ���� � ����������.
procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

/// ���������, ����� �� ��������, �� �� �� �������������� ��� �������� �� ������.
procedure TMainForm.ViewPortPaint(Sender: TObject);
begin
  // ������ ���������� ���� �������� ������ B
  B.Width := ClientWidth;
  B.Height := ClientHeight;
  B.Canvas.Brush.Color := clWhite;
  B.Canvas.FillRect(ClientRect);
  // ������������ � B
  DialogProcessor.ReDraw(Sender, B.Canvas);
  // �������� �� ������������� �� B �� ������
  ViewPort.Canvas.Draw(0, 0, B);
end;

/// �����, ����� ������� �� ���������� ����� ������������ ��� ���������� �������.
/// ������� �� ������� ��� ����������� � �� ���������� PaintBox-�.
procedure TMainForm.DrawRectangleSpeedButtonClick(Sender: TObject);
var width:integer; height:integer;
fillc:TColor; borderc:TColor;
begin

  width := 150;
  height :=20;
  fillc := clBlack;
  borderc := clRed;

  DialogProcessor.AddRandomRectangle(width,height, fillc, borderc);

  StatusBar1.Panels.Items[0].Text := '�������� ��������: �������� �� ������������';

  ViewPort.Invalidate;
end;

/// ���������� �� ������������ ��� ����������� �� ����� �� ������� � �������� (� ������� ���) ���� �� �
/// �������� ����� �������. ��� � ���� �� ��� �� ��������� ���� ���������� � ������� ������ �� "�������".
/// ������� �� ������� � ������������ �� ��������, � ����� �������������.
/// ������������ �� �������� � �����������, ��� ����� �� ������ "���-������" ������� �� ������.
procedure TMainForm.ViewPortMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var
  S:TShapes;
begin
  if PickUpSpeedButton.Down and (ssCtrl in Shift) then
    begin
    S:=DialogProcessor.ContainsPoint(Point(X,Y));
    if S<>nil then
    begin
//      DialogProcessor.Selection := S;
      if DialogProcessor.Selection.IndexOf(S)<0 then
      DialogProcessor.Selection.Add(S)
        else
         DialogProcessor.Selection.Remove(S);

          StatusBar1.Panels[0].Text := '�������� ��������: �������� �� ��������';
          DialogProcessor.IsDragging := True;
          DialogProcessor.LastLocation := Point(X, Y);
          ViewPort.Invalidate;
      end;
    end
    else if PickUpSpeedButton.Down then
    begin
    S:=DialogProcessor.ContainsPoint(Point(X,Y));
    if S<>nil then
    begin
//      DialogProcessor.Selection := S;

if DialogProcessor.Selection.IndexOf(S)<0 then
 begin
  DialogProcessor.Selection := TObjectList.Create(false);
 DialogProcessor.Selection.Add(S);
 end;



          StatusBar1.Panels[0].Text := '�������� ��������: �������� �� ��������';
          DialogProcessor.IsDragging := True;
          DialogProcessor.LastLocation := Point(X, Y);
          ViewPort.Invalidate;
      end
      else
      begin
      DialogProcessor.Selection := TObjectList.Create(false);
      ViewPort.Invalidate;
      end;
      end;
end;

/// ���������� �� ������������� �� �������.
/// ��� ��� � ���� �� "�������", �� �������� ������� �� ���������.
procedure TMainForm.ViewPortMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if DialogProcessor.IsDragging then
    begin
      if DialogProcessor.Selection <> nil then StatusBar1.Panels[0].Text := '�������� ��������: �������';
      DialogProcessor.TranslateTo(Point(X, Y));
      ViewPort.Invalidate;
    end;
end;

/// ���������� �� ����������� �� ������ �� �������.
/// �������� �� ����� "�������".
procedure TMainForm.ViewPortMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DialogProcessor.IsDragging := false;
end;

/// ���������� Windows ��������� � ��� ��������������� ������������ �� ���� �� ���������,
/// � ����� �� ������������� ������������ ��� ������������.
procedure TMainForm.OnVMPaint(var Param: TWMEraseBkgnd);
begin
  Param.Result := 1;
end;

procedure TMainForm.DrawElipsesSpeedButoonClick(Sender: TObject);
begin
  DialogProcessor.AddRandomElipse;

  StatusBar1.Panels.Items[0].Text := '�������� ��������: �������� �� ������';

  ViewPort.Invalidate;
end;

procedure TMainForm.triagleClick(Sender: TObject);
begin
 DialogProcessor.AddRandomTriangle;

  StatusBar1.Panels.Items[0].Text := '�������� ��������: �������� �� ����������';

  ViewPort.Invalidate;
end;




procedure TMainForm.SaveAsButtonClick(Sender: TObject);
var bmp:TBitmap;
W,H: Integer;
begin
 SavePictureDialog1.FileName := MainForm.Caption+'.jpg';
 if SavePictureDialog1.Execute then
  begin
  H := ViewPort.Height;
  W := ViewPort.Width;
  bmp := TBitmap.Create;
  bmp.Height := h;
  bmp.Width := w;
  DialogProcessor.Draw(bmp.Canvas);

  //bmp.Canvas.CopyRect(Rect(0,0,w,h),ViewPort.Canvas, Rect(0,0,w,h));
  bmp.SaveToFile(SavePictureDialog1.FileName);
  bmp.Free;
end;
end;



procedure TMainForm.GroupButtonClick(Sender: TObject);
begin
DialogProcessor.GroupSelect;
StatusBar1.Panels.Items[0].Text := '�������� ��������: ���������';
ViewPort.Invalidate;
end;

procedure TMainForm.BorderColorClick(Sender: TObject);
begin
if ColorDialog1.Execute then
    begin
      DialogProcessor.SetSelectedBorderColor(ColorDialog1.Color);
      StatusBar1.Panels.Items[0].Text := '�������� ��������: ���������� �������� �� ������';
      ViewPort.Invalidate;
    end;
end;

procedure TMainForm.FillColorClick(Sender: TObject);
begin
if ColorDialog1.Execute then
    begin
      DialogProcessor.SetSelectedFillColor(ColorDialog1.Color);
      StatusBar1.Panels.Items[0].Text := '�������� ��������: ���������� �� ������ �����';
      ViewPort.Invalidate;
    end;
end;


procedure TMainForm.About1Click(Sender: TObject);

begin
 ShowMessage('Hi ^.^ ');
end;

procedure TMainForm.Group1Click(Sender: TObject);
begin
DialogProcessor.GroupSelect;
ViewPort.Invalidate;
end;




procedure TMainForm.Rectangle1Click(Sender: TObject);
begin
Rectform.showmodal;
end;

procedure TMainForm.BorderColor1Click(Sender: TObject);
begin
BorderColorClick(Sender);
end;

procedure TMainForm.FillColor1Click(Sender: TObject);
begin
 FillColorClick(Sender);
end;

procedure TMainForm.SaveProject1Click(Sender: TObject);
var t:String;
imenafaila : TextFile;
han :Integer;
begin
SaveDialog1.Filter := 'Text file|*.txt';
SaveDialog1.FileName := MainForm.Caption+'.txt';
if SaveDialog1.Execute then
  begin
   t := 'dawdwadwad';
  FileCreate(SaveDialog1.FileName);
 han := FileOpen(SaveDialog1.FileName,fmOpenWrite or fmShareDenyNone or fmOpenRead);
 if han > 0 then
 begin
   FileWrite(han, null, 1);
   FileWrite(han, 'opaaa', 1);
  AssignFile(imenafaila, SaveDialog1.FileName);
  AssignFile(imenafaila, 'Draw.txt');
  Write(imenafaila, 'Hello ');
  Write(imenafaila, 'World');
    Writeln(imenafaila, 'Uspqh li da zapisha neshto');
     CloseFile(imenafaila);
   end;
end;
end;

procedure TMainForm.TriangleClick(Sender: TObject);
begin
triagleClick(Sender);
end;

procedure TMainForm.Krag1Click(Sender: TObject);
begin
DrawElipsesSpeedButoonClick(Sender);
end;

procedure TMainForm.RotateClick(Sender: TObject);
begin
DialogProcessor.Rotate(90);
StatusBar1.Panels.Items[0].Text := '�������� ��������: ���������';
ViewPort.Invalidate;
end;

procedure TMainForm.UnGroupClick(Sender: TObject);
begin
DialogProcessor.UnGroup;
StatusBar1.Panels.Items[0].Text := '�������� ��������: ������������';
ViewPort.Invalidate;
end;

procedure TMainForm.NewProject1Click(Sender: TObject);
var butsel : Integer;
begin
butsel := MessageDlg('Naistina li iskash da sazdadesh nov fail',mtWarning ,mbOKCancel,1);
if butsel = mrOK  then
begin
  DialogProcessor.NewProject;
ViewPort.Invalidate;
end;
end;

procedure TMainForm.NewProjectClick(Sender: TObject);
var butsel : integer;
begin
 butsel := MessageDlg('Naistina li iskash da sazdadesh nov fail',mtWarning ,mbOKCancel,1);
if butsel = mrOK  then
begin
  DialogProcessor.NewProject;
ViewPort.Invalidate;
end;

end;

procedure TMainForm.NewRectClick(Sender: TObject);
begin
DialogProcessor.AddNewRect;
ViewPort.Invalidate;
end;

end.
