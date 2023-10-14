program LocCoordenada;

uses
  {$IFDEF ANDROID}
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.Helpers,
  {$ENDIF }
  System.StartUpCopy,
  System.SysUtils,
  FMX.Forms,
  Principal in 'Principal.pas' {FPrinc},
  DataMod in 'DataMod.pas' {DMod: TDataModule},
  AgrCoordenada in 'AgrCoordenada.pas' {FrmAgregar: TFrame},
  SelCoordenada in 'SelCoordenada.pas' {FrmSeleccionar: TFrame},
  Acerca in 'Acerca.pas' {FrmAcerca: TFrame},
  UtilesLocalizador in 'UtilesLocalizador.pas',
  FMX.FontGlyphs.Android in 'FMX.FontGlyphs.Android.pas',
  Configuracion in 'Configuracion.pas' {FrmConfig: TFrame};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ANDROID}
  //TAndroidHelper.Activity.getWindow.addFlags(
	  //TJWindowManager_LayoutParams.JavaClass.FLAG_KEEP_SCREEN_ON);
  {$ENDIF}
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(TFPrinc, FPrinc);
  Application.CreateForm(TDMod, DMod);
  Application.Run;
end.
