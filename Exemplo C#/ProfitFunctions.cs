using System;
using System.Runtime.InteropServices;
using System.Text;

namespace ProfitDLLClient;

public class ProfitDLL
{
    private const string dll_path = "ProfitDLL.dll";

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
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
        TNewTinyBookCallBack newTinyBookCallBack);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
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

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetServerAndPort(
        [MarshalAs(UnmanagedType.LPWStr)] string strServer,
        [MarshalAs(UnmanagedType.LPWStr)] string strPort);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetServerClock(
        ref double serverClock,
        ref int nYear, ref int nMonth, ref int nDay, ref int nHour, ref int nMin, ref int nSec, ref int nMilisec);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetLastDailyClose(
        [MarshalAs(UnmanagedType.LPWStr)] string strTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string strBolsa,
        ref double dClose,
        int bAdjusted);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern IntPtr GetPosition(
        [MarshalAs(UnmanagedType.LPWStr)] string accountID,
        [MarshalAs(UnmanagedType.LPWStr)] string corretora,
        [MarshalAs(UnmanagedType.LPWStr)] string ticker,
        [MarshalAs(UnmanagedType.LPWStr)] string bolsa);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetChangeCotationCallback(TChangeCotation a_ChangeCotation);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetAssetListCallback(TAssetListCallback AssetListCallback);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetOfferBookCallbackV2(TOfferBookCallback OfferBookCallbackV2);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetAssetListInfoCallback(TAssetListInfoCallback AssetListInfoCallback);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetAssetListInfoCallbackV2(TAssetListInfoCallbackV2 AssetListInfoCallbackV2);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetInvalidTickerCallback(TInvalidTickerCallback InvalidTickerCallback);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetChangeStateTickerCallback(TChangeStateTickerCallback a_changeStateTickerCallback);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetTheoreticalPriceCallback(TTheoreticalPriceCallback a_theoreticalPriceCallback);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetAdjustHistoryCallbackV2(TAdjustHistoryCallbackV2 AdjustHistoryCallbackV2);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetAssetPositionListCallback(TConnectorAssetPositionListCallback AssetPositionListCallback);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetOrderChangeCallbackV2(TOrderChangeCallBackV2 OrderChangeCallbackV2);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetOrderCallback(TConnectorOrderCallback orderCallback);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetOrderHistoryCallback(TConnectorAccountCallback orderHistoryCallback);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetTradeCallbackV2(TConnectorTradeCallback a_TradeCallbackV2);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetHistoryTradeCallbackV2(TConnectorTradeCallback a_HistoryTradeCallbackV2);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetPriceDepthCallback(TConnectorPriceDepthCallback a_PriceDepthCallback);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetBrokerAccountListChangedCallback(TConnectorBrokerAccountListCallback a_BrokerAccountListCallback);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetBrokerSubAccountListChangedCallback(TConnectorBrokerSubAccountListCallback a_BrokerSubAccountListCallback);    

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SetEnabledLogToDebug(int bEnabled);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SubscribeTicker(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int UnsubscribeTicker(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SubscribePriceBook(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int UnsubscribePriceBook(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SubscribeOfferBook(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int UnsubscribeOfferBook(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SubscribeAdjustHistory(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetHistoryTrades(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa,
        [MarshalAs(UnmanagedType.LPWStr)] string dtDateStart,
        [MarshalAs(UnmanagedType.LPWStr)] string dtDateEnd);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int FreePointer(IntPtr pointer, int nSize);


    ////////////////////////////////////////////////////////////////////////////////
    // Roteamento
    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern Int64 SendStopBuyOrder(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDAccount,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDCorretora,
        [MarshalAs(UnmanagedType.LPWStr)] string sSenha,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa,
        double sPrice, double sStopPrice, int nAmount);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern Int64 SendStopSellOrder(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDAccount,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDCorretora,
        [MarshalAs(UnmanagedType.LPWStr)] string sSenha,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa,
        double sPrice, double sStopPrice, int nAmount);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SendChangeOrder(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDAccount,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDCorretora,
        [MarshalAs(UnmanagedType.LPWStr)] string sSenha,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcClOrdID,
        double sPrice, int nAmount);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SendCancelOrder(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDAccount,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDCorretora,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcClOrdID,
        [MarshalAs(UnmanagedType.LPWStr)] string sSenha);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SendCancelAllOrders(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDAccount,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDCorretora,
        [MarshalAs(UnmanagedType.LPWStr)] string sSenha);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SendCancelOrders(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDAccount,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDCorretora,
        [MarshalAs(UnmanagedType.LPWStr)] string sSenha,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern Int64 SendZeroPosition(
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDAccount,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcIDCorretora,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcTicker,
        [MarshalAs(UnmanagedType.LPWStr)] string pwcBolsa,
        [MarshalAs(UnmanagedType.LPWStr)] string sSenha,
        double sPrice);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern long SendBuyOrder(
        [MarshalAs(UnmanagedType.LPWStr)] string IDAccount,
        [MarshalAs(UnmanagedType.LPWStr)] string IDCorretora,
        [MarshalAs(UnmanagedType.LPWStr)] string Senha,
        [MarshalAs(UnmanagedType.LPWStr)] string Ticker,
        [MarshalAs(UnmanagedType.LPWStr)] string Bolsa,
        double sPrice, int nAmount);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern long SendSellOrder(
        [MarshalAs(UnmanagedType.LPWStr)] string IDAccount,
        [MarshalAs(UnmanagedType.LPWStr)] string IDCorretora,
        [MarshalAs(UnmanagedType.LPWStr)] string Senha,
        [MarshalAs(UnmanagedType.LPWStr)] string Ticker,
        [MarshalAs(UnmanagedType.LPWStr)] string Bolsa,
        double sPrice, int nAmount);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetOrder([MarshalAs(UnmanagedType.LPWStr)] string clOrdId);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern long SendOrder([In] ref TConnectorSendOrder sendOrder);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SendChangeOrderV2([In] ref TConnectorChangeOrder changeOrder);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SendCancelOrderV2([In] ref TConnectorCancelOrder cancelOrder);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SendCancelOrdersV2([In] ref TConnectorCancelOrders cancelOrders);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SendCancelAllOrdersV2([In] ref TConnectorCancelAllOrders cancelAllOrders);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern long SendZeroPositionV2([In] ref TConnectorZeroPosition zeroPosition);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetAccountCount();

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetAccounts(int startSource, int startDest, int count, [Out][MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 2)] TConnectorAccountIdentifierOut[] accounts);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetAccountDetails(ref TConnectorTradingAccountOut account);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetSubAccountCount(ref TConnectorAccountIdentifier masterAccountID);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetSubAccounts(ref TConnectorAccountIdentifier masterAccountID, int startSource, int startDest, int count, [Out][MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 3)] TConnectorAccountIdentifierOut[] accounts);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetPositionV2(ref TConnectorTradingAccountPosition position);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetOrderDetails(ref TConnectorOrderOut order);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int HasOrdersInInterval([In] ref TConnectorAccountIdentifier a_AccountID, SystemTime a_dtStart, SystemTime a_dtEnd);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int EnumerateOrdersByInterval([In] ref TConnectorAccountIdentifier a_AccountID, byte a_OrderVersion, SystemTime a_dtStart, SystemTime a_dtEnd, IntPtr a_Param, TConnectorEnumerateOrdersProc a_Callback);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int EnumerateAllOrders([In] ref TConnectorAccountIdentifier a_AccountID, byte a_OrderVersion, IntPtr a_Param, TConnectorEnumerateOrdersProc a_Callback);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int TranslateTrade(nint a_pTrade, ref TConnectorTrade a_Trade);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetAccountCountByBroker(int a_AgentID);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetAccountsByBroker(int a_BrokerID, int a_startSource, int a_startDest, int a_count, [Out][MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 2)] TConnectorAccountIdentifierOut[] accounts);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetAgentNameLength(int a_AgentID, int a_shortFlag);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetAgentName(int a_AgentLen, int a_AgentID, [MarshalAs(UnmanagedType.LPWStr)] StringBuilder AgentName, int a_shortFlag);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int EnumerateAllPositionAssets([In] ref TConnectorAccountIdentifier a_AccountID, byte a_OrderVersion, IntPtr a_Param, TConnectorEnumerateAssetProc a_Callback);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int SubscribePriceDepth(in TConnectorAssetIdentifier assetID);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int UnsubscribePriceDepth(in TConnectorAssetIdentifier assetID);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetTheoreticalValues(in TConnectorAssetIdentifier assetID, out double price, out long quantity);    

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetPriceDepthSideCount(in TConnectorAssetIdentifier assetID, byte side);

    [DllImport(dll_path, CallingConvention = CallingConvention.StdCall)]
    public static extern int GetPriceGroup(in TConnectorAssetIdentifier assetID, byte side, int position, ref TConnectorPriceGroup priceGroup);
}
