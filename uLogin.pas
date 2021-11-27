unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, IniFiles;

type
  TfrmLogin = class(TForm)
    imgLogin: TImage;
    editSenha: TMaskEdit;
    Label2: TLabel;
    editUsuario: TEdit;
    Label1: TLabel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    qryConUsuario: TFDQuery;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure editUsuarioKeyPress(Sender: TObject; var Key: Char);
    procedure editSenhaKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  dataModule, uPrincipal;

{$R *.dfm}
procedure TfrmLogin.btnCancelClick(Sender: TObject);
begin
  if Application.MessageBox('Tem certeza que deseja sair do programa?','Confirmação!',MB_YESNO + MB_ICONINFORMATION + MB_DEFBUTTON2)=IdYes then
    Application.Terminate
  else
    abort;
end;

procedure TfrmLogin.btnOkClick(Sender: TObject);
var
  mensagem:string;
  v, adim : String;
Begin
 if (editUsuario.Text <> '') and (editSenha.Text <> '') then
  begin
    qryConUsuario.Close;
    qryConUsuario.SQL.Clear;
    qryConUsuario.SQL.Add(' SELECT id_usuario, usuario, senha, status, administrador' +
                          ' FROM usuario' +
                          ' WHERE usuario = :vNome' +
                          ' AND senha = :vSenha');
    qryConUsuario.Params[0].Value:= editUsuario.Text;
    qryConUsuario.Params[1].Value:= editSenha.Text;
    qryConUsuario.Open;
    if (qryConUsuario.RecordCount = 1) then
    begin
      v:= 'Sim';
      adim := qryConUsuario.FieldByName('administrador').Value;
      qryConUsuario.SQL.Add(' AND status = '+ #39 + v + #39);
      qryConUsuario.Open;
      if (qryConUsuario.RecordCount) = 1 then
      begin
        FrmPrincipal.StatusBar.Panels[1].Text := 'Usuário - ' + qryConUsuario.FieldByName('usuario').Value;
        if adim = 'N' then
        begin
          frmPrincipal.MainMenu1.Items[3].Items[0].Enabled := false;
        end;
        frmLogin.Hide;
        frmPrincipal.ShowModal;
      end
      else
      Application.MessageBox(PChar('Você foi Bloqueado!' + #13 +
        'Consulte o administrador do sistema.'), 'Login não autorizado', MB_OK+MB_IconError);
      editSenha.Text := '';
      editUsuario.Text := '';
    end
    else
    begin
      mensagem:= 'Nome ou senha do usuário inválidos.' + #13 + #13
        + 'Se você esqueceu sua senha, consulte' + #13
        + 'o administrador do sistema.';
      Application.MessageBox(PChar(mensagem), 'Login não autorizado', MB_OK+MB_IconError);
      editSenha.Text:= '';
      editUsuario.SetFocus;
    end;
  end;
end;

procedure TfrmLogin.editSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    begin
      SelectNext(ActiveControl, True, True);
      key:= #0;
    end;
end;

procedure TfrmLogin.editUsuarioKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    begin
      SelectNext(ActiveControl, True, True);
      key:= #0;
    end;
end;

procedure TfrmLogin.FormActivate(Sender: TObject);
begin
  editUsuario.SetFocus;
end;

end.
