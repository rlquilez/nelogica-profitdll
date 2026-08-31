using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Runtime.InteropServices;
using System.Text;

namespace ProfitDLLClient;

public partial class DLLConnector
{
    public static void AssetListInfoCallbackV2(TAssetID assetId, [MarshalAs(UnmanagedType.LPWStr)] string strName, [MarshalAs(UnmanagedType.LPWStr)] string strDescription, long nMinOrderQtd, long nMaxOrderQtd, long nLote, int stSecurityType, int ssSecuritySubType, double sMinPriceInc, double sContractMultiplier,
        [MarshalAs(UnmanagedType.LPWStr)] string validityDate, [MarshalAs(UnmanagedType.LPWStr)] string strISIN, [MarshalAs(UnmanagedType.LPWStr)] string strSetor, [MarshalAs(UnmanagedType.LPWStr)] string strSubSetor, [MarshalAs(UnmanagedType.LPWStr)] string strSegmento)
    {
        WriteResultSync($"{assetId.Ticker} : {strName} - {strDescription} : ISIN: {strISIN} - Setor: {strSetor}");
    }

    public static void ChangeStateTickerCallback(TAssetID assetId, [MarshalAs(UnmanagedType.LPWStr)] string strDate, int nState)
    {
        WriteResultSync("ticker=" + assetId.Ticker + " Date=" + strDate + " nState=" + nState);
    }

    public static void ChangeCotationCallback(TAssetID assetId, [MarshalAs(UnmanagedType.LPWStr)] string date, uint tradeNumber, double sPrice)
    {
        WriteResultSync(assetId.Ticker + " : " + date + " : " + sPrice);
    }
    public static void AccountCallback(int nCorretora, [MarshalAs(UnmanagedType.LPWStr)] string CorretoraNomeCompleto, [MarshalAs(UnmanagedType.LPWStr)] string AccountID, [MarshalAs(UnmanagedType.LPWStr)] string NomeTitular)
    {
        WriteResultSync($"{AccountID} - {NomeTitular}");
    }

    private static (int offerQuantity, int pointerSize, OfferBookFlags bookFlags) GetOfferBookFieldsFromBuffer(nint buffer)
    {
        var offerQuantity = Marshal.ReadInt32(buffer, 0);
        var pointerSize = Marshal.ReadInt32(buffer, 4);

        var flags = (OfferBookFlags)Marshal.ReadInt32(buffer, 8 + 53 * offerQuantity);

        return (offerQuantity, pointerSize, flags);
    }

    private static IEnumerable<TConnectorOffer> DecodeOfferBufferStream(nint buffer)
    {
        var offerQuantity = Marshal.ReadInt32(buffer, 0);
        var pointerSize = Marshal.ReadInt32(buffer, 4);

        Stream stream;
        unsafe
        {
            stream = new UnmanagedMemoryStream((byte*)(buffer + 8), pointerSize);
        }

        using var reader = new BinaryReader(stream, Encoding.ASCII, false);

        // lê as ofertas
        for (int i = 0; i < offerQuantity; i++)
        {
            var offer = new TConnectorOffer(
                /*Price*/ reader.ReadDouble(),
                /*Quantity*/ reader.ReadInt64(),
                /*Agent*/ reader.ReadInt32(),
                /*OfferID*/ reader.ReadInt64(),
                /*Date*/ ReadDateFromString2(reader)
            );

            yield return offer;
        }
    }

    private static IEnumerable<TConnectorOffer> DecodeOfferBufferCast(nint buffer)
    {
        // This technique is also valid, and uses the modern Span<> to cast the buffer into an array of TConnectorBufferOffer
        // but, because of the unsafe context, it can't be an iterator method

        var pointerSize = Marshal.ReadInt32(buffer, 4);

        var retVal = new List<TConnectorOffer>();

        unsafe
        {
            var bytes = new Span<byte>((void*)(buffer + 8), pointerSize - 12);
            var span = MemoryMarshal.Cast<byte, TConnectorBufferOffer>(bytes);

            foreach (var item in span)
            {
                var raw = Encoding.ASCII.GetString(new ReadOnlySpan<byte>(item.DateString, item.DateStringLength));
                var date = DateTime.ParseExact(raw, ConnectorDateFormat, null);

                retVal.Add(
                    new TConnectorOffer(item.Price, item.Qty, item.Agent, item.OfferID, date)
                );
            }
        }

        return retVal;
    }

