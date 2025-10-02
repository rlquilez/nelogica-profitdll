unit ProfitConstantsU;

interface

const
  NL_OK                    = Integer($00000000);            // OK
  NL_INTERNAL_ERROR        = Integer($80000001);            // Internal error
  NL_NOT_INITIALIZED       = NL_INTERNAL_ERROR        + 1;  // Not initialized
  NL_INVALID_ARGS          = NL_NOT_INITIALIZED       + 1;  // Invalid arguments
  NL_WAITING_SERVER        = NL_INVALID_ARGS          + 1;  // Aguardando dados do servidor
  NL_NO_LOGIN              = NL_WAITING_SERVER        + 1;  // Nenhum login encontrado
  NL_NO_LICENSE            = NL_NO_LOGIN              + 1;  // Nenhuma licença encontrada
  NL_PASSWORD_HASH_SHA1    = NL_NO_LICENSE            + 1;  // Senha não está em SHA1
  NL_PASSWORD_HASH_MD5     = NL_PASSWORD_HASH_SHA1    + 1;  // Senha não está em MD5
  NL_OUT_OF_RANGE          = NL_PASSWORD_HASH_MD5     + 1;  // Count do parâmetro maior que o tamanho do array
  NL_MARKET_ONLY           = NL_OUT_OF_RANGE          + 1;  // Não possui roteamento
  NL_NO_POSITION           = NL_MARKET_ONLY           + 1;  // Não possui posição
  NL_NOT_FOUND             = NL_NO_POSITION           + 1;  // Recurso não encontrado
  NL_VERSION_NOT_SUPPORTED = NL_NOT_FOUND             + 1;  // Versão do recurso não suportada
  NL_OCO_NO_RULES          = NL_VERSION_NOT_SUPPORTED + 1;  // OCO sem nenhuma regra
  NL_EXCHANGE_UNKNOWN      = NL_OCO_NO_RULES          + 1;  // Bolsa desconhecida
  NL_NO_OCO_DEFINED        = NL_EXCHANGE_UNKNOWN      + 1;  // Nenhuma OCO encontrada para a ordem
  NL_INVALID_SERIE         = NL_NO_OCO_DEFINED        + 1;  // (Level + Offset + Factor) inválido
  NL_LICENSE_NOT_ALLOWED   = NL_INVALID_SERIE         + 1;  // Recurso não liberado na licença
  NL_NOT_HARD_LOGOUT       = NL_LICENSE_NOT_ALLOWED   + 1;  // Retorna que não esta em HardLogout
  NL_SERIE_NO_HISTORY      = NL_NOT_HARD_LOGOUT       + 1;  // Série não tem histórico no servidor
  NL_ASSET_NO_DATA         = NL_SERIE_NO_HISTORY      + 1;  // Asset não tem o dados carregados
  NL_SERIE_NO_DATA         = NL_ASSET_NO_DATA         + 1;  // Série não tem dados (count = 0)
  NL_HAS_STRATEGY_RUNNING  = NL_SERIE_NO_DATA         + 1;  // Existe uma estratégia rodando
  NL_SERIE_NO_MORE_HISTORY = NL_HAS_STRATEGY_RUNNING  + 1;  // Não tem mais dados disponiveis para a serie
  NL_SERIE_MAX_COUNT       = NL_SERIE_NO_MORE_HISTORY + 1;  // Série esta no limite de dados possíveis
  NL_DUPLICATE_RESOURCE    = NL_SERIE_MAX_COUNT       + 1;  // Recurso duplicado
  NL_UNSIGNED_CONTRACT     = NL_DUPLICATE_RESOURCE    + 1;
  NL_NO_PASSWORD           = NL_UNSIGNED_CONTRACT     + 1;  // Nenhuma senha informada
  NL_NO_USER               = NL_NO_PASSWORD           + 1;  // Nenhum usuário informado no login
  NL_FILE_ALREADY_EXISTS   = NL_NO_USER               + 1;  // Arquivo já existe
  NL_INVALID_TICKER        = NL_FILE_ALREADY_EXISTS   + 1;
  NL_NOT_MASTER_ACCOUNT    = NL_INVALID_TICKER        + 1;  // Conta não é master

