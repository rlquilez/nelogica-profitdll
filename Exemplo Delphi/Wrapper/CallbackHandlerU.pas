unit CallbackHandlerU;

interface

uses
  System.SysUtils,
  System.TypInfo,
  System.Classes,
  System.Generics.Collections,
  ProfitCallbackTypesU,
  ProfitDataTypesU,
  LegacyProfitDataTypesU;

///////////////////////////////////////////////////////////////////////////////

  procedure StateCallback(
    nConnStateType : Integer;
    nResult : Integer
  ); stdcall;

  procedure AccountCallback(
    nCorretora            : Integer;
    CorretoraNomeCompleto : PWideChar;
    AccountID             : PWideChar;
    NomeTitular           : PWideChar
  ); stdcall;

  procedure NewDailyCallback(
    rAssetID       : TAssetIDRec;
    pwcDate        : PWideChar;
    sOpen          : Double;
    sHigh          : Double;
    sLow           : Double;
    sClose         : Double;
    sVol           : Double;
    sAjuste        : Double;
    sMaxLimit      : Double;
    sMinLimit      : Double;
    sVolBuyer      : Double;
    sVolSeller     : Double;
    nQtd           : Integer;
    nNegocios      : Integer;
    nContratosOpen : Integer;
    nQtdBuyer      : Integer;
    nQtdSeller     : Integer;
    nNegBuyer      : Integer;
    nNegSeller     : Integer
  ); stdcall;

  procedure OfferBookCallback(
    rAssetID    : TAssetIDRec;
    nAction     : Integer;
    nPosition   : Integer;
    Side        : Integer;
    nQtd        : Integer;
    nAgent      : Integer;
    nOfferID    : Int64;
    sPrice      : Double;
    bHasPrice   : Char;
    bHasQtd     : Char;
    bHasDate    : Char;
    bHasOfferID : Char;
    bHasAgent   : Char;
    pwcDate     : PWideChar;
    pArraySell  : Pointer;
    pArrayBuy   : Pointer
  ); stdcall;

  procedure OfferBookCallbackV2(
    rAssetID    : TAssetIDRec;
    nAction     : Integer;
    nPosition   : Integer;
    Side        : Integer;
    nQtd        : Int64;
    nAgent      : Integer;
    nOfferID    : Int64;
    sPrice      : Double;
    bHasPrice   : Char;
    bHasQtd     : Char;
    bHasDate    : Char;
    bHasOfferID : Char;
    bHasAgent   : Char;
    pwcDate     : PWideChar;
    pArraySell  : Pointer;
    pArrayBuy   : Pointer
  ); stdcall;

  procedure TinyBookCallback(
    rAssetID  : TAssetIDRec;
    sPrice    : Double;
    nQtd      : Integer;
    nSide     : Integer
  ); stdcall;

  procedure AssetListCallback(
    AssetID : TAssetIDRec;
    pwcName : PWideChar
  ); stdcall;

  procedure AssetListInfoCallback(
    rAssetID            : TAssetIDRec;
    pwcName             : PWideChar;
    pwcDescription      : PWideChar;
    nMinOrderQtd        : Integer;
    nMaxOrderQtd        : Integer;
    nLote               : Integer;
    stSecurityType      : Integer;
    ssSecuritySubType   : Integer;
    sMinPriceIncrement  : Double;
    sContractMultiplier : Double;
    strValidDate        : PWideChar;
    strISIN             : PWideChar
  ); stdcall;

  procedure AssetListInfoCallbackV2(
    rAssetID            : TAssetIDRec;
    pwcName             : PWideChar;
    pwcDescription      : PWideChar;
    nMinOrderQtd        : Integer;
    nMaxOrderQtd        : Integer;
    nLote               : Integer;
    stSecurityType      : Integer;
    ssSecuritySubType   : Integer;
    sMinPriceIncrement  : Double;
    sContractMultiplier : Double;
    strValidDate        : PWideChar;
    strISIN             : PWideChar;
    strSetor            : PWideChar;
    strSubSetor         : PWideChar;
    strSegmento         : PWideChar
  ); stdcall;

  procedure ChangeStateTickerCallback(
    rAssetID : TAssetIDRec;
    pwcDate  : PWideChar;
    nState   : Integer
  ); stdcall;

  procedure AdjustHistoryCallback(
    rAssetID      : TAssetIDRec;
    sValue        : Double;
    strAdjustType : PWideChar;
    strObserv     : PWideChar;
    dtAjuste      : PWideChar;
    dtDeliber     : PWideChar;
    dtPagamento   : PWideChar;
    nAffectPrice  : Integer
  ); stdcall;

  procedure AdjustHistoryCallbackV2(
    rAssetID      : TAssetIDRec;
    dValue        : Double;
    strAdjustType : PWideChar;
    strObserv     : PWideChar;
    dtAjuste      : PWideChar;
    dtDeliber     : PWideChar;
    dtPagamento   : PWideChar;
    nFlags        : Cardinal;
    dMult         : Double
  ); stdcall;

  procedure TheoreticalPriceCallback(
    rAssetID          : TAssetIDRec;
    sTheoreticalPrice : Double;
    nTheoreticalQtd   : Int64
  ); stdcall;

  procedure ChangeCotationCallback(
    rAssetID     : TAssetIDRec;
    pwcDate      : PWideChar;
    nTradeNumber : Cardinal;
    sPrice       : Double
  ); stdcall;

  procedure InvalidTickerCallback(
    const AssetID : TConnectorAssetIdentifier
  ) stdcall;

  procedure OrderCallback(
    const a_OrderID : TConnectorOrderIdentifier
  ); stdcall;

  procedure BrokerAccountListChangedCallback(
    const BrokerID   : Integer;
    const a_nChanged : Cardinal
  ); stdcall;

  procedure BrokerSubAccountListChangedCallback(
    const a_AccountID : TConnectorAccountIdentifier
  ); stdcall;

  procedure OrderHistoryCallback(
    const a_AccountID : TConnectorAccountIdentifier
  ); stdcall;

  procedure TradeCallback(
    const a_Asset  : TConnectorAssetIdentifier;
    const a_pTrade : Pointer;
    const a_nFlags : Cardinal
  ); stdcall;

  procedure HistoryTradeCallback(
    const a_Asset  : TConnectorAssetIdentifier;
    const a_pTrade : Pointer;
    const a_nFlags : Cardinal
  ); stdcall;

  procedure AssetPositionListCallback(
    const a_AccountID : TConnectorAccountIdentifier;
    const a_AssetID   : TConnectorAssetIdentifier;
    const a_LastEvent : Int64
  ); stdcall;

  procedure PriceDepthCallback(
    const a_AssetID    : TConnectorAssetIdentifier;
    const a_Side       : Byte;
    const a_nPosition  : Integer;
    const a_UpdateType : Byte
  ); stdcall;

