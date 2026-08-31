using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Threading;
using System.IO;

namespace ProfitDLLClient;

public partial class DLLConnector
{
    private static readonly Timer clockTimer = new(_ => ServerClockPrint(), null, TimeSpan.Zero, TimeSpan.FromSeconds(1));

    #region Reader Functions

    private static long ReadInt64(string caption)
    {
        long retVal;

        do
        {
            WriteSync(caption);
        } while (!long.TryParse(Console.ReadLine(), out retVal));

        return retVal;
    }

    private static int ReadInt32(string caption)
    {
        int retVal;

        do
        {
            WriteSync(caption);
        } while (!int.TryParse(Console.ReadLine(), out retVal));

        return retVal;
    }

    private static double ReadDouble(string caption)
    {
        double retVal;

        do
        {
            WriteSync(caption);
        } while (!double.TryParse(Console.ReadLine(), out retVal));

        return retVal;
    }

    private static T ReadEnum<T>(string caption) where T : struct, Enum
    {
        T retVal;

        var names = Enum.GetNames<T>();

        for (int i = 0; i < names.Length; i++)
        {
            WriteLineSync($"{i}: {names[i]}");
        }

        int index;
        do
        {
            index = ReadInt32(caption);
        } while (!Enum.TryParse(names[index], out retVal));

        return retVal;
    }

    private static string ReadPassword()
    {
        Console.Write("Password: ");

        var retVal = "";
        while (true)
        {
            var keyInfo = Console.ReadKey(intercept: true);
            var key = keyInfo.Key;

            if (key == ConsoleKey.Enter)
            {
                break;
            }

            if (key == ConsoleKey.Backspace && retVal.Length > 0)
            {
                retVal = retVal[..^1];

                var (left, top) = Console.GetCursorPosition();
                Console.SetCursorPosition(left - 1, top);

                Console.Write(" ");
                Console.SetCursorPosition(left - 1, top);
            }
            else if (!char.IsControl(keyInfo.KeyChar))
            {
                Console.Write("*");
                retVal += keyInfo.KeyChar;
            }
        }

        Console.WriteLine();

        return retVal;
    }

    private static TConnectorAccountIdentifier ReadAccountId()
    {
        string input;

        do
        {
            Console.Write("Account Id (ex 1171:12345:1): ");
            input = Console.ReadLine();
        } while (!Regex.IsMatch(input, @"\d+:\d+(:\d+)?"));

        var numbers = input.Split(':');

        var retVal = new TConnectorAccountIdentifier()
        {
            Version = 0,
            BrokerID = int.Parse(numbers[0]),
            AccountID = numbers[1],
            SubAccountID = ""
        };

        if (numbers.Length == 3)
        {
            retVal.SubAccountID = numbers[2];
        }

        return retVal;
    }

    private static TConnectorAssetIdentifier ReadAssetID()
    {
        string input;
        Match match;

        do
        {
            Console.Write("Instrument (ex PETR4:B): ");
            input = Console.ReadLine().ToUpper();

            match = Regex.Match(input, "([^:]+):([A-Za-z0-9])");
        } while (!match.Success);

        return new TConnectorAssetIdentifier()
        {
            Version = 0,
            Ticker = match.Groups[1].Value,
            Exchange = match.Groups[2].Value
        };
    }

    #endregion

    #region Writer Functions

    private static readonly object writeLock = new();

    private static void WriteResultSync(string message, [CallerMemberName] string callerName = "")
    {
        lock (writeLock)
        {
            var color = Console.ForegroundColor;

            Console.ForegroundColor = ConsoleColor.Cyan;
            Console.Write(callerName);

            Console.ForegroundColor = color;
            Console.WriteLine($": {message}");
        }
    }

    private static void WriteLineSync(string text)
    {
        lock (writeLock)
        {
            Console.WriteLine(text);
        }
    }

    private static void WriteSync(string text)
    {
        lock (writeLock)
        {
            Console.Write(text);
        }
    }

    #endregion

    #region Callback Holders

