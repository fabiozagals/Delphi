unit uLocalizacaoDao;

interface

uses
  FireDAC.Comp.Client, System.Generics.Collections, System.SysUtils,
  uLocalizacaoModel, uConexao;

type
  TLocalizacaoDao = class
  private
    Conn: TConexao;
    Qry: TFDQuery;
  public
    function Obter: TObjectList<TLocalizacaoModel>;
    procedure Incluir(locModel: TLocalizacaoModel);
    procedure Alterar(locModel: TLocalizacaoModel);
    procedure Excluir(ID: Integer);
    function CriarQuery : TFDQuery;


    constructor Create;
    destructor Destroy; override;

  end;

implementation

{ TLocalizacaoDao }

constructor TLocalizacaoDao.Create;
begin
  Conn := TConexao.create;
  Qry := TFDQuery.create(nil);
  Qry.Connection := Conn.GetConn;
end;

function TLocalizacaoDao.CriarQuery: TFDQuery;
var
  Conn : TConexao;
  Qry : TFDQuery;
begin
  Conn := TConexao.create;
  Qry := TFDQuery.create(nil);
  Qry.Connection := Conn.GetConn;
  Result := Qry;
end;

destructor TLocalizacaoDao.Destroy;
begin
  FreeAndNil(Qry);
  FreeAndNil(Conn);
  inherited;
end;

function TLocalizacaoDao.Obter: TObjectList<TLocalizacaoModel>;
var
  Qry : TFDQuery;
  Lista : TObjectList<TLocalizacaoModel>;
  Localizacao : TLocalizacaoModel;
begin
  Qry := CriarQuery;
  try
    Qry.SQL.Add('Select ID, Usuario, Data_Hora, Endereco, Bairro, Cidade, Estado, Pais From Localizacao');
    Qry.Open;
    Qry.First;
    Lista := TObjectList<TLocalizacaoModel>.Create;
    while not Qry.Eof do
    begin
     Localizacao := TLocalizacaoModel.Create;
     Localizacao.ID       := Qry.FieldByName('ID').AsInteger;
     Localizacao.Nome     := Qry.FieldByName('Usuario').AsString;
     Localizacao.DataHora := Qry.FieldByName('Data_Hora').AsDateTime;
     Localizacao.Endereco := Qry.FieldByName('Endereco').AsString;
     Localizacao.Bairro   := Qry.FieldByName('Bairro').AsString;
     Localizacao.Cidade   := Qry.FieldByName('Cidade').AsString;
     Localizacao.Estado   := Qry.FieldByName('Estado').AsString;
     Localizacao.Pais     := Qry.FieldByName('Pais').AsString;

     Lista.Add(Localizacao);
     Qry.Next
    end;

    Result := Lista;
  finally
    FreeAndNil(Qry);
  end;
end;

procedure TLocalizacaoDao.Incluir(locModel: TLocalizacaoModel);
var
  Qry : TFDQuery;
begin
  Qry := CriarQuery;
  try
    Qry.SQL.Add('Insert Into Localizacao (Usuario, Data_Hora, Endereco, Bairro, Cidade, Estado, Pais) Values (:Usuario, :Data_Hora, :Endereco, :Bairro, :Cidade, :Estado, :Pais)');
    Qry.Params.ParamByName('Usuario').AsString     := locModel.Nome;
    Qry.Params.ParamByName('Data_Hora').AsDateTime := locModel.DataHora;
    Qry.Params.ParamByName('Endereco').AsString    := locModel.Endereco;
    Qry.Params.ParamByName('Bairro').AsString      := locModel.Bairro;
    Qry.Params.ParamByName('Cidade').AsString      := locModel.Cidade;
    Qry.Params.ParamByName('Estado').AsString      := locModel.Estado;
    Qry.Params.ParamByName('Pais').AsString        := locModel.Pais;
    Qry.ExecSQL;
  finally
    FreeAndNil(Qry);
  end;
end;

procedure TLocalizacaoDao.Alterar(locModel: TLocalizacaoModel);
var
  Qry : TFDQuery;
begin
  Qry := CriarQuery;
  try
    Qry.SQL.Add('Update Localizacao Set Usuario = :Usuario, Data_Hora = :Data_Hora, Endereco = :Endereco, Bairro = :Bairro, Cidade = :Cidade, Estado = :Estado, Pais = :Pais where ID = :ID');
    Qry.Params.ParamByName('Usuario').AsString     := locModel.Nome;
    Qry.Params.ParamByName('Data_Hora').AsDateTime := locModel.DataHora;
    Qry.Params.ParamByName('Endereco').AsString    := locModel.Endereco;
    Qry.Params.ParamByName('Bairro').AsString      := locModel.Bairro;
    Qry.Params.ParamByName('Cidade').AsString      := locModel.Cidade;
    Qry.Params.ParamByName('Estado').AsString      := locModel.Estado;
    Qry.Params.ParamByName('Pais').AsString        := locModel.Pais;
    Qry.ExecSQL;
  finally
    FreeAndNil(Qry);
  end;
end;

procedure TLocalizacaoDao.Excluir(ID: Integer);
var
  Qry : TFDQuery;
begin
  Qry := CriarQuery;
  try
    Qry.SQL.Add('Delete From Localizacao Where ID = :ID');
    Qry.Params.ParamByName('ID').AsInteger := ID;
    Qry.ExecSQL;
  finally
    FreeAndNil(Qry);
  end;
end;

end.
