object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 315
  Width = 538
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 450
    Top = 16
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 450
    Top = 72
  end
  object fdcConexao: TFDConnection
    Params.Strings = (
      'Database=E:\Projeto_Checkin\Mobile\database\Chkliphit.s3db'
      'OpenMode=ReadWrite'
      'LockingMode=Normal'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 32
    Top = 8
  end
  object qryCheckin: TFDQuery
    Connection = fdcConexao
    Left = 32
    Top = 64
  end
  object qryClientes: TFDQuery
    Connection = fdcConexao
    SQL.Strings = (
      'SELECT * FROM CLIENTES')
    Left = 32
    Top = 120
  end
  object qryAux: TFDQuery
    Connection = fdcConexao
    Left = 104
    Top = 64
  end
end