implementation

uses
  Winapi.Windows,
  frmClientU,
  ProfitConstantsU,
  ProfitFunctionsU;

///****************************************************************************
/// StateCallback
///****************************************************************************
procedure StateCallback(nConnStateType , nResult : Integer);
begin
  UpdateConnStatus(nConnStateType, nResult);
end;

///****************************************************************************
/// AccountCallback
///****************************************************************************
procedure AccountCallback(nCorretora : Integer; CorretoraNomeCompleto, AccountID, NomeTitular : PWideChar);
begin
  GenericLogUpdate(Format('TAccountCallback: %d | %s | %s | %s', [nCorretora, CorretoraNomeCompleto, AccountId, NomeTitular]));
end;

///****************************************************************************
/// NewDailyCallback
///****************************************************************************
procedure NewDailyCallback(rAssetID : TAssetIDRec;pwcDate : PWideChar; sOpen, sHigh, sLow, sClose, sVol, sAjuste, sMaxLimit, sMinLimit, sVolBuyer, sVolSeller : Double; nQtd, nNegocios, nContratosOpen, nQtdBuyer, nQtdSeller, nNegBuyer, nNegSeller : Integer);
begin
  GenericLogUpdate(Format('TNewDailyCallback '  +
                          #13#10 + 'Ticker: %s' +
                          #13#10 + 'Date:  %s'  +
                          #13#10 + 'Qtd:   %d'  +
                          #13#10 + 'Open:  %n'  +
                          #13#10 + 'High:  %n'  +
                          #13#10 + 'Low:   %n'  +
                          #13#10 + 'Close: %n'  +
                          #13#10 + 'Volume %n',
                          [rAssetId.pchTicker, pwcDate, nQtd, sOpen, sHigh, sLow, sClose, sVol]));
