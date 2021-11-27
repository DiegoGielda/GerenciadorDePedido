unit uConUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDefaultConsultas, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, Vcl.DBActns, System.Actions, Vcl.ActnList,
  FireDAC.Comp.Client, System.ImageList, Vcl.ImgList;

type
  TconUsuario = class(TfrmPadraoConsulta)
    QryUsuario: TFDQuery;
    dsUsuario: TDataSource;
    QryUsuarioid_usuario: TFDAutoIncField;
    QryUsuariousuario: TStringField;
    QryUsuariosenha: TStringField;
    QryUsuarioadministrador: TStringField;
    QryUsuariostatus: TStringField;
    procedure dbgPadraoDblClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure QryUsuarioNewRecord(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  conUsuario: TconUsuario;

implementation

uses
  dataModule, uCadUsuario;

{$R *.dfm}

procedure TconUsuario.btnEditarClick(Sender: TObject);
begin
  inherited;
  cadUsuario := TcadUsuario.Create(Self);
  try
    cadUsuario.btnEditar.Click;
    cadUsuario.ShowModal;
  finally
    cadUsuario.Free;
  end;
end;

procedure TconUsuario.btnNovoClick(Sender: TObject);
begin
  inherited;
  cadUsuario := TcadUsuario.Create(Self);
  try
    cadUsuario.btnNovo.Click;
    cadUsuario.ShowModal;
  finally
    cadUsuario.Free;
  end;
end;

procedure TconUsuario.dbgPadraoDblClick(Sender: TObject);
begin
  inherited;
  cadUsuario := TcadUsuario.Create(Self);
  try
    cadUsuario.btnEditar.Click;
    cadUsuario.ShowModal;
  finally
    cadUsuario.Free;
  end;
end;

procedure TconUsuario.FormCreate(Sender: TObject);
begin
  inherited;
  qryUsuario.Active := false;
  qryUsuario.Active := true;
end;

procedure TconUsuario.FormShow(Sender: TObject);
begin
  inherited;
  qryUsuario.Close;
  qryUsuario.SQL.Clear;
  qryUsuario.SQL.Add('Select id_usuario, usuario, senha, status, administrador');
  qryUsuario.SQL.Add(' from usuario');
  qryUsuario.Open;
end;

procedure TconUsuario.QryUsuarioNewRecord(DataSet: TDataSet);
begin
  inherited;
  QryUsuarioadministrador.AsString := 'N';
  QryUsuariostatus.AsString := 'Sim';
end;

end.
