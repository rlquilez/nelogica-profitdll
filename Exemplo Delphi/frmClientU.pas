unit frmClientU;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
  System.ImageList,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Imaging.pngimage,
  Vcl.ComCtrls,
  Vcl.Samples.Spin,
  Vcl.ImgList,
  DateUtils,
  ProfitDataTypesU,
  TypInfo,
  LegacyProfitDataTypesU;

const
  MD_HAS_ASSET          : Cardinal = 1;
  MD_HAS_AGENT          : Cardinal = 2;
  MD_HAS_DATE_RANGE     : Cardinal = 4;
  MD_HAS_BOOK           : Cardinal = 8;
  MD_HAS_SERIE          : Cardinal = 16;
  MD_HAS_QUOTE_ID_RANGE : Cardinal = 32;

  RT_HAS_ACCOUNT        : Cardinal = 1;
  RT_HAS_SUB_ACCOUNT    : Cardinal = 2;
  RT_HAS_PASSWORD       : Cardinal = 4;
  RT_HAS_ASSET          : Cardinal = 8;
  RT_HAS_PRICE          : Cardinal = 16;
  RT_HAS_AMOUNT         : Cardinal = 32;
  RT_HAS_STOP           : Cardinal = 64;
  RT_HAS_POSITION_TYPE  : Cardinal = 128;
  RT_HAS_ORDER_TYPE     : Cardinal = 256;
  RT_HAS_ORDER_SIDE     : Cardinal = 512;
  RT_HAS_CL_ORDER_ID    : Cardinal = 1024;
  RT_HAS_PROFIT_ID      : Cardinal = 2048;
  RT_HAS_DATE_RANGE     : Cardinal = 4096;
  RT_HAS_INDEX_RANGE    : Cardinal = 8192;

