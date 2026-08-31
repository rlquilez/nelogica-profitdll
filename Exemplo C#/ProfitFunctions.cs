using System;
using System.Runtime.InteropServices;
using System.Text;

namespace ProfitDLLClient;

public static class ProfitDLL
{
    private const string DLLPath = "ProfitDLL.dll";

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int DLLInitializeMarketLogin(
        [MarshalAs(UnmanagedType.LPWStr)] string activationKey,
        [MarshalAs(UnmanagedType.LPWStr)] string user,
        [MarshalAs(UnmanagedType.LPWStr)] string password,
        TStateCallback stateCallback,
        TTradeCallback newTradeCallback,
        TNewDailyCallback newDailyCallback,
        TPriceBookCallback priceBookCallback,
        TOfferBookCallback offerBookCallback,
        THistoryTradeCallback newHistoryCallback,
        TProgressCallBack progressCallBack,
        TNewTinyBookCallBack newTinyBookCallBack
    );

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int DLLInitializeLogin(
        [MarshalAs(UnmanagedType.LPWStr)] string activationKey,
        [MarshalAs(UnmanagedType.LPWStr)] string user,
        [MarshalAs(UnmanagedType.LPWStr)] string password,
        TStateCallback stateCallback,
        THistoryCallBack historyCallBack,
        TOrderChangeCallBack orderChangeCallBack,
        TAccountCallback accountCallback,
        TTradeCallback newTradeCallback,
        TNewDailyCallback newDailyCallback,
        TPriceBookCallback priceBookCallback,
        TOfferBookCallback offerBookCallback,
        THistoryTradeCallback newHistoryCallback,
        TProgressCallBack progressCallBack,
        TNewTinyBookCallBack newTinyBookCallBack);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetServerAndPort(
        [MarshalAs(UnmanagedType.LPWStr)] string strServer,
        [MarshalAs(UnmanagedType.LPWStr)] string strPort);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetServerClock(
        out double serverClock,
        out int nYear, out int nMonth, out int nDay, out int nHour, out int nMin, out int nSec, out int nMilisec);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetLastDailyClose(
        [MarshalAs(UnmanagedType.LPWStr)] string strTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string strBolsa,
        ref double dClose,
        int bAdjusted);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern IntPtr GetPosition(
        [MarshalAs(UnmanagedType.LPWStr)] string accountID,
        [MarshalAs(UnmanagedType.LPWStr)] string corretora,
        [MarshalAs(UnmanagedType.LPWStr)] string ticker,
        [MarshalAs(UnmanagedType.LPWStr)] string bolsa);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetChangeCotationCallback(TChangeCotation a_ChangeCotation);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetAssetListCallback(TAssetListCallback AssetListCallback);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetOfferBookCallbackV2(TOfferBookCallbackV2 OfferBookCallbackV2);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetAssetListInfoCallback(TAssetListInfoCallback AssetListInfoCallback);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetAssetListInfoCallbackV2(TAssetListInfoCallbackV2 AssetListInfoCallbackV2);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetInvalidTickerCallback(TInvalidTickerCallback InvalidTickerCallback);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetChangeStateTickerCallback(TChangeStateTickerCallback a_changeStateTickerCallback);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetTheoreticalPriceCallback(TTheoreticalPriceCallback a_theoreticalPriceCallback);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetAdjustHistoryCallbackV2(TAdjustHistoryCallbackV2 AdjustHistoryCallbackV2);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetAssetPositionListCallback(TConnectorAssetPositionListCallback AssetPositionListCallback);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetOrderChangeCallbackV2(TOrderChangeCallBackV2 OrderChangeCallbackV2);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetOrderCallback(TConnectorOrderCallback orderCallback);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetOrderHistoryCallback(TConnectorAccountCallback orderHistoryCallback);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetTradeCallbackV2(TConnectorTradeCallback a_TradeCallbackV2);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetHistoryTradeCallbackV2(TConnectorTradeCallback a_HistoryTradeCallbackV2);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetPriceDepthCallback(TConnectorPriceDepthCallback a_PriceDepthCallback);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetBrokerAccountListChangedCallback(TConnectorBrokerAccountListCallback a_BrokerAccountListCallback);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetBrokerSubAccountListChangedCallback(TConnectorBrokerSubAccountListCallback a_BrokerSubAccountListCallback);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetTradingMessageResultCallback(TConnectorTradingMessageResultCallback a_ResultCallback);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetEnabledLogToDebug(int bEnabled);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SubscribeTicker(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int UnsubscribeTicker(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SubscribePriceBook(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int UnsubscribePriceBook(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SubscribeOfferBook(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int UnsubscribeOfferBook(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SubscribeAdjustHistory(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetHistoryTrades(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa,
        [MarshalAs(UnmanagedType.LPWStr)] string dtDateStart,
        [MarshalAs(UnmanagedType.LPWStr)] string dtDateEnd);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int FreePointer(IntPtr pointer, int nSize);


    ////////////////////////////////////////////////////////////////////////////////
    // Roteamento
    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern Int64 SendStopBuyOrder(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDAccount,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDCorretora,
        [MarshalAs(UnmanagedType.LPWStr)] string sSenha,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa,
        double sPrice, double sStopPrice, int nAmount);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern Int64 SendStopSellOrder(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDAccount,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDCorretora,
        [MarshalAs(UnmanagedType.LPWStr)] string sSenha,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa,
        double sPrice, double sStopPrice, int nAmount);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SendChangeOrder(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDAccount,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDCorretora,
        [MarshalAs(UnmanagedType.LPWStr)] string sSenha,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcClOrdID,
        double sPrice, int nAmount);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SendCancelOrder(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDAccount,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDCorretora,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcClOrdID,
        [MarshalAs(UnmanagedType.LPWStr)] string sSenha);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SendCancelAllOrders(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDAccount,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDCorretora,
        [MarshalAs(UnmanagedType.LPWStr)] string sSenha);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SendCancelOrders(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDAccount,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDCorretora,
        [MarshalAs(UnmanagedType.LPWStr)] string sSenha,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern Int64 SendZeroPosition(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDAccount,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDCorretora,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa,
        [MarshalAs(UnmanagedType.LPWStr)] string sSenha,
        double sPrice);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern long SendBuyOrder(
        [MarshalAs(UnmanagedType.LPWStr)] string IDAccount,
        [MarshalAs(UnmanagedType.LPWStr)] string IDCorretora,
        [MarshalAs(UnmanagedType.LPWStr)] string Senha,
        [MarshalAs(UnmanagedType.LPWStr)] string Ticker,
        [MarshalAs(UnmanagedType.LPWStr)] string Bolsa,
        double sPrice, int nAmount);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern long SendSellOrder(
        [MarshalAs(UnmanagedType.LPWStr)] string IDAccount,
        [MarshalAs(UnmanagedType.LPWStr)] string IDCorretora,
        [MarshalAs(UnmanagedType.LPWStr)] string Senha,
        [MarshalAs(UnmanagedType.LPWStr)] string Ticker,
        [MarshalAs(UnmanagedType.LPWStr)] string Bolsa,
        double sPrice, int nAmount);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetOrder([MarshalAs(UnmanagedType.LPWStr)] string clOrdId);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern long SendOrder(ref TConnectorSendOrder sendOrder);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SendChangeOrderV2(in TConnectorChangeOrder changeOrder);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SendCancelOrderV2(in TConnectorCancelOrder cancelOrder);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SendCancelOrdersV2(in TConnectorCancelOrders cancelOrders);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SendCancelAllOrdersV2(in TConnectorCancelAllOrders cancelAllOrders);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern long SendZeroPositionV2(ref TConnectorZeroPosition zeroPosition);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetAccountCount();

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetAccounts(int startSource, int startDest, int count, [Out][MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 2)] TConnectorAccountIdentifierOut[] accounts);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetAccountDetails(ref TConnectorTradingAccountOut account);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetSubAccountCount(in TConnectorAccountIdentifier masterAccountID);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetSubAccounts(in TConnectorAccountIdentifier masterAccountID, int startSource, int startDest, int count, [Out][MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 3)] TConnectorAccountIdentifierOut[] accounts);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetPositionV2(ref TConnectorTradingAccountPosition position);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetOrderDetails(ref TConnectorOrderOut order);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int HasOrdersInInterval(in TConnectorAccountIdentifier a_AccountID, SystemTime a_dtStart, SystemTime a_dtEnd);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int EnumerateOrdersByInterval(in TConnectorAccountIdentifier a_AccountID, byte a_OrderVersion, SystemTime a_dtStart, SystemTime a_dtEnd, IntPtr a_Param, TConnectorEnumerateOrdersProc a_Callback);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int EnumerateAllOrders(in TConnectorAccountIdentifier a_AccountID, byte a_OrderVersion, IntPtr a_Param, TConnectorEnumerateOrdersProc a_Callback);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int TranslateTrade(nint a_pTrade, ref TConnectorTrade a_Trade);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetAccountCountByBroker(int a_AgentID);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetAccountsByBroker(int a_BrokerID, int a_startSource, int a_startDest, int a_count, [Out][MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 2)] TConnectorAccountIdentifierOut[] accounts);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetAgentNameLength(int a_AgentID, AgentNameFlags a_nShortName);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetAgentName(int a_AgentLen, int a_AgentID, [MarshalAs(UnmanagedType.LPWStr)] StringBuilder AgentName, AgentNameFlags a_nShortName);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int EnumerateAllPositionAssets(in TConnectorAccountIdentifier a_AccountID, byte a_OrderVersion, nint a_Param, TConnectorEnumerateAssetProc a_Callback);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int SubscribePriceDepth(in TConnectorAssetIdentifier assetID);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int UnsubscribePriceDepth(in TConnectorAssetIdentifier assetID);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetTheoreticalValues(in TConnectorAssetIdentifier assetID, out double price, out long quantity);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetPriceDepthSideCount(in TConnectorAssetIdentifier assetID, byte side);

    [DllImport(DLLPath, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetPriceGroup(in TConnectorAssetIdentifier assetID, byte side, int position, ref TConnectorPriceGroup priceGroup);
}