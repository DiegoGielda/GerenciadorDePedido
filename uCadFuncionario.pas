unit uCadFuncionario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDefaultCadastros, Vcl.Buttons,
  dxGDIPlusClasses, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, Data.db;

type
  TcadFuncionario = class(TDefaultCadastros)
    lblCodigo: TLabel;
    txtCodigoFun: TDBEdit;
    lblDescricaoFun: TLabel;
    txtDescricaoFun: TDBEdit;
    cbInativoUsuario: TDBCheckBox;
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
    procedure verificarCampos;
  public
    { Public declarations }
  end;

var
  cadFuncionario: TcadFuncionario;

implementation

uses
  uConFuncionario;

{$R *.dfm}
var
  lFun : Integer;

procedure TcadFuncionario.btnAnteriorClick(Sender: TObject);
begin
  inherited;
  conFuncionario.QryFuncionario.Prior;
  habilitarBotoes;
  configBotoes;
end;

procedure TcadFuncionario.btnCancelarClick(Sender: TObject);
begin
  inherited;
  conFuncionario.QryFuncionario.Cancel;
  habilitarBotoes;
  configBotoes;
  txtDescricaoFun.Enabled := false;
  cbInativoUsuario.Enabled := false;
end;

procedure TcadFuncionario.btnDeletarClick(Sender: TObject);
begin
  inherited;
  case Application.MessageBox('Deseja excluir o Funcionário ?', 'Excluir Funcionário', MB_YESNO + MB_ICONQUESTION) of
  IDYES :
    begin
     conFuncionario.QryFuncionario.Delete;
     ShowMessage('O Funcionário foi excluido');
     habilitarBotoes;
     configBotoes;
    end;
  IDNO :
    begin
      exit;
    end;
  end;
end;

procedure TcadFuncionario.btnEditarClick(Sender: TObject);
begin
  inherited;
  conFuncionario.QryFuncionario.Edit;
  habilitarBotoes;
  configBotoes;
  txtDescricaoFun.Enabled := True;
  cbInativoUsuario.Enabled := True;
end;

procedure TcadFuncionario.btnNovoClick(Sender: TObject);
begin
  inherited;
  conFuncionario.QryFuncionario.Insert;
  habilitarBotoes;
  configBotoes;
  txtDescricaoFun.Enabled := True;
  cbInativoUsuario.Enabled := True;
end;

procedure TcadFuncionario.btnProximoClick(Sender: TObject);
begin
  inherited;
  conFuncionario.QryFuncionario.Next;
  habilitarBotoes;
  configBotoes;
end;

procedure TcadFuncionario.btnSalvarClick(Sender: TObject);
begin
  inherited;
  verificarCampos;
  /// Gravando Registro
  if (lFun >= 4) then
  begin
    try
      conFuncionario.QryFuncionario.Post;
      Application.MessageBox('Registro gravado com sucesso!', 'Confirmação', MB_ICONEXCLAMATION + MB_OK);
      habilitarBotoes;
      configBotoes;
      txtDescricaoFun.Enabled := false;
      cbInativoUsuario.Enabled := false;
    except
      Application.MessageBox('NÃO FOI POSSÍVEL GRAVAR O REGISTRO. Reinicie o sistema', 'Falha', MB_ICONERROR + MB_OK);
    end;
  end;
end;

procedure TcadFuncionario.habilitarBotoes;
begin
  btnAnterior.Enabled := conFuncionario.QryFuncionario.State in [dsBrowse];
  btnProximo.Enabled := conFuncionario.QryFuncionario.State in [dsBrowse];
  btnSalvar.Enabled := conFuncionario.QryFuncionario.State in [dsInsert, dsEdit];
  btnCancelar.Enabled := conFuncionario.QryFuncionario.State in [dsInsert, dsEdit];
  btnNovo.Enabled := conFuncionario.QryFuncionario.State in [dsBrowse];
  btnEditar.Enabled := conFuncionario.QryFuncionario.State in [dsBrowse];
  btnDeletar.Enabled := conFuncionario.QryFuncionario.State in [dsbrowse];
end;

procedure TcadFuncionario.verificarCampos;
begin
  lFun := Length(txtDescricaoFun.Text);
  if txtDescricaoFun.Text = '' then
  begin
    Application.MessageBox('Necessário informar o Funcionário!', 'Atenção', MB_ICONWARNING + MB_OK);
  end
  else
  if lFun < 4 then
  begin
    Application.MessageBox('Não é possível gravar funcionário com nome inferior a 4 letras!', 'Atenção', MB_ICONWARNING + MB_OK);
  end
end;

end.
