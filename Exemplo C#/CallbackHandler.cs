using System.Runtime.InteropServices;

namespace ProfitDLLClient;

public partial class DLLConnector
{
    private const uint PG_IS_THEORIC = 1;

    public static void PriceDepthCallback(TConnectorAssetIdentifier assetID, byte side, int position, byte updateType)
    {
        switch ((TConnectorUpdateType)updateType)
        {
            case TConnectorUpdateType.Add:
                // Can be ignored
                break;

            case TConnectorUpdateType.Edit:
            case TConnectorUpdateType.Insert:
                {
                    var priceGroup = new TConnectorPriceGroup { Version = 0 };
                    if ((NResult)ProfitDLL.GetPriceGroup(assetID, side, position, ref priceGroup) == NResult.NL_OK)
                    {
                        if ((priceGroup.PriceGroupFlags & PG_IS_THEORIC) == PG_IS_THEORIC)
                        {
                            if ((NResult)ProfitDLL.GetTheoreticalValues(assetID, out var theoricPrice, out _) == NResult.NL_OK)
                            {
                                priceGroup.Price = theoricPrice;
                            }
                        }

                        WriteResultSync($"{assetID} | {(TConnectorBookSideType)side} : {(TConnectorUpdateType)updateType} | {priceGroup.Price:N} : {priceGroup.Count} : {priceGroup.Quantity}");
                    }

                    break;
                }

            case TConnectorUpdateType.Delete:
                {
                    WriteResultSync($"{assetID} | {(TConnectorBookSideType)side} : Delete | Position={position}");
                    break;
                }

            case TConnectorUpdateType.FullBook:
                {
                    int countBuy = ProfitDLL.GetPriceDepthSideCount(assetID, (byte)TConnectorBookSideType.Buy);
                    if (countBuy >= 0)
                    {
                        WriteResultSync($"{assetID} | Buy : FullBook | Count={countBuy}");
                    }

                    int countSell = ProfitDLL.GetPriceDepthSideCount(assetID, (byte)TConnectorBookSideType.Sell);
                    if (countSell >= 0)
                    {
                        WriteResultSync($"{assetID} | Sell : FullBook | Count={countSell}");
                    }

                    break;
                }

            case TConnectorUpdateType.TheoricPrice:
                // This example doesn't include TheoricPrice, so we are ignoring it here
                break;

            case TConnectorUpdateType.DeleteFrom:
                {
                    WriteResultSync($"{assetID} | {(TConnectorBookSideType)side} : DeleteFrom | Position={position}");
                    break;
                }

            default:
                // This example doesn't care about Prepare and Flush
                break;
        }
    }

    private static void TradingMessageResultCallback(in TConnectorTradingMessageResult a_pResult)
    {
        WriteResultSync($"{a_pResult.BrokerID} | {a_pResult.Message} | {a_pResult.MessageID} | {a_pResult.ResultCode} | {a_pResult.OrderID}");
    }

    public static void InvalidTickerCallback(TConnectorAssetIdentifier assetId)
    {
        WriteResultSync($"{assetId}");
    }

    public static void AssetPositionListCallback(TConnectorAccountIdentifier AccountID, TConnectorAssetIdentifier assetId, int EventID)
    {
        WriteResultSync($"{AccountID.AccountID} - {assetId.Ticker} - {EventID}");
    }

    public static void BrokerAccountListChangedCallback(int brokerId, [MarshalAs(UnmanagedType.Bool)] bool hasChanged)
    {
        var count = ProfitDLL.GetAccountCountByBroker(brokerId);

        if (count < 0)
        {
            WriteResultSync($"Broker={brokerId} Changed={hasChanged} | {nameof(ProfitDLL.GetAccountCountByBroker)}: Error={(NResult)count}");
        }
        else
        {
            WriteResultSync($"Broker={brokerId} Changed={hasChanged} | AccountCount={count}");
        }
    }

    public static void BrokerSubAccountListChangedCallback(TConnectorAccountIdentifier accountId)
    {
        var count = ProfitDLL.GetSubAccountCount(accountId);

        if (count < 0)
        {
            WriteResultSync($"Account={accountId} | {nameof(ProfitDLL.GetSubAccountCount)}: Error={(NResult)count}");
        }
        else
        {
            WriteResultSync($"Account={accountId} | SubAccountCount={count}");
        }
    }

    public static void OrderCallback(TConnectorOrderIdentifier orderId)
    {
        if (!GetOrder(orderId, out var order)) { return; }

        WriteResultSync($"{order.AssetID.Ticker} | {order.TradedQuantity} | {order.OrderSide} | {order.Price} | {order.AccountID} | {order.OrderID.ClOrderID} | {order.OrderSide} | {order.TextMessage}");
    }

    private static void OrderHistoryCallback(TConnectorAccountIdentifier accountId)
    {
        var count = 0;

        bool CountOrders(in TConnectorOrder a_Order, nint a_Param)
        {
            count++;

            return true;
        }

        var result = (NResult)ProfitDLL.EnumerateAllOrders(accountId, 0, 0, CountOrders);

        if (result != NResult.NL_OK) { WriteLineSync($"{nameof(ProfitDLL.EnumerateAllOrders)}: {result}"); }

        WriteResultSync($"Total orders: {count}");
    }

    public static void TradeCallback(TConnectorAssetIdentifier a_Asset, nint a_pTrade, TConnectorTradeCallbackFlags a_nFlags)
    {
        var trade = new TConnectorTrade() { Version = 0 };

        var result = (NResult)ProfitDLL.TranslateTrade(a_pTrade, ref trade);

        if (!EvalNResult(result, ProfitDLL.TranslateTrade)) { return; }

        WriteResultSync($"{a_Asset} | {trade} | {a_nFlags}");
    }

    public static void TradeHistoryCallback(TConnectorAssetIdentifier a_Asset, nint a_pTrade, TConnectorTradeCallbackFlags a_nFlags)
    {
        var trade = new TConnectorTrade() { Version = 0 };

        var result = (NResult)ProfitDLL.TranslateTrade(a_pTrade, ref trade);

        if (!EvalNResult(result, ProfitDLL.TranslateTrade)) { return; }

        WriteResultSync($"{a_Asset} | {trade} | {a_nFlags}");
    }
}