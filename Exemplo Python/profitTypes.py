from enum import Enum, IntEnum
from ctypes import POINTER, WINFUNCTYPE, Structure, c_bool, c_double, c_int, c_int64, c_long, c_longlong, c_ubyte, c_uint, c_ushort, c_wchar, c_wchar_p, c_void_p, c_size_t

class TConnectorOrderType(Enum):
    Limit = 2
    Stop = 4
    Market = 1

class TConnectorOrderSide(Enum):
    Buy = 1
    Sell = 2

class TConnectorPositionType(Enum):
    DayTrade = 1
    Consolidated = 2

class TTradeType(IntEnum):
    CrossTrade      = 1
    AggressorBuyer  = 2   # Agressor de compra (BUY)
    AggressorSeller = 3   # Agressor de venda (SELL)
    Auction         = 4
    Surveillance    = 5
    Expit           = 6
    OptionExercise  = 7
    OverTheCounter  = 8
    DerivativeTerm  = 9
    Index           = 10
    BTC             = 11
    OnBehalf        = 12
    RLP             = 13
    BBT             = 14  # Block Book Trade
    RFQ             = 15  # Request For Trade
    MPT             = 16  # Midpoint Trade
    TAC             = 17  # Trade at Close
    TAA             = 18  # Trade At Average
    Unknown         = 32
    Update          = 33
    Mid             = 34
    OffExchange     = 35

class TSystemHealthState(IntEnum):
    Responsive = 0
    Frozen     = 1

class TConnectorTradingMessageResultCode(Enum):
    Starting                       = 0
    NotConnected                   = 1
    SentToHadesProxy               = 2
    RejectedMercury                = 3
    SentToHades                    = 4
    RejectedHades                  = 5
    SentToBroker                   = 6
    RejectedBroker                 = 7
    SentToMarket                   = 8
    RejectedMarket                 = 9
    Accepted                       = 10
    MarginTypeChangeRejected       = 11
    PositionModeChangeRejected     = 12
    NeedUpdateFromServer           = 13
    SentToWallet                   = 17
    BlockedByRisk                  = 24
    SubAccount                     = 50
    SubAccountPlan                 = 51
    SubAccountResetLimit           = 52
    SubAccountBrokerage            = 53
    SubAccountBrokeragePrefix      = 54
    SubAccountGroup                = 55
    SubAccountGroupInsertion       = 56
    RiskGroup                      = 60
    RiskPrefix                     = 61
    RiskAccount                    = 62
    ResetPasswordResult            = 63
    FinEditTradeResultSucess       = 70
    FinTradeResultErro             = 71
    SubAccountPrefixSuccess        = 74
    SubAccountPrefixError          = 75
    FinancialLossSuccess           = 76
    InvalidData                    = 77
    InvalidWalletTransfer          = 78
    SubAccountAssetsUpdateSuccess  = 79
    SubAccountAssetsUpdateError    = 80
    Unknown                        = 200

class SystemTime(Structure):
    _fields_ = [
        ("wYear", c_ushort),
        ("wMonth", c_ushort),
        ("wDayOfWeek", c_ushort),
        ("wDay", c_ushort),
        ("wHour", c_ushort),
        ("wMinute", c_ushort),
        ("wSecond", c_ushort),
        ("wMilliseconds", c_ushort)
    ]

class TConnectorAccountIdentifier(Structure):
    _fields_ = [
        ("Version", c_ubyte),
        ("BrokerID", c_int),
        ("AccountID", c_wchar_p),
        ("SubAccountID", c_wchar_p),
        ("Reserved", c_int64)
    ]

class TConnectorAccountIdentifierOut(Structure):
    _fields_ = [
        ("Version", c_ubyte),
        ("BrokerID", c_int),
        ("AccountID", c_wchar * 100),
        ("AccountIDLength", c_int),
        ("SubAccountID", c_wchar * 100),
        ("SubAccountIDLength", c_int),
        ("Reserved", c_int64)
    ]

class TConnectorAssetIdentifier(Structure):
    _fields_ = [
        ("Version", c_ubyte),
        ("Ticker", c_wchar_p),
        ("Exchange", c_wchar_p),
        ("FeedType", c_ubyte)
    ]

