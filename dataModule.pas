unit dataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, System.Actions, Vcl.ActnList,
  FireDAC.Comp.UI, Data.DB, FireDAC.Comp.Client, Vcl.DBActns, IniFiles;

type
  Tdm = class(TDataModule)
    conexao: TFDConnection;
    cursor: TFDGUIxWaitCursor;
    link: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  {conIni : TIniFile;
  lib : String;
  rel : string;
begin
  if FileExists (GetCurrentDir + '\IBConfig.ini') then
  begin
    conIni := TIniFile.Create(GetCurrentDir + '\IBConfig.ini');

    lib := conIni.ReadString('dados_banco', 'lib', '\lib\libmysql.dll');
    rel := conIni.ReadString('dados_banco', 'rel', '\rel\relPedido.fr3');
    Link.VendorLib := lib;
    conIni.Free;
  end
  else
  begin
     Link.VendorLib := GetCurrentDir + '\lib\libmysql.dll';
  end;
   }
  conexao.Connected := false;
  conexao.Connected := true;
end;

end.
