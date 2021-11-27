unit uConFuncionario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDefaultConsultas, Data.DB, Vcl.Grids,
  Vcl.DBGrids, dxGDIPlusClasses, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBActns, System.Actions,
  Vcl.ActnList, Vcl.Buttons, System.ImageList, Vcl.ImgList;

type
  TconFuncionario = class(TfrmPadraoConsulta)
    QryFuncionario: TFDQuery;
    dsFuncionario: TDataSource;
    QryFuncionarionome: TStringField;
    QryFuncionarioid_funcionario: TFDAutoIncField;
    QryFuncionariostatus2: TStringField;
    procedure dbgPadraoDblClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure QryFuncionarioNewRecord(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  conFuncionario: TconFuncionario;

implementation

uses
 dataModule, uCadFuncionario;

{$R *.dfm}

procedure TconFuncionario.btnEditarClick(Sender: TObject);
begin
  cadFuncionario := TcadFuncionario.Create(Self);
  try
    cadFuncionario.btnEditar.Click;
    cadFuncionario.ShowModal;
  finally
    cadFuncionario.Free;
  end;

end;

procedure TconFuncionario.btnNovoClick(Sender: TObject);
begin
  cadFuncionario := TcadFuncionario.Create(Self);
  try
    cadFuncionario.btnNovo.Click;
    cadFuncionario.ShowModal;
  finally
    cadFuncionario.Free;
  end;

end;

procedure TconFuncionario.dbgPadraoDblClick(Sender: TObject);
begin
  cadFuncionario := TcadFuncionario.Create(Self);
  try
    cadFuncionario.btnEditar.Click;
    cadFuncionario.ShowModal;
  finally
    cadFuncionario.Free;
  end;
end;
procedure TconFuncionario.FormCreate(Sender: TObject);
begin
  inherited;
  QryFuncionario.Active := false;
  qryFuncionario.Active := true;
end;

procedure TconFuncionario.FormShow(Sender: TObject);
begin
  inherited;
  qryFuncionario.Close;
  qryFuncionario.SQL.Clear;
  qryFuncionario.SQL.Add('Select id_funcionario, nome, status');
  qryFuncionario.SQL.Add(' from funcionario');
  qryFuncionario.Open;
end;

procedure TconFuncionario.QryFuncionarioNewRecord(DataSet: TDataSet);
begin
  QryFuncionariostatus2.AsString := 'Sim';
end;

end.