class TConnectorAssetIdentifierOut(Structure):
    _fields_ = [
        ("Version", c_ubyte),
        ("Ticker", c_wchar_p),
        ("TickerLength", c_int),
        ("Exchange", c_wchar_p),
        ("ExchangeLength", c_int),
        ("FeedType", c_ubyte)
    ]

class TConnectorPriceGroup(Structure):
    _fields_ = [
        ("Version", c_ubyte),
        ("Price", c_double),
        ("Count", c_uint),
        ("Quantity", c_long),
        ("PriceGroupFlags", c_uint)
    ]

class TConnectorOrderIdentifier(Structure):
    _fields_ = [
        ("Version", c_ubyte),
        ("LocalOrderID", c_int64),
        ("ClOrderID", c_wchar_p)
    ]

class TConnectorSendOrder(Structure):
    _fields_ = [
        ("Version", c_ubyte),
        ("AccountID", TConnectorAccountIdentifier),
        ("AssetID", TConnectorAssetIdentifier),
        ("Password", c_wchar_p),
        ("OrderType", c_ubyte),
        ("OrderSide", c_ubyte),
        ("Price", c_double),
        ("StopPrice", c_double),
        ("Quantity", c_int64),

        # V2
        ("MessageID", c_int64)
    ]

class TConnectorChangeOrder(Structure):
    _fields_ = [
        ("Version", c_ubyte),
        ("AccountID", TConnectorAccountIdentifier),
        ("OrderID", TConnectorOrderIdentifier),
        ("Password", c_wchar_p),
        ("Price", c_double),
        ("StopPrice", c_double),
        ("Quantity", c_int64),

        # V1
        ("MessageID", c_int64)
    ]

class TConnectorCancelOrder(Structure):
    _fields_ = [
        ("Version", c_ubyte),
        ("AccountID", TConnectorAccountIdentifier),
        ("OrderID", TConnectorOrderIdentifier),
        ("Password", c_wchar_p),

        # V1
        ("MessageID", c_int64)
    ]

class TConnectorCancelOrders(Structure):
    _fields_ = [
        ("Version", c_ubyte),
        ("AccountID", TConnectorAccountIdentifier),
        ("AssetID", TConnectorAssetIdentifier),
        ("Password", c_wchar_p)
    ]

class TConnectorCancelAllOrders(Structure):
    _fields_ = [
        ("Version", c_ubyte),
        ("AccountID", TConnectorAccountIdentifier),
        ("Password", c_wchar_p)
    ]

class TConnectorZeroPosition(Structure):
    _fields_ = [
        ("Version", c_ubyte),
        ("AccountID", TConnectorAccountIdentifier),
        ("AssetID", TConnectorAssetIdentifier),
        ("Password", c_wchar_p),
        ("Price", c_double),
        ("PositionType", c_ubyte),

        # V2
        ("MessageID", c_int64)
    ]

class TConnectorTradingAccountOut(Structure):
    _fields_ = [
        ("Version", c_ubyte),
        ("AccountID", TConnectorAccountIdentifier),
        ("BrokerName", c_wchar_p),
        ("BrokerNameLength", c_int),
        ("OwnerName", c_wchar_p),
        ("OwnerNameLength", c_int),
        ("SubOwnerName", c_wchar_p),
        ("SubOwnerNameLength", c_int),
        ("AccountFlags", c_int),
        ("AccountType", c_ubyte)
    ]

class TConnectorTradingAccountPosition(Structure):
    _fields_ = [
        ("Version", c_ubyte),
        ("AccountID", TConnectorAccountIdentifier),
        ("AssetID", TConnectorAssetIdentifier),
        ("OpenQuantity", c_int64),
        ("OpenAveragePrice", c_double),
        ("OpenSide", c_ubyte),
        ("DailyAverageSellPrice", c_double),
        ("DailySellQuantity", c_int64),
        ("DailyAverageBuyPrice", c_double),
        ("DailyBuyQuantity", c_int64),
        ("DailyQuantityD1", c_int64),
        ("DailyQuantityD2", c_int64),
        ("DailyQuantityD3", c_int64),
        ("DailyQuantityBlocked", c_int64),
        ("DailyQuantityPending", c_int64),
        ("DailyQuantityAlloc", c_int64),
        ("DailyQuantityProvision", c_int64),
        ("DailyQuantity", c_int64),
        ("DailyQuantityAvailable", c_int64),
        ("PositionType", c_ubyte),
        ("EventID", c_int64)
    ]