function NResultToString(const a_nResult : Int64) : String;

implementation

uses
  System.SysUtils;

function NResultToString(const a_nResult : Int64) : String;
begin
  case a_nResult of
    NL_OK                    : Result := 'NL_OK';
    NL_INTERNAL_ERROR        : Result := 'NL_INTERNAL_ERROR';
    NL_NOT_INITIALIZED       : Result := 'NL_NOT_INITIALIZED';
    NL_INVALID_ARGS          : Result := 'NL_INVALID_ARGS';
    NL_WAITING_SERVER        : Result := 'NL_WAITING_SERVER';
    NL_NO_LOGIN              : Result := 'NL_NO_LOGIN';
    NL_NO_LICENSE            : Result := 'NL_NO_LICENSE';
    NL_PASSWORD_HASH_SHA1    : Result := 'NL_PASSWORD_HASH_SHA1';
    NL_PASSWORD_HASH_MD5     : Result := 'NL_PASSWORD_HASH_MD5';
    NL_OUT_OF_RANGE          : Result := 'NL_OUT_OF_RANGE';
    NL_MARKET_ONLY           : Result := 'NL_MARKET_ONLY';
    NL_NO_POSITION           : Result := 'NL_NO_POSITION';
    NL_NOT_FOUND             : Result := 'NL_NOT_FOUND';
    NL_VERSION_NOT_SUPPORTED : Result := 'NL_VERSION_NOT_SUPPORTED';
    NL_OCO_NO_RULES          : Result := 'NL_OCO_NO_RULES';
    NL_EXCHANGE_UNKNOWN      : Result := 'NL_EXCHANGE_UNKNOWN';
    NL_NO_OCO_DEFINED        : Result := 'NL_NO_OCO_DEFINED';
    NL_INVALID_SERIE         : Result := 'NL_INVALID_SERIE';
    NL_LICENSE_NOT_ALLOWED   : Result := 'NL_LICENSE_NOT_ALLOWED';
    NL_NOT_HARD_LOGOUT       : Result := 'NL_NOT_HARD_LOGOUT';
    NL_SERIE_NO_HISTORY      : Result := 'NL_SERIE_NO_HISTORY';
    NL_ASSET_NO_DATA         : Result := 'NL_ASSET_NO_DATA';
    NL_SERIE_NO_DATA         : Result := 'NL_SERIE_NO_DATA';
    NL_HAS_STRATEGY_RUNNING  : Result := 'NL_HAS_STRATEGY_RUNNING';
    NL_SERIE_NO_MORE_HISTORY : Result := 'NL_SERIE_NO_MORE_HISTORY';
    NL_SERIE_MAX_COUNT       : Result := 'NL_SERIE_MAX_COUNT';
    NL_DUPLICATE_RESOURCE    : Result := 'NL_DUPLICATE_RESOURCE';
    NL_UNSIGNED_CONTRACT     : Result := 'NL_UNSIGNED_CONTRACT';
    NL_NO_PASSWORD           : Result := 'NL_NO_PASSWORD';
    NL_NO_USER               : Result := 'NL_NO_USER';
    NL_FILE_ALREADY_EXISTS   : Result := 'NL_FILE_ALREADY_EXISTS';
    NL_INVALID_TICKER        : Result := 'NL_INVALID_TICKER';
    NL_NOT_MASTER_ACCOUNT    : Result := 'NL_NOT_MASTER_ACCOUNT';
  else
    if a_nResult < 0
      then Result := Format('0x%x', [Integer(a_nResult)])
      else Result := IntToStr(a_nResult);
  end;
end;

end.
