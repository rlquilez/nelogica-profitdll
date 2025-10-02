using System;
using System.Runtime.InteropServices;

namespace ProfitDLLClient;


////////////////////////////////////////////////////////////////////////////////
// WARNING: Não utilizar funções da dll dentro do CALLBACK
////////////////////////////////////////////////////////////////////////////////
//Callback do stado das diferentes conexões
public delegate void TStateCallback(int nResult, int result);
////////////////////////////////////////////////////////////////////////////////
//Callback com informações marketData
public delegate void TTradeCallback(TAssetID assetId, [MarshalAs(UnmanagedType.LPWStr)] string date, uint tradeNumber, double price, double vol, int qtd, int buyAgent, int sellAgent, int tradeType, int bIsEdit);
public delegate void TNewDailyCallback(TAssetID TAssetIDRec, [MarshalAs(UnmanagedType.LPWStr)] string date, double sOpen, double sHigh, double sLow, double sClose, double sVol, double sAjuste, double sMaxLimit, double sMinLimit, double sVolBuyer, double sVolSeller, int nQtd, int nNegocios, int nContratosOpen, int nQtdBuyer, int nQtdSeller, int nNegBuyer, int nNegSeller);
public delegate void THistoryTradeCallback(TAssetID assetId, [MarshalAs(UnmanagedType.LPWStr)] string date, uint tradeNumber, double price, double vol, int qtd, int buyAgent, int sellAgent, int tradeType);
public delegate void TProgressCallBack(TAssetID assetId, int nProgress);
public delegate void TNewTinyBookCallBack(TAssetID assetId, double price, int qtd, int side);

////////////////////////////////////////////////////////////////////////////////
//Callback de alteração em ordens

public delegate void TChangeCotation(TAssetID assetId, [MarshalAs(UnmanagedType.LPWStr)] string date, uint tradeNumber, double sPrice);

public delegate void TAssetListCallback(TAssetID assetId, [MarshalAs(UnmanagedType.LPWStr)] string strName);
public delegate void TConnectorOrderCallback(TConnectorOrderIdentifier orderId);
public delegate void TConnectorAccountCallback(TConnectorAccountIdentifier accountId);

public delegate void TConnectorTradeCallback(TConnectorAssetIdentifier a_Asset, nint a_pTrade, [MarshalAs(UnmanagedType.U4)] TConnectorTradeCallbackFlags a_nFlags);

public delegate void TAdjustHistoryCallbackV2(TAssetID assetId,
    double dValue,
    [MarshalAs(UnmanagedType.LPWStr)] string adjustType,
    [MarshalAs(UnmanagedType.LPWStr)] string strObserv,
    [MarshalAs(UnmanagedType.LPWStr)] string dtAjuste,
    [MarshalAs(UnmanagedType.LPWStr)] string dtDeliber,
    [MarshalAs(UnmanagedType.LPWStr)] string dtPagamento,
    int nFlags,
    double dMult);

public delegate void TAssetListInfoCallback(
    TAssetID assetId,
    [MarshalAs(UnmanagedType.LPWStr)] string strName,
    [MarshalAs(UnmanagedType.LPWStr)] string strDescription,
    int nMinOrderQtd,
    int nMaxOrderQtd,
    int nLote,
    int stSecurityType,
    int ssSecuritySubType,
    double sMinPriceInc,
    double sContractMultiplier,
    [MarshalAs(UnmanagedType.LPWStr)] string validityDate,
    [MarshalAs(UnmanagedType.LPWStr)] string strISIN);

public delegate void TAssetListInfoCallbackV2(
    TAssetID assetId,
    [MarshalAs(UnmanagedType.LPWStr)] string strName,
    [MarshalAs(UnmanagedType.LPWStr)] string strDescription,
    int nMinOrderQtd,
    int nMaxOrderQtd,
    int nLote,
    int stSecurityType,
    int ssSecuritySubType,
    double sMinPriceInc,
    double sContractMultiplier,
    [MarshalAs(UnmanagedType.LPWStr)] string validityDate,
    [MarshalAs(UnmanagedType.LPWStr)] string strISIN,
    [MarshalAs(UnmanagedType.LPWStr)] string strSetor,
    [MarshalAs(UnmanagedType.LPWStr)] string strSubSetor,
    [MarshalAs(UnmanagedType.LPWStr)] string strSegmento);

public delegate void TChangeStateTickerCallback(TAssetID assetId, [MarshalAs(UnmanagedType.LPWStr)] string strDate, int nState);

