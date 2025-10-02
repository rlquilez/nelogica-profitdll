from ctypes import POINTER, WinDLL, c_double, c_int, c_int64, c_long, c_longlong, c_size_t, c_ubyte, c_wchar_p
from profitTypes import *

def initializeDll(path: str) -> WinDLL:
    profit_dll = WinDLL(path)

    profit_dll.SendSellOrder.restype = c_longlong
    profit_dll.SendBuyOrder.restype = c_longlong
    profit_dll.SendZeroPosition.restype = c_longlong
    profit_dll.GetAgentNameByID.restype = c_wchar_p
    profit_dll.GetAgentShortNameByID.restype = c_wchar_p
    profit_dll.GetPosition.restype = POINTER(c_int)
    profit_dll.SendMarketSellOrder.restype = c_int64
    profit_dll.SendMarketBuyOrder.restype = c_int64

    profit_dll.SendStopSellOrder.argtypes = [c_wchar_p, c_wchar_p, c_wchar_p, c_wchar_p, c_wchar_p, c_double, c_double, c_int]
    profit_dll.SendStopSellOrder.restype = c_longlong

    profit_dll.SendStopBuyOrder.argtypes = [c_wchar_p, c_wchar_p, c_wchar_p, c_wchar_p, c_wchar_p, c_double, c_double, c_int]
    profit_dll.SendStopBuyOrder.restype = c_longlong

    profit_dll.SendOrder.argtypes = [POINTER(TConnectorSendOrder)]
    profit_dll.SendOrder.restype = c_int64

    profit_dll.SendChangeOrderV2.argtypes = [POINTER(TConnectorChangeOrder)]
    profit_dll.SendChangeOrderV2.restype = c_int

    profit_dll.SendCancelOrderV2.argtypes = [POINTER(TConnectorCancelOrder)]
    profit_dll.SendCancelOrderV2.restype = c_int

    profit_dll.SendCancelOrdersV2.argtypes = [POINTER(TConnectorCancelOrders)]
    profit_dll.SendCancelOrdersV2.restype = c_int

    profit_dll.SendCancelAllOrdersV2.argtypes = [POINTER(TConnectorCancelAllOrders)]
    profit_dll.SendCancelAllOrdersV2.restype = c_int

    profit_dll.SendZeroPositionV2.argtypes = [POINTER(TConnectorZeroPosition)]
    profit_dll.SendZeroPositionV2.restype = c_int64

    profit_dll.GetAccountCount.argtypes = []
    profit_dll.GetAccountCount.restype = c_int

    profit_dll.GetAccounts.argtypes = [c_int, c_int, c_int, POINTER(TConnectorAccountIdentifierOut)]
    profit_dll.GetAccounts.restype = c_int

    profit_dll.GetAccountDetails.argtypes = [POINTER(TConnectorTradingAccountOut)]
    profit_dll.GetAccountDetails.restype = c_int

    profit_dll.GetSubAccountCount.argtypes = [POINTER(TConnectorAccountIdentifier)]
    profit_dll.GetSubAccountCount.restype = c_int

    profit_dll.GetSubAccounts.argtypes = [POINTER(TConnectorAccountIdentifier), c_int, c_int, c_int, POINTER(TConnectorAccountIdentifierOut)]
    profit_dll.GetSubAccounts.restype = c_int

    profit_dll.GetPositionV2.argtypes = [POINTER(TConnectorTradingAccountPosition)]
    profit_dll.GetPositionV2.restype = c_int

    profit_dll.GetOrderDetails.argtypes = [POINTER(TConnectorOrderOut)]
    profit_dll.GetOrderDetails.restype = c_int

    profit_dll.HasOrdersInInterval.argtypes = [POINTER(TConnectorAccountIdentifier), SystemTime, SystemTime]
    profit_dll.HasOrdersInInterval.restype = c_int

    profit_dll.EnumerateOrdersByInterval.argtypes = [POINTER(TConnectorAccountIdentifier), c_ubyte, SystemTime, SystemTime, c_long, TConnectorEnumerateOrdersProc]
    profit_dll.EnumerateOrdersByInterval.restype = c_int

    profit_dll.EnumerateAllOrders.argtypes = [POINTER(TConnectorAccountIdentifier), c_ubyte, c_long, TConnectorEnumerateOrdersProc]
    profit_dll.EnumerateAllOrders.restype = c_int

    profit_dll.TranslateTrade.argtypes = [c_size_t, POINTER(TConnectorTrade)]
    profit_dll.TranslateTrade.restype = c_int


    profit_dll.SubscribePriceDepth.argtypes = [POINTER(TConnectorAssetIdentifier)]
    profit_dll.SubscribePriceDepth.restype = c_int

    profit_dll.UnsubscribePriceDepth.argtypes = [POINTER(TConnectorAssetIdentifier)]
    profit_dll.UnsubscribePriceDepth.restype = c_int

    profit_dll.GetPriceDepthSideCount.argtypes = [POINTER(TConnectorAssetIdentifier), c_ubyte]
    profit_dll.GetPriceDepthSideCount.restype = c_int

    profit_dll.GetPriceGroup.argtypes = [POINTER(TConnectorAssetIdentifier), c_ubyte, c_int, POINTER(TConnectorPriceGroup)]
    profit_dll.GetPriceGroup.restype = c_int

    profit_dll.GetTheoreticalValues.argtypes = [POINTER(TConnectorAssetIdentifier), POINTER(c_double), POINTER(c_int64)]
    profit_dll.GetTheoreticalValues.restype = c_int

    profit_dll.GetAccountCountByBroker.argtypes = [c_int]
    profit_dll.GetAccountCountByBroker.restype = c_int

    profit_dll.GetAccountsByBroker.argtypes = [c_int, c_int, c_int, c_int, POINTER(TConnectorAccountIdentifierOut)]
    profit_dll.GetAccountsByBroker.restype = c_int

    profit_dll.GetAgentNameLength.argtypes = [c_int, c_int]
    profit_dll.GetAgentNameLength.restype = c_int

    profit_dll.GetAgentName.argtypes = [c_int, c_int, c_wchar_p, c_int]
    profit_dll.GetAgentName.restype = c_int

    profit_dll.EnumerateAllPositionAssets.argtypes = [POINTER(TConnectorAccountIdentifier), c_ubyte, c_long, TConnectorEnumerateAssetProc]
    profit_dll.EnumerateAllPositionAssets.restype = c_int

    return profit_dll