program SistemaAgendamento;

uses
  Vcl.Forms,
  dataModule in 'dataModule.pas' {dm: TDataModule},
  uCadFuncionario in 'uCadFuncionario.pas' {cadFuncionario},
  uCadPedido in 'uCadPedido.pas' {cadPedido},
  uConFuncionario in 'uConFuncionario.pas' {conFuncionario},
  uConPedido in 'uConPedido.pas' {conPedido},
  uDefaultCadastros in 'uDefaultCadastros.pas' {DefaultCadastros},
  uDefaultConsultas in 'uDefaultConsultas.pas' {frmPadraoConsulta},
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uConCurso in 'uConCurso.pas' {conCurso},
  uCadCurso in 'uCadCurso.pas' {cadCurso},
  uRelatorio in 'uRelatorio.pas' {frmRelatorio},
  uLogin in 'uLogin.pas' {frmLogin},
  uConUsuario in 'uConUsuario.pas' {conUsuario},
  uCadUsuario in 'uCadUsuario.pas' {cadUsuario},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmRelatorio, frmRelatorio);
  Application.Run;
end.