class TConnectorOrder(Structure):
    _fields_ = [
        ("Version", c_ubyte),
        ("OrderID", TConnectorOrderIdentifier),
        ("AccountID", TConnectorAccountIdentifier),
        ("AssetID", TConnectorAssetIdentifier),
        ("Quantity", c_int64),
        ("TradedQuantity", c_int64),
        ("LeavesQuantity", c_int64),
        ("Price", c_double),
        ("StopPrice", c_double),
        ("AveragePrice", c_double),
        ("OrderSide", c_ubyte),
        ("OrderType", c_ubyte),
        ("OrderStatus", c_ubyte),
        ("ValidityType", c_ubyte),
        ("Date", SystemTime),
        ("LastUpdate", SystemTime),
        ("CloseDate", SystemTime),
        ("ValidityDate", SystemTime),
        ("TextMessage", c_wchar_p),
        ("EventID", c_int64)
    ]

class TConnectorOrderOut(Structure):
    _fields_ = [
        ("Version", c_ubyte),
        ("OrderID", TConnectorOrderIdentifier),
        ("AccountID", TConnectorAccountIdentifierOut),
        ("AssetID", TConnectorAssetIdentifierOut),
        ("Quantity", c_int64),
        ("TradedQuantity", c_int64),
        ("LeavesQuantity", c_int64),
        ("Price", c_double),
        ("StopPrice", c_double),
        ("AveragePrice", c_double),
        ("OrderSide", c_ubyte),
        ("OrderType", c_ubyte),
        ("OrderStatus", c_ubyte),
        ("ValidityType", c_ubyte),
        ("Date", SystemTime),
        ("LastUpdate", SystemTime),
        ("CloseDate", SystemTime),
        ("ValidityDate", SystemTime),
        ("TextMessage", c_wchar_p),
        ("TextMessageLength", c_int),
        ("EventID", c_int64)
    ]


class TConnectorTrade(Structure):
    _fields_ = [
        ("Version", c_ubyte),
        ("TradeDate", SystemTime),
        ("TradeNumber", c_uint),
        ("Price", c_double),
        ("Quantity", c_longlong),
        ("Volume", c_double),
        ("BuyAgent", c_int),
        ("SellAgent", c_int),
        ("TradeType", c_ubyte)  # ver TTradeType
    ]

class TAssetID(Structure):
    _fields_ = [("ticker", c_wchar_p),
                ("bolsa", c_wchar_p),
                ("feed", c_int)]

class TGroupOffer(Structure):
    _fields_ = [("nPosition", c_int),
                ("nQtd", c_int),
                ("nOfferID", c_int),
                ("nAgent", c_int),
                ("sPrice", c_double),
                ("strDtOffer", c_int)]


class TGroupPrice(Structure):
    _fields_ = [("nQtd", c_int),
                ("nCount", c_int),
                ("sPrice", c_double)]

class TConnectorTradingMessageResult(Structure):
    _fields_ = [
        ("Version", c_ubyte),

        # V0
        ("BrokerID", c_int),
        ("OrderID", TConnectorOrderIdentifier),
        ("MessageID", c_int64),
        ("ResultCode", c_ubyte), # TBrokerMessageResultCode
        ("Message", c_wchar_p),
        ("MessageLength", c_int)
    ]

class TNewTradeCallback(Structure):
    _fields_ = [("assetId", TAssetID),
                ("date", c_wchar_p),
                ("tradeNumber", c_uint),
                ("price", c_double),
                ("vol", c_double),
                ("qtd", c_int),
                ("buyAgent", c_int),
                ("sellAgent", c_int),
                ("tradeType", c_int),
                ("bIsEdit", c_int)]

