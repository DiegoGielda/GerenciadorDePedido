unit uRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, frxClass,
  frxDBSet, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.DBCtrls, Vcl.Mask;

type
  TfrmRelatorio = class(TForm)
    pnlPrincipal: TPanel;
    qryRelatorio: TFDQuery;
    txtCliente: TEdit;
    lblCliente: TLabel;
    lblProduto: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    rgStatus: TRadioGroup;
    btnRelatorio: TButton;
    lblTitulo: TLabel;
    txtFuncionario: TEdit;
    dsRelPedido: TfrxDBDataset;
    reportPedido: TfrxReport;
    cxInicial: TcxDateEdit;
    cxFinal: TcxDateEdit;
    lblPedido: TLabel;
    txtIDPedido: TMaskEdit;
    procedure btnRelatorioClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtIDPedidoExit(Sender: TObject);
    procedure cxFinalExit(Sender: TObject);
  private
    { Private declarations }
    FFiltro : String;
    procedure montarSQL;
  public
    { Public declarations }
  end;

var
  frmRelatorio: TfrmRelatorio;

implementation

uses
  dataModule;

{$R *.dfm}

procedure TfrmRelatorio.btnRelatorioClick(Sender: TObject);
begin
  montarSQL;
  if(qryRelatorio.RecordCount > 0) then
  begin
    //reportPedido.LoadFromFile(GetCurrentDir + rel);
    reportPedido.ShowReport();
  end
  else
    Application.MessageBox('Nenhum registro encontrado!' + #13 + 'Verifique os filtros', 'Resultado', MB_ICONEXCLAMATION + MB_OK);
end;

procedure TfrmRelatorio.cxFinalExit(Sender: TObject);
begin
  if cxInicial.Date > cxFinal.Date then
  begin
    Application.MessageBox('Data inicial maior que data final', 'Verifique', MB_ICONEXCLAMATION + MB_OK);
  end;
end;

procedure TfrmRelatorio.FormCreate(Sender: TObject);
begin
  qryRelatorio.Active := false;
  qryRelatorio.Active := true;
end;

procedure TfrmRelatorio.montarSQL;
begin
  qryRelatorio.close;
  qryRelatorio.SQL.Clear;
  qryRelatorio.SQL.Add('Select ped.id_pedido, ped.nome, ped.telefone,  ped.celular,');
  qryRelatorio.SQL.Add(' ped.email, ped.tipo_pedido, ped.data_entrada, ped.nome_funcionario,');
  qryRelatorio.SQL.Add(' ped.data_previsao, ped.curso_TCC, ped.arquivo, ped.folha_assinada,');
  qryRelatorio.SQL.Add(' ped.cd, ped.capa_pronta, ped.tcc_impresso, ped.observacoes,');
  qryRelatorio.SQL.Add(' ped.valor_total, ped.valor_entrada, ped.valor_pendente, ped.data_prim_pag, ped.status, formaPagamento');
  qryRelatorio.SQL.Add(' from pedido as ped ');
  qryRelatorio.SQL.Add(' where (0=0)');

  if txtFuncionario.Text <> '' then
  begin
    qryRelatorio.SQL.Add(' and ped.nome_funcionario LIKE ' + QuotedStr(txtFuncionario.Text + '%'));
  end;
  if txtCliente.Text <> '' then
  begin
    qryRelatorio.SQL.Add(' and ped.nome LIKE ' + QuotedStr(txtCliente.Text + '%'));
  end;
  if (cxInicial.Date > 0) then begin
    FFiltro := FormatDateTime('yyyy-mm-dd', cxInicial.Date);
    qryRelatorio.SQL.Add(' and (ped.data_entrada >= ' + QuotedStr(FFiltro) + ') ');
  end;
  if (cxFinal.Date > 0) then begin
    FFiltro := FormatDateTime('yyyy-mm-dd', cxFinal.Date);
    qryRelatorio.SQL.Add(' and (ped.data_entrada <= ' + QuotedStr(FFiltro) + ') ');
  end;
  if rgstatus.ItemIndex >= 0 then
  begin
    case rgstatus.ItemIndex of
      0 : begin
        qryRelatorio.SQL.Add(' and ped.status = ' + QuotedStr('Cancelado'));
      end;
      1 : begin
        qryRelatorio.SQL.Add(' and ped.status = ' + QuotedStr('Aberto'));
      end;
      2 : begin
        qryRelatorio.SQL.Add(' and ped.status = ' + QuotedStr('Concluído'));
      end;
      3 : begin
        qryRelatorio.SQL.Add(' and ped.status in (' + QuotedStr('Concluído') + ',' + QuotedStr('Aberto')
        + ',' + QuotedStr('Cancelado') + ')');
      end;
    end;
  end;
  if txtIDPedido.Text <> '' then
  begin
    qryRelatorio.SQL.Add(' and ped.id_pedido = ' + txtIDPedido.Text);
  end;
  qryRelatorio.Open;
end;

procedure TfrmRelatorio.txtIDPedidoExit(Sender: TObject);
begin
  if StrToIntDef(txtIDPedido.Text, 0) = 0 then
  begin
    if txtIDPedido.Text = '' then
    begin
      exit;
    end
    else
    begin
      Application.MessageBox('Digite um numero', 'Atenção', MB_ICONEXCLAMATION + MB_OK);
      abort;
    end;
  end
end;

end.
