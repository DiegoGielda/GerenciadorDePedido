unit uDefaultConsultas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxGDIPlusClasses, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TfrmPadraoConsulta = class(TForm)
    pnlCabecalho: TPanel;
    dbgPadrao: TDBGrid;
    btnEditar: TSpeedButton;
    btnNovo: TSpeedButton;
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TDBGridPadrao = class(TDBGrid);

var
  frmPadraoConsulta: TfrmPadraoConsulta;

implementation

{$R *.dfm}

procedure TfrmPadraoConsulta.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
      if Odd( dbgPadrao.DataSource.DataSet.RecNo) then
    begin
      dbgPadrao.Canvas.Brush.Color := $00E9E9E9;
    end
    else
    begin
      dbgPadrao.Canvas.Brush.Color := clWhite;
    end;

    if (gdSelected in State) then
    begin
      dbgPadrao.Canvas.Brush.Color := clRed;
      dbgPadrao.Canvas.Font.Color := clWhite;
      dbgPadrao.Canvas.Font.Style := [fsBold];
    end;

    dbgPadrao.Canvas.FillRect(Rect);
    dbgPadrao.DefaultDrawColumnCell(Rect, DataCol, Column, State);

    dbgPadrao.Canvas.TextRect(Rect, Rect.Left + 8, Rect.Top + 8, Column.Field.DisplayText);
end;

procedure TfrmPadraoConsulta.FormShow(Sender: TObject);
begin
  TDBGridPadrao(dbgPadrao).DefaultRowHeight := 30;
  TDBGridPadrao(dbgPadrao).ClientHeight := (30  * TDBGridPadrao(dbgPadrao).RowCount) + 30;
end;

end.