    public static void OfferBookCallbackV2(
        TAssetID assetId,
        int nAction,
        int nPosition,
        int Side,
        long nQtd,
        int nAgent,
        long nOfferID,
        double sPrice,
        ushort hasPrice,
        ushort hasQtd,
        ushort hasDate,
        ushort hasOfferID,
        ushort hasAgent,
        [MarshalAs(UnmanagedType.LPWStr)] string dateString,
        nint pArraySell,
        nint pArrayBuy
    )
    {
        var side = (TConnectorBookSideType)Side;

        var bookList = (side == TConnectorBookSideType.Buy) ? buyOfferList : sellOfferList;

        switch ((TConnectorBookActionType)nAction)
        {
            case TConnectorBookActionType.Add:
                {
                    var offer = BuildOffer(nQtd, nAgent, nOfferID, sPrice, dateString);

                    if (nPosition >= 0 && nPosition < bookList.Count)
                    {
                        WriteResultSync($"{assetId} - {side} | Inserted Offer | Index={bookList.Count - nPosition} | {offer}");
                        bookList.Insert(bookList.Count - nPosition, offer);
                    }
                }
                break;
            case TConnectorBookActionType.Edit:
                {
                    if (nPosition >= 0 && nPosition < bookList.Count)
                    {
                        var offerDiff = BuildOffer(nQtd, nAgent, nOfferID, sPrice, dateString);
                        var currentOffer = bookList[bookList.Count - 1 - nPosition];

                        if (hasQtd != 0) { currentOffer.Qty += offerDiff.Qty; }
                        if (hasPrice != 0) { currentOffer.Price = offerDiff.Price; }
                        if (hasOfferID != 0) { currentOffer.OfferID = offerDiff.OfferID; }
                        if (hasAgent != 0) { currentOffer.Agent = offerDiff.Agent; }
                        if (hasDate != 0) { currentOffer.Date = offerDiff.Date; }

                        WriteResultSync($"{assetId} - {side} | Edited Offer | Index={bookList.Count - 1 - nPosition} | {currentOffer}");
                    }
                }
                break;
            case TConnectorBookActionType.Delete:
                {
                    if (nPosition >= 0 && nPosition < bookList.Count)
                    {
                        WriteResultSync($"{assetId} - {side} | Removed Offer | Index={bookList.Count - nPosition - 1} | {bookList[bookList.Count - nPosition - 1]}");
                        bookList.RemoveAt(bookList.Count - nPosition - 1);
                    }
                }
                break;
            case TConnectorBookActionType.DeleteFrom:
                {
                    if (nPosition >= 0 && nPosition < bookList.Count)
                    {
                        WriteResultSync($"{assetId} - {side} | Removed Offers | From={bookList.Count - nPosition - 1} Count={bookList.Count - nPosition}");
                        bookList.RemoveRange(bookList.Count - nPosition - 1, nPosition + 1);
                    }
                }
                break;
            case TConnectorBookActionType.FullBook:
                {
                    if (pArraySell != nint.Zero)
                    {
                        DoFullBook(assetId, TConnectorBookSideType.Sell, pArraySell);
                    }

                    if (pArrayBuy != nint.Zero)
                    {
                        DoFullBook(assetId, TConnectorBookSideType.Buy, pArrayBuy);
                    }
                }
                break;
            default:
                break;
        }

        static TConnectorOffer BuildOffer(long qty, int agentId, long offerId, double price, string dateString)
        {
            if (!DateTime.TryParseExact(dateString, ConnectorDateFormat, null, DateTimeStyles.None, out var date))
            {
                date = DateTime.MinValue;
            }

            var offer = new TConnectorOffer(price, qty, agentId, offerId, date);
            return offer;
        }
    }

    private static void DoFullBook(TAssetID assetId, TConnectorBookSideType side, nint buffer)
    {
        var bookList = (side == TConnectorBookSideType.Buy) ? buyOfferList : sellOfferList;

        var (offerQuantity, pointerSize, flags) = GetOfferBookFieldsFromBuffer(buffer);

        if (flags.HasFlag(OfferBookFlags.OB_FIRST_PACKET))
        {
            bookList.Clear();
        }

        var decoded = DecodeOfferBufferCast(buffer);
        bookList.AddRange(decoded);

        ProfitDLL.FreePointer(buffer, pointerSize);

        WriteResultSync($"Full {assetId} - {side} Offers | Quantity={offerQuantity} Flags={flags}", nameof(OfferBookCallbackV2));
    }

