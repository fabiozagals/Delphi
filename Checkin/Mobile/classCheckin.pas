unit classCheckin;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TClassCheckin = Class
  private
    FEmpresa: String;
    FDtCheckout: TDateTime;
    FChkOutLatitude: Double;
    FDtCheckin: TDateTime;
    FChkInLatitude: Double;
    FChkOutLongitude: Double;
    FEndereco: String;
    FChkInLongitude: Double;

  public
    Constructor Create;
    Destructor  Destroy; Override;

    property Empresa : String read FEmpresa write FEmpresa;
    property Endereco : String read FEndereco write FEndereco;
    property DtCheckin : TDateTime read FDtCheckin write FDtCheckin;
    property ChkInLatitude : Double read FChkInLatitude write FChkInLatitude;
    property ChkInLongitude : Double read FChkInLongitude write FChkInLongitude;
    property DtCheckout : TDateTime read FDtCheckout write FDtCheckout;
    property ChkOutLatitude : Double read FChkOutLatitude write FChkOutLatitude;
    property ChkOutLongitude : Double read FChkOutLongitude write FChkOutLongitude;

  end;

  {CRUD}
  TCheckinDao = class
  private
    class function ComandoSql(AReceber: TClassCheckin): Boolean;
  public
    class function Insert(ACheckin: TClassCheckin): Boolean; //create
    class function Read(AQuery: TFDQuery; ADocumento: string): integer;
    class function Update(ACheckin: TClassCheckin): Boolean;
  end;

implementation

{ TClassCheckin }

constructor TClassCheckin.Create;
begin

end;

destructor TClassCheckin.Destroy;
begin

  inherited;
end;

end.
