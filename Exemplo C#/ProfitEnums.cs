using System;

namespace ProfitDLLClient;

public enum NResult : int
{
    NL_OK = 0,

    NL_INTERNAL_ERROR = unchecked((int)0x80000001),
    NL_NOT_INITIALIZED,
    NL_INVALID_ARGS,
    NL_WAITING_SERVER,
    NL_NO_LOGIN,
    NL_NO_LICENSE,
    NL_PASSWORD_HASH_SHA1,
    NL_PASSWORD_HASH_MD5,
    NL_OUT_OF_RANGE,
    NL_MARKET_ONLY,
    NL_NO_POSITION,
    NL_NOT_FOUND,
    NL_VERSION_NOT_SUPPORTED,
    NL_OCO_NO_RULES,
    NL_EXCHANGE_UNKNOWN,
    NL_NO_OCO_DEFINED,
    NL_INVALID_SERIE,
    NL_LICENSE_NOT_ALLOWED,
    NL_NOT_HARD_LOGOUT,
    NL_SERIE_NO_HISTORY,
    NL_ASSET_NO_DATA,
    NL_SERIE_NO_DATA,
    NL_HAS_STRATEGY_RUNNING,
    NL_SERIE_NO_MORE_HISTORY,
    NL_SERIE_MAX_COUNT,
    NL_DUPLICATE_RESOURCE,
    NL_UNSIGNED_CONTRACT,
    NL_NO_PASSWORD,
    NL_NO_USER,
    NL_FILE_ALREADY_EXISTS,
    NL_INVALID_TICKER,
    NL_NOT_MASTER_ACCOUNT
}

[Flags]
public enum OfferBookFlags : uint
{
    OB_LAST_PACKET = 1,
    OB_FIRST_PACKET = 2
}

public enum TConnectorOrderType : byte
{
    Market = 1,
    Limit = 2,
    Stop = 3,
    StopLimit = 4,
    MarketOnClose = 5,
    WithOrWithout = 6,
    LimitOrBetter = 7,
    LimitWithOrWithout = 8,
    OnBasis = 9,
    OnClose = 10,
    LimitOnClose = 11,
    ForexMarket = 12,
    PreviouslyQuoted = 13,
    PreviouslyIndicated = 14,
    ForexLimit = 15,
    ForexSwap = 16,
    ForexPreviouslyQuoted = 17,
    Funari = 18,
    MarketIfTouched = 19,
    MarketWithLeftoverAsLimit = 20,
    PreviousFundValuationPoint = 21,
    NextFundValuationPoint = 22,
    Pegged = 23,
    RLP = 24,
    WalletTransfer = 25,
    Simulator = 27,
    MarketOnAuction = 28,
    Unknown = 200
}

public enum TConnectorOrderSide : byte
{
    Buy = 1,
    Sell = 2,
    BuyMinus = 3,
    SellPlus = 4,
    SellShort = 5,
    SellShortExempt = 6,
    Undisclosed = 7,
    Cross = 8,
    CrossShort = 9,
    CrossShortExempt = 10,
    AsDefined = 11,
    Opposite = 12,
    Subscribe = 13,
    Redeem = 14,
    Lend = 15,
    Borrow = 16,
    Unknown = 200
}

public enum TConnectorPositionType : byte
{
    DayTrade = 1,
    Consolidated = 2
}

public enum TConnectorBookActionType : byte
{
    Add = 0,
    Edit = 1,
    Delete = 2,
    DeleteFrom = 3,
    FullBook = 4
}

public enum TConnectorUpdateType
{
    Add = 0,
    Edit = 1,
    Delete = 2,
    Insert = 3,
    FullBook = 4,
    Prepare = 5,
    Flush = 6,
    TheoricPrice = 7,
    DeleteFrom = 8
}

public enum TConnectorBookSideType : byte
{
    Buy = 0,
    Sell = 1,
    Both = 254,
    None = 255
}

[Flags]
public enum TConnectorTradeCallbackFlags : uint
{
    TC_IS_EDIT = 1,
    TC_LAST_PACKET = 2
}

public enum TConnectorTradingMessageResultCode : byte
{
    Starting = 0,
    NotConnected = 1,
    SentToHadesProxy = 2,
    RejectedMercury = 3,
    SentToHades = 4,
    RejectedHades = 5,
    SentToBroker = 6,
    RejectedBroker = 7,
    SentToMarket = 8,
    RejectedMarket = 9,
    Accepted = 10,
    MarginTypeChangeRejected = 11,
    PositionModeChangeRejected = 12,
    NeedUpdateFromServer = 13,
    SentToWallet = 17,
    BlockedByRisk = 24,
    SubAccount = 50,
    SubAccountPlan = 51,
    SubAccountResetLimit = 52,
    SubAccountBrokerage = 53,
    SubAccountBrokeragePrefix = 54,
    SubAccountGroup = 55,
    SubAccountGroupInsertion = 56,
    RiskGroup = 60,
    RiskPrefix = 61,
    RiskAccount = 62,
    ResetPasswordResult = 63,
    FinEditTradeResultSucess = 70,
    FinTradeResultErro = 71,
    SubAccountPrefixSuccess = 74,
    SubAccountPrefixError = 75,
    FinancialLossSuccess = 76,
    InvalidData = 77,
    InvalidWalletTransfer = 78,
    SubAccountAssetsUpdateSuccess = 79,
    SubAccountAssetsUpdateError = 80,
    Unknown = 200
}

public enum AgentNameFlags : uint
{
    CM_NONE = 0,
    CM_IS_SHORT_NAME = 1
}

public enum TradeType : byte
{
    CrossTrade = 1,
    AggressorBuyer = 2,
    AggressorSeller = 3,
    Auction = 4,
    Surveillance = 5,
    Expit = 6,
    OptionExercise = 7,
    OverTheCounter = 8,
    DerivativeTerm = 9,
    Index = 10,
    BTC = 11,
    OnBehalf = 12,
    RLP = 13,
    BBT = 14,
    RFQ = 15,
    MPT = 16,
    TAC = 17,
    TAA = 18,
    Unknown = 32,
    Update = 33,
    Mid = 34,
    OffExchange = 35
}