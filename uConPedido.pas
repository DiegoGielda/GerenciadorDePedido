unit uConPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDefaultConsultas, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.DBActns, System.Actions, Vcl.ActnList, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, System.ImageList, Vcl.ImgList,
  dxGDIPlusClasses;

type
  TconPedido = class(TfrmPadraoConsulta)
    qryPedido: TFDQuery;
    dsPedido: TDataSource;
    Label1: TLabel;
    qryFuncionario: TFDQuery;
    dsFuncionario: TDataSource;
    qryCurso: TFDQuery;
    dsCurso: TDataSource;
    DBGrid1: TDBGrid;
    qryPedidoid_pedido: TFDAutoIncField;
    qryPedidonome: TStringField;
    qryPedidotelefone: TStringField;
    qryPedidocelular: TStringField;
    qryPedidoemail: TStringField;
    qryPedidotipo_pedido: TStringField;
    qryPedidodata_entrada: TDateField;
    qryPedidodata_previsao: TDateField;
    qryPedidocurso_TCC: TStringField;
    qryPedidoarquivo: TStringField;
    qryPedidofolha_assinada: TStringField;
    qryPedidocd: TStringField;
    qryPedidocapa_pronta: TStringField;
    qryPedidotcc_impresso: TStringField;
    qryPedidoobservacoes: TStringField;
    qryPedidovalor_total: TBCDField;
    qryPedidovalor_entrada: TBCDField;
    qryPedidovalor_pendente: TBCDField;
    qryPedidodata_prim_pag: TDateField;
    qryPedidostatus: TStringField;
    qryCursoid_curso: TFDAutoIncField;
    qryCursodescricao: TStringField;
    qryPedidoformaPagamento: TStringField;
    qryPedidonome_funcionario: TStringField;
    procedure dbgPadraoDblClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure qryPedidoNewRecord(DataSet: TDataSet);
    procedure btnEditarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryPedidoBeforePost(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  conPedido: TconPedido;

implementation

uses
  dataModule, uCadPedido;

{$R *.dfm}

procedure TconPedido.btnEditarClick(Sender: TObject);
begin
  cadPedido := TcadPedido.Create(Self);
    try
      cadPedido.btnEditar.Click;
      cadPedido.ShowModal;
    finally
      cadPedido.Free;
    end;
end;

procedure TconPedido.btnNovoClick(Sender: TObject);
begin
  cadPedido := TcadPedido.Create(Self);
  try
    cadPedido.btnNovo.Click;
    cadPedido.ShowModal;
  finally
    cadPedido.Free;
  end;
end;

procedure TconPedido.dbgPadraoDblClick(Sender: TObject);
begin
  cadPedido := TcadPedido.Create(Self);
  try
    cadPedido.btnEditar.Click;
    cadPedido.ShowModal;
  finally
    cadPedido.Free;
  end;
end;

procedure TconPedido.FormCreate(Sender: TObject);
begin
  inherited;
  qryPedido.Active := false;
  qryPedido.Active := true;
  qryFuncionario.Active := false;
  qryFuncionario.Active := true;
  qryCurso.Active := false;
  qryCurso.Active := true;
end;

procedure TconPedido.FormShow(Sender: TObject);
begin
  inherited;
  qryPedido.Close;
  qryPedido.SQL.Clear;
  qryPedido.SQL.Add('Select ped.id_pedido, ped.nome, ped.telefone,  ped.celular,');
  qryPedido.SQL.Add(' ped.email, ped.tipo_pedido, ped.data_entrada, ped.nome_funcionario,');
  qryPedido.SQL.Add(' ped.data_previsao, ped.curso_TCC, ped.arquivo, ped.folha_assinada,');
  qryPedido.SQL.Add(' ped.cd, ped.capa_pronta, ped.tcc_impresso, ped.observacoes,');
  qryPedido.SQL.Add(' ped.valor_total, ped.valor_entrada, ped.valor_pendente, ped.data_prim_pag, ped.status, formaPagamento');
  qryPedido.SQL.Add(' from pedido as ped ');
  qryPedido.Open;


  qryFuncionario.Close;
  qryFuncionario.SQL.Clear;
  qryFuncionario.SQL.Add('select id_funcionario, nome, status from funcionario where status = ' + QuotedStr('Sim'));
  qryFuncionario.Open;

  qryCurso.Close;
  qryCurso.SQL.Clear;
  qryCurso.SQL.Add('select id_curso, descricao from curso');
  qryCurso.Open;

end;

procedure TconPedido.qryPedidoBeforePost(DataSet: TDataSet);
begin
  inherited;
  if cadPedido.checkCapaPronta.Checked = false then
  begin
    qryPedidocapa_pronta.Value := 'Não';
  end;
  if cadPedido.checkTCCImpresso.Checked = false then
  begin
    qryPedidotcc_impresso.Value := 'Não';
  end;
  if cadPedido.checkCD.Checked = false then
  begin
    qryPedidocd.Value := 'Não';
  end;
  if conPedido.qryPedidovalor_total.Value = 0 then
  begin
    qryPedidovalor_total.Value := 0;
  end;
  if conPedido.qryPedidovalor_entrada.Value = 0 then
  begin
    qryPedidovalor_entrada.Value := 0;
  end;
  if conPedido.qryPedidovalor_pendente.Value = 0 then
  begin
    qryPedidovalor_pendente.Value := 0;
  end;
   // Campos TCC
  if cadPedido.cbTipoPedido.ItemIndex = 0 then
  begin
    qryPedidocapa_pronta.AsVariant := null;
    qryPedidotcc_impresso.AsVariant := null;
    qryPedidocd.AsVariant := null;

    qryPedidocurso_TCC.AsVariant := null;
    qryPedidofolha_assinada.AsVariant := null;
    qryPedidoarquivo.AsVariant := null;
  end;
  if cadPedido.cxDataPrevisao.Date < 0 then
  begin
    qryPedidodata_prim_pag.AsVariant := null;
  end;
end;

procedure TconPedido.qryPedidoNewRecord(DataSet: TDataSet);
begin
  qryPedidodata_entrada.AsDateTime := Date;
  qryPedidotipo_pedido.AsString := 'Serviço';
  qryPedidostatus.AsString := 'Aberto';
  qryPedidoformaPagamento.AsString := 'Dinheiro';
end;

end.
