unit Main.Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.Menus,

  System.Threading, StrUtils, Vcl.StdCtrls ;

type
  TMain_Form = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    Procedure DoStart;
  public
    { Public declarations }
  end;

var
  Main_Form: TMain_Form;
  canceled: Boolean;

implementation

{$R *.dfm}

function GetWindow: string;
var
  Handle: THandle;
  Len: LongInt;
  Title: string;
begin
  Result := '';
  Handle := GetForegroundWindow;

  if Handle <> 0 then
  begin
    Len := GetWindowTextLength(Handle) + 1;
    SetLength(Title, Len);
    GetWindowText(Handle, PChar(Title), Len);
    Result := TrimRight(Title);
  end;
end;

{ TMain_Form }

procedure TMain_Form.Button1Click(Sender: TObject);
begin
  DoStart;
end;

procedure TMain_Form.Button2Click(Sender: TObject);
begin
  canceled := true;
end;

procedure TMain_Form.DoStart;
var
  Task: ITask;
  window: String;
begin
    canceled := false;

    Task := TTask.Run(
      procedure
      begin

        while not canceled do
        begin
          if canceled then
            Exit;

          sleep(2000);
          TThread.Queue(nil,
             procedure
             begin
               window := GetWindow;
               if (not window.IsEmpty) and (window <> self.Caption) then
                 Memo1.Lines.Add(window);
             end
          );
        end;

      end
    );
end;

end.