type
  TDLLFunctionType = (ftTrading, ftMarketData, ftConfig);

  TDLLFunctionDetails = class(TInterfacedObject)
  protected
    m_ftFunctionType : TDLLFunctionType;
    m_bIsDeprecated  : Boolean;
    m_strNewFunction : String;

    constructor Create(const a_ftFunctionType : TDLLFunctionType; const a_bIsDeprecated : Boolean; const a_strNewFunction : String = '');
  public
    property FunctionType : TDLLFunctionType read m_ftFunctionType;
    property IsDeprecated : Boolean          read m_bIsDeprecated;
    property NewFunction  : String           read m_strNewFunction;
  end;

  TDLLMarketDataFunctionDetails = class(TDLLFunctionDetails)
  protected
    m_bHasAsset        : Boolean;
    m_bHasAgent        : Boolean;
    m_HasDateRange     : Boolean;
    m_bHasBook         : Boolean;
    m_bHasSerie        : Boolean;
    m_bHasQuoteIDRange : Boolean;

  public
    property HasAsset        : Boolean read m_bHasAsset;
    property HasAgent        : Boolean read m_bHasAgent;
    property HasDateRange    : Boolean read m_HasDateRange;
    property HasBook         : Boolean read m_bHasBook;
    property HasSerie        : Boolean read m_bHasSerie;
    property HasQuoteIDRange : Boolean read m_bHasQuoteIDRange;

    constructor Create(const a_nControlFlags : Cardinal; const a_bIsDeprecated : Boolean; const a_strNewFunction : String = '');
  end;

  TDLLTradingFunctionDetails = class(TDLLFunctionDetails)
  protected
    m_bHasAccount      : Boolean;
    m_bHasSubAccount   : Boolean;
    m_bHasPassword     : Boolean;
    m_bHasAsset        : Boolean;

    m_bHasPrice        : Boolean;
    m_bHasAmount       : Boolean;
    m_bHasStop         : Boolean;

    m_bHasPositionType : Boolean;
    m_bHasOrderType    : Boolean;
    m_bHasOrderSide    : Boolean;

    m_bHasClOrderId    : Boolean;
    m_bHasProfitId     : Boolean;

    m_bHasDateRange    : Boolean;
    m_bHasIndexRange   : Boolean;

  public
    property HasAccount      : Boolean read m_bHasAccount;
    property HasSubAccount   : Boolean read m_bHasSubAccount;
    property HasPassword     : Boolean read m_bHasPassword;
    property HasAsset        : Boolean read m_bHasAsset;
    property HasPrice        : Boolean read m_bHasPrice;
    property HasAmount       : Boolean read m_bHasAmount;
    property HasStop         : Boolean read m_bHasStop;
    property HasPositionType : Boolean read m_bHasPositionType;
    property HasOrderType    : Boolean read m_bHasOrderType;
    property HasOrderSide    : Boolean read m_bHasOrderSide;
    property HasClOrderId    : Boolean read m_bHasClOrderId;
    property HasProfitId     : Boolean read m_bHasProfitId;
    property HasDateRange    : Boolean read m_bHasDateRange;
    property HasIndexRange   : Boolean read m_bHasIndexRange;

    constructor Create(const a_nControlFlags : Cardinal; const a_bIsDeprecated : Boolean; const a_strNewFunction : String = '');
  end;

  TfrmClient = class(TForm)
    pnlLeft: TPanel;
    pnlRight: TPanel;
    edtUser: TEdit;
    edtPass: TEdit;
    edtActCode: TEdit;
    lbPass: TLabel;
    lbActCode: TLabel;
    lbUser: TLabel;
    lbLogin: TLabel;
    btnInitialize: TButton;
    lbStatus: TLabel;
    imgInfoOff: TImage;
    imgMdOff: TImage;
    imgRotOff: TImage;
    btnFinalize: TButton;
    lbLoginResult: TLabel;
    lbVersion: TLabel;
    cbFunctions: TComboBox;
    pnlFunc: TPanel;
    lbFunc: TLabel;
    btnExecute: TButton;
    pcType: TPageControl;
    pnlPC: TPanel;
    tabRot: TTabSheet;
    tabMd: TTabSheet;
    edtTickerMd: TEdit;
    cbBolsaMd: TComboBox;
    lbBolsaMd: TLabel;
    lbTickerMd: TLabel;
    mmUpdates: TMemo;
    lbCallbackTitle: TLabel;
    lbAgentIdMd: TLabel;
    edtAgentId: TSpinEdit;
    lbContaRot: TLabel;
    lbBrokerIdRot: TLabel;
    edtBrokerAccRot: TEdit;
    edtBrokerIdRot: TEdit;
    lbPassRot: TLabel;
    edtPassRot: TEdit;
    lbTickerRot: TLabel;
    lbBolsaRot: TLabel;
    edtTickerRot: TEdit;
    cbBolsaRot: TComboBox;
    edtPriceRot: TEdit;
    lbPriceRot: TLabel;
    lbAmountRot: TLabel;
    edtAmountRot: TEdit;
    lbTitleRot: TLabel;
    lbTitleMd: TLabel;
    edtPriceStopRot: TEdit;
    lbPriceStopRot: TLabel;
    edtClOrdIdRot: TEdit;
    lbClOrdIdRot: TLabel;
    bvRot: TBevel;
    dateStartRot: TDateTimePicker;
    dateEndRot: TDateTimePicker;
    lbDateStartRot: TLabel;
    lbDateEndRot: TLabel;
    lbProfitIdRot: TLabel;
    edtProfitIdRot: TEdit;
    bvMd: TBevel;
    dateStartMd: TDateTimePicker;
    lbDateStartMd: TLabel;
    dateEndMd: TDateTimePicker;
    lbDateEndMd: TLabel;
    tabConfig: TTabSheet;
    lbTitleCfg: TLabel;
    mmDescCfg: TMemo;
    bvCfg: TBevel;
    imgCfg: TImage;
    mmFunc: TMemo;
    lbFuncTitle: TLabel;
    imgList: TImageList;
    btnClearUpdates: TButton;
    imgInfoOn: TImage;
    imgMdOn: TImage;
    imgRotOn: TImage;
    edtBookPos: TEdit;
    mmBookPos: TMemo;
    btnBookPos: TButton;
    lblDeprecated: TLabel;
    EdtSubAccountID: TEdit;
    lblSubAccount: TLabel;
    edtStartSource: TEdit;
    lblStartSource: TLabel;
    edtTotalCount: TEdit;
    lblTotalCount: TLabel;
    cbOrderType: TComboBox;
    cbOrderSide: TComboBox;
    cbPositionType: TComboBox;
    lblPositionType: TLabel;
    Bevel1: TBevel;
    edtQuoteIDStart: TSpinEdit;
    edtQuoteIDEnd: TSpinEdit;
    Bevel2: TBevel;
    Bevel3: TBevel;
    cbIntervalType: TComboBox;
    lblIntervalType: TLabel;
    edtOffset: TSpinEdit;
    lblOffset: TLabel;
    edtFactor: TSpinEdit;
    lblFactor: TLabel;
    cbAdjustType: TComboBox;
    lblAdjustType: TLabel;
    Bevel4: TBevel;
    cbBookSide: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btnInitializeClick(Sender: TObject);
    procedure btnFinalizeClick(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure cbFunctionsChange(Sender: TObject);
    procedure btnClearUpdatesClick(Sender: TObject);
    procedure btnBookPosClick(Sender: TObject);
    procedure cbOrderTypeChange(Sender: TObject);
  private
    FConnected: Boolean;
    FConnection: TDictionary<TConnStateType, Integer>;
    FListBuyOfferBook: TList;
    FListSellOfferBook: TList;
    procedure LoadDllVersion;
    procedure FillComboFunctions;
    procedure ServerClock(AText: String);
    procedure LastDailyClose(AText: String);
    procedure CopyMemoryToString(var ADest: String; Source: Pointer; Length: NativeUInt);
    function DecryptArrayPosition(AData: Pointer): String;
    procedure EnableDisableControls(ATab: TTabSheet; AItem: String);
    procedure ConnectionNotify(Sender: TObject; const Item: Integer; Action: TCollectionNotification);
    procedure LoadImages;

    procedure DecryptOfferArray(ASouce: Pointer; ATarget: TList; out nQtd : Integer; out nTam : Integer; out bLast : Boolean);
    procedure DecryptOfferArrayV2(ASouce: Pointer; ATarget: TList; out nQtd : Integer; out nTam : Integer; out bLast : Boolean);

    // são inline para não perder a referência da string dos WideChar
    function GetAccountID  : TConnectorAccountIdentifier; inline;
    function GetAssetIDRot : TConnectorAssetIdentifier; inline;
    function GetOrderID    : TConnectorOrderIdentifier; inline;

    function GetAssetIDMD : TConnectorAssetIdentifier; inline;

    function DoSubscribePriceBook        : Integer;
    function DoUnsubscribePriceBook      : Integer;

    function DoGetTheoreticalValues      : Integer;

    function DoSendOrder                 : Int64;
    function DoSendChangeOrderV2         : Integer;
    function DoSendCancelOrderV2         : Integer;
    function DoSendCancelOrdersV2        : Integer;
    function DoSendCancelAllOrdersV2     : Integer;
    function DoSendZeroPositionV2        : Int64;
    function DoGetAccountCount           : Integer;
    function DoGetAccounts               : Integer;
    function DoGetAccountDetails         : Integer;
    function DoGetAccountCountByBroker   : Integer;
    function DoGetAccountsByBroker       : Integer;
    function DoGetSubAccountCount        : Integer;
    function DoGetSubAccounts            : Integer;
    function DoGetPositionV2             : Integer;
    function DoGetOrderDetails           : Integer;
    function DoHasOrdersInInterval       : Integer;
    function DoEnumerateOrdersByInterval : Integer;
    function DoEnumerateAllOrders        : Integer;
    function DoEnumerateAllPositionAssets: Integer;

    function DoGetAgentName(a_nValue : Integer; a_bShort : Boolean = False) : Integer;

  public
    property Connected: Boolean read FConnected write FConnected;
    property Connection: TDictionary<TConnStateType, Integer> read FConnection write FConnection;

    property ListBuyOfferBook: TList read FListBuyOfferBook write FListBuyOfferBook;
    property ListSellOfferBook: TList read FListSellOfferBook write FListSellOfferBook;

    destructor Destroy; override;
  end;

  procedure UpdateConnStatus(AType, AValue: Integer);
  procedure GenericLogUpdate(AValue: String);

  procedure UpdateOfferBook(
    nVersion    : Integer;
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
  );

var
  frmClient: TfrmClient;

const
  C_CURRENTVER = '4.0.0.0';

implementation

uses
  ProfitFunctionsU,
  LegacyProfitFunctionsU,
  ProfitConstantsU,
  CallbackHandlerU;

{$R *.dfm}

procedure TfrmClient.FormCreate(Sender: TObject);
begin
  lbFunc.Caption:= 'Funções ' + '(' + C_CURRENTVER + ')';

  LoadDllVersion;

  FillComboFunctions;

  Self.Connected:= False;

  dateStartRot.Date:= Now;
  dateEndRot.Date  := Now;
  dateStartMd.Date := Now;
  dateEndMd.Date   := Now;

  Self.Connection:= TDictionary<TConnStateType, Integer>.Create;
  Self.Connection.Clear;
  Self.Connection.OnValueNotify:= Self.ConnectionNotify;

  LoadImages;

  ListBuyOfferBook := TList.Create;
  ListSellOfferBook:= TList.Create;
end;

procedure TfrmClient.btnInitializeClick(Sender: TObject);
var
  nRes: Integer;
begin
  nRes:=  DLLInitializeLogin(PWideChar(edtActCode.Text),
                             PWideChar(edtUser.Text),
                             PWideChar(edtPass.Text),
                             StateCallback,
                             nil,
                             nil,
                             AccountCallback,
                             nil,
                             NewDailyCallback,
                             nil,
                             nil,
                             nil,
                             nil,
                             TinyBookCallback);

  lbLoginResult.Caption:= 'Initialize return: 0x' + IntToHex(nRes);
  lbLoginResult.Visible:= true;

  if nRes <> NL_OK then
    ShowMessage('Erro durante inicialização.')
  else
    begin
      SetEnabledHistOrder(1);
      SetAssetListCallback(AssetListCallback);
      SetAssetListInfoCallback(AssetListInfoCallback);
      SetAssetListInfoCallbackV2(AssetListInfoCallbackV2);
      SetChangeStateTickerCallback(ChangeStateTickerCallback);
      SetAdjustHistoryCallback(AdjustHistoryCallback);
      SetAdjustHistoryCallbackV2(AdjustHistoryCallbackV2);
      SetTheoreticalPriceCallback(TheoreticalPriceCallback);
      SetChangeCotationCallback(ChangeCotationCallback);
      SetOfferBookCallbackV2(OfferBookCallbackV2);
      SetPriceDepthCallback(PriceDepthCallback);
      SetInvalidTickerCallback(InvalidTickerCallback);
      SetOrderCallback(OrderCallback);
      SetBrokerAccountListChangedCallback(BrokerAccountListChangedCallback);
      SetBrokerSubAccountListChangedCallback(BrokerSubAccountListChangedCallback);

      SetAssetPositionListCallback(AssetPositionListCallback);
      // setar essa callback desabilita SetOrderCallback **SOMENTE** quando for histórico de ordem
      SetOrderHistoryCallback(OrderHistoryCallback);
    end;
end;

procedure TfrmClient.btnFinalizeClick(Sender: TObject);
begin
  DLLFinalize;
end;

procedure TfrmClient.LoadDllVersion;
var
  sExe, sVer: string;
  iSize: integer;
  hHandle: Cardinal;
  pBuff: Pointer;
 FixedFileInfo : PVSFixedFileInfo;
begin
  sExe:= ExtractFilePath(Application.ExeName) + 'ProfitDLL.dll';

  iSize:= GetFileVersionInfoSize(PWideChar(sExe), hHandle);
  GetMem(pBuff, iSize);
  try
    if GetFileVersionInfo(PWideChar(sExe), hHandle, iSize, pBuff) then
      begin
        VerQueryValue(pBuff, PWideChar('\'), Pointer(FixedFileInfo), DWord(iSize));
        sVer := IntToStr(FixedFileInfo.dwFileVersionMS div $10000) + '.' +
                    IntToStr(FixedFileInfo.dwFileVersionMS and $0FFFF) + '.' +
                    IntToStr(FixedFileInfo.dwFileVersionLS div $10000) + '.' +
                    IntToStr(FixedFileInfo.dwFileVersionLS and $0FFFF);

        lbVersion.Caption:= lbVersion.Caption + ' ' + sVer;
      end;

    if sVer <> C_CURRENTVER then
      begin
        lbVersion.Font.Color:= clMaroon;
        {$IFNDEF DEBUG}
        ShowMessage('Versão compilada diferente da versão encontrada da DLL.' + #13 +
                    'Algumas funções podem não funcionar conforme o esperado.');
        {$ENDIF}
      end;
  finally
    FreeMem(pBuff);
  end;
end;

procedure UpdateConnStatus(AType, AValue: Integer);
label
  login, md, rot, act;
begin
  case TConnStateType(AType) of
    cstInfo: goto login;
    cstMarketData: goto md;
    cstRoteamento: goto rot;
    cstActivation: goto act;
  end;

  login:
    GenericLogUpdate(Format('StateCallback: %s | %s', [GetEnumName(TypeInfo(TConnStateType), AType),
                                                       GetEnumName(TypeInfo(TConnInfo), AValue)]));
    if (AValue = Ord(ciArSuccess)) then
      frmClient.Connection.AddOrSetValue(cstInfo, 1)
    else
      frmClient.Connection.AddOrSetValue(cstInfo, 0);
    exit;

  md:
    GenericLogUpdate(Format('StateCallback: %s | %s', [GetEnumName(TypeInfo(TConnStateType), AType),
                                                       GetEnumName(TypeInfo(TConnMarketData), AValue)]));
    if (AValue = Ord(cmdConnectedLogged)) then
      frmClient.Connection.AddOrSetValue(cstMarketData, 1)
    else
      frmClient.Connection.AddOrSetValue(cstMarketData, 0);
    exit;

  rot:
    GenericLogUpdate(Format('StateCallback: %s | %s', [GetEnumName(TypeInfo(TConnStateType), AType),
                                                       GetEnumName(TypeInfo(TConnRoteamento), AValue)]));
    if (AValue = Ord(crConnected)) or (AValue = Ord(crBrokerConnected)) then
      frmClient.Connection.AddOrSetValue(cstRoteamento, 1)
    else
      frmClient.Connection.AddOrSetValue(cstRoteamento, 0);
    exit;

  act:
    GenericLogUpdate(Format('StateCallback: %s | %s', [GetEnumName(TypeInfo(TConnStateType), AType),
                                                       GetEnumName(TypeInfo(TConnActivation), AValue)]));
    if (AValue = Ord(caValid)) then
      frmClient.Connection.AddOrSetValue(cstActivation, 1)
    else if AValue = Ord(caInvalid) then
      frmClient.Connection.AddOrSetValue(cstActivation, 0);
    exit;
end;

procedure TfrmClient.FillComboFunctions;
begin
  cbFunctions.Items.BeginUpdate;
  try
    cbFunctions.Items.Clear;

    cbFunctions.Items.AddObject('SubscribeTicker',              TDLLMarketDataFunctionDetails.Create(MD_HAS_ASSET, False));
    cbFunctions.Items.AddObject('UnsubscribeTicker',            TDLLMarketDataFunctionDetails.Create(MD_HAS_ASSET, False));

    cbFunctions.Items.AddObject('GetHistoryTrades',             TDLLMarketDataFunctionDetails.Create(MD_HAS_ASSET or MD_HAS_DATE_RANGE, False));
    cbFunctions.Items.AddObject('GetSerieHistory',              TDLLMarketDataFunctionDetails.Create(MD_HAS_ASSET or MD_HAS_DATE_RANGE or MD_HAS_QUOTE_ID_RANGE, False));

    cbFunctions.Items.AddObject('SubscribePriceBook',           TDLLMarketDataFunctionDetails.Create(MD_HAS_ASSET or MD_HAS_BOOK, False));
    cbFunctions.Items.AddObject('UnsubscribePriceBook',         TDLLMarketDataFunctionDetails.Create(MD_HAS_ASSET or MD_HAS_BOOK, False));
    cbFunctions.Items.AddObject('SubscribeOfferBook',           TDLLMarketDataFunctionDetails.Create(MD_HAS_ASSET or MD_HAS_BOOK, False));
    cbFunctions.Items.AddObject('UnsubscribeOfferBook',         TDLLMarketDataFunctionDetails.Create(MD_HAS_ASSET or MD_HAS_BOOK, False));

    cbFunctions.Items.AddObject('GetTheoreticalValues',         TDLLMarketDataFunctionDetails.Create(MD_HAS_ASSET, False));

    cbFunctions.Items.AddObject('GetAgentNameByID',             TDLLMarketDataFunctionDetails.Create(MD_HAS_AGENT, False));
    cbFunctions.Items.AddObject('GetAgentShortNameByID',        TDLLMarketDataFunctionDetails.Create(MD_HAS_AGENT, False));
    cbFunctions.Items.AddObject('RequestTickerInfo',            TDLLMarketDataFunctionDetails.Create(MD_HAS_ASSET, False));
    cbFunctions.Items.AddObject('SubscribeAdjustHistory',       TDLLMarketDataFunctionDetails.Create(MD_HAS_ASSET, False));
    cbFunctions.Items.AddObject('UnsubscribeAdjustHistory',     TDLLMarketDataFunctionDetails.Create(MD_HAS_ASSET, False));
    cbFunctions.Items.AddObject('GetServerClock',               TDLLMarketDataFunctionDetails.Create(0, False));
    cbFunctions.Items.AddObject('GetLastDailyClose',            TDLLMarketDataFunctionDetails.Create(MD_HAS_ASSET, False));
    cbFunctions.Items.AddObject('GetAgentNameLength',           TDLLMarketDataFunctionDetails.Create(MD_HAS_AGENT, False));
    cbFunctions.Items.AddObject('GetAgentName',                 TDLLMarketDataFunctionDetails.Create(MD_HAS_AGENT, False));

    cbFunctions.Items.AddObject('SendOrder',                    TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_SUB_ACCOUNT or RT_HAS_PASSWORD or RT_HAS_ASSET or RT_HAS_PRICE or RT_HAS_AMOUNT or RT_HAS_STOP or RT_HAS_ORDER_TYPE or RT_HAS_ORDER_SIDE, False));
    cbFunctions.Items.AddObject('SendChangeOrderV2',            TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_SUB_ACCOUNT or RT_HAS_PASSWORD or RT_HAS_PRICE or RT_HAS_AMOUNT or RT_HAS_STOP or RT_HAS_CL_ORDER_ID or RT_HAS_PROFIT_ID, False));
    cbFunctions.Items.AddObject('SendCancelOrderV2',            TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_SUB_ACCOUNT or RT_HAS_PASSWORD or RT_HAS_CL_ORDER_ID or RT_HAS_PROFIT_ID, False));
    cbFunctions.Items.AddObject('SendCancelOrdersV2',           TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_SUB_ACCOUNT or RT_HAS_PASSWORD or RT_HAS_ASSET, False));
    cbFunctions.Items.AddObject('SendCancelAllOrdersV2',        TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_SUB_ACCOUNT or RT_HAS_PASSWORD, False));
    cbFunctions.Items.AddObject('SendZeroPositionV2',           TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_SUB_ACCOUNT or RT_HAS_PASSWORD or RT_HAS_ASSET or RT_HAS_PRICE or RT_HAS_POSITION_TYPE or RT_HAS_ORDER_TYPE, False));
    cbFunctions.Items.AddObject('GetAccountCount',              TDLLTradingFunctionDetails.Create(0, False));
    cbFunctions.Items.AddObject('GetAccounts',                  TDLLTradingFunctionDetails.Create(RT_HAS_INDEX_RANGE, False));
    cbFunctions.Items.AddObject('GetAccountDetails',            TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_SUB_ACCOUNT, False));
    cbFunctions.Items.AddObject('GetAccountCountByBroker',      TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_SUB_ACCOUNT, False));
    cbFunctions.Items.AddObject('GetAccountsByBroker',          TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_SUB_ACCOUNT, False));
    cbFunctions.Items.AddObject('GetSubAccountCount',           TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT, False));
    cbFunctions.Items.AddObject('GetSubAccounts',               TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_INDEX_RANGE, False));
    cbFunctions.Items.AddObject('EnumerateAllPositionAssets',   TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_SUB_ACCOUNT, False));
    cbFunctions.Items.AddObject('GetPositionV2',                TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_SUB_ACCOUNT or RT_HAS_ASSET or RT_HAS_POSITION_TYPE, False));
    cbFunctions.Items.AddObject('GetOrderDetails',              TDLLTradingFunctionDetails.Create(RT_HAS_CL_ORDER_ID or RT_HAS_PROFIT_ID, False));

    cbFunctions.Items.AddObject('HasOrdersInInterval',          TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_DATE_RANGE, False));
    cbFunctions.Items.AddObject('EnumerateOrdersByInterval',    TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_SUB_ACCOUNT or RT_HAS_DATE_RANGE, False));
    cbFunctions.Items.AddObject('EnumerateAllOrders',           TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_SUB_ACCOUNT, False));

    cbFunctions.Items.AddObject('SendBuyOrder',                 TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_PASSWORD or RT_HAS_ASSET or RT_HAS_PRICE or RT_HAS_AMOUNT, True, 'SendOrder'));
    cbFunctions.Items.AddObject('SendSellOrder',                TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_PASSWORD or RT_HAS_ASSET or RT_HAS_PRICE or RT_HAS_AMOUNT, True, 'SendOrder'));
    cbFunctions.Items.AddObject('SendStopBuyOrder',             TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_PASSWORD or RT_HAS_ASSET or RT_HAS_PRICE or RT_HAS_AMOUNT or RT_HAS_STOP, True, 'SendOrder'));
    cbFunctions.Items.AddObject('SendStopSellOrder',            TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_PASSWORD or RT_HAS_ASSET or RT_HAS_PRICE or RT_HAS_AMOUNT or RT_HAS_STOP, True, 'SendOrder'));
    cbFunctions.Items.AddObject('SendChangeOrder',              TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_PASSWORD or RT_HAS_ASSET or RT_HAS_PRICE or RT_HAS_AMOUNT or RT_HAS_CL_ORDER_ID, True, 'SendChangeOrderV2'));
    cbFunctions.Items.AddObject('SendCancelOrder',              TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_PASSWORD or RT_HAS_ASSET or RT_HAS_CL_ORDER_ID, True, 'SendCancelOrderV2'));
    cbFunctions.Items.AddObject('SendCancelOrders',             TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_PASSWORD or RT_HAS_ASSET, True, 'SendCancelOrdersV2'));
    cbFunctions.Items.AddObject('SendCancelAllOrders',          TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_PASSWORD or RT_HAS_ASSET, True, 'SendCancelAllOrdersV2'));
    cbFunctions.Items.AddObject('SendZeroPosition',             TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_PASSWORD or RT_HAS_ASSET or RT_HAS_PRICE, True, 'SendZeroPositionV2'));
    cbFunctions.Items.AddObject('GetAccount',                   TDLLTradingFunctionDetails.Create(0, True, 'GetAccountCount / GetAccounts / GetAccountDetails'));
    cbFunctions.Items.AddObject('GetOrder',                     TDLLTradingFunctionDetails.Create(RT_HAS_CL_ORDER_ID or RT_HAS_PROFIT_ID, True, 'GetOrderDetails'));
    cbFunctions.Items.AddObject('GetOrderProfitID',             TDLLTradingFunctionDetails.Create(RT_HAS_CL_ORDER_ID or RT_HAS_PROFIT_ID, True, 'GetOrderDetails'));
    cbFunctions.Items.AddObject('GetPosition',                  TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT, True, 'GetPositionV2'));
    cbFunctions.Items.AddObject('SendMarketSellOrder',          TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_PASSWORD or RT_HAS_ASSET or RT_HAS_AMOUNT, True, 'SendOrder'));
    cbFunctions.Items.AddObject('SendMarketBuyOrder',           TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_PASSWORD or RT_HAS_ASSET or RT_HAS_AMOUNT, True, 'SendOrder'));
    cbFunctions.Items.AddObject('SendZeroPositionAtMarket',     TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_PASSWORD or RT_HAS_ASSET, True, 'SendZeroPositionV2'));

    cbFunctions.Items.AddObject('GetOrders',                    TDLLTradingFunctionDetails.Create(RT_HAS_ACCOUNT or RT_HAS_DATE_RANGE, True, 'EnumerateOrdersByInterval / EnumerateAllOrders'));

    cbFunctions.Items.AddObject('SetDayTrade',                  TDLLFunctionDetails.Create(ftConfig, False));
    cbFunctions.Items.AddObject('SetEnabledLogToDebug',         TDLLFunctionDetails.Create(ftConfig, False));
    cbFunctions.Items.AddObject('SetEnabledHistOrder',          TDLLFunctionDetails.Create(ftConfig, False));
    cbFunctions.Items.AddObject('SetServerAndPort',             TDLLFunctionDetails.Create(ftConfig, False));
  finally
    cbFunctions.Items.EndUpdate;
    cbFunctions.ItemIndex:= 0;
    cbFunctions.OnChange(nil);
  end;
