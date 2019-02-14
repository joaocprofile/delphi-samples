program SpyWindow;

uses
  Vcl.Forms,
  Main.Form in 'Main.Form.pas' {Main_Form};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain_Form, Main_Form);
  Application.Run;
end.
