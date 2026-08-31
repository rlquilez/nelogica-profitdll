using System;
using System.Runtime.InteropServices;

namespace ProfitDLLClient;

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

    public override readonly string ToString()
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
    [MarshalAs(UnmanagedType.ByValArray, SizeConst = 100)]
    public char[] AccountID;
    public int AccountIDLength;
    [MarshalAs(UnmanagedType.ByValArray, SizeConst = 100)]
    public char[] SubAccountID;
    public int SubAccountIDLength;
    public long Reserved;

    public override readonly string ToString() => $"{BrokerID} | {new string(AccountID, 0, AccountIDLength)} | {new string(SubAccountID, 0, SubAccountIDLength)} ";
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

    public override readonly string ToString() => $"{Ticker}:{Exchange}";
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

    public override readonly string ToString() => $"{Ticker}:{Exchange}";
}

[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
public struct TConnectorOrderIdentifier
{
    public byte Version;
    public long LocalOrderID;
    [MarshalAs(UnmanagedType.LPWStr)]
    public string ClOrderID;

    public override readonly string ToString() => string.IsNullOrWhiteSpace(ClOrderID) ? LocalOrderID.ToString() : ClOrderID;
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

    // V1
    public long MessageID;
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

    // V1
    public long MessageID;
}

[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
public struct TConnectorCancelOrder
{
    public byte Version;
    public TConnectorAccountIdentifier AccountID;
    public TConnectorOrderIdentifier OrderID;
    [MarshalAs(UnmanagedType.LPWStr)]
    public string Password;

    // V1
    public long MessageID;
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

    // V2
    public long MessageID;
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

    public override readonly string ToString() => $"{OrderID} | {AccountID} | {AssetID} | {Price} | {Quantity}";

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

    public override readonly string ToString() => ToDateTime(this).ToString();
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
    public TradeType TradeType;

    public override readonly string ToString() => $"{TradeDate} | {Price} | {Quantity}";
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

[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
public struct TConnectorTradingMessageResult
{
    public byte Version;

    // V0
    public int BrokerID;
    public TConnectorOrderIdentifier OrderID;
    public long MessageID;
    public TConnectorTradingMessageResultCode ResultCode;
    [MarshalAs(UnmanagedType.LPWStr)] public string Message;
    public int MessageLength;
}


[UnmanagedFunctionPointer(CallingConvention.StdCall)]
[return: MarshalAs(UnmanagedType.Bool)]
public delegate bool TConnectorEnumerateOrdersProc(in TConnectorOrder a_Order, nint a_Param);

[UnmanagedFunctionPointer(CallingConvention.StdCall)]
[return: MarshalAs(UnmanagedType.Bool)]
public delegate bool TConnectorEnumerateAssetProc(in TConnectorAssetIdentifier a_Asset, nint a_Param);