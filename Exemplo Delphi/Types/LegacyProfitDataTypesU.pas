unit LegacyProfitDataTypesU;

interface

type
  TConnStateType = (cstInfo        = 0,
                    cstRoteamento  = 1,
                    cstMarketData  = 2,
                    cstActivation  = 3);

  TConnInfo = (ciArSuccess         = 0,
               ciArLoginInvalid    = 1,
               ciArPasswordInvalid = 2,
               ciArPasswordBlocked = 3,
               ciArPasswordExpired = 4);

  TConnMarketData = (cmdDisconnected       = 0,
                     cmdConnecting         = 1,
                     cmdConnectedWaiting   = 2,
                     cmdConnectedNotLogged = 3,
                     cmdConnectedLogged    = 4);

  TConnRoteamento = (crDisconnected       = 0,
                     crConnecting         = 1,
                     crConnected          = 2,
                     crBrokerDisconnected = 3,
                     crBrokerConnecting   = 4,
                     crBrokerConnected    = 5);

  TConnActivation = (caValid   = 0,
                     caInvalid = 1);

  TTradeType = (ttZero            = 0,
                ttCrossTrade      = 1,
                ttAgressionBuy    = 2,
                ttAgressionSell   = 3,
                ttAuction         = 4,
                ttSurveillance    = 5,
                ttExpit           = 6,
                ttOptionsExercise = 7,
                ttOverTheCounter  = 8,
                ttDerivativeTerm  = 9,
                ttIndex           = 10,
                ttBTC             = 11,
                ttOnBehalf        = 12,
                ttRLP             = 13);

  TAssetStateType = (astOpened     = 0,
                     astNone1      = 1,
                     astFronzen    = 2,
                     astInhibited  = 3,
                     astAuctioned  = 4,
                     astNone5      = 5,
                     astClosed     = 6,
                     astNone7      = 7,
                     astNone8      = 8,
                     astNone9      = 9,
                     astPreClosing = 10,
                     astNone11     = 11,
                     astNone12     = 12,
                     astPreOpening = 13);

  TSecurityType = (stFuture               = 0,
                   stSpot                 = 1,
                   stSpotOption           = 2,
                   stFutureOption         = 3,
                   stDerivativeTerm       = 4,
                   stStock                = 5,
                   stOption               = 6,
                   stForward              = 7,
                   stETF                  = 8,
                   stIndex                = 9,
                   stOptionExercise       = 10,
                   stUnknown              = 11,
                   stEconomicIndicator    = 12,
                   stMultilegInstrument   = 13,
                   stCommonStock          = 14,
                   stPreferredStock       = 15,
                   stSecurityLoan         = 16,
                   stOptionOnIndex        = 17,
                   stRights               = 18,
                   stCorporateFixedIncome = 19);

  TSecuritySubType = (sstFXSpot                  = 0,
                      sstGold                    = 1,
                      sstIndex                   = 2,
                      sstInterestRate            = 3,
                      sstFXRate                  = 4,
                      sstForeignDebt             = 5,
                      sstAgricultural            = 6,
                      sstEnergy                  = 7,
                      sstEconomicIndicator       = 8,
                      sstStrategy                = 9,
                      sstFutureOption            = 10,
                      sstVolatility              = 11,
                      sstSwap                    = 12,
                      sstMiniContract            = 13,
                      sstFinancialRollOver       = 14,
                      sstAgriculturalRollOver    = 15,
                      sstCarbonCredit            = 16,
                      sstUnknown                 = 17,
                      sstFractionary             = 18,
                      sstStock                   = 19,
                      sCturrency                 = 20,
                      sstOTC                     = 21,      //OTC=MercadoBalcao
                      sstFII                     = 22,      // FII=Fundo de Investimento Imobiliario
                      sstOrdinaryRights          = 23,      //(DO)
                      sstPreferredRights         = 24,      //(DP)
                      sstCommonShares            = 25,      //(ON)
                      sstPreferredShares         = 26,      //(PN)
                      sstClassApreferredShares   = 27,      //(PNA)
                      sstClassBpreferredShares   = 28,      //(PNB)
                      sstClassCpreferredShares   = 29,      //(PNC)
                      sstClassDpreferredShares   = 30,      //(PND)
                      sstOrdinaryReceipts        = 31,      //(ON REC)
                      sstPreferredReceipts       = 32,      //(PN REC)
                      sstCommonForward           = 33,
                      sstFlexibleForward         = 34,
                      sstDollarForward           = 35,
                      sstIndexPointsForward      = 36,
                      sstNonTradeableETFIndex    = 37,
                      sstPredefinedCoveredSpread = 38,
                      sstTraceableETF            = 39,
                      sstNonTradeableIndex       = 40,
                      sstUserDefinedSpread       = 41,
                      sstExchangeDefinedspread   = 42,
                      sstSecurityLoan            = 43,
                      sstTradeableIndex          = 44,
                      sstOthers                  = 45);

  // Asset //
  PAssetIDRec = ^TAssetIDRec;
  TAssetIDRec = packed record
    pchTicker : PWideChar;
    pchBolsa  : PWideChar;
    nFeed     : Integer;
  end;

  // Offer book //
  TGroupOffer = record
      nPosition  : Integer;
      nQtd       : Int64;
      nOfferID   : Int64;
      nAgent     : Integer;
      sPrice     : Double;
      strDtOffer : String;
  end;
  PGroupOffer = ^TGroupOffer;

implementation

end.