end;

///****************************************************************************
/// OfferBookCallback
///****************************************************************************
procedure OfferBookCallback(rAssetID : TAssetIDRec ; nAction, nPosition, Side, nQtd, nAgent : Integer; nOfferID : Int64; sPrice : Double; bHasPrice, bHasQtd, bHasDate, bHasOfferID, bHasAgent : Char; pwcDate : PWideChar; pArraySell, pArrayBuy : Pointer);
begin
  UpdateOfferBook(1, rAssetID, nAction, nPosition, Side, nQtd, nAgent, nOfferID, sPrice, bHasPrice, bHasQtd, bHasDate, bHasOfferID, bHasAgent, pwcDate, pArraySell, pArrayBuy);
end;

///****************************************************************************
/// OfferBookCallbackV2
///****************************************************************************
procedure OfferBookCallbackV2(rAssetID : TAssetIDRec ; nAction, nPosition, Side : Integer; nQtd : Int64; nAgent : Integer; nOfferID : Int64; sPrice : Double; bHasPrice, bHasQtd, bHasDate, bHasOfferID, bHasAgent : Char; pwcDate : PWideChar; pArraySell, pArrayBuy : Pointer);
begin
  UpdateOfferBook(2, rAssetID, nAction, nPosition, Side, nQtd, nAgent, nOfferID, sPrice, bHasPrice, bHasQtd, bHasDate, bHasOfferID, bHasAgent, pwcDate, pArraySell, pArrayBuy);
end;

///****************************************************************************
/// TinyBookCallback
///****************************************************************************
procedure TinyBookCallback(rAssetID : TAssetIDRec; sPrice : Double; nQtd, nSide : Integer);
begin
  GenericLogUpdate(Format('TinyBookCallback: %s | %n | %d | %d', [rAssetID.pchTicker, sPrice, nQtd, nSide]));
end;

///****************************************************************************
/// AssetListCallback
///****************************************************************************
procedure AssetListCallback(AssetID : TAssetIDRec; pwcName : PWideChar);
begin
  GenericLogUpdate(Format('AssetListCallback: %s | %s', [AssetId.pchTicker, pwcName]));
end;

///****************************************************************************
/// AssetListInfoCallback
///****************************************************************************
procedure AssetListInfoCallback (rAssetID : TAssetIDRec; pwcName, pwcDescription : PwideChar; nMinOrderQtd, nMaxOrderQtd, nLote, stSecurityType, ssSecuritySubType : Integer; sMinPriceIncrement, sContractMultiplier : Double; strValidDate, strISIN : PwideChar);
begin
  GenericLogUpdate(Format('TAssetListInfoCallback: %s | %s | %s | %s | %s | %s |', [rAssetId.pchTicker, pwcName, strValidDate, strISIN, GetEnumName(TypeInfo(TSecurityType), stSecurityType), GetEnumName(TypeInfo(TSecuritySubType), ssSecuritySubType)]));
end;

///****************************************************************************
/// AssetListInfoCallbackV2
///****************************************************************************
procedure AssetListInfoCallbackV2 (rAssetID : TAssetIDRec; pwcName, pwcDescription : PwideChar; nMinOrderQtd, nMaxOrderQtd, nLote, stSecurityType, ssSecuritySubType : Integer; sMinPriceIncrement, sContractMultiplier : Double; strValidDate, strISIN, strSetor, strSubSetor, strSegmento : PwideChar);
begin
  GenericLogUpdate(Format('TAssetListInfoCallbackV2: %s | %s | %s | %s | %s | %s | %s', [rAssetId.pchTicker, pwcName, strValidDate, strISIN, strSetor, strSubSetor, StrSegmento]));
end;

///****************************************************************************
/// ChangeStateTickerCallback
///****************************************************************************
procedure ChangeStateTickerCallback(rAssetID : TAssetIDRec; pwcDate : PWideChar; nState : Integer);
begin
  GenericLogUpdate(Format('TChangeStateTicker: %s | %s | %s', [rAssetId.pchTicker, pwcDate, GetEnumName(TypeInfo(TAssetStateType),nState)]));
