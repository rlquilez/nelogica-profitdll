using System;
using System.Runtime.InteropServices;
using System.Runtime.InteropServices.Marshalling;

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
    OB_LAST_PACKET = 1
}

public enum TConnectorOrderType
{
    Limit = 2,
    Stop = 4,
    Market = 1
}

public enum TConnectorOrderSide
{
    Buy = 1,
    Sell = 2
}

public enum TConnectorPositionType : byte
{
    DayTrade = 1,
    Consolidated = 2
}

public enum TConnectorIntervalType : byte
{
    Trade = 0,
    Minute = 1,
    Daily = 2,
    Weekly = 3,
    Monthly = 4,
    Yearly = 5,
    Aggressor = 6,
    Lote = 7,
    Variation = 8,
    Inversion = 9,
    Quantity = 10,
    Renko = 11,
    Range = 12,
    PointFigure = 13,
    KagiChart = 14,
    PriceAction = 15,
    VarInv = 16,
    Second = 17,
    VolumeSerie = 18,
    None = 255
}

public enum TConnectorAdjustType : byte
{
    atNone = 2,
    atAdjust = 3,
    atSplits = 4,
    atBoth = 5
}

public enum TConnectorActionType
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

public enum TConnectorBookSideType
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

[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
public struct TConnectorAccountIdentifier
{
    public byte Version;
    public int BrokerID;
    [MarshalAs(UnmanagedType.LPWStr)]
    public string AccountID;
    [MarshalAs(UnmanagedType.LPWStr)]
    public string SubAccountID;
    public long Reserved;

    public override string ToString()
    {
        var retVal = $"{BrokerID}:{AccountID}";

        if (!string.IsNullOrWhiteSpace(SubAccountID))
        {
            retVal += $":{SubAccountID}";
        }

        return retVal;
    }
}

[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
public struct TConnectorAccountIdentifierOut
{
    public byte Version;
    public int BrokerID;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 100)]
    public string AccountID;
    public int AccountIDLength;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 100)]
    public string SubAccountID;
    public int SubAccountIDLength;
    public long Reserved;
}

