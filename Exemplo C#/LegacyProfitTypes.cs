using System;
using System.Runtime.InteropServices;

namespace ProfitDLLClient;

#region Types
public struct TConnectorOffer(double price, long qtd, int agent, long offerId, DateTime date)
{
    public long Qtd { get; set; } = qtd;
    public long OfferID { get; set; } = offerId;
    public int Agent { get; set; } = agent;
    public double Price { get; set; } = price;
    public DateTime Date { get; set; } = date;
}

public struct TGroupPrice
{
    public int Qtd { get; set; }
    public int Count { get; set; }
    public double Price { get; set; }

    public TGroupPrice(double price, int count, int qtd)
    {
        this.Qtd = qtd;
        this.Price = price;
        this.Count = count;
    }
}
public struct TPosition
{
    public int CorretoraID;
    public string AccountID;
    public string Titular;
    public string Ticker;
    public int IntradayPosition;
    public double Price;
    public double AvgSellPrice;
    public int SellQtd;
    public double AvgBuyPrice;
    public int BuyQtd;
    public int CustodyD1;
    public int CustodyD2;
    public int CustodyD3;
    public int Blocked;
    public int Pending;
    public int Allocated;
    public int Provisioned;
    public int QtdPosition;
    public int Available;

    public override string ToString()
    {
        return $"Corretora: {CorretoraID}, AccountID: {AccountID}, Titular: {Titular}, Ticker: {Ticker}, IntradayPosition: {IntradayPosition}, Price: {Price}, AvgSellPrice: {AvgSellPrice}, AvgBuyPrice: {AvgBuyPrice}, BuyQtd: {BuyQtd}, SellQtd: {SellQtd}";
    }
}

[StructLayout(LayoutKind.Sequential)]
public struct TAssetID
{
    [MarshalAs(UnmanagedType.LPWStr)]
    public string Ticker;
    [MarshalAs(UnmanagedType.LPWStr)]
    public string Bolsa;
    public int Feed;
};
#endregion