end;

procedure TfrmClient.btnExecuteClick(Sender: TObject);
var
  sText: String;
  nRes: Int64;
  sRes: String;
  pRes: Pointer;
begin
  // executa cada funcao da dll //

  sText:= cbFunctions.Items.Strings[cbFunctions.ItemIndex];
  if cbFunctions.ItemIndex <> -1 then
  begin
    nRes:= -1;
    sRes:= EmptyStr;
    pRes:= nil;
    mmFunc.Lines.Clear;

    if sText = 'SubscribeTicker' then
      nRes:= SubscribeTicker(PWideChar(edtTickerMd.Text),PWideChar(cbBolsaMd.Items.Strings[cbBolsaMd.ItemIndex]))
    else if sText = 'UnsubscribeTicker' then
      nRes:= UnsubscribeTicker(PWideChar(edtTickerMd.Text),PWideChar(cbBolsaMd.Items.Strings[cbBolsaMd.ItemIndex]))
    else if sText = 'SubscribePriceBook' then
      nRes := DoSubscribePriceBook
    else if sText = 'UnsubscribePriceBook' then
      nRes:= DoUnsubscribePriceBook
    else if sText = 'SubscribeOfferBook' then
      nRes:= SubscribeOfferBook(PWideChar(edtTickerMd.Text),PWideChar(cbBolsaMd.Items.Strings[cbBolsaMd.ItemIndex]))
    else if sText = 'UnsubscribeOfferBook' then
      nRes:= UnsubscribeOfferBook(PWideChar(edtTickerMd.Text),PWideChar(cbBolsaMd.Items.Strings[cbBolsaMd.ItemIndex]))
    else if sText = 'GetAgentNameByID' then
      sRes:= GetAgentNameByID(edtAgentId.Value)
    else if sText = 'GetAgentShortNameByID' then
      sRes:= GetAgentShortNameByID(edtAgentId.Value)
    else if sText = 'GetAgentName' then
      nRes:= DoGetAgentName(edtAgentId.Value, False)
    else if sText = 'GetAgentNameLength' then
      nRes:= GetAgentNameLength(edtAgentId.Value, 0)

    else if sText = 'SendBuyOrder' then
      nRes:= SendBuyOrder(PWideChar(edtBrokerAccRot.Text),PWideChar(edtBrokerIdRot.Text),
                   PWideChar(edtPassRot.Text), PWideChar(edtTickerRot.Text),
                   PWideChar(cbBolsaRot.Items.Strings[cbBolsaRot.ItemIndex]),
                   StrToFloat(edtPriceRot.Text), StrToInt(edtAmountRot.Text))
    else if sText = 'SendSellOrder' then
      nRes:= SendSellOrder(PWideChar(edtBrokerAccRot.Text),PWideChar(edtBrokerIdRot.Text),
                   PWideChar(edtPassRot.Text), PWideChar(edtTickerRot.Text),
                   PWideChar(cbBolsaRot.Items.Strings[cbBolsaRot.ItemIndex]),
                   StrToFloat(edtPriceRot.Text), StrToInt(edtAmountRot.Text))
    else if sText = 'SendStopBuyOrder' then
      nRes:= SendStopBuyOrder(PWideChar(edtBrokerAccRot.Text),PWideChar(edtBrokerIdRot.Text),
                       PWideChar(edtPassRot.Text), PWideChar(edtTickerRot.Text),
                       PWideChar(cbBolsaRot.Items.Strings[cbBolsaRot.ItemIndex]),
                       StrToFloat(edtPriceRot.Text), StrToFloat(edtPriceStopRot.Text),
                       StrToInt(edtAmountRot.Text))
    else if sText = 'SendStopSellOrder' then
      nRes:= SendStopSellOrder(PWideChar(edtBrokerAccRot.Text),PWideChar(edtBrokerIdRot.Text),
                       PWideChar(edtPassRot.Text), PWideChar(edtTickerRot.Text),
                       PWideChar(cbBolsaRot.Items.Strings[cbBolsaRot.ItemIndex]),
                       StrToFloat(edtPriceRot.Text), StrToFloat(edtPriceStopRot.Text),
                       StrToInt(edtAmountRot.Text))
    else if sText = 'SendChangeOrder' then
      nRes:= SendChangeOrder(PWideChar(edtBrokerAccRot.Text), PWideChar(edtBrokerIdRot.Text),
                      PWideChar(edtPassRot.Text), PWideChar(edtClOrdIdRot.Text),
                      StrToFloat(edtPriceRot.Text), StrToInt(edtAmountRot.Text))
    else if sText = 'SendCancelOrder' then
      nRes:= SendCancelOrder(PWideChar(edtBrokerAccRot.Text), PWideChar(edtBrokerIdRot.Text),
                      PWideChar(edtClOrdIdRot.Text), PWideChar(edtPassRot.Text))
    else if sText = 'SendCancelOrders' then
      nRes:= SendCancelOrders(PWideChar(edtBrokerAccRot.Text), PWideChar(edtBrokerIdRot.Text),
                       PWideChar(edtPassRot.Text), PWideChar(edtTickerRot.Text),
                       PWideChar(cbBolsaRot.Items.Strings[cbBolsaRot.ItemIndex]))
    else if sText = 'SendCancelAllOrders' then
      nRes:= SendCancelAllOrders(PWideChar(edtBrokerAccRot.Text), PWideChar(edtBrokerIdRot.Text),
                          PWideChar(edtPassRot.Text))
    else if sText = 'SendZeroPosition' then
      nRes:= SendZeroPosition(PWideChar(edtBrokerAccRot.Text), PWideChar(edtBrokerIdRot.Text),
                       PWideChar(edtTickerRot.Text), PWideChar(cbBolsaRot.Items.Strings[cbBolsaRot.ItemIndex]),
                       PWideChar(edtPassRot.Text), StrToFloat(edtPriceRot.Text))
    else if sText = 'SendZeroPositionAtMarket' then
      nRes:= SendZeroPositionAtMarket(PWideChar(edtBrokerAccRot.Text), PWideChar(edtBrokerIdRot.Text),
                       PWideChar(edtTickerRot.Text), PWideChar(cbBolsaRot.Items.Strings[cbBolsaRot.ItemIndex]),
                       PWideChar(edtPassRot.Text))
    else if sText = 'SendMarketSellOrder' then
      nRes:= SendMarketSellOrder(PWideChar(edtBrokerAccRot.Text), PWideChar(edtBrokerIdRot.Text),
                   PWideChar(edtPassRot.Text), PWideChar(edtTickerRot.Text),
                   PWideChar(cbBolsaRot.Items.Strings[cbBolsaRot.ItemIndex]), StrToInt(edtAmountRot.Text))
    else if sText = 'SendMarketBuyOrder' then
      nRes:= SendMarketBuyOrder(PWideChar(edtBrokerAccRot.Text), PWideChar(edtBrokerIdRot.Text),
                   PWideChar(edtPassRot.Text), PWideChar(edtTickerRot.Text),
                   PWideChar(cbBolsaRot.Items.Strings[cbBolsaRot.ItemIndex]), StrToInt(edtAmountRot.Text))
    else if sText = 'GetAccount' then
      nRes:= GetAccount()
    else if sText = 'GetOrders' then
      nRes:= GetOrders(PWideChar(edtBrokerAccRot.Text), PWideChar(edtBrokerIdRot.Text),
                PWideChar(DateToStr(dateStartRot.Date)), PWideChar(DateToStr(dateEndRot.Date)))
    else if sText = 'GetOrder' then
      nRes:= GetOrder(PWideChar(edtClOrdIdRot.Text))
    else if sText = 'GetOrderProfitID' then
      nRes:= GetOrderProfitID(StrToInt(edtProfitIdRot.Text))
    else if sText = 'GetPosition' then
      pRes:= GetPosition(PWideChar(edtBrokerAccRot.Text), PWideChar(edtBrokerIdRot.Text),
                  PWideChar(edtTickerRot.Text), PWideChar(cbBolsaRot.Items.Strings[cbBolsaRot.ItemIndex]))
    else if sText = 'GetHistoryTrades' then
      nRes:= GetHistoryTrades(PWideChar(edtTickerMd.Text), PWideChar(cbBolsaMd.Items.Strings[cbBolsaMd.ItemIndex]),
                       PWideChar(DateTimeToStr(dateStartMd.DateTime)),
                       PWideChar(DateTimeToStr(dateEndMd.DateTime)))
    else if sText = 'GetSerieHistory' then
      nRes:= GetSerieHistory(PWideChar(edtTickerMd.Text), PWideChar(cbBolsaMd.Items.Strings[cbBolsaMd.ItemIndex]),
                       PWideChar(DateTimeToStr(dateStartMd.DateTime)),
                       PWideChar(DateTimeToStr(dateEndMd.DateTime)), 0, 0)
    else if sText = 'RequestTickerInfo' then
      nRes:= RequestTickerInfo(PWideChar(edtTickerMd.Text), PWideChar(cbBolsaMd.Items.Strings[cbBolsaMd.ItemIndex]))
    else if sText = 'SubscribeAdjustHistory' then
      nRes:= SubscribeAdjustHistory(PWideChar(edtTickerMd.Text), PWideChar(cbBolsaMd.Items.Strings[cbBolsaMd.ItemIndex]))
    else if sText = 'UnsubscribeAdjustHistory' then
      nRes:= UnsubscribeAdjustHistory(PWideChar(edtTickerMd.Text), PWideChar(cbBolsaMd.Items.Strings[cbBolsaMd.ItemIndex]))
    else if sText = 'GetServerClock' then
      ServerClock(sText)
    else if sText = 'GetLastDailyClose' then
      LastDailyClose(sText)
    else if sText = 'GetTheoreticalValues' then
      nRes := DoGetTheoreticalValues
    else if sText = 'SendOrder' then
      nRes := DoSendOrder
    else if sText = 'SendChangeOrderV2' then
      nRes := DoSendChangeOrderV2
    else if sText = 'SendCancelOrderV2' then
      nRes := DoSendCancelOrderV2
    else if sText = 'SendCancelOrdersV2' then
      nRes := DoSendCancelOrdersV2
    else if sText = 'SendCancelAllOrdersV2' then
      nRes := DoSendCancelAllOrdersV2
    else if sText = 'SendZeroPositionV2' then
      nRes := DoSendZeroPositionV2
    else if sText = 'GetAccountCount' then
      nRes := DoGetAccountCount
    else if sText = 'GetAccounts' then
      nRes := DoGetAccounts
    else if sText = 'GetAccountDetails' then
      nRes := DoGetAccountDetails
    else if sText = 'GetAccountsByBroker' then
      nRes := DoGetAccountsByBroker
    else if sText = 'GetAccountCountByBroker' then
      nRes := DoGetAccountCountByBroker
    else if sText = 'GetSubAccountCount' then
      nRes := DoGetSubAccountCount
    else if sText = 'GetSubAccounts' then
      nRes := DoGetSubAccounts
    else if sText = 'GetPositionV2' then
      nRes := DoGetPositionV2
    else if sText = 'GetOrderDetails' then
      nRes := DoGetOrderDetails
    else if sText = 'HasOrdersInInterval' then
      nRes := DoHasOrdersInInterval
    else if sText = 'EnumerateOrdersByInterval' then
      nRes := DoEnumerateOrdersByInterval
    else if sText = 'EnumerateAllOrders' then
      nRes := DoEnumerateAllOrders
    else if sText = 'EnumerateAllPositionAssets' then
      nRes := DoEnumerateAllPositionAssets;

    if nRes <> -1 then
      mmFunc.Lines.Add(sText + ': ' + NResultToString(nRes))
    else if sRes <> EmptyStr then
      mmFunc.Lines.Add(Format(sText + ': %s', [sRes]))
    else if pRes <> nil then
    begin
      mmFunc.Lines.Add(Format(sText + ': %s', [DecryptArrayPosition(pRes)]));
    end;
  end;
