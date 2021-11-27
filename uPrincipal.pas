unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, dxGDIPlusClasses, Vcl.ComCtrls;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Funcionarios1: TMenuItem;
    Relatrios1: TMenuItem;
    Pedido1: TMenuItem;
    Configuraes1: TMenuItem;
    Sair1: TMenuItem;
    Funcionarios2: TMenuItem;
    Novo1: TMenuItem;
    Consulta1: TMenuItem;
    Produtos1: TMenuItem;
    Cursos1: TMenuItem;
    Imprimir1: TMenuItem;
    Usuario1: TMenuItem;
    StatusBar: TStatusBar;
    Timer1: TTimer;
    Image1: TImage;
    procedure Funcionarios2Click(Sender: TObject);
    procedure Consulta1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure Cursos1Click(Sender: TObject);
    procedure Novo1Click(Sender: TObject);
    procedure Imprimir1Click(Sender: TObject);
    procedure Usuario1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  uConFuncionario, uConPedido, uConCurso, uCadPedido, uRelatorio, uConUsuario,
  uLogin;

{$R *.dfm}

procedure TfrmPrincipal.Consulta1Click(Sender: TObject);
begin
  conPedido := TconPedido.Create(Self);
  try
    conPedido.ShowModal;
  finally
    conPedido.Free;
  end;
end;

procedure TfrmPrincipal.Cursos1Click(Sender: TObject);
begin
  conCurso := TconCurso.Create(Self);
  try
    conCurso.ShowModal;
  finally
    conCurso.Free;
  end;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  frmLogin := nil;
end;

procedure TfrmPrincipal.Funcionarios2Click(Sender: TObject);
begin
  conFuncionario := TconFuncionario.Create(Self);
  try
    conFuncionario.ShowModal;
  finally
    conFuncionario.Free;
  end;
end;

procedure TfrmPrincipal.Imprimir1Click(Sender: TObject);
begin
    frmRelatorio.ShowModal;
end;

procedure TfrmPrincipal.Novo1Click(Sender: TObject);
begin
  cadPedido := TcadPedido.Create(Self);
  conPedido := TconPedido.Create(Self);
  try
    cadPedido.btnNovo.Click;
    cadPedido.ShowModal;
  finally
    cadPedido.Free;
    conPedido.Free;
  end;
end;

procedure TfrmPrincipal.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.Timer1Timer(Sender: TObject);
begin
  StatusBar.Panels[2].Text := 'Data: ' + FormatDateTime('dddd, dd " de " mmmm " de " yyyy', Now) + '  ';
  StatusBar.Panels[3].Text := 'Hora: ' + FormatDateTime('hh:mm:ss', Now);
end;

procedure TfrmPrincipal.Usuario1Click(Sender: TObject);
begin
  conUsuario := TconUsuario.Create(Self);
  try
    conUsuario.ShowModal;
  finally
    conUsuario.Free;
  end;
end;

end.
