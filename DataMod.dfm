object DMod: TDMod
  OnCreate = DataModuleCreate
  Height = 383
  Width = 555
  PixelsPerInch = 120
  object FDConn: TFDConnection
    ConnectionName = 'Conex'
    Params.Strings = (
      'DriverID=SQLite'
      
        'Database=D:\Users\fjsae\Documents\Embarcadero\Studio\Projects\AP' +
        'LICACIONES ANDROID\Localizador de coordenada\Database\DBLocaliza' +
        'dor.db')
    LoginPrompt = False
    Left = 50
    Top = 30
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 150
    Top = 30
  end
  object Query: TFDQuery
    Connection = FDConn
    Left = 60
    Top = 280
  end
  object QrLista: TFDQuery
    Connection = FDConn
    SQL.Strings = (
      'select IDCoord,EsteUTM,NorteUTM,Huso,Lat,Lon,Descripcion'
      'from Coordenadas '
      'order by Descripcion asc')
    Left = 180
    Top = 280
  end
end
