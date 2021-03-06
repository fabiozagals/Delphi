unit uConexao;

interface

uses
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.MySQL, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, System.SysUtils;

type
  TConexao = Class
  private
    FConn : TFDConnection;

    procedure ConfigurarConexao;
  public
    Constructor Create;
    Destructor Destroy; override;

    function GetConn : TFDConnection;
  end;

implementation

{ TConexao }

procedure TConexao.ConfigurarConexao;
begin
  FConn.DriverName := 'MySQL';
  FConn.Params.Add('Server=192.168.1.191');
  FConn.Params.Add('Database=checkin');
  FConn.Params.Add('User_name=sgi');
  FConn.Params.Add('Password=1a245g78');
end;

constructor TConexao.Create;
begin
  FConn := TFDConnection.Create(nil);
  Self.ConfigurarConexao;
  FConn.Connected := True;
end;


destructor TConexao.Destroy;
begin
  FreeAndNil(FConn);
  inherited;
end;

function TConexao.GetConn: TFDConnection;
begin
  Result := FConn;
end;

end.

