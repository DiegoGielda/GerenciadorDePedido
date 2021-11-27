unit uDefaultCadastros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxGDIPlusClasses, Vcl.ExtCtrls,
  Vcl.Buttons;

type
  TDefaultCadastros = class(TForm)
    pnlCadastros: TPanel;
    pnlCabecalho: TPanel;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnProximo: TSpeedButton;
    btnAnterior: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnDeletar: TSpeedButton;
    imgNovo: TImage;
    imgProximo: TImage;
    imgAnterior: TImage;
    imgEditar: TImage;
    imgSalvar: TImage;
    imgCancelar: TImage;
    imgDeletar: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  published
    procedure configBotoes;
  end;

var
  DefaultCadastros: TDefaultCadastros;

implementation

{$R *.dfm}

{ TDefaultCadastros }

procedure TDefaultCadastros.configBotoes;
begin
   // Novo
  if btnNovo.Enabled = true then
    imgNovo.Enabled := false
  else
    imgNovo.Enabled := true;
  // Deletar
  if btnDeletar.Enabled = true then
    imgDeletar.Enabled := false
  else
    imgDeletar.Enabled := true;
  // Editar
  if btnEditar.Enabled = true then
    imgEditar.Enabled := false
  else
    imgEditar.Enabled := true;
  // Salvar
  if btnSalvar.Enabled = true then
    imgSalvar.Enabled := false
  else
    imgSalvar.Enabled := true;
  // Cancelar
  if btnCancelar.Enabled = true then
    imgCancelar.Enabled := false
  else
    imgCancelar.Enabled := true;
  // Anteriror
  if btnAnterior.Enabled = true then
    imgAnterior.Enabled := false
  else
    imgAnterior.Enabled := true;
  // Proximo
  if btnProximo.Enabled = true then
    imgProximo.Enabled := false
  else
    imgProximo.Enabled := true;
end;

procedure TDefaultCadastros.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if btnSalvar.Enabled then
  begin
    case Application.MessageBox('Deseja salvar as alterações ?', 'Validação', MB_YESNO+MB_ICONQUESTION) of
      IDYES :
      begin
        btnSalvar.Click;
        close;
      end;
      IDNO :
      begin
        btnCancelar.Click;
        exit;
      end;
  end;
  end;
end;

end.
