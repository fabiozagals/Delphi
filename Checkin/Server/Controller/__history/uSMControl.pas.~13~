unit uSMControl;

interface

uses System.SysUtils, System.Classes, System.Json,
    DataSnap.DSProviderDataModuleAdapter, REST.Json,
    Datasnap.DSServer, Datasnap.DSAuth, uLocalizacaoModel;

type
  TSMControl = class(TDSServerModule)
  private
    { Private declarations }
    FLocalizacao : TLocalizacaoModel;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;

    function Localizacao : TJSONArray; // GET LOCALIZA플O
    function acceptLocalizacao(JsonObject : TJSONObject) : TJSONValue; // PUT LOCALIZA플O
    function updateLocalizacao(JsonObject : TJSONObject) : TJSONValue; // POST LOCALIZA플O
    procedure cancelLocalizacao(ID : Integer); // DELETE LOCALIZA플O


  end;

implementation

{$R *.dfm}

{ TSM }

function TSMControl.Localizacao: TJSONArray;
begin
  Result := FLocalizacao.Obter;
end;

function TSMControl.updateLocalizacao(JsonObject : TJSONObject): TJSONValue;
begin
  Result := FLocalizacao.Alterar(JsonObject);
end;

function TSMControl.acceptLocalizacao(JsonObject : TJSONObject): TJSONValue;
begin
  Result := FLocalizacao.Incluir(JsonObject);
end;

procedure TSMControl.cancelLocalizacao(ID : Integer);
begin
  FLocalizacao.Excluir(ID);
end;

constructor TSMControl.Create;
begin
  FLocalizacao := TLocalizacaoModel.Create;
end;

destructor TSMControl.Destroy;
begin
  FreeAndNil(FLocalizacao);
  inherited;
end;

end.