end;

function TfrmClient.GetAccountID : TConnectorAccountIdentifier;
begin
  Result.Version := 0;
  Result.BrokerID      := StrToIntDef(edtBrokerIdRot.Text, -1);
  Result.AccountID     := PWideChar(Trim(edtBrokerAccRot.Text));
  Result.Reserved      := -1;

  if EdtSubAccountID.Enabled
    then Result.SubAccountID := PWideChar(Trim(EdtSubAccountID.Text))
    else Result.SubAccountID := '';
end;

function TfrmClient.GetAssetIDRot : TConnectorAssetIdentifier;
begin
  Result.Version := 0;
  Result.Ticker   := PWideChar(Trim(edtTickerRot.Text));
  Result.Exchange := PWideChar(Trim(cbBolsaRot.Text));
  Result.FeedType := 0;
end;

function TfrmClient.GetAssetIDMD : TConnectorAssetIdentifier;
begin
  Result.Version := 0;
  Result.Ticker   := PWideChar(Trim(edtTickerMd.Text));
  Result.Exchange := PWideChar(Trim(cbBolsaMd.Text));
  Result.FeedType := 0;
end;

function TfrmClient.GetOrderID : TConnectorOrderIdentifier;
begin
  Result.Version := 0;
  Result.LocalOrderID := StrToInt64Def(edtProfitIdRot.Text, -1);
  Result.ClOrderID    := PWideChar(Trim(edtClOrdIdRot.Text));
end;

function TfrmClient.DoSubscribePriceBook : Integer;
var
  AssetID : TConnectorAssetIdentifier;
begin
  AssetID := GetAssetIDMD;

  Result := SubscribePriceDepth(@AssetID);
end;

function TfrmClient.DoUnsubscribePriceBook : Integer;
var
  AssetID : TConnectorAssetIdentifier;
begin
  AssetID := GetAssetIDMD;

  Result := UnsubscribePriceDepth(@AssetID);
end;

function TfrmClient.DoGetTheoreticalValues : Integer;
var
  AssetID : TConnectorAssetIdentifier;
  dPrice  : Double;
  nQtd    : Int64;
begin
  AssetID := GetAssetIDMD;

  Result := GetTheoreticalValues(@AssetID, dPrice, nQtd);

  if Result = NL_OK then
    GenericLogUpdate(Format('GetTheoreticalValues: %s:%s | %n %d', [AssetID.Ticker, AssetID.Exchange, dPrice, nQtd]));
end;

function TfrmClient.DoSendOrder : Int64;
var
  pSendOrder : TConnectorSendOrder;
begin
  pSendOrder.Version := 1;

  pSendOrder.AccountID := GetAccountID;
  pSendOrder.AssetID   := GetAssetIDRot;
  pSendOrder.Password  := PWideChar(edtPassRot.Text);

  case cbOrderSide.ItemIndex of
    0 : pSendOrder.OrderSide := Byte(cosBuy);
    1 : pSendOrder.OrderSide := Byte(cosSell);
  end;

  case cbOrderType.ItemIndex of
    0 : pSendOrder.OrderType := Byte(cotLimit);
    1 : pSendOrder.OrderType := Byte(cotStopLimit);
    2 : pSendOrder.OrderType := Byte(cotMarket);
  end;

  // mercado
  if pSendOrder.OrderType <> Byte(cotMarket)
    then pSendOrder.Price := StrToFloatDef(edtPriceRot.Text, -1)
    else pSendOrder.Price := -1;

  if pSendOrder.OrderType = Byte(cotStopLimit)
    then pSendOrder.StopPrice := StrToFloatDef(edtPriceStopRot.Text, -1)
    else pSendOrder.StopPrice := -1;

  pSendOrder.Quantity := StrToInt64Def(edtAmountRot.Text, -1);

  Result := SendOrder(@pSendOrder);
end;

function TfrmClient.DoSendChangeOrderV2 : Integer;
var
  pChangeOrder : PConnectorChangeOrder;
begin
  New(pChangeOrder);
  try
    pChangeOrder.Version := 0;

    pChangeOrder.AccountID := GetAccountID;
    pChangeOrder.OrderID   := GetOrderID;
    pChangeOrder.Password  := PWideChar(edtPassRot.Text);
    pChangeOrder.Price     := StrToFloatDef(edtPriceRot.Text, -1);
    pChangeOrder.StopPrice := StrToFloatDef(edtPriceStopRot.Text, -1);
    pChangeOrder.Quantity  := StrToInt64(edtAmountRot.Text);

    Result := SendChangeOrderV2(pChangeOrder);
  finally
    Dispose(pChangeOrder);
  end;
