unit ProfitDataTypesU;

interface

uses
  WinApi.Windows;

type
{$POINTERMATH ON}
  PConnectorAccountIdentifierArrayOut = ^TConnectorAccountIdentifierOut;
  PByteArrayInOut                     = ^Byte;
  PIntegerArrayInOut                  = ^Integer;
{$POINTERMATH OFF}

  TTickerLength = 0..49;
  TTicker       = array [TTickerLength] of WideChar;
  TString0In    = array[0 .. 99] of WideChar;

  TConnectorOrderType = (
    cotMarket    = 1,
    cotLimit     = 2,
    cotStopLimit = 4
  );

  TConnectorOrderSide = (
    cosBuy  = 1,
    cosSell = 2
  );

  TConnectorActionType = (
    atAdd        = 0,
    atEdit       = 1,
    atDelete     = 2,
    atDeleteFrom = 3,
    atFullBook   = 4
  );

  TConnectorUpdateType = (
    utAdd          = 0,
    utEdit         = 1,
    utDelete       = 2,
    utInsert       = 3,
    utFullBook     = 4,
    utPrepare      = 5,
    utFlush        = 6,
    utTheoricPrice = 7,
    utDeleteFrom   = 8
  );

  TConnectorBookSideType = (
    bsBuy  = 0,
    bsSell = 1,
    bsBoth = 254,
    bsNone = 255
  );

  TConnectorTradingMessageResultCode = (
    mrcStarting                       = 0,
    mrcNotConnected                   = 1,
    mrcSentToHadesProxy               = 2,
    mrcRejectedMercury                = 3,
    mrcSentToHades                    = 4,
    mrcRejectedHades                  = 5,
    mrcSentToBroker                   = 6,
    mrcRejectedBroker                 = 7,
    mrcSentToMarket                   = 8,
    mrcRejectedMarket                 = 9,
    mrcAccepted                       = 10,
    mrcMarginTypeChangeRejected       = 11,
    mrcPositionModeChangeRejected     = 12,
    mrcNeedUpdateFromServer           = 13,
    mrcSentToWallet                   = 17,
    mrcBlockedByRisk                  = 24,
    mrcSubAccount                     = 50,
    mrcSubAccountPlan                 = 51,
    mrcSubAccountResetLimit           = 52,
    mrcSubAccountBrokerage            = 53,
    mrcSubAccountBrokeragePrefix      = 54,
    mrcSubAccountGroup                = 55,
    mrcSubAccountGroupInsertion       = 56,
    mrcRiskGroup                      = 60,
    mrcRiskPrefix                     = 61,
    mrcRiskAccount                    = 62,
    mrcResetPasswordResult            = 63,
    mrcFinEditTradeResultSucess       = 70,
    mrcFinTradeResultErro             = 71,
    mrcSubAccountPrefixSuccess        = 74,
    mrcSubAccountPrefixError          = 75,
    mrcFinancialLossSuccess           = 76,
    mrcInvalidData                    = 77,
    mrcInvalidWalletTransfer          = 78,
    mrcSubAccountAssetsUpdateSuccess  = 79,
    mrcSubAccountAssetsUpdateError    = 80,
    mrcUnknown                        = 200
  );

  TConnectorTradingMessageResultCodeHelper = record Helper for TConnectorTradingMessageResultCode
  public
    function ToString : String;
  end;

  TConnectorAccountIdentifier = record
    Version : Byte;

    // V0
    BrokerID     : Integer;
    AccountID    : PWideChar;
    SubAccountID : PWideChar;
    Reserved     : Int64;
  end;
  PConnectorAccountIdentifier = ^TConnectorAccountIdentifier;

  TConnectorAccountIdentifierOut = record
    Version : Byte;

    // V0
    BrokerID           : Integer;
    AccountID          : TString0In;
    AccountIDLength    : Integer;
    SubAccountID       : TString0In;
    SubAccountIDLength : Integer;
    Reserved           : Int64;
  end;
  PConnectorAccountIdentifierOut = ^TConnectorAccountIdentifierOut;

  TConnectorAssetIdentifier = record
    Version : Byte;

    // V0
    Ticker   : PWideChar;
    Exchange : PWideChar;
    FeedType : Byte;
  end;
  PConnectorAssetIdentifier = ^TConnectorAssetIdentifier;

  TConnectorAssetIdentifierOut = record
    Version : Byte;

    // V0
    Ticker         : PWideChar;
    TickerLength   : Integer;
    Exchange       : PWideChar;
    ExchangeLength : Integer;
    FeedType : Byte;
  end;

  TConnectorPriceGroup = record
    Version : Byte;

    Price           : Double;
    Count           : Cardinal;
    Quantity        : Int64;

    PriceGroupFlags : Cardinal;
  end;
  PConnectorPriceGroup = ^TConnectorPriceGroup;

  TConnectorOrderIdentifier = record
    Version : Byte;

    // V0
    LocalOrderID : Int64;
    ClOrderID    : PWideChar;
  end;

  TConnectorSendOrder = record
    Version : Byte;

    // V0
    AccountID : TConnectorAccountIdentifier;
    AssetID   : TConnectorAssetIdentifier;
    Password  : PWideChar;
    OrderType : Byte; // TConnectorOrderType
    OrderSide : Byte; // TConnectorOrderSide

    Price     : Double;
    StopPrice : Double;
    Quantity  : Int64;

    // V1
    MessageID : Int64;
  end;
  PConnectorSendOrder = ^TConnectorSendOrder;

  TConnectorChangeOrder = record
    Version : Byte;

    // V0
    AccountID : TConnectorAccountIdentifier;
    OrderID   : TConnectorOrderIdentifier;
    Password  : PWideChar;

    Price     : Double;
    StopPrice : Double;
    Quantity  : Int64;

    // V1
    MessageID : Int64;
  end;
  PConnectorChangeOrder = ^TConnectorChangeOrder;

  TConnectorCancelOrder = record
    Version : Byte;

    // V0
    AccountID : TConnectorAccountIdentifier;
    OrderID   : TConnectorOrderIdentifier;
    Password  : PWideChar;

    // V1
    MessageID : Int64;
  end;
  PConnectorCancelOrder = ^TConnectorCancelOrder;

  TConnectorCancelOrders = record
    Version : Byte;

    // V0
    AccountID : TConnectorAccountIdentifier;
    AssetID   : TConnectorAssetIdentifier;
    Password  : PWideChar;
  end;
  PConnectorCancelOrders = ^TConnectorCancelOrders;

  TConnectorCancelAllOrders = record
    Version : Byte;

    // V0
    AccountID : TConnectorAccountIdentifier;
    Password  : PWideChar;
  end;
  PConnectorCancelAllOrders = ^TConnectorCancelAllOrders;

  TConnectorZeroPosition = record
    Version : Byte;

    // V0
    AccountID : TConnectorAccountIdentifier;
    AssetID   : TConnectorAssetIdentifier;
    Password  : PWideChar;
    Price     : Double;

    // V1
    PositionType : Byte;

    // V2
    MessageID : Int64;
  end;
  PConnectorZeroPosition = ^TConnectorZeroPosition;

  TConnectorTradingAccountOut = record
    Version : Byte;

    // In Fields
    AccountID : TConnectorAccountIdentifier;

    // Out fields
    BrokerName         : PWideChar;
    BrokerNameLength   : Integer;

    OwnerName          : PWideChar;
    OwnerNameLength    : Integer;

    SubOwnerName       : PWideChar;
    SubOwnerNameLength : Integer;

    AccountFlags       : Cardinal;

    AccountType        : Byte;
  end;
  PConnectorTradingAccountOut = ^TConnectorTradingAccountOut;

  TConnectorTradingAccountPosition = record
    Version : Byte;

    // In Fields
    AccountID : TConnectorAccountIdentifier;
    AssetID   : TConnectorAssetIdentifier;

    // Out Fields
    OpenQuantity           : Int64;
    OpenAveragePrice       : Double;
    OpenSide               : Byte; // TBrokerOrderSide

    DailyAverageSellPrice  : Double;
    DailySellQuantity      : Int64;
    DailyAverageBuyPrice   : Double;
    DailyBuyQuantity       : Int64;

    DailyQuantityD1        : Int64;
    DailyQuantityD2        : Int64;
    DailyQuantityD3        : Int64;
    DailyQuantityBlocked   : Int64;
    DailyQuantityPending   : Int64;
    DailyQuantityAlloc     : Int64;
    DailyQuantityProvision : Int64;
    DailyQuantity          : Int64;
    DailyQuantityAvailable : Int64;

    // V1
    PositionType           : Byte;

    // V2
    EventID                : Int64;
  end;
  PConnectorTradingAccountPosition = ^TConnectorTradingAccountPosition;

  TConnectorOrder = record
    Version : Byte;

    OrderID           : TConnectorOrderIdentifier;
    AccountID         : TConnectorAccountIdentifier;
    AssetID           : TConnectorAssetIdentifier;

    Quantity          : Int64;
    TradedQuantity    : Int64;
    LeavesQuantity    : Int64;

    Price             : Double;
    StopPrice         : Double;
    AveragePrice      : Double;

    OrderSide         : Byte;
    OrderType         : Byte;
    OrderStatus       : Byte;
    ValidityType      : Byte;

    Date              : TSystemTime;
    LastUpdate        : TSystemTime;
    CloseDate         : TSystemTime;
    ValidityDate      : TSystemTime;

    TextMessage       : PWideChar;

    // V1
    EventID           : Int64;
  end;
  PConnectorOrder = ^TConnectorOrder;

  TConnectorOrderOut = record
    Version : Byte;

    // In Fields
    OrderID           : TConnectorOrderIdentifier;

                              // Out Fields
    AccountID         : TConnectorAccountIdentifierOut;
    AssetID           : TConnectorAssetIdentifierOut;

    Quantity          : Int64;
    TradedQuantity    : Int64;
    LeavesQuantity    : Int64;

    Price             : Double;
    StopPrice         : Double;
    AveragePrice      : Double;

    OrderSide         : Byte; // TBrokerOrderSide
    OrderType         : Byte; // TBrokerOrderType
    OrderStatus       : Byte; // TBrokerOrderStatus
    ValidityType      : Byte; // TBrokerTimeInForce

    Date              : TSystemTime;
    LastUpdate        : TSystemTime;
    CloseDate         : TSystemTime;
    ValidityDate      : TSystemTime;

    TextMessage       : PWideChar;
    TextMessageLength : Integer;

    // V1

    EventID           : Int64;
  end;
  PConnectorOrderOut = ^TConnectorOrderOut;

  TConnectorTradingMessageResult = record
    Version : Byte;

    // V0
    BrokerID      : Integer;
    OrderID       : TConnectorOrderIdentifier;
    MessageID     : Int64;
    ResultCode    : Byte; // TBrokerMessageResultCode
    Message       : PWideChar;
    MessageLength : Integer;
  end;
  PConnectorTradingMessageResult = ^TConnectorTradingMessageResult;

  TConnectorTrade = record
    Version     : Byte;

    TradeDate   : TSystemTime;
    TradeNumber : Cardinal;
    Price       : Double;
    Quantity    : Int64;
    Volume      : Double;
    BuyAgent    : Integer;
    SellAgent   : Integer;
    TradeType   : Byte; //TTradeType;
  end;
  PConnectorTrade = ^TConnectorTrade;

  TConnectorEnumerateOrdersProc = function(
    const a_Order : PConnectorOrder;
    const a_Param : LPARAM
  ) : BOOL; stdcall;

  TConnectorEnumerateAssetProc = function(
    const a_Asset : TConnectorAssetIdentifier;
    const a_Param : LPARAM
  ) : BOOL; stdcall;

