program LocCoordenada;

uses
  System.StartUpCopy,
  FMX.Forms,
  Principal in 'Principal.pas' {FPrinc},
  AgrCoordenada in 'AgrCoordenada.pas' {FrmAgregar: TFrame},
  UtilesLocalizador in 'UtilesLocalizador.pas',
  DataMod in 'DataMod.pas' {DMod: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFPrinc, FPrinc);
  Application.CreateForm(TDMod, DMod);
  Application.Run;
end.
