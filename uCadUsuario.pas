unit uCadUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDefaultCadastros, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons, dxGDIPlusClasses, Vcl.ExtCtrls, Data.db;

type
  TcadUsuario = class(TDefaultCadastros)
    txtCodigoUsuario: TDBEdit;
    lblCodigo: TLabel;
    lblUsuario: TLabel;
    txtUsuario: TDBEdit;
    txtSenha: TDBEdit;
    lblSenha: TLabel;
    cxInativoUsuario: TDBCheckBox;
    DBCheckBox1: TDBCheckBox;
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
    procedure habilitarBotoes;
    procedure vericarCampos;
  public
    { Public declarations }
  end;

var
  cadUsuario: TcadUsuario;

implementation

uses
  uConUsuario;

{$R *.dfm}

var
  lTamSenha, lTamUsuario : Integer;

procedure TcadUsuario.btnAnteriorClick(Sender: TObject);
begin
  inherited;
  conUsuario.QryUsuario.Prior;
  habilitarBotoes;
  configBotoes;
end;

procedure TcadUsuario.btnCancelarClick(Sender: TObject);
begin
  inherited;
  conUsuario.QryUsuario.Cancel;
  habilitarBotoes;
  configBotoes;
  txtUsuario.Enabled := False;
  txtSenha.Enabled := false;
end;

procedure TcadUsuario.btnDeletarClick(Sender: TObject);
begin
  inherited;
    case Application.MessageBox('Deseja excluir o Usuário ?', 'Excluir Usuário', MB_YESNO + MB_ICONQUESTION) of
  IDYES :
    begin
     conUsuario.QryUsuario.Delete;
     ShowMessage('O Usuário foi excluido');
     habilitarBotoes;
     configBotoes;
    end;
  IDNO :
    begin
      exit;
    end;
  end;
end;

procedure TcadUsuario.btnEditarClick(Sender: TObject);
begin
  inherited;
  conUsuario.QryUsuario.Edit;
  habilitarBotoes;
  configBotoes;
  txtUsuario.Enabled := True;
  txtSenha.Enabled := True;
end;

procedure TcadUsuario.btnNovoClick(Sender: TObject);
begin
  inherited;
  conUsuario.QryUsuario.Insert;
  habilitarBotoes;
  configBotoes;
  txtUsuario.Enabled := True;
  txtSenha.Enabled := True;
end;

procedure TcadUsuario.btnProximoClick(Sender: TObject);
begin
  inherited;
  conUsuario.QryUsuario.Next;
  habilitarBotoes;
  configBotoes;
end;

procedure TcadUsuario.btnSalvarClick(Sender: TObject);
begin
  inherited;
  vericarCampos;
/// Gravando Registro
  if (lTamSenha >= 8) and (lTamUsuario >= 4) then
  begin
    try
      conUsuario.QryUsuario.Post;
      Application.MessageBox('Registro gravado com sucesso!', 'Confirmação', MB_ICONEXCLAMATION + MB_OK);
      habilitarBotoes;
      configBotoes;
      txtUsuario.Enabled := false;
      txtSenha.Enabled := false;
    except
      Application.MessageBox('NÃO FOI POSSÍVEL GRAVAR O REGISTRO. Reinicie o sistema', 'Falha', MB_ICONERROR + MB_OK);
    end;
  end;
end;

procedure TcadUsuario.habilitarBotoes;
begin
  btnAnterior.Enabled := conUsuario.qryUsuario.State in [dsBrowse];
  btnProximo.Enabled := conUsuario.qryUsuario.State in [dsBrowse];
  btnSalvar.Enabled := conUsuario.qryUsuario.State in [dsInsert, dsEdit];
  btnCancelar.Enabled := conUsuario.qryUsuario.State in [dsInsert, dsEdit];
  btnNovo.Enabled := conUsuario.qryUsuario.State in [dsBrowse];
  btnEditar.Enabled := conUsuario.qryUsuario.State in [dsBrowse];
  btnDeletar.Enabled := conUsuario.qryUsuario.State in [dsbrowse];
end;

procedure TcadUsuario.vericarCampos;
begin
  lTamSenha := Length(txtSenha.Text);
  lTamUsuario := Length(txtUsuario.Text);
  if txtUsuario.Text = '' then
  begin
    Application.MessageBox('Necessario informar Usuario!', 'Verifique', MB_ICONWARNING + MB_OK);
  end;
  if txtSenha.Text = '' then
  begin
    Application.MessageBox('Necessario informar Senha!', 'Verifique', MB_ICONWARNING + MB_OK);
  end;
  if (lTamSenha < 8) and (ltamSenha >= 1) then
  begin
    Application.MessageBox('Necessario informar senha igual ou superior a 8 digitos!', 'Verifique', MB_ICONWARNING + MB_OK);
  end;
  if (lTamUsuario < 4) and (lTamUsuario >= 1)  then
  begin
    Application.MessageBox('Necessario informar usuário igual ou superior a 4 digitos!', 'Verifique', MB_ICONWARNING + MB_OK);
  end;
end;

end.