end;

function TfrmClient.DoSendCancelOrderV2 : Integer;
var
  pCancelOrder : PConnectorCancelOrder;
begin
  New(pCancelOrder);
  try
    pCancelOrder.Version := 0;

    pCancelOrder.AccountID := GetAccountID;
    pCancelOrder.OrderID   := GetOrderID;
    pCancelOrder.Password  := PWideChar(edtPassRot.Text);

    Result := SendCancelOrderV2(pCancelOrder);
  finally
    Dispose(pCancelOrder);
  end;
end;

function TfrmClient.DoSendCancelOrdersV2 : Integer;
var
  pCancelOrder : PConnectorCancelOrders;
begin
  New(pCancelOrder);
  try
    pCancelOrder.Version := 0;

    pCancelOrder.AccountID := GetAccountID;
    pCancelOrder.AssetID   := GetAssetIDRot;
    pCancelOrder.Password  := PWideChar(edtPassRot.Text);

    Result := SendCancelOrdersV2(pCancelOrder);
  finally
    Dispose(pCancelOrder);
  end;
end;

function TfrmClient.DoSendCancelAllOrdersV2 : Integer;
var
  pCancelOrder : PConnectorCancelAllOrders;
begin
  New(pCancelOrder);
  try
    pCancelOrder.Version := 0;

    pCancelOrder.AccountID := GetAccountID;
    pCancelOrder.Password  := PWideChar(edtPassRot.Text);

    Result := SendCancelAllOrdersV2(pCancelOrder);
  finally
    Dispose(pCancelOrder);
  end;
end;

function TfrmClient.DoSendZeroPositionV2 : Int64;
var
  pZeroPosition : PConnectorZeroPosition;
begin
  New(pZeroPosition);
  try
    pZeroPosition.Version := 1;

    pZeroPosition.AccountID := GetAccountID;
    pZeroPosition.AssetID   := GetAssetIDRot;
    pZeroPosition.Password  := PWideChar(edtPassRot.Text);

    pZeroPosition.PositionType := cbPositionType.ItemIndex + 1;

    // mercado
    if cbOrderType.ItemIndex <> 2
      then pZeroPosition.Price := StrToFloat(edtPriceRot.Text)
      else pZeroPosition.Price := -1;

    Result := SendZeroPositionV2(pZeroPosition);
  finally
    Dispose(pZeroPosition);
  end;
end;

function TfrmClient.DoGetAccountCount : Integer;
begin
  Result := GetAccountCount;
end;

function TfrmClient.DoGetAccounts : Integer;
var
  arAccountID : Array of TConnectorAccountIdentifierOut;
  nLength     : Integer;
  nStart      : Integer;
  nIndex      : Integer;
begin
  nLength := StrToIntDef(edtTotalCount.Text, 0);
  nStart  := StrToIntDef(edtStartSource.Text, 0);

  SetLength(arAccountID, nLength);
  ZeroMemory(@arAccountID[0], nLength * SizeOf(TConnectorAccountIdentifierOut));

  nLength := GetAccounts(nStart, 0, nLength, @arAccountID[0]);

  for nIndex := 0 to nLength - 1 do
    mmUpdates.Lines.Add('GetAccounts[' + IntToStr(nIndex) + ']: ' + arAccountID[nIndex].BrokerID.ToString + ' | AccountID=' + Trim(arAccountID[nIndex].AccountID));

  Result := nLength;
end;

function TfrmClient.DoGetAccountDetails : Integer;
var
  Account : TConnectorTradingAccountOut;
begin
  ZeroMemory(@Account, SizeOf(Account));

  Account.Version := 1;
  Account.AccountID := GetAccountID;

  Result := GetAccountDetails(Account);

  if Result = NL_OK then
    begin
      Account.BrokerName   := PWideChar(StringOfChar(' ', Account.BrokerNameLength));
      Account.OwnerName    := PWideChar(StringOfChar(' ', Account.OwnerNameLength));
      Account.SubOwnerName := PWideChar(StringOfChar(' ', Account.SubOwnerNameLength));

      Result := GetAccountDetails(Account);

      if (Account.AccountFlags and CA_IS_SUB_ACCOUNT) = CA_IS_SUB_ACCOUNT
        then mmUpdates.Lines.Add('GetAccountDetails: ' + Account.BrokerName + ' | ' + Account.OwnerName + ' | ' + Account.SubOwnerName + ' | Type=' + IntToStr(Account.AccountType))
        else mmUpdates.Lines.Add('GetAccountDetails: ' + Account.BrokerName + ' | ' + Account.OwnerName                                + ' | Type=' + IntToStr(Account.AccountType));
    end;
end;

function TfrmClient.DoGetAccountCountByBroker : Integer;
var
  nBroker : Integer;
begin
  nBroker := StrToIntDef(edtBrokerIdRot.Text, 0);
  Result  := GetAccountCountByBroker(nBroker);
  if Result = NL_NOT_FOUND then
    begin
      Result := -1;
      mmUpdates.Lines.Add('GetAccountCountByBroker: Broker Not Found/Empty');
    end;
end;

function TfrmClient.DoGetAccountsByBroker : Integer;
var
  arAccountID : Array of TConnectorAccountIdentifierOut;
  nLength   : Integer;
  nStart    : Integer;
  nBrokerID : Integer;
  nTotalAcc : Integer;
  nIndex    : Integer;
begin
  nTotalAcc := DoGetAccountCountByBroker;

  if nTotalAcc > 0 then
    begin
      nBrokerID := StrToIntDef(edtBrokerIdRot.Text, 0);

      nLength := nTotalAcc;
      nStart  := StrToIntDef(edtStartSource.Text, 0);

      SetLength(arAccountID, nLength);
      ZeroMemory(@arAccountID[0], nLength * SizeOf(TConnectorAccountIdentifierOut));

      nLength := GetAccountsByBroker(nBrokerID, nStart, 0, nLength, @arAccountID[0]);

      for nIndex := 0 to nLength - 1 do
        mmUpdates.Lines.Add('GetAccountsByBroker[' + IntToStr(nIndex) + ']: ' + arAccountID[nIndex].BrokerID.ToString + ' | AccountID=' + Trim(arAccountID[nIndex].AccountID));

      Result := nLength;
    end
  else
    mmUpdates.Lines.Add('GetAccountsByBroker: Broker Not Found/Empty');
end;

function TfrmClient.DoGetSubAccountCount : Integer;
var
  AccountID : TConnectorAccountIdentifier;
begin
  AccountID := GetAccountID;

  Result := GetSubAccountCount(@AccountID);
end;

function TfrmClient.DoGetSubAccounts : Integer;
var
  MasterAccount : TConnectorAccountIdentifier;
  arAccountID : Array of TConnectorAccountIdentifierOut;
  nLength     : Integer;
  nStart      : Integer;
  nIndex      : Integer;
begin
  nLength := StrToIntDef(edtTotalCount.Text, 0);
  nStart  := StrToIntDef(edtStartSource.Text, 0);

  MasterAccount := GetAccountID;

  SetLength(arAccountID, nLength);
  ZeroMemory(@arAccountID[0], nLength * SizeOf(TConnectorAccountIdentifierOut));

  nLength := GetSubAccounts(@MasterAccount, nStart, 0, nLength, @arAccountID[0]);

  for nIndex := 0 to nLength - 1 do
    mmUpdates.Lines.Add('GetSubAccounts[' + IntToStr(nIndex) + ']: ' + arAccountID[nIndex].BrokerID.ToString + ' | AccountID=' + Trim(arAccountID[nIndex].AccountID) + ' | SubAccountID=' + Trim(arAccountID[nIndex].SubAccountID));

  Result := nLength;
end;

function TfrmClient.DoGetPositionV2 : Integer;
var
  Position : TConnectorTradingAccountPosition;
begin
  Position.Version := 2;

  Position.AccountID := GetAccountID;
  Position.AssetID   := GetAssetIDRot;

  Position.PositionType := cbPositionType.ItemIndex + 1;

  Result := GetPositionV2(Position);

  if Result = NL_OK then
    mmUpdates.Lines.Add('GetPositionV2: Qtd=' + Position.OpenQuantity.ToString + ' Price=' + Position.OpenAveragePrice.ToString + ' Side=' + Position.OpenSide.ToString + ' LastEvent=' + Position.EventID.ToString);
end;

function TfrmClient.DoGetOrderDetails : Integer;
var
  Order : TConnectorOrderOut;
begin
  ZeroMemory(@Order, SizeOf(Order));

  Order.Version := 1;
  Order.OrderID := GetOrderID;

  Result := GetOrderDetails(Order);

  if Result = NL_OK then
    mmUpdates.Lines.Add('GetOrderDetails: Price=' + Order.Price.ToString);
end;

function TfrmClient.DoGetAgentName(a_nValue : Integer; a_bShort : Boolean) : Integer;
var
  nSize    : Integer;
  strAgent : String;
  nFlag    : Cardinal;
begin
  if a_bShort
    then nFlag := CM_IS_SHORT_NAME
    else nFlag := 0;

  nSize := GetAgentNameLength(a_nValue, nFlag);
  strAgent := StringOfChar(' ', nSize);

  Result := GetAgentName(nSize, a_nValue, PWideChar(strAgent), nFlag);

  if (Result = NL_OK)
    then mmUpdates.Lines.Add('GetAgentName: Agent=' + strAgent)
    else mmUpdates.Lines.Add('GetAgentName: Erro ao buscar=' + NResultToString(Result));

end;

function TfrmClient.DoHasOrdersInInterval : Integer;
var
  AccID   : TConnectorAccountIdentifier;
  dtStart : TSystemTime;
  dtEnd   : TSystemTime;
const
  c_OrderVersion : Byte = 0;
begin
  AccID := GetAccountID;

  DateTimeToSystemTime(DateOf(dateStartRot.DateTime), dtStart);
  DateTimeToSystemTime(DateOf(dateEndRot.DateTime), dtEnd);

  Result := HasOrdersInInterval(@AccID, dtStart, dtEnd);
end;

function EnumOrders(const a_Order : PConnectorOrder; const a_Param : LPARAM) : BOOL; stdcall;
var
  frmInstance : TfrmClient;
  strAccount  : String;
  strAsset    : String;
  strOrderId  : String;
begin
  // recebemos a instância do form que nos foi enviada pelo DoEnumerateOrdersByInterval/DoEnumerateAllOrders
  frmInstance := TfrmClient(a_Param);

  if a_Order.OrderID.ClOrderID = ''
    then strOrderId := a_Order.OrderID.LocalOrderID.ToString
    else strOrderId := a_Order.OrderID.ClOrderID;

  strAccount := a_Order.AccountID.BrokerID.ToString + ':' + a_Order.AccountID.AccountID;

  if a_Order.AccountID.SubAccountID <> '' then
    strAccount := strAccount + ':' + a_Order.AccountID.SubAccountID;

  strAsset := String(a_Order.AssetID.Ticker) + ':' + String(a_Order.AssetID.Exchange);

  frmInstance.mmUpdates.Lines.Add(Format('EnumOrders: %s | %s | %s | %f | %d', [strOrderId, strAccount, strAsset, a_Order.Price, a_Order.Quantity]));

  // continuanos até o final
  Result := True;
end;

