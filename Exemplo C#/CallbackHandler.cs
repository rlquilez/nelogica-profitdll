using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace ProfitDLLClient;

public partial class DLLConnector
{
    // TODO

    private const uint PG_IS_THEORIC = 1;

    public static void PriceDepthCallback(TConnectorAssetIdentifier assetID, byte side, int position, byte updateType)
    {
        switch ((TConnectorUpdateType)updateType)
        {
            case TConnectorUpdateType.Add:
                // Can be ignored in this example
                break;

            case TConnectorUpdateType.Edit:
            case TConnectorUpdateType.Insert:
                {
                    var priceGroup = new TConnectorPriceGroup { Version = 0 };
                    if (ProfitDLL.GetPriceGroup(assetID, side, position, ref priceGroup) == NL_OK)
                    {
                        if ((priceGroup.PriceGroupFlags & PG_IS_THEORIC) == PG_IS_THEORIC)
                        {
                            if (ProfitDLL.GetTheoreticalValues(assetID, out var theoricPrice, out _) == NL_OK)
                            {
                                priceGroup.Price = theoricPrice;
                            }
                        }

                        WriteSync($"PriceDepthCallback: {assetID} | {(TConnectorBookSideType)side} : {(TConnectorUpdateType)updateType} | {priceGroup.Price:N} : {priceGroup.Count} : {priceGroup.Quantity}");
                    }

                    break;
                }

            case TConnectorUpdateType.Delete:
                {
                    WriteSync($"PriceDepthCallback: {assetID} | {(TConnectorBookSideType)side} : Delete | Position={position}");
                    break;
                }

            case TConnectorUpdateType.FullBook:
                {
                    int countBuy = ProfitDLL.GetPriceDepthSideCount(assetID, (byte)TConnectorBookSideType.Buy);
                    if (countBuy >= 0)
                    {
                        WriteSync($"PriceDepthCallback: {assetID} | Buy : FullBook | Count={countBuy}");
                    }

                    int countSell = ProfitDLL.GetPriceDepthSideCount(assetID, (byte)TConnectorBookSideType.Sell);
                    if (countSell >= 0)
                    {
                        WriteSync($"PriceDepthCallback: {assetID} | Sell : FullBook | Count={countSell}");
                    }

                    break;
                }

            case TConnectorUpdateType.TheoricPrice:
                // Can be ignored in this example
                break;

            case TConnectorUpdateType.DeleteFrom:
                {
                    WriteSync($"PriceDepthCallback: {assetID} | {(TConnectorBookSideType)side} : DeleteFrom | Position={position}");
                    break;
                }

            default:
                // Ignore utPrepare and utFlush
                break;
        }
    }
}