    // C# GC collects delegates immediately after leaving the stack, so we need to hold their instances        
    private static readonly TAssetListInfoCallbackV2 _AssetListInfoCallbackV2 = new(AssetListInfoCallbackV2);
    private static readonly TStateCallback _StateCallback = new(StateCallback);
    private static readonly TProgressCallBack _ProgressCallBack = new (ProgressCallBack);
    private static readonly TNewDailyCallback _NewDailyCallback = new(NewDailyCallback);
    private static readonly TOfferBookCallbackV2 _OfferBookCallbackV2 = new(OfferBookCallbackV2);
    private static readonly TNewTinyBookCallBack _NewTinyBookCallBack = new(NewTinyBookCallBack);
    private static readonly TAccountCallback _AccountCallback = new(AccountCallback);
    private static readonly TConnectorBrokerAccountListCallback _BrokerAccountListCallback = new(BrokerAccountListChangedCallback);
    private static readonly TConnectorBrokerSubAccountListCallback _BrokerSubAccountListCallback = new(BrokerSubAccountListChangedCallback);
    private static readonly TChangeStateTickerCallback _ChangeStateTickerCallback = new(ChangeStateTickerCallback);
    private static readonly TTheoreticalPriceCallback _TheoreticalPriceCallback = new(TheoreticalPriceCallback);
    private static readonly TConnectorAssetPositionListCallback _AssetPositionListCallback = new(AssetPositionListCallback);
    private static readonly TAdjustHistoryCallbackV2 _AdjustHistoryCallbackV2 = new(AdjustHistoryCallbackV2);
    private static readonly TConnectorOrderCallback _OrderCallback = new(OrderCallback);
    private static readonly TConnectorAccountCallback _OrderHistoryCallback = new(OrderHistoryCallback);
    private static readonly TConnectorPriceDepthCallback _PriceDepthCallback = new(PriceDepthCallback);
    private static readonly TConnectorTradingMessageResultCallback _TradingMessageResultCallback = new(TradingMessageResultCallback);
    private static readonly TInvalidTickerCallback _InvalidTickerCallback = new(InvalidTickerCallback);
    private static readonly TConnectorTradeCallback _TradeCallback = new(TradeCallback);
    private static readonly TConnectorTradeCallback _TradeHistoryCallback = new(TradeHistoryCallback);

    #endregion

    #region Control Variables

    private static readonly List<TConnectorOffer> sellOfferList = [];
    private static readonly List<TConnectorOffer> buyOfferList = [];

    #endregion

    #region consts
    private const string ConnectorDateFormat = "dd/MM/yyyy HH:mm:ss.fff";
    #endregion

    #region Helper Funtions

    private static bool EvalNResult(long result, Delegate function)
    {
        if (result < 0)
        {
            WriteLineSync($"{function.Method.Name}: {(NResult)result}");
            return false;
        }
        else
        {
            return true;
        }
    }

    private static bool EvalNResult(NResult result, Delegate function)
    {
        if (result != NResult.NL_OK)
        {
            WriteLineSync($"{function.Method.Name}: {result}");
            return false;
        }
        else
        {
            return true;
        }
    }

    private static bool GetOrder(TConnectorOrderIdentifier orderId, out TConnectorOrderOut order)
    {
        order = new TConnectorOrderOut()
        {
            Version = 0,
            OrderID = orderId
        };

        if ((NResult)ProfitDLL.GetOrderDetails(ref order) != NResult.NL_OK) { return false; }

        order.AssetID.Ticker = new string(' ', order.AssetID.TickerLength);
        order.AssetID.Exchange = new string(' ', order.AssetID.ExchangeLength);
        order.TextMessage = new string(' ', order.TextMessageLength);

        if ((NResult)ProfitDLL.GetOrderDetails(ref order) != NResult.NL_OK) { return false; }

        return true;
    }

    #endregion

    public static void ServerClockPrint()
    {
        var result = (NResult)ProfitDLL.GetServerClock(out var _, out var year, out var month, out var day, out var hour, out var minute, out var second, out var millisecond);

        var serverClock = result == NResult.NL_OK ? new DateTime(year, month, day, hour, minute, second, millisecond) : DateTime.Now;

        Console.Title = $"{serverClock:G}";
    }

    private static DateTime ReadDateFromString2(BinaryReader reader)
    {
        var size = reader.ReadUInt16();

        var chars = reader.ReadChars(size);

        return DateTime.ParseExact(chars, ConnectorDateFormat, null);
    }