function TfrmClient.DoEnumerateOrdersByInterval : Integer;
var
  AccID   : TConnectorAccountIdentifier;
  dtStart : TSystemTime;
  dtEnd   : TSystemTime;
const
  c_OrderVersion : Byte = 1; // Versão da estrutura a ser enviada
begin
  AccID := GetAccountID;

  DateTimeToSystemTime(dateStartRot.DateTime, dtStart);
  DateTimeToSystemTime(dateEndRot.DateTime, dtEnd);

  // passamos a intância do form para o EnumOrders no a_Param
  Result := EnumerateOrdersByInterval(@AccID, 0, dtStart, dtEnd, LPARAM(Self), EnumOrders);

  mmUpdates.Lines.Add('EnumerateOrdersByInterval : Concluído');
end;

function EnumAssets(const a_Asset : TConnectorAssetIdentifier; const a_Param : LPARAM) : BOOL; stdcall;
var
  frmInstance : TfrmClient;
begin
  // recebemos a instância do form que nos foi enviada pelo DoEnumerateAllPositionAssets
  frmInstance := TfrmClient(a_Param);

  frmInstance.mmUpdates.Lines.Add(Format('EnumAssets: %s | %s | %d', [a_Asset.Ticker, a_Asset.Exchange, a_Asset.FeedType]));

  // continuanos até o final
  Result := True;
end;

function TfrmClient.DoEnumerateAllOrders : Integer;
var
  AccID : TConnectorAccountIdentifier;
const
  c_OrderVersion : Byte = 1; // Versão da estrutura a ser enviada
begin
  AccID := GetAccountID;

  Result := EnumerateAllOrders(@AccID, c_OrderVersion, LPARAM(Self), EnumOrders);

  mmUpdates.Lines.Add('EnumerateAllOrders : Concluído');
end;

function TfrmClient.DoEnumerateAllPositionAssets : Integer;
var
  AccID    : TConnectorAccountIdentifier;                   
begin
  AccID := GetAccountID;

  Result := EnumerateAllPositionAssets(@AccID, 0, LPARAM(Self), EnumAssets);

  mmUpdates.Lines.Add('EnumerateAllPositionAssets : Concluído');
end;

procedure TfrmClient.cbFunctionsChange(Sender: TObject);
var
  fdFunction : TDLLFunctionDetails;
begin
  // muda a tab com os componentes necessarios //

  if cbFunctions.ItemIndex <> -1 then
    begin
      fdFunction:= TDLLFunctionDetails(cbFunctions.Items.Objects[cbFunctions.ItemIndex]);

      btnExecute.Enabled := (fdFunction.FunctionType <> ftConfig);
      lblDeprecated.Visible := fdFunction.IsDeprecated;
      lblDeprecated.Caption := 'Função deprecada. Nova função: ' + fdFunction.NewFunction;

      case fdFunction.FunctionType of
        ftTrading    : pcType.ActivePage:= tabRot;
        ftMarketData : pcType.ActivePage:= tabMd;
        ftConfig     : pcType.ActivePage:= tabConfig;
      end;

      EnableDisableControls(pcType.ActivePage, cbFunctions.Items.Strings[cbFunctions.ItemIndex]);
    end;
end;

procedure GenericLogUpdate(AValue: String);
begin
  if not (csDestroying in frmClient.ComponentState) then
    frmClient.mmUpdates.Lines.Add(AValue);
end;

procedure TfrmClient.ServerClock(AText: String);
var
  lDate: TDateTime;
  lYear, lMonth, lDay, lHour, lMin, lSec, lMilisec: Integer;
  lData: TDateTime;
  nRes: Cardinal;
begin
  nRes:= GetServerClock(lDate, lYear, lMonth, lDay, lHour, lMin, lSec, lMilisec);

  mmFunc.Lines.Add(Format(AText + ': 0x%x | %s', [nRes, DateTimeToStr(lData)]));
end;

procedure TfrmClient.LastDailyClose(AText: String);
var
  lClose: Double;
  nRes: Cardinal;
begin
  lClose:= 0;
  nRes:= GetLastDailyClose(PWideChar(edtTickerMd.Text), PWideChar(cbBolsaMd.Items.Strings[cbBolsaMd.ItemIndex]),
                           lClose, 1);
  mmFunc.Lines.Add(Format(AText + ': 0x%x | %n', [nRes, lClose]))
end;

procedure TfrmClient.CopyMemoryToString(var ADest: String; Source: Pointer;
  Length: NativeUInt);
var
  iIndex  : Integer;
  pMyArray : PByteArray;
begin
  if Length > 0 then
    begin
      pMyArray := Source;
      SetLength(ADest, Length);
      For iIndex := 1 to Length do
        ADest[iIndex] := Chr(pMyArray[iIndex - 1]);
    end
  else
    ADest:= '';
end;

function TfrmClient.DecryptArrayPosition(AData: Pointer): String;
type
  TBrokerOrderSide = (bosUnknown = 0, bosBuy=1, bosSell=2);
var
  nQtd      : Integer;
  nTam      : Integer;
  nIndex    : Integer;
  nStart    : Integer;
  sAux      : String;
  sResult   : String;
  nLength   : Word;
  pBuffer   : PByteArray;
begin
  pBuffer := AData;
  nQtd    := pBuffer[0];
  nTam    := PInteger(@pBuffer[4])^;
  nStart  := 8;
  sResult := EmptyStr;
  for nIndex := 0 to nQtd - 1 do
  begin
    //////////////////////////////////////////////////////////////////
    // Copia a ID corretora
    sAux := IntToStr(PInteger(@pBuffer[nStart])^);
    nStart := nStart + 4;
    sResult:= sAux + '|';

    //////////////////////////////////////////////////////////////////
    // Copia a string de Conta
    nLength := PWord(@pBuffer[nStart])^;
    nStart  := nStart + 2;

    SetLength(sAux, nLength);
    if nLength > 0 then
      CopyMemoryToString(sAux, @pBuffer[nStart], nLength);
    nStart := nStart + nLength;
    sResult:= sResult + sAux + '|';

    //////////////////////////////////////////////////////////////////
    // Copia a string do Titular
    nLength := PWord(@pBuffer[nStart])^;;
    nStart  := nStart + 2;

    SetLength(sAux, nLength);
    if nLength > 0 then
      CopyMemoryToString(sAux, @pBuffer[nStart], nLength);
    nStart := nStart + nLength;
    sResult:= sResult + sAux + '|';

    //////////////////////////////////////////////////////////////////
    // Copia a string do Ticker
    nLength := PWord(@pBuffer[nStart])^;;
    nStart  := nStart + 2;

    SetLength(sAux, nLength);
    if nLength > 0 then
      CopyMemoryToString(sAux, @pBuffer[nStart], nLength);
    nStart := nStart + nLength;
    sResult:= sResult + sAux + '|';

    //////////////////////////////////////////////////////////////////
    // Copia TodayPosition nQtd
    sAux := IntToStr(PInteger(@pBuffer[nStart])^);
    nStart := nStart + 4;
    sResult:= sResult + sAux + '|';

    //////////////////////////////////////////////////////////////////
    // Copia TodayPosition sPrice
    sAux := FloatToStr(PDouble(@pBuffer[nStart])^);
    nStart := nStart + 8;
    sResult:= sResult + sAux + '|';

    //utilizado no Day
    //////////////////////////////////////////////////////////////////////
    // Salva SellAvgPriceToday
    sAux := FloatToStr(PDouble(@pBuffer[nStart])^);
    nStart := nStart + 8;

    //////////////////////////////////////////////////////////////////////
    // Salva SellQtdToday
    sAux := IntToStr(PInteger(@pBuffer[nStart])^);
    nStart := nStart + 4;

    //////////////////////////////////////////////////////////////////////
    // Salva BuyAvgPriceToday
    sAux := FloatToStr(PDouble(@pBuffer[nStart])^);
    nStart := nStart + 8;


    //////////////////////////////////////////////////////////////////////
    // Salva BuyQtdToday
    sAux := IntToStr(PInteger(@pBuffer[nStart])^);
    nStart := nStart + 4;

    //Custodia
    //////////////////////////////////////////////////////////////////////
    // Salva Quantidade em D+1
    sAux := IntToStr(PInteger(@pBuffer[nStart])^);
    nStart := nStart + 4;

    //////////////////////////////////////////////////////////////////////
    // Salva Quantidade em D+2
    sAux := IntToStr(PInteger(@pBuffer[nStart])^);
    nStart := nStart + 4;

    //////////////////////////////////////////////////////////////////////
    // Salva Quantidade em D+3
    sAux := IntToStr(PInteger(@pBuffer[nStart])^);
    nStart := nStart + 4;

    //////////////////////////////////////////////////////////////////////
    // Salva Quantidade bloqueada
    sAux := IntToStr(PInteger(@pBuffer[nStart])^);
    nStart := nStart + 4;

    //////////////////////////////////////////////////////////////////////
    // Salva Quantidade Pending
    sAux := IntToStr(PInteger(@pBuffer[nStart])^);
    nStart := nStart + 4;

    //////////////////////////////////////////////////////////////////////
    // Salva Quantidade alocada
    sAux := IntToStr(PInteger(@pBuffer[nStart])^);
    nStart := nStart + 4;
    sResult:= sResult + sAux + '|';

    //////////////////////////////////////////////////////////////////////
    // Salva Quantidade provisionada
    sAux := IntToStr(PInteger(@pBuffer[nStart])^);
    nStart := nStart + 4;
    sResult:= sResult + sAux + '|';

    //////////////////////////////////////////////////////////////////////
    // Salva Quantidade da posição
    sAux := IntToStr(PInteger(@pBuffer[nStart])^);
    nStart := nStart + 4;
    sResult:= sResult + sAux + '|';

    //////////////////////////////////////////////////////////////////////
    // Salva Quantidade Disponível
    sAux := IntToStr(PInteger(@pBuffer[nStart])^);
    nStart := nStart + 4;
    sResult:= sResult + sAux + '|';

    //////////////////////////////////////////////////////////////////////
    // Salva Lado da posição
    case TBrokerOrderSide(PByte(@pBuffer[nStart])^) of
      bosSell: sResult := sResult + 'Vendido|';
      bosBuy:  sResult := sResult + 'Comprado|';
    else
      sResult := sResult +'Unknown|';
    end;
   end;
   FreePointer(AData,nTam);
   Result:= sResult;
end;

procedure TfrmClient.EnableDisableControls(ATab: TTabSheet; AItem: String);
var
  nIndex : Integer;
  mdFunction : TDLLMarketDataFunctionDetails;
  rtFunction : TDLLTradingFunctionDetails;