end;

///****************************************************************************
/// AdjustHistoryCallback
///****************************************************************************
procedure AdjustHistoryCallback(rAssetID : TAssetIDRec; sValue : Double; strAdjustType, strObserv, dtAjuste, dtDeliber, dtPagamento : PwideChar; nAffectPrice : Integer);
begin
  GenericLogUpdate(Format('TAdjustHistoryCallback: %s | %n | %s | %s | %d', [rAssetId.pchTicker, sValue, strAdjustType, strObserv, nAffectPrice]));
end;

///****************************************************************************
/// AdjustHistoryCallbackV2
///****************************************************************************
procedure AdjustHistoryCallbackV2(rAssetID : TAssetIDRec; dValue : Double; strAdjustType, strObserv, dtAjuste, dtDeliber, dtPagamento : PwideChar; nFlags : Cardinal; dMult : Double);
begin
  GenericLogUpdate(Format('TAdjustHistoryCallbackV2: %s | %n | %s | %s | %d | %n', [rAssetId.pchTicker, dValue, strAdjustType, strObserv, nFlags, dMult]));
end;

///****************************************************************************
/// TheoreticalPriceCallback
///****************************************************************************
procedure TheoreticalPriceCallback(rAssetID : TAssetIDRec; sTheoreticalPrice : Double; nTheoreticalQtd : Int64);
begin
  GenericLogUpdate(Format('TTheoreticalPriceCallback: %s | %n | %d', [rAssetId.pchTicker, sTheoreticalPrice, nTheoreticalQtd]));
end;

///****************************************************************************
/// ChangeCotationCallback
///****************************************************************************
procedure ChangeCotationCallback(rAssetID : TAssetIDRec; pwcDate : PWideChar; nTradeNumber : Cardinal; sPrice : Double);
begin
  GenericLogUpdate(Format('TChangeCotationCallback: %s | %s | %n', [rAssetId.pchTicker, pwcDate, sPrice]));
end;

///****************************************************************************
/// AssetPositionListCallback
///****************************************************************************
procedure AssetPositionListCallback(const a_AccountID : TConnectorAccountIdentifier; const a_AssetID : TConnectorAssetIdentifier; const a_LastEvent : Int64);
begin
  GenericLogUpdate(Format('AssetPositionListCallback: Broker %d | Conta: %s | Asset: %s | LastEvent: %d',
                          [a_AccountID.BrokerID, a_AccountID.AccountID, a_AssetID.Ticker, a_LastEvent]));
end;

///****************************************************************************
/// OrderCallback
///****************************************************************************
procedure OrderCallback(const a_OrderID : TConnectorOrderIdentifier);
var
  Order : TConnectorOrderOut;
  nResult : Integer;
begin
  ZeroMemory(@Order, SizeOf(Order));
  Order.Version := 0;
  Order.OrderID := a_OrderID;

  nResult := GetOrderDetails(Order);

  if nResult = NL_OK then
    begin
      Order.AssetID.Ticker   := PWideChar(StringOfChar(' ', Order.AssetID.TickerLength));
      Order.AssetID.Exchange := PWideChar(StringOfChar(' ', Order.AssetID.ExchangeLength));
      Order.TextMessage      := PWideChar(StringOfChar(' ', Order.TextMessageLength));
      nResult := GetOrderDetails(Order);

      if nResult = NL_OK then
        begin
          GenericLogUpdate(Format('OrderCallback: %s | %d | %d | %n | %s | %s | %d | %s', [
            Trim(Order.AssetID.Ticker),
            Order.TradedQuantity,
            Order.OrderSide,
            Order.Price,
            Trim(Order.AccountID.AccountID),
            Trim(Order.OrderID.ClOrderID),
            Order.OrderStatus,
            Trim(Order.TextMessage)
          ] ));
        end;
    end;

  if nResult <> NL_OK then
    GenericLogUpdate('OrderCallback: ' + NResultToString(nResult));
end;

///****************************************************************************
/// BrokerAccountListChangedCallback
///****************************************************************************
procedure BrokerAccountListChangedCallback(const BrokerID : Integer; const a_nChanged : Cardinal);
var
  nCountContas : Integer;