    public static void DoGetAccountsByBroker()
    {
        var brokerId = ReadInt32("Broker ID: ");

        var count = ProfitDLL.GetAccountCountByBroker(brokerId);

        if (!EvalNResult(count, ProfitDLL.GetAccountCountByBroker)) { return; }

        var accounts = new TConnectorAccountIdentifierOut[count];

        count = ProfitDLL.GetAccountsByBroker(brokerId, 0, 0, count, accounts);

        if (!EvalNResult(count, ProfitDLL.GetAccountCountByBroker)) { return; }

        foreach (var accountId in accounts.Take(count))
        {
            WriteResultSync(accountId.ToString());
        }
    }

    public static void DoGetAgentName()
    {
        var agentId = ReadInt32("Agent ID: ");
        var flags = ReadEnum<AgentNameFlags>("Name kind: ");

        var agentLength = ProfitDLL.GetAgentNameLength(agentId, flags);

        if (!EvalNResult(agentLength, ProfitDLL.GetAgentNameLength)) { return; }

        var agentName = new StringBuilder(agentLength);

        agentLength = ProfitDLL.GetAgentName(agentLength, agentId, agentName, flags);

        if (!EvalNResult(agentLength, ProfitDLL.GetAgentName)) { return; }

        WriteResultSync(agentName.ToString(0, agentLength));
    }

    public static void DoGetPositionInstruments()
    {
        static bool EnumAssets(in TConnectorAssetIdentifier assetId, nint param)
        {
            WriteResultSync($"{assetId}");

            return true;
        }

        var accountId = ReadAccountId();

        var result = (NResult)ProfitDLL.EnumerateAllPositionAssets(accountId, 0, 0, EnumAssets);

        EvalNResult(result, ProfitDLL.EnumerateAllPositionAssets);
    }

    private static void DoSubscribeInstrument()
    {
        var assetId = ReadAssetID();

        var result = (NResult)ProfitDLL.SubscribeTicker(assetId.Ticker, assetId.Exchange);

        if (!EvalNResult(result, ProfitDLL.SubscribeTicker)) { return; }

        WriteLineSync("Subscribe Instrument Successful");
    }

    private static void DoSubscribeOfferBook()
    {
        var assetId = ReadAssetID();

        var result = (NResult)ProfitDLL.SubscribeOfferBook(assetId.Ticker, assetId.Exchange);

        EvalNResult(result, ProfitDLL.SubscribeOfferBook);

        WriteLineSync("Subscribe MarketDepth Successful");
    }

    private static void DoSubscribePriceDepth()
    {
        var assetId = ReadAssetID();

        var result = (NResult)ProfitDLL.SubscribePriceDepth(assetId);

        EvalNResult(result, ProfitDLL.SubscribePriceDepth);

        WriteLineSync("Subscribe PriceDepth Successful");
    }

    private static void DoUnsubscribePriceDepth()
    {
        var assetId = ReadAssetID();

        var result = (NResult)ProfitDLL.UnsubscribePriceDepth(assetId);

        EvalNResult(result, ProfitDLL.UnsubscribePriceDepth);

        WriteLineSync("Unsubscribe PriceDepth Successful");
    }

    private static void DoUnsubscribeInstrument()
    {
        var assetId = ReadAssetID();

        var result = (NResult)ProfitDLL.UnsubscribeTicker(assetId.Ticker, assetId.Exchange);

        if (!EvalNResult(result, ProfitDLL.UnsubscribeTicker)) { return; }

        WriteLineSync("Unsubscribe Instrument Successful");
    }

    private static void DoRequestTradeHistory()
    {
        var assetId = ReadAssetID();

        var result = (NResult)ProfitDLL.GetHistoryTrades(assetId.Ticker, assetId.Exchange, DateTime.Today.ToString(ConnectorDateFormat), DateTime.Now.ToString(ConnectorDateFormat));

        if (!EvalNResult(result, ProfitDLL.GetHistoryTrades)) { return; }

        WriteLineSync("GetHistoryTrades Successful");
    }

    private static void DoSendOrder()
    {
        var sendOrder = new TConnectorSendOrder()
        {
            Version = 1,
            AssetID = ReadAssetID(),
            AccountID = ReadAccountId(),
            OrderSide = ReadEnum<TConnectorOrderSide>("Order Side: "),
            OrderType = ReadEnum<TConnectorOrderType>("Order Type: "),
            Quantity = ReadInt64("Quantity: "),
            Price = -1,
            StopPrice = -1
        };

        if (sendOrder.OrderType != TConnectorOrderType.Market)
        {
            sendOrder.Price = ReadDouble("Price: ");

            if (sendOrder.OrderType == TConnectorOrderType.Stop)
            {
                sendOrder.StopPrice = ReadDouble("Stop Price: ");
            }
        }

        sendOrder.Password = ReadPassword();

        var result = ProfitDLL.SendOrder(ref sendOrder);

        if (!EvalNResult(result, ProfitDLL.SendOrder)) { return; }

        WriteResultSync($"LocalOrderID={result} MessageID={sendOrder.MessageID}");
    }