begin
  for nIndex := 0 to ATab.ControlCount - 1 do
    ATab.Controls[nIndex].Enabled:= false;

  // defs //
  lbTitleRot.Enabled := True;
  lbTitleMd.Enabled  := True;
  lbTitleCfg.Enabled := True;

  // cond //
  if ATab = tabMd then
    begin
      mdFunction := TDLLMarketDataFunctionDetails(cbFunctions.Items.Objects[cbFunctions.ItemIndex]);

      lbTickerMd.Enabled      := mdFunction.HasAsset;
      edtTickerMd.Enabled     := mdFunction.HasAsset;
      lbBolsaMd.Enabled       := mdFunction.HasAsset;
      cbBolsaMd.Enabled       := mdFunction.HasAsset;

      lblOffset.Enabled       := mdFunction.HasSerie;
      edtOffset.Enabled       := mdFunction.HasSerie;
      lblIntervalType.Enabled := mdFunction.HasSerie;
      cbIntervalType.Enabled  := mdFunction.HasSerie;
      lblFactor.Enabled       := mdFunction.HasSerie;
      edtFactor.Enabled       := mdFunction.HasSerie;
      lblAdjustType.Enabled   := mdFunction.HasSerie;
      cbAdjustType.Enabled    := mdFunction.HasSerie;

      lbAgentIdMd.Enabled     := mdFunction.HasAgent;
      edtAgentId.Enabled      := mdFunction.HasAgent;

      lbDateStartMd.Enabled   := mdFunction.HasDateRange;
      dateStartMd.Enabled     := mdFunction.HasDateRange;
      edtQuoteIDStart.Enabled := mdFunction.HasQuoteIDRange;
      lbDateEndMd.Enabled     := mdFunction.HasDateRange;
      dateEndMd.Enabled       := mdFunction.HasDateRange;
      edtQuoteIDEnd.Enabled   := mdFunction.HasQuoteIDRange;

      edtBookPos.Enabled      := mdFunction.HasBook;
      mmBookPos.Enabled       := mdFunction.HasBook;
      btnBookPos.Enabled      := mdFunction.HasBook;
      cbBookSide.Enabled      := mdFunction.HasBook;
    end
  else if ATab = tabRot then
    begin
      rtFunction := TDLLTradingFunctionDetails(cbFunctions.Items.Objects[cbFunctions.ItemIndex]);

      lbContaRot.Enabled      := rtFunction.HasAccount;
      edtBrokerAccRot.Enabled := rtFunction.HasAccount;
      lbBrokerIdRot.Enabled   := rtFunction.HasAccount;
      edtBrokerIdRot.Enabled  := rtFunction.HasAccount;
      lblSubAccount.Enabled   := rtFunction.HasSubAccount;
      edtSubAccountID.Enabled := rtFunction.HasSubAccount;

      lbPassRot.Enabled       := rtFunction.HasPassword;
      edtPassRot.Enabled      := rtFunction.HasPassword;

      lbTickerRot.Enabled     := rtFunction.HasAsset;
      edtTickerRot.Enabled    := rtFunction.HasAsset;
      lbBolsaRot.Enabled      := rtFunction.HasAsset;
      cbBolsaRot.Enabled      := rtFunction.HasAsset;

      lbPriceRot.Enabled      := rtFunction.HasPrice;
      edtPriceRot.Enabled     := rtFunction.HasPrice;
      lbAmountRot.Enabled     := rtFunction.HasAmount;
      edtAmountRot.Enabled    := rtFunction.HasAmount;
      lbPriceStopRot.Enabled  := rtFunction.HasStop;
      edtPriceStopRot.Enabled := rtFunction.HasStop;

      lblPositionType.Enabled := rtFunction.HasPositionType;
      cbPositionType.Enabled  := rtFunction.HasPositionType;

      cbOrderType.Enabled     := rtFunction.HasOrderType;
      cbOrderSide.Enabled     := rtFunction.HasOrderSide;

      if cbOrderType.Enabled then
        begin
          lbPriceRot.Enabled  := cbOrderType.ItemIndex <> 2;
          edtPriceRot.Enabled := lbPriceRot.Enabled;

          lbPriceStopRot.Enabled  := cbOrderType.ItemIndex = 1;
          edtPriceStopRot.Enabled := cbOrderType.ItemIndex = 1;
        end;

      lbClOrdIdRot.Enabled    := rtFunction.HasClOrderId;
      edtClOrdIdRot.Enabled   := rtFunction.HasClOrderId;
      lbProfitIdRot.Enabled   := rtFunction.HasProfitId;
      edtProfitIdRot.Enabled  := rtFunction.HasProfitId;

      lbDateStartRot.Enabled  := rtFunction.HasDateRange;
      dateStartRot.Enabled    := rtFunction.HasDateRange;
      lbDateEndRot.Enabled    := rtFunction.HasDateRange;
      dateEndRot.Enabled      := rtFunction.HasDateRange;

      lblStartSource.Enabled  := rtFunction.HasIndexRange;
      edtStartSource.Enabled  := rtFunction.HasIndexRange;
      lblTotalCount.Enabled   := rtFunction.HasIndexRange;
      edtTotalCount.Enabled   := rtFunction.HasIndexRange;
    end;
end;

destructor TfrmClient.Destroy;
begin
  if Self.Connected then
    DLLFinalize;
  FreeAndNil(FConnection);
  FreeAndNil(FListBuyOfferBook);
  FreeAndNil(FListSellOfferBook);
  inherited;
end;

procedure TfrmClient.ConnectionNotify(Sender: TObject; const Item: Integer; Action: TCollectionNotification);
var
  info, md, rot: integer;
begin
  if not (Sender is TDictionary<TConnStateType, Integer>) then
    Exit;

  (Sender as TDictionary<TConnStateType, Integer>).TryGetValue(cstMarketData, md);
  (Sender as TDictionary<TConnStateType, Integer>).TryGetValue(cstInfo, info);
  (Sender as TDictionary<TConnStateType, Integer>).TryGetValue(cstRoteamento, rot);

  imgRotOff.Visible:= (rot = 0);
  imgInfoOff.Visible:= (info = 0);
  imgMdOff.Visible:= (md = 0);

  imgRotOn.Visible:= (rot = 1);
  imgInfoOn.Visible:= (info = 1);
  imgMdOn.Visible:= (md = 1);

  btnInitialize.Enabled:= not ((md=1) and (info=1));
  btnFinalize.Enabled  := not ((md=0) and (info=0));
end;

procedure TfrmClient.btnClearUpdatesClick(Sender: TObject);
begin
  mmUpdates.Lines.BeginUpdate;
  try
    mmUpdates.Lines.Clear;
  finally
    mmUpdates.Lines.EndUpdate;
  end;
end;

procedure TfrmClient.LoadImages;
begin
  imgList.GetBitmap(0, imgMdOff.Picture.Bitmap);
  imgMdOff.Refresh;
  imgList.GetBitmap(0, imgInfoOff.Picture.Bitmap);
  imgInfoOff.Refresh;
  imgList.GetBitmap(0, imgRotOff.Picture.Bitmap);
  imgRotOff.Refresh;

  imgList.GetBitmap(1, imgMdOn.Picture.Bitmap);
  imgMdOn.Refresh;
  imgList.GetBitmap(1, imgInfoOn.Picture.Bitmap);
  imgInfoOn.Refresh;
  imgList.GetBitmap(1, imgRotOn.Picture.Bitmap);
  imgRotOn.Refresh;
end;

procedure TfrmClient.btnBookPosClick(Sender: TObject);
var
  lstBook       : TList;
  AssetID       : TConnectorAssetIdentifier;
  pPrice        : PConnectorPriceGroup;
  Offer         : PGroupOffer;
  nPosition     : Integer;
  dTheoricPrice : Double;
  dTheroicQty   : Int64;
begin
  nPosition := StrToIntDef(edtBookPos.Text, 0);

  if nPosition >= 0 then
    begin
      if cbFunctions.Items.Strings[cbFunctions.ItemIndex].Contains('PriceBook') then
        begin
          AssetID := GetAssetIDMD;

          New(pPrice);
          pPrice.Version := 0;

          if GetPriceGroup(@AssetID, cbBookSide.ItemIndex, nPosition, pPrice) = NL_OK then
            begin
              if pPrice.PriceGroupFlags and PG_IS_THEORIC = PG_IS_THEORIC then
                begin
                  if GetTheoreticalValues(@AssetID, dTheoricPrice, dTheroicQty) = NL_OK then
                    pPrice.Price := dTheoricPrice;
                end;

              mmBookPos.Text := 'Asset' +
                #13#10 + ' Ação=(Button)' +
                #13#10 + ' PosiçãoUp=' + IntToStr(nPosition) +
                #13#10 + ' Side=' + cbBookSide.Text +
                #13#10 + ' Qtd=' + IntToStr(pPrice.Quantity) +
                #13#10 + ' Count=' + IntToStr(pPrice.Count) +
                #13#10 + ' Price=' + FloatToStr(pPrice.Price);
            end;
        end
      else if cbFunctions.Items.Strings[cbFunctions.ItemIndex].Contains('OfferBook') then
        begin
            if cbBookSide.ItemIndex = 0
              then lstBook := ListBuyOfferBook
              else lstBook := ListSellOfferBook;

            if nPosition < lstBook.Count then
              begin
                Offer:= lstBook.Items[lstBook.Count - 1 - nPosition];

                mmBookPos.Text := ' Posição='          + IntToStr(Offer.nPosition) +
                  #13#10 + ' Side='    + cbBookSide.Text +
                  #13#10 + ' Qtd='     + IntToStr(Offer.nQtd) +
                  #13#10 + ' Agent='   + IntToStr(Offer.nAgent) +
                  #13#10 + ' Offer='   + IntToStr(Offer.nOfferID) +
                  #13#10 + ' Price='   + FloatToStr(Offer.sPrice) +
                  #13#10 + ' Date='    + Offer.strDtOffer;
              end;
        end;
    end;
end;

procedure TfrmClient.cbOrderTypeChange(Sender: TObject);
begin
  if cbOrderType.Enabled then
    begin
      lbPriceRot.Enabled  := cbOrderType.ItemIndex <> 2;
      edtPriceRot.Enabled := lbPriceRot.Enabled;

      lbPriceStopRot.Enabled  := cbOrderType.ItemIndex = 1;
      edtPriceStopRot.Enabled := cbOrderType.ItemIndex = 1;
    end;
end;

procedure TfrmClient.DecryptOfferArray(ASouce: Pointer; ATarget: TList; out nQtd : Integer; out nTam : Integer; out bLast : Boolean);
var
  nIndex    : Integer;
  nStart    : Integer;
  strAux    : String;
  nLength   : Word;
  pBuffer   : PByteArray;
  Offer     : PGroupOffer;
  nFlags    : Cardinal;
const
  OB_LAST_PACKET : Cardinal = 1;
begin
  for nIndex := 0 to ATarget.Count - 1 do
    begin
      Offer := ATarget[nIndex];
      Dispose(Offer);
    end;
  ATarget.Clear;

  pBuffer := ASouce;
  nQtd := PInteger(@pBuffer[0])^;
  nTam := PInteger(@pBuffer[4])^;
  nStart := 8;
  for nIndex := 0 to nQtd - 1 do
    begin
      New(Offer);
      //////////////////////////////////////////////////////////////////
      // Copia sPrice
      Offer.sPrice := PDouble(@pBuffer[nStart])^;
      nStart       := nStart + 8;

      //////////////////////////////////////////////////////////////////
      // Copia nQtd
      Offer.nQtd := PInteger(@pBuffer[nStart])^;
      nStart     := nStart + 4;

      //////////////////////////////////////////////////////////////////
      // Copia nAgent
      Offer.nAgent := PInteger(@pBuffer[nStart])^;
      nStart       := nStart + 4;

      //////////////////////////////////////////////////////////////////
      // Copia nOfferID
      Offer.nOfferID := PInt64(@pBuffer[nStart])^;
      nStart         := nStart + 8;

      //////////////////////////////////////////////////////////////////
      // Copia dtOffer
      nLength := PWord(@pBuffer[nStart])^;
      nStart  := nStart + 2;

      SetLength(strAux, nLength);
      if nLength > 0 then
        CopyMemoryToString(strAux, @pBuffer[nStart], nLength);
      nStart := nStart + nLength;

      Offer.strDtOffer := strAux;

      ATarget.Add(Offer);
    end;

  nFlags := PCardinal(@pBuffer[nStart])^;
  nStart := nStart + 4;

  FreePointer(ASouce, nStart);

  bLast := ((nFlags and OB_LAST_PACKET) = OB_LAST_PACKET);
