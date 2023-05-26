program LocCoordenada;

uses
  System.StartUpCopy,
  FMX.Forms,
  Principal in 'Principal.pas' {Form1},
  AgrCoordenada in 'AgrCoordenada.pas' {FrmAgregar: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
