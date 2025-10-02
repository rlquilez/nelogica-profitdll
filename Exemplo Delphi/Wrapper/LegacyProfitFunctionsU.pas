unit LegacyProfitFunctionsU;

interface

uses
  Winapi.Windows,
  ProfitDataTypesU,
  ProfitCallbackTypesU;

const
  c_strDLLPath = 'ProfitDLL.dll';

///////////////////////////////////////////////////////////////////////////////
///  MARKET DATA
///////////////////////////////////////////////////////////////////////////////

function SubscribeTicker          (const pwcTicker : PWideChar; const pwcBolsa : PWideChar) : Integer; stdcall; external c_strDLLPath;
function UnsubscribeTicker        (const pwcTicker : PWideChar; const pwcBolsa : PWideChar) : Integer; stdcall; external c_strDLLPath;

function GetHistoryTrades         (const pwcTicker : PWideChar; const pwcBolsa : PWideChar; dtDateStart, dtDateEnd : PWideChar) : Integer; stdcall; external c_strDLLPath;
function GetSerieHistory          (const pwcTicker : PWideChar; const pwcBolsa : PWideChar; dtDateStart, dtDateEnd : PWideChar; const nQuoteNumberStart, nQuoteNumberEnd : Cardinal) : Integer; stdcall; external c_strDLLPath;

///////////////////////////////////////////////////////////////////////////////
///  TRADING
///////////////////////////////////////////////////////////////////////////////

function SendBuyOrder(
  pwcIDAccount   : PWideChar;
  pwcIDCorretora : PWideChar;
  sSenha         : PWideChar;
  pwcTicker      : PWideChar;
  pwcBolsa       : PWideChar;
  sPrice         : Double;
  nAmount        : Integer
): Int64; stdcall; external c_strDLLPath;

function SendSellOrder(
  pwcIDAccount   : PWideChar;
  pwcIDCorretora : PWideChar;
  sSenha         : PWideChar;
  pwcTicker      : PWideChar;
  pwcBolsa       : PWideChar;
  sPrice         : Double;
  nAmount        : Integer
): Int64; stdcall; external c_strDLLPath;

function SendStopBuyOrder(
  pwcIDAccount   : PWideChar;
  pwcIDCorretora : PWideChar;
  sSenha         : PWideChar;
  pwcTicker      : PWideChar;
  pwcBolsa       : PWideChar;
  sPrice         : Double;
  sStopPrice     : Double;
  nAmount        : Integer
): Int64; stdcall; external c_strDLLPath;

function SendStopSellOrder(
  pwcIDAccount   : PWideChar;
  pwcIDCorretora : PWideChar;
  sSenha         : PWideChar;
  pwcTicker      : PWideChar;
  pwcBolsa       : PWideChar;
  sPrice         : Double;
  sStopPrice     : Double;
  nAmount        : Integer
): Int64; stdcall; external c_strDLLPath;

function SendMarketSellOrder(
  pwcIDAccount   : PWideChar;
  pwcIDCorretora : PWideChar;
  sSenha         : PWideChar;
  pwcTicker      : PWideChar;
  pwcBolsa       : PWideChar;
  nAmount        : Integer
): Int64; stdcall; external c_strDLLPath;

function SendMarketBuyOrder(
  pwcIDAccount   : PWideChar;
  pwcIDCorretora : PWideChar;
  sSenha         : PWideChar;
  pwcTicker      : PWideChar;
  pwcBolsa       : PWideChar;
  nAmount        : Integer
): Int64; stdcall; external c_strDLLPath;

function SendChangeOrder(
  pwcIDAccount   : PWideChar;
  pwcIDCorretora : PWideChar;
  sSenha         : PWideChar;
  pwcClOrdID     : PWideChar;
  sPrice         : Double;
  nAmount        : Integer
): Integer; stdcall; external c_strDLLPath;

function SendCancelOrder(
  pwcIDAccount   : PWideChar;
  pwcIDCorretora : PWideChar;
  pwcClOrdId     : PWideChar;
  pwcSenha       : PWideChar
): Integer; stdcall; external c_strDLLPath;

function SendCancelAllOrders(
  pwcIDAccount   : PWideChar;
  pwcIDCorretora : PWideChar;
  pwcSenha       : PWideChar
): Integer; stdcall; external c_strDLLPath;

function SendCancelOrders(
  pwcIDAccount   : PWideChar;
  pwcIDCorretora : PWideChar;
  pwcSenha       : PWideChar;
  pwcTicker      : PWideChar;
  pwcBolsa       : PWideChar
): Integer; stdcall; external c_strDLLPath;

function SendZeroPosition(
  pwcIDAccount   : PWideChar;
  pwcIDCorretora : PWideChar;
  pwcTicker      : PWideChar;
  pwcBolsa       : PWideChar;
  pwcSenha       : PWideChar;
  sPrice         : Double
): Int64; stdcall; external c_strDLLPath;

function SendZeroPositionAtMarket(
  pwcIDAccount   : PWideChar;
  pwcIDCorretora : PWideChar;
  pwcTicker      : PWideChar;
  pwcBolsa       : PWideChar;
  pwcSenha       : PWideChar
): Int64; stdcall; external c_strDLLPath;

function GetOrders(
  pwcIDAccount   : PWideChar;
  pwcIDCorretora : PWideChar;
  dtStart        : PWideChar;
  dtEnd          : PWideChar
) : Integer; stdcall; external c_strDLLPath;

function GetOrder(pwcClOrdId : PWideChar): Integer; stdcall; external c_strDLLPath;

function GetOrderProfitID(nProfitId : Int64): Integer; stdcall; external c_strDLLPath;

function GetPosition(
  pwcIDAccount   : PWideChar;
  pwcIDCorretora : PWideChar;
  pwcTicker      : PWideChar;
  pwcBolsa       : PWideChar
): Pointer ; stdcall; external c_strDLLPath;

function GetAccount : Integer; stdcall; external c_strDLLPath;

///////////////////////////////////////////////////////////////////////////////
///  CALLBACK SETTERS
///////////////////////////////////////////////////////////////////////////////

function  SetTradeCallbackV2           (const a_TradeCallbackV2          : TConnectorTradeCallback)   : Integer; stdcall; external c_strDLLPath;
function  SetHistoryTradeCallbackV2    (const a_HistoryTradeCallbackV2   : TConnectorTradeCallback)   : Integer; stdcall; external c_strDLLPath;

function  SetHistoryCallback           (const a_HistoryCallback          : THistoryCallback)          : Integer; stdcall; external c_strDLLPath;
function  SetHistoryCallbackV2         (const a_HistoryCallbackV2        : THistoryCallbackV2)        : Integer; stdcall; external c_strDLLPath;
function  SetOrderChangeCallback       (const a_OrderChangeCallback      : TOrderChangeCallback)      : Integer; stdcall; external c_strDLLPath;
function  SetOrderChangeCallbackV2     (const a_OrderChangeCallbackV2    : TOrderChangeCallbackV2)    : Integer; stdcall; external c_strDLLPath;

implementation

end.