    public static void NewDailyCallback(TAssetID assetId, [MarshalAs(UnmanagedType.LPWStr)] string date, double sOpen, double sHigh, double sLow, double sClose, double sVol, double sAjuste, double sMaxLimit, double sMinLimit, double sVolBuyer, double sVolSeller, int nQtd, int nNegocios, int nContratosOpen, int nQtdBuyer, int nQtdSeller, int nNegBuyer, int nNegSeller)
    {
        WriteResultSync($"{assetId.Ticker}: {date} {sOpen} {sHigh} {sLow} {sClose}");
    }

    public static void ProgressCallBack(TAssetID assetId, int nProgress)
    {
        WriteResultSync($"{assetId} - {nProgress}");
    }

    public static void NewTinyBookCallBack(TAssetID assetId, double price, int qtd, int side)
    {
        var sideName = side == 0 ? "buy" : "sell";
        WriteResultSync($"{assetId.Ticker}: {sideName} {price} {qtd}");
    }

    public static void TheoreticalPriceCallback(TAssetID assetId, double dTheoreticalPrice, long nTheoreticalQtd)
    {
        WriteResultSync($"{assetId.Ticker}: {dTheoreticalPrice}");
    }

    public static void AdjustHistoryCallbackV2(TAssetID assetId, double dValue, [MarshalAs(UnmanagedType.LPWStr)] string adjustType, [MarshalAs(UnmanagedType.LPWStr)] string strObserv, [MarshalAs(UnmanagedType.LPWStr)] string dtAjuste, [MarshalAs(UnmanagedType.LPWStr)] string dtDeliber, [MarshalAs(UnmanagedType.LPWStr)] string dtPagamento, int nFlags, double dMult)
    {
        WriteResultSync($"{assetId.Ticker}: Value={dValue} Type={adjustType}");
    }

    public static void StateCallback(int nConnStateType, int result)
    {
        switch (nConnStateType)
        {
            case 0:
                switch (result)
                {
                    case 0:
                        WriteLineSync("Login: Connected");
                        break;
                    case 1:
                        WriteLineSync("Login: Invalid");
                        break;
                    case 2:
                        WriteLineSync("Login: Invalid password");
                        break;
                    case 3:
                        WriteLineSync("Login: Blocked password");
                        break;
                    case 4:
                        WriteLineSync("Login: Expired password");
                        break;
                    default:
                        WriteLineSync("Login: Unknown Error");
                        break;
                }
                break;
            case 1:
                switch (result)
                {
                    case 0:
                        WriteLineSync("Broker: Disconnected");
                        break;
                    case 1:
                        WriteLineSync("Broker: Connecting");
                        break;
                    case 2:
                        WriteLineSync("Broker: Connected");
                        break;
                    case 3:
                        WriteLineSync("Broker: HCS Disconnected");
                        break;
                    case 4:
                        WriteLineSync("Broker: HCS Connecting");
                        break;
                    case 5:
                        WriteLineSync("Broker: HCS Connected");
                        break;
                    default:
                        break;
                }
                break;
            case 2:
                switch (result)
                {
                    case 0:
                        WriteLineSync("Market: Disconnected");
                        break;
                    case 1:
                        WriteLineSync("Market: Connecting");
                        break;
                    case 2:
                        WriteLineSync("Market: Connected Waiting");
                        break;
                    case 3:
                        WriteLineSync("Market: not logged");
                        break;
                    case 4:
                        WriteLineSync("Market: Connected");
                        break;
                    case 5:
                        WriteLineSync("Market: Performance Warning");
                        break;
                    case 6:
                        WriteLineSync("Market: Partial Connected (feed dispatch stalled)");
                        break;
                    default:
                        WriteLineSync($"Market: Unknown result={result}");
                        break;
                }
                break;
            case 3:
                switch (result)
                {
                    case 0:
                        WriteLineSync("Profit: Active");
                        break;
                    default:
                        WriteLineSync("Profit: Invalid");
                        break;
                }
                break;
            default:
                break;
        }
    }
}