class TTheoreticalPriceCallback(Structure):
    _fields_ = [("assetId", TAssetID),
                ("dTheoreticalPrice", c_double),
                ("nTheoreticalQtd", c_uint)]

class TNewDailyCallback(Structure):
    _fields_ = [("tAssetIDRec", TAssetID),
                ("date", c_wchar_p),
                ("sOpen", c_double),
                ("sHigh", c_double),
                ("sLow", c_double),
                ("sClose", c_double),
                ("sVol", c_double),
                ("sAjuste", c_double),
                ("sMaxLimit", c_double),
                ("sMinLimit", c_double),
                ("sVolBuyer", c_double),
                ("sVolSeller", c_double),
                ("nQtd", c_int),
                ("nNegocios", c_int),
                ("nContratosOpen", c_int),
                ("nQtdBuyer", c_int),
                ("nQtdSeller", c_int),
                ("nNegBuyer", c_int),
                ("nNegSeller", c_int)]



class TNewHistoryCallback(Structure):
    _fields_ = [("assetId", TAssetID),
                ("date", c_wchar_p),
                ("tradeNumber", c_uint),
                ("price", c_double),
                ("vol", c_double),
                ("qtd", c_int),
                ("buyAgent", c_int),
                ("sellAgent", c_int),
                ("tradeType", c_int)]



class TProgressCallBack(Structure):
    _fields_ = [("assetId", TAssetID),
                ("nProgress", c_int)]


class TNewTinyBookCallBack(Structure):
    _fields_ = [("assetId", TAssetID),
                ("price", c_double),
                ("qtd", c_int),
                ("side", c_int)]



class TPriceBookCallback(Structure):
    _fields_ = [("assetId", TAssetID),
                ("nAction", c_int),
                ("nPosition", c_int),
                ("side", c_int),
                ("nQtd", c_int),
                ("ncount", c_int),
                ("sprice", c_double),
                ("pArraySell", POINTER(c_int)),
                ("pArrayBuy", POINTER(c_int))]



class TOfferBookCallback(Structure):
    _fields_ = [("assetId", TAssetID),
                ("nAction", c_int),
                ("nPosition", c_int),
                ("side", c_int),
                ("nQtd", c_int),
                ("nAgent", c_int),
                ("nOfferID", c_longlong),
                ("sPrice", c_double),
                ("bHasPrice", c_int),
                ("bHasQtd", c_int),
                ("bHasDate", c_int),
                ("bHasOfferId", c_int),
                ("bHasAgent", c_int),
                ("date", c_wchar_p),
                ("pArraySell", POINTER(c_int)),
                ("pArrayBuy", POINTER(c_int))]

class TOfferBookCallbackV2(Structure):
    _fields_ = [("assetId", TAssetID),
                ("nAction", c_int),
                ("nPosition", c_int),
                ("side", c_int),
                ("nQtd", c_int),
                ("nAgent", c_int),
                ("nOfferID", c_longlong),
                ("sPrice", c_double),
                ("bHasPrice", c_int),
                ("bHasQtd", c_int),
                ("bHasDate", c_int),
                ("bHasOfferId", c_int),
                ("bHasAgent", c_int),
                ("date", c_wchar_p),
                ("pArraySell", POINTER(c_int)),
                ("pArrayBuy", POINTER(c_int))]


TConnectorEnumerateOrdersProc = WINFUNCTYPE(
    c_bool,
    POINTER(TConnectorOrder),
    c_long
)

TConnectorEnumerateAssetProc = WINFUNCTYPE(
    c_bool,
    POINTER(TConnectorAssetIdentifier),
    c_long
)

TConnectorTradingMessageResultCallback = WINFUNCTYPE(
    None,
    POINTER(TConnectorTradingMessageResult)
)

class TConnectorAssetIdentifierSafe(Structure):
    _fields_ = [
        ("Version", c_ubyte),
        ("Ticker", c_void_p),  
        ("Exchange", c_void_p), 
        ("FeedType", c_ubyte)
    ]

TConnectorTradeCallback = WINFUNCTYPE(
    None,
    TConnectorAssetIdentifierSafe, 
    c_size_t,                  
    c_uint                     # flags
)