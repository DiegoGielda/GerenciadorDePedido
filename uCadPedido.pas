unit uCadPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDefaultCadastros, Vcl.Buttons,
  dxGDIPlusClasses, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxDBEdit, cxCurrencyEdit, Data.db;

type
  TcadPedido = class(TDefaultCadastros)
    txtCodigoPedido: TDBEdit;
    lblCodigo: TLabel;
    lblNome: TLabel;
    txtNomePedido: TDBEdit;
    lblTelefone: TLabel;
    txtTelefone2: TDBEdit;
    lblCelular: TLabel;
    txtTelefone1: TDBEdit;
    lblEmail: TLabel;
    txtEmail: TDBEdit;
    lblDataPrevisao: TLabel;
    lblAtendente: TLabel;
    lblDataEntrada: TLabel;
    lblTipoPedido: TLabel;
    cbTipoPedido: TDBComboBox;
    lblTotal: TLabel;
    lblEntrada: TLabel;
    lblDevedor: TLabel;
    lblPrimPagamento: TLabel;
    cxDataEntrada: TcxDBDateEdit;
    cxDataPrevisao: TcxDBDateEdit;
    cbFuncionario: TDBLookupComboBox;
    cxPrimeiroPagamento: TcxDBDateEdit;
    cxValorTotal: TcxDBCurrencyEdit;
    cxValorEntrada: TcxDBCurrencyEdit;
    cxValorPendente: TcxDBCurrencyEdit;
    pgPedidoCad: TPageControl;
    tbServico: TTabSheet;
    tbTCC: TTabSheet;
    lblCurso: TLabel;
    cbCurso: TDBLookupComboBox;
    lblArquivo: TLabel;
    cbArquivo: TDBComboBox;
    lblFolhaAssinatura: TLabel;
    cbFolhaAssinatura: TDBComboBox;
    gbAndamento: TGroupBox;
    checkCapaPronta: TDBCheckBox;
    checkTCCImpresso: TDBCheckBox;
    checkCD: TDBCheckBox;
    mmTCCObservacoes: TDBMemo;
    lblObservacao: TLabel;
    lblDescPedido: TLabel;
    mmServicoObservacoes: TDBMemo;
    btnCurso: TSpeedButton;
    cbStatus: TDBComboBox;
    lblStatus: TLabel;
    btnImprimir: TSpeedButton;
    cbFormaPagamento: TDBComboBox;
    lblFormaPagamento: TLabel;
    gbFinanceiro: TGroupBox;
    procedure cbTipoPedidoChange(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure btnCursoClick(Sender: TObject);
    procedure cxValorEntradaExit(Sender: TObject);
    procedure cxPrimeiroPagamentoExit(Sender: TObject);
  private
    { Private declarations }
    procedure habilitarBotoes;
    procedure validarCampos;
    procedure ativarCampos;
    procedure desativarCampos;
    procedure telefone;
  public
    { Public declarations }
  end;

var
  cadPedido: TcadPedido;

implementation

uses
  uConPedido, uRelatorio, uConCurso;

{$R *.dfm}

procedure TcadPedido.ativarCampos;
begin
  txtNomePedido.Enabled := True;
  txtTelefone1.Enabled := true;
  txtTelefone2.Enabled := true;
  txtEmail.Enabled := true;
  cbTipoPedido.Enabled := true;
  cxDataEntrada.Enabled := true;
  cbFuncionario.Enabled := true;
  cxDataPrevisao.Enabled := true;
  mmServicoObservacoes.Enabled := true;
  cbCurso.Enabled := true;
  cbArquivo.Enabled := true;
  cbFolhaAssinatura.Enabled := true;
  checkCapaPronta.Enabled := true;
  checkTCCImpresso.Enabled := true;
  checkCD.Enabled := true;
  mmTCCObservacoes.Enabled := true;
  cxValorTotal.Enabled := true;
  cxValorEntrada.Enabled := true;
  cxValorPendente.Enabled := true;
  cxPrimeiroPagamento.Enabled := true;
  cbStatus.Enabled := true;
  cbFormaPagamento.Enabled := true;
end;

procedure TcadPedido.btnAnteriorClick(Sender: TObject);
begin
  inherited;
  conPedido.qryPedido.Prior;
  if cbTipoPedido.ItemIndex = 0 then
  begin
    pgPedidoCad.ActivePageIndex := cbTipoPedido.ItemIndex;
    pgPedidoCad.TabIndex := 0;
  end
  else
  if cbTipoPedido.ItemIndex = 1 then
  begin
    pgPedidoCad.ActivePageIndex := cbTipoPedido.ItemIndex;
    pgPedidoCad.TabIndex := 1;
  end;
  HabilitarBotoes;
  configBotoes;
end;


procedure TcadPedido.btnCancelarClick(Sender: TObject);
begin
  inherited;
  conPedido.qryPedido.Cancel;
  HabilitarBotoes;
  configBotoes;
  desativarCampos;
end;

procedure TcadPedido.btnDeletarClick(Sender: TObject);
begin
  inherited;
    case Application.MessageBox('Deseja excluir o Pedido ?', 'Excluir Pedido', MB_YESNO + MB_ICONQUESTION) of
  IDYES :
    begin
     conPedido.qryPedido.Delete;
     ShowMessage('O Pedido foi excluido');
     habilitarBotoes;
     configBotoes;
    end;
  IDNO :
    begin
      exit;
    end;
  end;
end;

procedure TcadPedido.btnEditarClick(Sender: TObject);
begin
  inherited;
  conPedido.qryPedido.Edit;
  HabilitarBotoes;
  configBotoes;
  ativarCampos;
end;

procedure TcadPedido.btnImprimirClick(Sender: TObject);
begin
  frmRelatorio.qryRelatorio.close;
  frmRelatorio.qryRelatorio.SQL.Clear;
  frmRelatorio.qryRelatorio.SQL.Add('select * from pedido where id_pedido = ' + txtCodigoPedido.Text);
  frmRelatorio.qryRelatorio.Open;
  frmRelatorio.reportPedido.ShowReport();
end;

procedure TcadPedido.btnNovoClick(Sender: TObject);
begin
  inherited;
  conPedido.qryPedido.Insert;
  HabilitarBotoes;
  configBotoes;
  ativarCampos;
  cbTipoPedido.OnChange(cbTipoPedido);
end;

procedure TcadPedido.btnProximoClick(Sender: TObject);
begin
  inherited;
  conPedido.qryPedido.Next;
  if cbTipoPedido.ItemIndex = 0 then
  begin
    pgPedidoCad.ActivePageIndex := cbTipoPedido.ItemIndex;
    pgPedidoCad.TabIndex := 0;
  end
  else
  if cbTipoPedido.ItemIndex = 1 then
  begin
    pgPedidoCad.ActivePageIndex := cbTipoPedido.ItemIndex;
    pgPedidoCad.TabIndex := 1;
  end;
  HabilitarBotoes;
  configBotoes;
end;

procedure TcadPedido.btnSalvarClick(Sender: TObject);
begin
  inherited;
  validarCampos;
  /// Gravando Registro
  if (txtNomePedido.Text <> '') and (cxDataEntrada.Date > 0) and (cxDataPrevisao.Date > 0) and (cbFuncionario.Text <> '') then
  begin
    try
      conPedido.qryPedido.Post;
      Application.MessageBox('Pedido gravado com sucesso!', 'Confirmação', MB_ICONEXCLAMATION + MB_OK);
      HabilitarBotoes;
      configBotoes;
      desativarCampos;
      telefone;
      except
      Application.MessageBox('NÃO FOI POSSÍVEL GRAVAR O PEDIDO. Reinicie o sistema', 'Falha', MB_ICONERROR + MB_OK);
    end;
  end;
  exit;
end;

procedure TcadPedido.cbTipoPedidoChange(Sender: TObject);
begin
  if cbTipoPedido.ItemIndex = 0 then
  begin
    pgPedidoCad.ActivePageIndex := cbTipoPedido.ItemIndex;
    pgPedidoCad.TabIndex := 0;
  end;
  if cbTipoPedido.ItemIndex = 1 then
  begin
    pgPedidoCad.ActivePageIndex := cbTipoPedido.ItemIndex;
    pgPedidoCad.TabIndex := 1;
    checkCapaPronta.Checked := false;
    checkTCCImpresso.Checked := false;
    checkCD.Checked := false;
  end;
end;

procedure TcadPedido.cxPrimeiroPagamentoExit(Sender: TObject);
begin
  inherited;
  cbFormaPagamento.SetFocus;
end;

procedure TcadPedido.cxValorEntradaExit(Sender: TObject);
var
  valor : double;
begin
  inherited;
  if ((cxValorTotal.Value >= 0) and  (cxValorEntrada.Value >= 0)) then
  begin
    valor := cxValorTotal.Value - cxValorEntrada.Value;
    cxValorPendente.Value := valor;
    cxPrimeiroPagamento.SetFocus;
  end;
  if (cxValorTotal.Value < cxValorEntrada.Value) then
  begin
    Application.MessageBox('Valor recebido maior que valor total!', 'Aviso', MB_ICONINFORMATION + MB_OK);
  end;
end;

procedure TcadPedido.desativarCampos;
begin
  txtNomePedido.Enabled := false;
  txtTelefone1.Enabled := false;
  txtTelefone2.Enabled := false;
  txtEmail.Enabled := false;
  cbTipoPedido.Enabled := false;
  cxDataEntrada.Enabled := false;
  cbFuncionario.Enabled := false;
  cxDataPrevisao.Enabled := false;
  mmServicoObservacoes.Enabled := false;
  cbCurso.Enabled := false;
  cbArquivo.Enabled := false;
  cbFolhaAssinatura.Enabled := false;
  checkCapaPronta.Enabled := false;
  checkTCCImpresso.Enabled := false;
  checkCD.Enabled := false;
  mmTCCObservacoes.Enabled := false;
  cxValorTotal.Enabled := false;
  cxValorEntrada.Enabled := false;
  cxValorPendente.Enabled := false;
  cxPrimeiroPagamento.Enabled := false;
  cbStatus.Enabled := false;
  cbFormaPagamento.Enabled := false;
end;

procedure TcadPedido.FormShow(Sender: TObject);
begin
  inherited;
  tbTCC.TabVisible := false;
  tbServico.TabVisible := false;
  if cbTipoPedido.ItemIndex = 0 then
  begin
    pgPedidoCad.ActivePageIndex := cbTipoPedido.ItemIndex;
    pgPedidoCad.TabIndex := 0;
  end
  else
  if cbTipoPedido.ItemIndex = 1 then
  begin
    pgPedidoCad.ActivePageIndex := cbTipoPedido.ItemIndex;
    pgPedidoCad.TabIndex := 1;
  end
  else
    pgPedidoCad.TabIndex := 0;
end;

procedure TcadPedido.habilitarBotoes;
begin
  btnAnterior.Enabled := conPedido.qryPedido.State in [dsBrowse];
  btnProximo.Enabled := conPedido.qryPedido.State in [dsBrowse];
  btnSalvar.Enabled := conPedido.qryPedido.State in [dsInsert, dsEdit];
  btnCancelar.Enabled := conPedido.qryPedido.State in [dsInsert, dsEdit];
  btnNovo.Enabled := conPedido.qryPedido.State in [dsBrowse];
  btnEditar.Enabled := conPedido.qryPedido.State in [dsBrowse];
  btnDeletar.Enabled := conPedido.qryPedido.State in [dsbrowse];
end;

procedure TcadPedido.btnCursoClick(Sender: TObject);
begin
  inherited;
  conCurso := TconCurso.Create(Self);
  try
    conCurso.ShowModal;
  finally
    conCurso.Free;
    conPedido.qryCurso.Refresh;
  end;
end;

procedure TcadPedido.telefone;
begin
  if (txtTelefone1.Text = '(  )     -    ') and (txtTelefone2.Text = '(  )     -    ') then
  begin
    case Application.MessageBox('Não foi adicionado nenhum contato!' + #13+ 'Deseja adicionar ?', 'Lembrete', MB_YESNO + MB_ICONQUESTION) of
      IDYES :
      begin
        btnEditar.Click;
        txtTelefone1.SetFocus;
      end;
      IDNO :
      begin
        exit;
      end;
  end;
  end;
end;

procedure TcadPedido.ValidarCampos;
begin
  if txtNomePedido.Text = '' then
  begin
    Application.MessageBox('Campo ''Nome'' não informado. Verifique!', 'Atenção', MB_ICONEXCLAMATION + MB_OK);
  end;
  if (txtTelefone1.Text = '(  )     -    ') then
  begin
    conPedido.qryPedidocelular.Value := '';
  end;
  if (txtTelefone2.Text = '(  )     -    ') then
  begin
  conPedido.qryPedidotelefone.Value := '';
  end;
  if txtEmail.Text = '' then
  begin
    conPedido.qryPedidoemail.Value := '';
  end;
  if cxDataEntrada.Date < 0 then
  begin
    Application.MessageBox('Campo ''Data da Solicitação'' não informado. Verifique!', 'Atenção', MB_ICONEXCLAMATION + MB_OK);
  end;
  if cbFuncionario.Text = '' then
  begin
    Application.MessageBox('Campo ''Atendente'' não informado. Verifique!', 'Atenção', MB_ICONEXCLAMATION + MB_OK);
  end;
  if cxDataPrevisao.Date < 0 then
  begin
    Application.MessageBox('Campo ''Previsão de Entrega'' não informado. Verifique!', 'Atenção', MB_ICONEXCLAMATION + MB_OK);
  end;
end;

end.