end;

procedure TfrmClient.DecryptOfferArrayV2(ASouce: Pointer; ATarget: TList; out nQtd : Integer; out nTam : Integer; out bLast : Boolean);
var
  nIndex    : Integer;
  nStart    : Integer;
  strAux    : String;
  nLength   : Word;
  pBuffer   : PByteArray;
  Offer     : PGroupOffer;
  nFlags    : Cardinal;
const
  OB_LAST_PACKET : Cardinal = 1;
begin
  for nIndex := 0 to ATarget.Count - 1 do
    begin
      Offer := ATarget[nIndex];
      Dispose(Offer);
    end;
  ATarget.Clear;

  pBuffer := ASouce;
  nQtd := PInteger(@pBuffer[0])^;
  nTam := PInteger(@pBuffer[4])^;
  nStart := 8;
  for nIndex := 0 to nQtd - 1 do
    begin
      New(Offer);
      //////////////////////////////////////////////////////////////////
      // Copia sPrice
      Offer.sPrice := PDouble(@pBuffer[nStart])^;
      nStart       := nStart + 8;

      //////////////////////////////////////////////////////////////////
      // Copia nQtd
      Offer.nQtd := PInt64(@pBuffer[nStart])^;
      nStart     := nStart + 8;

      //////////////////////////////////////////////////////////////////
      // Copia nAgent
      Offer.nAgent := PInteger(@pBuffer[nStart])^;
      nStart       := nStart + 4;

      //////////////////////////////////////////////////////////////////
      // Copia nOfferID
      Offer.nOfferID := PInt64(@pBuffer[nStart])^;
      nStart         := nStart + 8;

      //////////////////////////////////////////////////////////////////
      // Copia dtOffer
      nLength := PWord(@pBuffer[nStart])^;
      nStart  := nStart + 2;

      SetLength(strAux, nLength);
      if nLength > 0 then
        CopyMemoryToString(strAux, @pBuffer[nStart], nLength);
      nStart := nStart + nLength;

      Offer.strDtOffer := strAux;

      ATarget.Add(Offer);
    end;
  nFlags := PCardinal(@pBuffer[nStart])^;
  nStart := nStart + 4;

  FreePointer(ASouce, nStart);

  bLast := ((nFlags and OB_LAST_PACKET) = OB_LAST_PACKET);
end;

procedure UpdateOfferBook(nVersion : Integer; rAssetID : TAssetIDRec ; nAction, nPosition, Side, nQtd, nAgent : Integer; nOfferID : Int64; sPrice : Double; bHasPrice, bHasQtd, bHasDate, bHasOfferID, bHasAgent : Char; pwcDate : PWideChar; pArraySell, pArrayBuy : Pointer);
var
  lBook    : TList;
  Group    : PGroupOffer;
  iIndex   : Integer;
  nBookLen : Integer;
  nMemSize : Integer;
  bLast    : Boolean;
begin
  with frmClient do
    begin
      GenericLogUpdate(Format('UpdateOfferBook V%d: %s | Side=%d | Action=%d', [nVersion, rAssetID.pchTicker, Side, nAction]));

      if Assigned(pArraySell) then
        begin
          case nVersion of
            1 : DecryptOfferArray(pArraySell, ListSellOfferBook, nBookLen, nMemSize, bLast);
            2 : DecryptOfferArrayV2(pArraySell, ListSellOfferBook, nBookLen, nMemSize, bLast);
          end;

          GenericLogUpdate(Format('UpdateOfferBook V%d: %s | Sell | BookLen=%d | MemSize=%d | Last=%s', [nVersion, rAssetID.pchTicker, nBookLen, nMemSize, BoolToStr(bLast, True)]));
        end;
      if Assigned(pArrayBuy) then
        begin
          case nVersion of
            1 : DecryptOfferArray(pArrayBuy, ListBuyOfferBook, nBookLen, nMemSize, bLast);
            2 : DecryptOfferArrayV2(pArrayBuy, ListBuyOfferBook, nBookLen, nMemSize, bLast);
          end;

          GenericLogUpdate(Format('UpdateOfferBook V%d: %s | Buy | BookLen=%d | MemSize=%d | Last=%s', [nVersion, rAssetID.pchTicker, nBookLen, nMemSize, BoolToStr(bLast, True)]));
        end;

      if Side = 0
        then lBook := ListBuyOfferBook
        else lBook := ListSellOfferBook;

      Case TConnectorActionType(nAction) of
        atAdd:         begin
                          if (lBook <> nil) and (nPosition >= 0) and (nPosition <= lBook.Count) then
                            begin
                              New(Group);
                              Group.nOfferID   := nOfferID;
                              Group.nAgent     := nAgent;
                              Group.nQtd       := nQtd;
                              Group.nPosition  := nPosition;
                              Group.sPrice     := sPrice;
                              Group.strDtOffer := pwcDate;
                              //////////////////////////////////////////////////////////////////////////
                              // Cria a oferta
                              lBook.Insert(lBook.Count - nPosition, Group);
                            end
                       end;

        atDelete:      begin
                         //////////////////////////////////////////////////////////////////////////////
                        // Pega a oferta
                        if (lBook <> nil) and (nPosition >= 0) and (nPosition < lBook.Count) then
                          begin
                            //////////////////////////////////////////////////////////////////////////
                            // Apaga a oferta
                            Group := lBook.Items[lBook.Count - 1 - nPosition];
                            Dispose(Group);
                            lBook.Delete(lBook.Count - 1 - nPosition);
                          end
                       end;

        atDeleteFrom:  begin
                          //////////////////////////////////////////////////////////////////////////////
                          // Pega a oferta
                          if (lBook <> nil) and (nPosition >= 0) and (nPosition < lBook.Count) then
                            begin
                              //////////////////////////////////////////////////////////////////////////
                              // Apaga as ofertas
                              For iIndex := lBook.Count-1-nPosition to lBook.Count-1 do
                                begin
                                  Group := lBook.Items[iIndex];

                                  Dispose(Group);
                                end;
                              lBook.Count := lBook.Count-1-nPosition;
                            end
                       end;

        atEdit:        begin
                        //////////////////////////////////////////////////////////////////////////////
                        // Pega a oferta
                        if (lBook <> nil) and (nPosition >= 0) and (nPosition < lBook.Count) then
                          begin
                            Group    := lBook.Items[lBook.Count - 1 - nPosition];
                            //////////////////////////////////////////////////////////////////////////
                            // Atualiza a oferta
                            if Boolean(bHasQtd) then
                              Group.nQtd := Group.nQtd + nQtd;
                            if Boolean(bHasPrice) then
                              Group.sPrice := Group.sPrice;
                            if Boolean(bHasDate) then
                              Group.strDtOffer := pwcDate;
                            if Boolean(bHasAgent) then
                              Group.nAgent := nAgent;
                            if Boolean(bHasOfferID) then
                              Group.nOfferID := nOfferID;
                          end;
                       end;
      end;

      if (nPosition = StrToInt(edtBookPos.Text)) and ((lBook.Count - 1 - nPosition) > 0) then
        begin
          Group  := lBook.Items[lBook.Count - 1 - nPosition];
          mmBookPos.Text := rAssetID.pchTicker + #13#10 + ' Ação=' + IntToStr(nAction) +
                                                 #13#10 + ' PosiçãoUp=' + IntToStr(nPosition) +
                                                 #13#10 + ' Posição=' + IntToStr(Group.nPosition) +
                                                 #13#10 + ' Side=' + IntToStr(Side) +
                                                 #13#10 + ' Qtd=' + IntToStr(Group.nQtd) +
                                                 #13#10 + ' Agent=' + IntToStr(Group.nAgent) +
                                                 #13#10 + ' Offer=' + IntToStr(Group.nOfferID) +
                                                 #13#10 + ' Price=' + FloatToStr(Group.sPrice) +
                                                 #13#10 + ' Date=' + Group.strDtOffer;
        end;
    end;
end;

{ TDLLFunctionDetails }

constructor TDLLFunctionDetails.Create(const a_ftFunctionType : TDLLFunctionType; const a_bIsDeprecated : Boolean; const a_strNewFunction : String = '');
begin
  inherited Create;

  m_ftFunctionType := a_ftFunctionType;
  m_bIsDeprecated  := a_bIsDeprecated;
  m_strNewFunction := a_strNewFunction;
end;

function HasFlag(const a_nField : Cardinal; const a_nFlag : Cardinal) : Boolean; inline;
begin
  Result := a_nField and a_nFlag = a_nFlag;
end;

constructor TDLLMarketDataFunctionDetails.Create(const a_nControlFlags : Cardinal; const a_bIsDeprecated : Boolean; const a_strNewFunction : String = '');
begin
  inherited Create(ftMarketData, a_bIsDeprecated, a_strNewFunction);

  m_bHasAsset        := HasFlag(a_nControlFlags, MD_HAS_ASSET);
  m_bHasAgent        := HasFlag(a_nControlFlags, MD_HAS_AGENT);
  m_HasDateRange     := HasFlag(a_nControlFlags, MD_HAS_DATE_RANGE);
  m_bHasBook         := HasFlag(a_nControlFlags, MD_HAS_BOOK);
  m_bHasSerie        := HasFlag(a_nControlFlags, MD_HAS_SERIE);
  m_bHasQuoteIDRange := HasFlag(a_nControlFlags, MD_HAS_QUOTE_ID_RANGE);
end;

constructor TDLLTradingFunctionDetails.Create(const a_nControlFlags : Cardinal; const a_bIsDeprecated : Boolean; const a_strNewFunction : String = '');
begin
  inherited Create(ftTrading, a_bIsDeprecated, a_strNewFunction);

  m_bHasAccount      := HasFlag(a_nControlFlags, RT_HAS_ACCOUNT);
  m_bHasSubAccount   := HasFlag(a_nControlFlags, RT_HAS_SUB_ACCOUNT);
  m_bHasPassword     := HasFlag(a_nControlFlags, RT_HAS_PASSWORD);
  m_bHasAsset        := HasFlag(a_nControlFlags, RT_HAS_ASSET);
  m_bHasPrice        := HasFlag(a_nControlFlags, RT_HAS_PRICE);
  m_bHasAmount       := HasFlag(a_nControlFlags, RT_HAS_AMOUNT);
  m_bHasStop         := HasFlag(a_nControlFlags, RT_HAS_STOP);
  m_bHasPositionType := HasFlag(a_nControlFlags, RT_HAS_POSITION_TYPE);
  m_bHasOrderType    := HasFlag(a_nControlFlags, RT_HAS_ORDER_TYPE);
  m_bHasOrderSide    := HasFlag(a_nControlFlags, RT_HAS_ORDER_SIDE);
  m_bHasClOrderId    := HasFlag(a_nControlFlags, RT_HAS_CL_ORDER_ID);
  m_bHasProfitId     := HasFlag(a_nControlFlags, RT_HAS_PROFIT_ID);
  m_bHasDateRange    := HasFlag(a_nControlFlags, RT_HAS_DATE_RANGE);
  m_bHasIndexRange   := HasFlag(a_nControlFlags, RT_HAS_INDEX_RANGE);
end;

end.
