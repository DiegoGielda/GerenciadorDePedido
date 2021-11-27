unit uConCurso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDefaultConsultas, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.DBActns, System.Actions, Vcl.ActnList, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.ImageList, Vcl.ImgList, dxGDIPlusClasses;

type
  TconCurso = class(TfrmPadraoConsulta)
    qryCurso: TFDQuery;
    dsCurso: TDataSource;
    procedure dbgPadraoDblClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  conCurso: TconCurso;

implementation

uses
  dataModule, uCadCurso;

{$R *.dfm}

procedure TconCurso.btnEditarClick(Sender: TObject);
begin
  cadCurso := TcadCurso.Create(Self);
  try
    cadCurso.btnEditar.Click;
    cadCurso.ShowModal;
  finally
    cadCurso.Free;
  end;
end;

procedure TconCurso.btnNovoClick(Sender: TObject);
begin
  cadCurso := TcadCurso.Create(Self);
  try
    cadCurso.btnNovo.Click;
    cadCurso.ShowModal;
  finally
    cadCurso.Free;
  end;
end;

procedure TconCurso.dbgPadraoDblClick(Sender: TObject);
begin
  cadCurso := TcadCurso.Create(Self);
  try
    cadCurso.btnEditar.Click;
    cadCurso.ShowModal;
  finally
    cadCurso.Free;
  end;
end;

procedure TconCurso.FormCreate(Sender: TObject);
begin
  inherited;
  qryCurso.Active := false;
  qryCurso.Active := true;
end;

procedure TconCurso.FormShow(Sender: TObject);
begin
  inherited;
  qryCurso.Close;
  qryCurso.SQL.Clear;
  qryCurso.SQL.Add('select id_curso, descricao');
  qryCurso.SQL.Add(' from curso');
  qryCurso.Open;
end;

end.