public delegate void TInvalidTickerCallback(TConnectorAssetIdentifier assetId);

public delegate void TTheoreticalPriceCallback(TAssetID assetId, double dTheoreticalPrice, Int64 nTheoreticalQtd);

public delegate void TConnectorAssetPositionListCallback(TConnectorAccountIdentifier AccountID, TConnectorAssetIdentifier assetId, int nEventID);

public delegate void THistoryCallBack(TAssetID AssetID, int nCorretora, int nQtd, int nTradedQtd, int nLeavesQtd, int Side, double sPrice, double sStopPrice, double sAvgPrice, long nProfitID,
    [MarshalAs(UnmanagedType.LPWStr)] string TipoOrdem,
    [MarshalAs(UnmanagedType.LPWStr)] string Conta,
    [MarshalAs(UnmanagedType.LPWStr)] string Titular,
    [MarshalAs(UnmanagedType.LPWStr)] string ClOrdID,
    [MarshalAs(UnmanagedType.LPWStr)] string Status,
    [MarshalAs(UnmanagedType.LPWStr)] string Date);

public delegate void TOrderChangeCallBack(TAssetID assetId, int nCorretora, int nQtd, int nTradedQtd, int nLeavesQtd, int Side, double sPrice, double sStopPrice, double sAvgPrice, long nProfitID,
    [MarshalAs(UnmanagedType.LPWStr)] string TipoOrdem,
    [MarshalAs(UnmanagedType.LPWStr)] string Conta,
    [MarshalAs(UnmanagedType.LPWStr)] string Titular,
    [MarshalAs(UnmanagedType.LPWStr)] string ClOrdID,
    [MarshalAs(UnmanagedType.LPWStr)] string Status,
    [MarshalAs(UnmanagedType.LPWStr)] string Date,
    [MarshalAs(UnmanagedType.LPWStr)] string TextMessage);

public delegate void TOrderChangeCallBackV2(TAssetID assetId, int nCorretora, int nQtd, int nTradedQtd, int nLeavesQtd, int Side, int nValidity, double sPrice, double sStopPrice, double sAvgPrice, long nProfitID,
    [MarshalAs(UnmanagedType.LPWStr)] string TipoOrdem,
    [MarshalAs(UnmanagedType.LPWStr)] string Conta,
    [MarshalAs(UnmanagedType.LPWStr)] string Titular,
    [MarshalAs(UnmanagedType.LPWStr)] string ClOrdID,
    [MarshalAs(UnmanagedType.LPWStr)] string Status,
    [MarshalAs(UnmanagedType.LPWStr)] string Date,
    [MarshalAs(UnmanagedType.LPWStr)] string LastUpdate,
    [MarshalAs(UnmanagedType.LPWStr)] string CloseDate,
    [MarshalAs(UnmanagedType.LPWStr)] string ValidityDate,
    [MarshalAs(UnmanagedType.LPWStr)] string TextMessage);

////////////////////////////////////////////////////////////////////////////////
//Callback com a lista de contas
public delegate void TAccountCallback(int nCorretora,
    [MarshalAs(UnmanagedType.LPWStr)] string CorretoraNomeCompleto,
    [MarshalAs(UnmanagedType.LPWStr)] string AccountID,
    [MarshalAs(UnmanagedType.LPWStr)] string NomeTitular);

public delegate void TConnectorBrokerAccountListCallback(int nCorretora, int nChanged);

public delegate void TConnectorBrokerSubAccountListCallback(TConnectorAccountIdentifier accountId);

////////////////////////////////////////////////////////////////////////////////
//Callback com informações marketData
public delegate void TPriceBookCallback(TAssetID assetId, int nAction, int nPosition, int Side, int nQtd, int nCount, double sPrice, IntPtr pArraySell, IntPtr pArrayBuy);

public delegate void TOfferBookCallback(TAssetID assetId, int nAction, int nPosition, int Side, int nQtd, int nAgent, Int64 nOfferID, double sPrice, int bHasPrice, int bHasQtd, int bHasDate, int bHasOfferID, int bHasAgent,
    [MarshalAs(UnmanagedType.LPWStr)] string date,
    IntPtr pArraySell, IntPtr pArrayBuy);

public delegate void TConnectorPriceDepthCallback(TConnectorAssetIdentifier a_AssetID, byte a_Side, int a_nPosition, byte a_UpdateType);