[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
public struct TConnectorAssetIdentifier
{
    public byte Version;
    [MarshalAs(UnmanagedType.LPWStr)]
    public string Ticker;
    [MarshalAs(UnmanagedType.LPWStr)]
    public string Exchange;
    public byte FeedType;

    public override string ToString() => $"{Ticker}:{Exchange}";
}

[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
public struct TConnectorAssetIdentifierOut
{
    public byte Version;
    [MarshalAs(UnmanagedType.LPWStr)]
    public string Ticker;
    public int TickerLength;
    [MarshalAs(UnmanagedType.LPWStr)]
    public string Exchange;
    public int ExchangeLength;
    public byte FeedType;
}

[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
public struct TConnectorOrderIdentifier
{
    public byte Version;
    public long LocalOrderID;
    [MarshalAs(UnmanagedType.LPWStr)]
    public string ClOrderID;

    public override string ToString() => string.IsNullOrWhiteSpace(ClOrderID) ? LocalOrderID.ToString() : ClOrderID;
}

[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
public struct TConnectorSendOrder
{
    public byte Version;
    public TConnectorAccountIdentifier AccountID;
    public TConnectorAssetIdentifier AssetID;
    [MarshalAs(UnmanagedType.LPWStr)]
    public string Password;
    [MarshalAs(UnmanagedType.U1)]
    public TConnectorOrderType OrderType;
    [MarshalAs(UnmanagedType.U1)]
    public TConnectorOrderSide OrderSide;
    public double Price;
    public double StopPrice;
    public long Quantity;
}

[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
public struct TConnectorChangeOrder
{
    public byte Version;
    public TConnectorAccountIdentifier AccountID;
    public TConnectorOrderIdentifier OrderID;
    [MarshalAs(UnmanagedType.LPWStr)]
    public string Password;
    public double Price;
    public double StopPrice;
    public long Quantity;
}

[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
public struct TConnectorCancelOrder
{
    public byte Version;
    public TConnectorAccountIdentifier AccountID;
    public TConnectorOrderIdentifier OrderID;
    [MarshalAs(UnmanagedType.LPWStr)]
    public string Password;
}

[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
public struct TConnectorCancelOrders
{
    public byte Version;
    public TConnectorAccountIdentifier AccountID;
    public TConnectorAssetIdentifier AssetID;
    [MarshalAs(UnmanagedType.LPWStr)]
    public string Password;
}

[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
public struct TConnectorCancelAllOrders
{
    public byte Version;
    public TConnectorAccountIdentifier AccountID;
    [MarshalAs(UnmanagedType.LPWStr)]
    public string Password;
}

[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
public struct TConnectorZeroPosition
{
    public byte Version;
    public TConnectorAccountIdentifier AccountID;
    public TConnectorAssetIdentifier AssetID;
    [MarshalAs(UnmanagedType.LPWStr)]
    public string Password;
    public double Price;

    // V1
    [MarshalAs(UnmanagedType.U1)] public TConnectorPositionType PositionType;
}

[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
public struct TConnectorTradingAccountOut
{
    public byte Version;
    public TConnectorAccountIdentifier AccountID;
    [MarshalAs(UnmanagedType.LPWStr)]
    public string BrokerName;
    public int BrokerNameLength;
    [MarshalAs(UnmanagedType.LPWStr)]
    public string OwnerName;
    public int OwnerNameLength;
    [MarshalAs(UnmanagedType.LPWStr)]
    public string SubOwnerName;
    public int SubOwnerNameLength;
    public int AccountFlags;
    public byte AccountType;
}

[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
public struct TConnectorTradingAccountPosition
{
    public byte Version;
    public TConnectorAccountIdentifier AccountID;
    public TConnectorAssetIdentifier AssetID;
    public long OpenQuantity;
    public double OpenAveragePrice;
    public byte OpenSide;
    public double DailyAverageSellPrice;
    public long DailySellQuantity;
    public double DailyAverageBuyPrice;
    public long DailyBuyQuantity;
    public long DailyQuantityD1;
    public long DailyQuantityD2;
    public long DailyQuantityD3;
    public long DailyQuantityBlocked;
    public long DailyQuantityPending;
    public long DailyQuantityAlloc;
    public long DailyQuantityProvision;
    public long DailyQuantity;
    public long DailyQuantityAvailable;

    // V1
    [MarshalAs(UnmanagedType.U1)] public TConnectorPositionType PositionType;

    // V2
    public long EventID;
}

[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
public struct TConnectorOrder
{
    public byte Version;
    public TConnectorOrderIdentifier OrderID;
    public TConnectorAccountIdentifier AccountID;
    public TConnectorAssetIdentifier AssetID;
    public long Quantity;
    public long TradedQuantity;
    public long LeavesQuantity;
    public double Price;
    public double StopPrice;
    public double AveragePrice;
    [MarshalAs(UnmanagedType.U1)]
    public TConnectorOrderSide OrderSide;
    [MarshalAs(UnmanagedType.U1)]
    public TConnectorOrderType OrderType;
    public byte OrderStatus;
    public byte ValidityType;
    public SystemTime Date;
    public SystemTime LastUpdate;
    public SystemTime CloseDate;
    public SystemTime ValidityDate;
    [MarshalAs(UnmanagedType.LPWStr)]
    public string TextMessage;

    public override string ToString() => $"{OrderID} | {AccountID} | {AssetID} | {Price} | {Quantity}";

    // V1
    public long EventID;
}

[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
public struct TConnectorOrderOut
{
    public byte Version;
    public TConnectorOrderIdentifier OrderID;
    public TConnectorAccountIdentifierOut AccountID;
    public TConnectorAssetIdentifierOut AssetID;
    public long Quantity;
    public long TradedQuantity;
    public long LeavesQuantity;
    public double Price;
    public double StopPrice;
    public double AveragePrice;
    [MarshalAs(UnmanagedType.U1)]
    public TConnectorOrderSide OrderSide;
    [MarshalAs(UnmanagedType.U1)]
    public TConnectorOrderType OrderType;
    public byte OrderStatus;
    public byte ValidityType;
    public SystemTime Date;
    public SystemTime LastUpdate;
    public SystemTime CloseDate;
    public SystemTime ValidityDate;
    [MarshalAs(UnmanagedType.LPWStr)]
    public string TextMessage;
    public int TextMessageLength;

    // V1
    public long EventID;
}

[StructLayout(LayoutKind.Sequential)]
public struct SystemTime
{
    public ushort Year;
    public ushort Month;
    public ushort DayOfWeek;
    public ushort Day;
    public ushort Hour;
    public ushort Minute;
    public ushort Second;
    public ushort Milliseconds;

    public static SystemTime FromDateTime(DateTime date)
    {
        return new SystemTime()
        {
            Year = (ushort)date.Year,
            Month = (ushort)date.Month,
            DayOfWeek = (ushort)date.DayOfWeek,
            Day = (ushort)date.Day,
            Minute = (ushort)date.Minute,
            Hour = (ushort)date.Hour,
            Second = (ushort)date.Second,
            Milliseconds = (ushort)date.Millisecond
        };
    }

    public static DateTime ToDateTime(SystemTime date)
    {
        return new DateTime(date.Year, date.Month, date.Day, date.Hour, date.Minute, date.Second, date.Milliseconds);
    }

    public override string ToString() => ToDateTime(this).ToString();
}

[StructLayout(LayoutKind.Sequential)]
public struct TConnectorTrade
{
    public byte Version;
    public SystemTime TradeDate;
    public uint TradeNumber;
    public double Price;
    public long Quantity;
    public double Volume;
    public int BuyAgent;
    public int SellAgent;
    public byte TradeType;

    public override string ToString() => $"{TradeDate} | {Price} | {Quantity}";
}


[StructLayout(LayoutKind.Sequential)]
public struct TConnectorPriceGroup
{
    public byte Version;

    public double Price;
    public uint Count;
    public long Quantity;

    public uint PriceGroupFlags;
}


[UnmanagedFunctionPointer(CallingConvention.StdCall)]
[return: MarshalAs(UnmanagedType.Bool)]
public delegate bool TConnectorEnumerateOrdersProc([In] in TConnectorOrder a_Order, nint a_Param);

[UnmanagedFunctionPointer(CallingConvention.StdCall)]
[return: MarshalAs(UnmanagedType.Bool)]
public delegate bool TConnectorEnumerateAssetProc([In] in TConnectorAssetIdentifier a_Asset, nint a_Param);