    private static void DoGetPosition()
    {
        var assetId = ReadAssetID();
        var accountId = ReadAccountId();
        var positionType = ReadEnum<TConnectorPositionType>("Position type: ");

        var position = new TConnectorTradingAccountPosition()
        {
            Version = 1,
            AssetID = assetId,
            AccountID = accountId,
            PositionType = positionType
        };

        var result = (NResult)ProfitDLL.GetPositionV2(ref position);

        if (!EvalNResult(result, ProfitDLL.GetPositionV2)) { return; }

        WriteResultSync($" OpenPosition: {position.OpenSide} | {position.OpenAveragePrice} | {position.OpenQuantity}");
        WriteResultSync($"DailyPosition: {position.DailyAverageBuyPrice} | {position.DailyAverageSellPrice} | {position.DailyBuyQuantity} | {position.DailySellQuantity}");
    }

    private static void DoZeroPosition()
    {
        var assetId = ReadAssetID();
        var accountId = ReadAccountId();
        var positionType = ReadEnum<TConnectorPositionType>("Position type: ");

        var zeroOrder = new TConnectorZeroPosition()
        {
            Version = 2,
            AssetID = assetId,
            AccountID = accountId,
            PositionType = positionType,
            Password = ReadPassword(),
            Price = -1
        };

        var result = ProfitDLL.SendZeroPositionV2(ref zeroOrder);

        if (!EvalNResult(result, ProfitDLL.SendZeroPositionV2)) { return; }

        WriteResultSync($"LocalOrderID={result} | MessageID={zeroOrder.MessageID}");
    }

    private static void DoGetOrders()
    {
        var count = 0;

        bool EnumOrders(in TConnectorOrder a_Order, nint a_Param)
        {
            WriteResultSync(a_Order.ToString());

            if (a_Order.Quantity == 100) { count++; }

            return true;
        }

        var accountId = ReadAccountId();

        var result = (NResult)ProfitDLL.EnumerateOrdersByInterval(accountId, 1, SystemTime.FromDateTime(DateTime.Now.AddHours(-1)), SystemTime.FromDateTime(DateTime.Now.AddMinutes(-1)), 0, EnumOrders);

        if (!EvalNResult(result, ProfitDLL.EnumerateOrdersByInterval)) { return; }

        WriteResultSync($"Orders with 100 quantity: {count}");
    }

    private static void DoGetOrder()
    {
        WriteSync("LocalOrderID (leave empty if unknown): ");

        if (!long.TryParse(Console.ReadLine().Trim(), out var localOrderId))
        {
            localOrderId = -1;
        }

        WriteSync("ClOrderID (leave empty if unknown): ");

        var clOrderID = Console.ReadLine().Trim();

        var orderId = new TConnectorOrderIdentifier()
        {
            Version = 0,
            LocalOrderID = localOrderId,
            ClOrderID = clOrderID
        };

        if (!GetOrder(orderId, out var order)) { return; }

        WriteResultSync($"{order.AssetID} | {order.TradedQuantity} | {order.OrderSide} | {order.Price} | {order.AccountID} | {order.OrderID.ClOrderID} | {order.OrderSide} | {order.TextMessage}");
    }

