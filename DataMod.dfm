object DMod: TDMod
  Height = 306
  Width = 444
  object FDConn: TFDConnection
    ConnectionName = 'Conex'
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 40
    Top = 24
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 120
    Top = 24
  end
  object Query: TFDQuery
    Connection = FDConn
    Left = 48
    Top = 224
  end
  object QrLista: TFDQuery
    Connection = FDConn
    Left = 144
    Top = 224
  end
end