begin
  nCountContas := GetAccountCountByBroker(BrokerID);
  GenericLogUpdate(Format('BrokerAccountListChangedCallback: %d | Contas: %d | %d', [BrokerID, nCountContas, a_nChanged]));
end;

///****************************************************************************
/// BrokerAccountListChangedCallback
///****************************************************************************
procedure BrokerSubAccountListChangedCallback(const a_AccountID : TConnectorAccountIdentifier);
var
  nCountContas : Integer;
begin
  nCountContas := GetSubAccountCount(@a_AccountID);
  GenericLogUpdate(Format('BrokerSubAccountListChangedCallback: %d | Conta: %s | Contas: %d',
                          [a_AccountID.BrokerID, a_AccountID.AccountID, nCountContas]));
end;

///****************************************************************************
/// CountOrders
///****************************************************************************
function CountOrders(const a_Order : PConnectorOrder; const a_Param : LPARAM) : BOOL; stdcall;
var
  pCount : PInteger;
begin
  // recebemos no a_Param o ponteiro do nCount que nos foi passado pelo OrderHistoryCallback
  pCount := PInteger(a_Param);
  pCount^ := pCount^ + 1;

  // continuanos até o final
  Result := True;
end;

///****************************************************************************
/// OrderHistoryCallback
///****************************************************************************
procedure OrderHistoryCallback(const a_AccountID : TConnectorAccountIdentifier);
var
  nCount      : Integer;
  strAccount  : String;
begin
  // passamos no a_Param o ponteiro do nCount para que CountOrders tenha acesso ao nCount
  EnumerateAllOrders(@a_AccountID, 0, LPARAM(@nCount), CountOrders);

  strAccount := a_AccountID.BrokerID.ToString + ':' + a_AccountID.AccountID;

  if a_AccountID.SubAccountID <> '' then
    strAccount := strAccount + ':' + a_AccountID.SubAccountID;

  GenericLogUpdate('OrderHistoryCallback: ' + strAccount + ' | Count=' + IntToStr(nCount));
end;

///****************************************************************************
/// InvalidTickerCallback
///****************************************************************************
procedure InvalidTickerCallback(const AssetID : TConnectorAssetIdentifier);
begin
  GenericLogUpdate(Format('TInvalidTickerCallback: %s | %s', [AssetID.Ticker, AssetID.Exchange]));
end;

///****************************************************************************
/// TradeCallback
///****************************************************************************
procedure TradeCallback(const a_Asset : TConnectorAssetIdentifier; const a_pTrade : Pointer; const a_nFlags : Cardinal);
var
  ctTrade : TConnectorTrade;
  bIsEdit : Boolean;
begin
  ctTrade.Version := 0;
  if TranslateTrade(a_pTrade, ctTrade) = NL_OK then
    begin
      bIsEdit := (a_nFlags and TC_IS_EDIT) = TC_IS_EDIT;

      GenericLogUpdate(Format('TradeCallback: %s:%s | %n | %d | %s | %s', [a_Asset.Ticker, a_Asset.Exchange, ctTrade.Price, ctTrade.Quantity, GetEnumName(TypeInfo(TTradeType), ctTrade.TradeType), BoolToStr(bIsEdit, True)]));
    end;
end;

///****************************************************************************
/// HistoryTradeCallback
///****************************************************************************
procedure HistoryTradeCallback(const a_Asset : TConnectorAssetIdentifier; const a_pTrade : Pointer; const a_nFlags : Cardinal);
var
  ctTrade : TConnectorTrade;
  dtDate  : TDateTime;
  bIsLast : Boolean;
begin
  ctTrade.Version := 0;
  if TranslateTrade(a_pTrade, ctTrade) = NL_OK then
    begin
      dtDate := SystemTimeToDateTime(ctTrade.TradeDate);
      bIsLast := (a_nFlags and TC_LAST_PACKET) = TC_LAST_PACKET;

      GenericLogUpdate(Format('THistoryTradeCallback: %s:%s | %s | %n | %d | %s | %s', [a_Asset.Ticker, a_Asset.Exchange, FormatDateTime('dd/mm/yyyy hh:nn:ss', dtDate), ctTrade.Price, ctTrade.Quantity, GetEnumName(TypeInfo(TTradeType), ctTrade.TradeType), BoolToStr(bIsLast, True)]));
    end;