    private static bool InitializeDLL(string key, string user, string password)
    {
        var result = (NResult)ProfitDLL.DLLInitializeLogin(
            key,
            user,
            password,
            _StateCallback,
            null, /* HistoryCallback, replaced by SetOrderHistoryCallback */
            null, /* OrderChangeCallback, replaced by SetOrderCallback */
            _AccountCallback,
            null, /* TradeCallback, replaced by SetTradeCallbackV2 */
            _NewDailyCallback,
            null, /* PriceBookCallback, replaced by SetPriceDepthCallback */
            null, /* OfferBookCallback, replaced by SetOfferBookCallbackV2 */
            null, /* HistoryTradeCallback, replaced by SetHistoryTradeCallbackV2 */
            _ProgressCallBack,
            _NewTinyBookCallBack
        );

        if (result != NResult.NL_OK)
        {
            WriteLineSync($"Initialization Error: {result}");
            return false;
        }
        else
        {
            if (!EvalNResult((NResult)ProfitDLL.SetPriceDepthCallback(_PriceDepthCallback), ProfitDLL.SetPriceDepthCallback)) { return false; }
            if (!EvalNResult((NResult)ProfitDLL.SetBrokerAccountListChangedCallback(_BrokerAccountListCallback), ProfitDLL.SetBrokerAccountListChangedCallback)) { return false; }
            if (!EvalNResult((NResult)ProfitDLL.SetBrokerSubAccountListChangedCallback(_BrokerSubAccountListCallback), ProfitDLL.SetBrokerSubAccountListChangedCallback)) { return false; }
            if (!EvalNResult((NResult)ProfitDLL.SetOrderCallback(_OrderCallback), ProfitDLL.SetOrderCallback)) { return false; }
            if (!EvalNResult((NResult)ProfitDLL.SetOrderHistoryCallback(_OrderHistoryCallback), ProfitDLL.SetOrderHistoryCallback)) { return false; }
            if (!EvalNResult((NResult)ProfitDLL.SetOfferBookCallbackV2(_OfferBookCallbackV2), ProfitDLL.SetOfferBookCallbackV2)) { return false; }
            if (!EvalNResult((NResult)ProfitDLL.SetAssetListInfoCallbackV2(_AssetListInfoCallbackV2), ProfitDLL.SetAssetListInfoCallbackV2)) { return false; }
            if (!EvalNResult((NResult)ProfitDLL.SetAdjustHistoryCallbackV2(_AdjustHistoryCallbackV2), ProfitDLL.SetAdjustHistoryCallbackV2)) { return false; }
            if (!EvalNResult((NResult)ProfitDLL.SetAssetPositionListCallback(_AssetPositionListCallback), ProfitDLL.SetAssetPositionListCallback)) { return false; }
            if (!EvalNResult((NResult)ProfitDLL.SetTradingMessageResultCallback(_TradingMessageResultCallback), ProfitDLL.SetTradingMessageResultCallback)) { return false; }
            if (!EvalNResult((NResult)ProfitDLL.SetInvalidTickerCallback(_InvalidTickerCallback), ProfitDLL.SetInvalidTickerCallback)) { return false; }
            if (!EvalNResult((NResult)ProfitDLL.SetTradeCallbackV2(_TradeCallback), ProfitDLL.SetHistoryTradeCallbackV2)) { return false; }
            if (!EvalNResult((NResult)ProfitDLL.SetHistoryTradeCallbackV2(_TradeHistoryCallback), ProfitDLL.SetHistoryTradeCallbackV2)) { return false; }
        }

        return true;
    }

    public static void Main()
    {
        Console.Write("Username: ");
        var user = Console.ReadLine();

        var password = ReadPassword();

        Console.Write("Activation Key (Optional): ");
        var key = Console.ReadLine();

        if (!InitializeDLL(key, user, password)) { return; }

        var terminate = false;
        while (!terminate)
        {
            WriteSync("Command: ");

            var input = Console.ReadLine();
            switch (input)
            {
                case "subscribe":
                    DoSubscribeInstrument();
                    break;
                case "unsubscribe":
                    DoUnsubscribeInstrument();
                    break;
                case "subscribe price depth":
                    DoSubscribePriceDepth();
                    break;
                case "unsubscribe price depth":
                    DoUnsubscribePriceDepth();
                    break;
                case "offerbook":
                    DoSubscribeOfferBook();
                    break;
                case "request history":
                    DoRequestTradeHistory();
                    break;
                case "send order":
                    DoSendOrder();
                    break;
                case "get position":
                    DoGetPosition();
                    break;
                case "zero position":
                    DoZeroPosition();
                    break;
                case "get orders":
                    DoGetOrders();
                    break;
                case "get accounts broker":
                    DoGetAccountsByBroker();
                    break;
                case "get agent name":
                    DoGetAgentName();
                    break;
                case "get position asset":
                    DoGetPositionInstruments();
                    break;
                case "get order":
                    DoGetOrder();
                    break;
                case "exit":
                    terminate = true;
                    break;
                case "clear":
                    Console.Clear();
                    break;
                default:
                    break;
            }
        }
    }
}
