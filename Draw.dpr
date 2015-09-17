program Draw;

uses
  Forms,
  MainFormU in 'src\GUI\MainFormU.pas' {MainForm},
  ShapesU in 'src\Model\ShapesU.pas',
  RectangleShapeU in 'src\Model\RectangleShapeU.pas',
  DisplayProcessorU in 'src\Processors\DisplayProcessorU.pas',
  DialogProcessorU in 'src\Processors\DialogProcessorU.pas',
  ElipseShapeU in 'src\Model\ElipseShapeU.pas',
  TriangleShapeU in 'src\Model\TriangleShapeU.pas',
  GroupShapeU in 'src\Model\GroupShapeU.pas',
  RectangleU in 'src\GUI\RectangleU.pas' {RectForm},
  RotateU in 'src\Model\RotateU.pas',
  UnGroupShapeU in 'src\Model\UnGroupShapeU.pas',
  NewRectU in 'src\Model\NewRectU.pas';

{$R *.res}

/// Входна точка на програмата.
/// Създава обекта приложение и главната форма.
begin
  Application.Initialize;
  Application.Title := 'Draw';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TRectForm, RectForm);
  Application.Run;
end.
