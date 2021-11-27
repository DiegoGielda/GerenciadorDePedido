unit uCadCurso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDefaultCadastros, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons, dxGDIPlusClasses, Vcl.ExtCtrls, Data.db;

type
  TcadCurso = class(TDefaultCadastros)
    txtIDCurso: TDBEdit;
    txtDescricaoCurso: TDBEdit;
    lblDescricaoFun: TLabel;
    lblCodigo: TLabel;
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
  public
    { Public declarations }
  end;

var
  cadCurso: TcadCurso;

implementation

uses
  uConCurso;

{$R *.dfm}

procedure TcadCurso.btnAnteriorClick(Sender: TObject);
begin
  inherited;
  conCurso.qryCurso.Prior;
  habilitarBotoes;
  configBotoes;
end;

procedure TcadCurso.btnCancelarClick(Sender: TObject);
begin
  inherited;
  conCurso.qryCurso.Cancel;
  habilitarBotoes;
  configBotoes;
  txtDescricaoCurso.Enabled := False;
end;

procedure TcadCurso.btnDeletarClick(Sender: TObject);
begin
  inherited;
inherited;
  case Application.MessageBox('Deseja excluir o Curso ?', 'Excluir Curso', MB_YESNO + MB_ICONQUESTION) of
  IDYES :
    begin
     conCurso.qryCurso.Delete;
     ShowMessage('O Curso foi excluido');
     habilitarBotoes;
     configBotoes;
    end;
  IDNO :
    begin
      exit;
    end;
  end;
end;

procedure TcadCurso.btnEditarClick(Sender: TObject);
begin
  inherited;
  conCurso.qryCurso.Edit;
  habilitarBotoes;
  configBotoes;
  txtDescricaoCurso.Enabled := True;
end;

procedure TcadCurso.btnNovoClick(Sender: TObject);
begin
  inherited;
  conCurso.qryCurso.Insert;
  habilitarBotoes;
  configBotoes;
  txtDescricaoCurso.Enabled := True;
end;

procedure TcadCurso.btnProximoClick(Sender: TObject);
begin
  inherited;
  conCurso.qryCurso.Next;
  habilitarBotoes;
  configBotoes;
end;

procedure TcadCurso.btnSalvarClick(Sender: TObject);
begin
  inherited;
  conCurso.qryCurso.Post;
  habilitarBotoes;
  configBotoes;
  txtDescricaoCurso.Enabled := false;
end;

procedure TcadCurso.habilitarBotoes;
begin
  btnAnterior.Enabled := conCurso.QryCurso.State in [dsBrowse];
  btnProximo.Enabled := conCurso.QryCurso.State in [dsBrowse];
  btnSalvar.Enabled := conCurso.QryCurso.State in [dsInsert, dsEdit];
  btnCancelar.Enabled := conCurso.QryCurso.State in [dsInsert, dsEdit];
  btnNovo.Enabled := conCurso.QryCurso.State in [dsBrowse];
  btnEditar.Enabled := conCurso.QryCurso.State in [dsBrowse];
  btnDeletar.Enabled := conCurso.QryCurso.State in [dsbrowse];
end;

end.
