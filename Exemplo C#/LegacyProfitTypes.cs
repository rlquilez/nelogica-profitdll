using System;
using System.Runtime.InteropServices;

namespace ProfitDLLClient;

[StructLayout(LayoutKind.Sequential, Pack = 1)]
public unsafe struct TConnectorBufferOffer
{
    public double Price;
    public long Qty;
    public int Agent;
    public long OfferID;
    public ushort DateStringLength;
    public fixed byte DateString[23];
}

public class TConnectorOffer(double price, long qty, int agent, long offerId, DateTime date)
{
    public double Price { get; set; } = price;
    public long Qty { get; set; } = qty;
    public int Agent { get; set; } = agent;
    public long OfferID { get; set; } = offerId;
    public DateTime Date { get; set; } = date;

    public override string ToString() => $"Price={Price} Quantity={Qty}";
}

public struct TGroupPrice(double price, int count, int qty)
{
    public int Qty { get; set; } = qty;
    public int Count { get; set; } = count;
    public double Price { get; set; } = price;
}

[StructLayout(LayoutKind.Sequential)]
public struct TAssetID
{
    [MarshalAs(UnmanagedType.LPWStr)]
    public string Ticker;
    [MarshalAs(UnmanagedType.LPWStr)]
    public string Exchange;
    public int Feed;

    public override readonly string ToString() => $"{Ticker}:{Exchange}";
}