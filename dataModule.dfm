object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 154
  Width = 330
  object conexao: TFDConnection
    Params.Strings = (
      'Database=pedido'
      'User_Name=root'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 64
    Top = 64
  end
  object cursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 128
    Top = 64
  end
  object link: TFDPhysMySQLDriverLink
    Left = 192
    Top = 64
  end
end