const
  // TConnectorTradingAccountOut.Flags
  CA_IS_SUB_ACCOUNT : Cardinal = 1;
  CA_IS_ENABLED     : Cardinal = 2;

  // TConnectorMarketDataLibrary.Flags
  CM_IS_SHORT_NAME  : Cardinal = 1;

  // TConnectorPriceGroup.PriceGroupFlags
  PG_IS_THEORIC     : Cardinal = 1;

implementation

uses
  System.SysUtils;

function TConnectorTradingMessageResultCodeHelper.ToString : String;
begin
  case Self of
    mrcStarting                       : Result := 'Starting';
    mrcNotConnected                   : Result := 'NotConnectedServer';
    mrcSentToHadesProxy               : Result := 'SentToHadesProxy';
    mrcRejectedMercury                : Result := 'RejectedMercuryLegacy';
    mrcSentToHades                    : Result := 'SentToHades';
    mrcRejectedHades                  : Result := 'RejectedHades';
    mrcSentToBroker                   : Result := 'SentToBroker';
    mrcRejectedBroker                 : Result := 'RejectedBroker';
    mrcSentToMarket                   : Result := 'SentToMarket';
    mrcRejectedMarket                 : Result := 'RejectedMarket';
    mrcAccepted                       : Result := 'Accepted';
    mrcMarginTypeChangeRejected       : Result := 'MarginTypeChangeRejected';
    mrcPositionModeChangeRejected     : Result := 'PositionModeChangeRejected';
    mrcNeedUpdateFromServer           : Result := 'NeedUpdateFromServer';
    mrcBlockedByRisk                  : Result := 'BlockedByRisk';
    mrcSubAccount                     : Result := 'SubAccount';
    mrcSubAccountPlan                 : Result := 'SubAccountPlan';
    mrcSubAccountResetLimit           : Result := 'SubAccountResetLimit';
    mrcSubAccountBrokerage            : Result := 'SubAccountBrokerage';
    mrcSubAccountBrokeragePrefix      : Result := 'SubAccountBrokeragePrefix';
    mrcSubAccountGroup                : Result := 'SubAccountGroup';
    mrcSubAccountGroupInsertion       : Result := 'SubAccountGroupInsertion';
    mrcRiskGroup                      : Result := 'RiskGroup';
    mrcRiskPrefix                     : Result := 'RiskPrefix';
    mrcRiskAccount                    : Result := 'RiskAccount';
    mrcResetPasswordResult            : Result := 'ResetPasswordResult';
    mrcFinEditTradeResultSucess       : Result := 'FinEditTradeResultSucess';
    mrcFinTradeResultErro             : Result := 'FinTradeResultErro';
    mrcSubAccountPrefixSuccess        : Result := 'SubAccountPrefixSuccess';
    mrcSubAccountPrefixError          : Result := 'SubAccountPrefixError';
    mrcFinancialLossSuccess           : Result := 'FinancialLossSuccess';
    mrcInvalidData                    : Result := 'InvalidData';
    mrcInvalidWalletTransfer          : Result := 'InvalidWalletTransfer';
    mrcSubAccountAssetsUpdateSuccess  : Result := 'SubAccountAssetsUpdateSuccess';
    mrcSubAccountAssetsUpdateError    : Result := 'SubAccountAssetsUpdateError';
    mrcUnknown                        : Result := 'Unknown';
  else
    Result := IntToStr(Integer(Self));
  end;
end;

end.