end;

///****************************************************************************
/// SerieIDToString
///****************************************************************************
function AssetIDToString(const a_AssetID : TConnectorAssetIdentifier) : String;
begin
  Result := a_AssetID.Ticker + ' @ ' + a_AssetID.Exchange;
end;

///****************************************************************************
/// PriceDepthCallback
///****************************************************************************
procedure PriceDepthCallback(const a_AssetID : TConnectorAssetIdentifier; const a_Side : Byte; const a_nPosition : Integer; const a_UpdateType : Byte);
var
  pPrice        : PConnectorPriceGroup;
  strSide       : String;
  nCount        : Integer;
  dTheoricPrice : Double;
  dTheroicQty   : Int64;
begin
  if TConnectorBookSideType(a_Side) = bsBuy then
    strSide := 'Buy'
  else if TConnectorBookSideType(a_Side) = bsSell then
    strSide := 'Sell'
  else if TConnectorBookSideType(a_Side) = bsBoth then
    strSide := 'Both'
  else
    strSide := 'None';

  case TConnectorUpdateType(a_UpdateType)of
    utAdd :
      begin
         // notifies the smallest index that was modified (if there is a prepare/flush, it happens after flush)
         // can be ignored in this example
      end;
    utEdit :
      begin
        New(pPrice);
        pPrice.Version := 0;

        if GetPriceGroup(@a_AssetID, a_Side, a_nPosition, pPrice) = NL_OK then
          begin
            if (pPrice.PriceGroupFlags and PG_IS_THEORIC = PG_IS_THEORIC) then
              begin
                if GetTheoreticalValues(@a_AssetID, dTheoricPrice, dTheroicQty) = NL_OK then
                  pPrice.Price := dTheoricPrice;
              end;

            GenericLogUpdate(Format('PriceDepthCallback: %s | %s : Edit | %n : %d : %d', [AssetIDToString(a_AssetID), strSide, pPrice.Price, pPrice.Count, pPrice.Quantity]));
          end;
      end;
    utDelete :
      begin
        GenericLogUpdate(Format('PriceDepthCallback: %s | %s : Delete | Position=%d', [AssetIDToString(a_AssetID), strSide, a_nPosition]));
      end;
    utInsert :
      begin
        New(pPrice);
        pPrice.Version := 0;

        if GetPriceGroup(@a_AssetID, a_Side, a_nPosition, pPrice) = NL_OK then
          begin
            if (pPrice.PriceGroupFlags and PG_IS_THEORIC = PG_IS_THEORIC) then
              begin
                if GetTheoreticalValues(@a_AssetID, dTheoricPrice, dTheroicQty) = NL_OK then
                  pPrice.Price := dTheoricPrice;
              end;

            GenericLogUpdate(Format('PriceDepthCallback: %s | %s : Insert | %n : %d : %d', [AssetIDToString(a_AssetID), strSide, pPrice.Price, pPrice.Count, pPrice.Quantity]));
          end;
      end;
    utFullBook :
      begin
        nCount := GetPriceDepthSideCount(@a_AssetID, Byte(bsBuy));
        if nCount >= 0 then
          GenericLogUpdate(Format('PriceDepthCallback: %s | Buy : FullBook | Count=%d', [AssetIDToString(a_AssetID), nCount]));

        nCount := GetPriceDepthSideCount(@a_AssetID, Byte(bsSell));
        if nCount >= 0 then
          GenericLogUpdate(Format('PriceDepthCallback: %s | Sell : FullBook | Count=%d', [AssetIDToString(a_AssetID), nCount]));
      end;
    utTheoricPrice :
      begin
        // the book has been updated with theroic price
      end;
    utDeleteFrom :
      begin
        GenericLogUpdate(Format('PriceDepthCallback: %s | %s : DeleteFrom | Position=%d', [AssetIDToString(a_AssetID), strSide, a_nPosition]));
      end;
  else
    // we can ignore utPrepare and utFlush in this example
    // utPrepare indicates that there will be more than 1 notification
    // utFlush indicates that all notifications happened
  end;
end;

end.
