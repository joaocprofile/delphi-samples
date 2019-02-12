unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  System.Threading, Vcl.ComCtrls;

type
  TThreadMailsRead = class(TThread)
  private
    _Form: TForm;
    _Id: Integer;
    _countLoop: integer;
    procedure Execute; override;
    procedure EndCheck;
    procedure Canceled;
  public
    constructor Create(AForm: TForm; AId: Integer);
    destructor Destroy; override;

  end;

  TForm1 = class(TForm)
    Button1: TButton;
    lst_MailsRead: TListView;
    Button2: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FCanceled: Boolean;
  public
    ArrayThreads: Array of TThreadMailsRead;

    function isCanceled: boolean;
    procedure UpdateList(AItem, AStatus: String);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TThreadMailsRead }

function FindListViewItem(lv: TListView; const S: string; column: Integer): TListItem;
var
  i: Integer;
  found: Boolean;
begin
  Assert(Assigned(lv));
  Assert((lv.viewstyle = vsReport) or (column = 0));
  Assert(S <> '');
  for i := 0 to lv.Items.Count - 1 do
  begin
    Result := lv.Items[i];
    if column = 0 then
      found := AnsiCompareText(Result.Caption, S) = 0
    else if column > 0 then
      found := AnsiCompareText(Result.SubItems[column - 1], S) = 0
    else
      found := False;
    if found then
      Exit;
  end;
  // No hit if we get here
  Result := nil;
end;

procedure TForm1.UpdateList(AItem, AStatus: String);
Var
  lvItem: TListItem;
 begin
  lvItem := FindListViewItem(lst_MailsRead, AItem, 0);
  if lvItem = nil then
  begin
    lst_MailsRead.Items.BeginUpdate;
    try
      lvItem := lst_MailsRead.Items.Add;
      lvItem.Caption := AItem;
      lvItem.SubItems.Add(AStatus);
    finally
      lst_MailsRead.Items.EndUpdate;
    end;
  end
  else
  begin
    lvItem.SubItems[0] := AStatus;
  end;
//  lst_MailsRead.Selected := lvItem;
//  lvItem.MakeVisible(True);
end;

constructor TThreadMailsRead.Create(AForm: TForm; AId: Integer);
begin
  inherited Create(false);
  FreeOnTerminate := true;
  _Form := AForm;
  _id := AId;
  _countLoop := 0;
end;

destructor TThreadMailsRead.Destroy;
begin

  inherited;
end;

procedure TThreadMailsRead.EndCheck;
var
  lForm : TForm1;
  countLoop: integer;
begin
  lForm := _Form As TForm1;
  lForm.UpdateList(_Id.ToString, 'Update thread '+_countLoop.ToString);
end;

procedure TThreadMailsRead.Canceled;
var
  lForm : TForm1;
  countLoop: integer;
begin
  lForm := _Form As TForm1;
  lForm.UpdateList(_Id.ToString, 'Canceled in ' + FormatDateTime('hh:mm:ss', now));
end;

procedure TThreadMailsRead.Execute;
var
  lForm : TForm1;
begin
  lForm := _Form As TForm1;

  while not Terminated do
  begin
    inc(_countLoop);
    Synchronize(EndCheck);
    sleep(10000);

    if lForm.isCanceled then
    begin
      if not Terminated then
      begin
        Terminate;
        Synchronize(Canceled);
      end;
    end;

  end;

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Tasks: Array[0..0] of ITask;
begin
  FCanceled := false;

  SetLength(ArrayThreads, 0);

  try

    Tasks[0] := TTask.Run(
      procedure
      var
        i: integer;
      begin
        for I := 1 to 20 do
        begin
          SetLength(ArrayThreads, Length(ArrayThreads) + 1);
          ArrayThreads[High(ArrayThreads)] := TThreadMailsRead.Create(self, i);

          sleep(200);
          TThread.Queue(nil,
            procedure
            begin
              Label1.Caption := i.ToString() + ' of 20' ;
            end
          );
        end;
      end
    );

  except
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  FCanceled := true;
end;

function TForm1.isCanceled: boolean;
begin
  result := FCanceled;
end;

end.
