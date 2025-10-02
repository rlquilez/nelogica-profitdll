# ProfitDLL - Python Integration Guide

**Complete integration guide for Nelogica's ProfitDLL with Python**

[Overview](#overview) • [Installation](#installation) • [Quick Start](#quick-start) • [How-to Guides](#how-to-guides) • [API Reference](#api-reference) • [Examples](#examples)

---

## 📋 Table of Contents

- [Overview](#overview)
- [Requirements and Installation](#requirements-and-installation)
- [Quick Start](#quick-start)
- [Core Concepts](#core-concepts)
- [How-to Guides](#how-to-guides)
- [API Reference](#api-reference)
- [Complete Examples](#complete-examples)
- [Troubleshooting](#troubleshooting)
- [Additional Resources](#additional-resources)

## 🎯 Overview

**ProfitDLL** is a library developed by Nelogica that enables external applications to integrate with market data and order routing services. This documentation provides a comprehensive guide for using ProfitDLL in Python applications.

### Key Features

- 📈 **Real-time Market Data**: Quotes, order book, trades
- 📊 **Historical Data**: Access to historical prices and volumes
- 🔄 **Order Routing**: Send, modify, and cancel orders
- 💰 **Position Management**: Query and manage positions
- 🏦 **Account Management**: Access to account and sub-account information

### Usage Modes

- **Full Routing**: Market data + order sending
- **Market Data Only**: Only market data (quotes, historical)

## 🛠 Requirements and Installation

### Prerequisites

- **Python 3.7+**
- **Windows** (DLL is Windows-specific)
- **License key** provided by Nelogica
- **Access credentials** (username and password)

### Installation

1. **Get the required files:**

   ```text
   ProfitDLL.dll        # Main library (32 or 64 bits)
   profit_dll.py        # Python wrapper
   profitTypes.py       # Type definitions
   ```

2. **Place files in your project:**

   ```text
   your_project/
   ├── ProfitDLL.dll
   ├── profit_dll.py
   ├── profitTypes.py
   └── main.py          # Your code
   ```

3. **Install dependencies:**

   ```bash
   # No external dependencies, only ctypes (built-in)
   ```

## 🚀 Quick Start

### Basic Example - Market Data

```python
from ctypes import WINFUNCTYPE, byref, c_int32, c_wchar_p
from profitTypes import *
from profit_dll import initializeDll

# Initialize DLL
profit_dll = initializeDll("./ProfitDLL.dll")

# Control variables
connected = False
market_connected = False

# Connection state callback
@WINFUNCTYPE(None, c_int32, c_int32)
def state_callback(connection_type, result):
    global connected, market_connected
    
    if connection_type == 0:  # Login
        if result == 0:
            connected = True
            print("✅ Login successful")
        else:
            print(f"❌ Login error: {result}")
    
    elif connection_type == 2:  # Market Data
        if result == 4:
            market_connected = True
            print("✅ Market Data connected")
        else:
            print(f"❌ Market Data error: {result}")

# Quote callback
@WINFUNCTYPE(None, TAssetID, c_double, c_int, c_int)
def ticker_callback(asset_id, price, quantity, side):
    side_name = "Buy" if side == 0 else "Sell"
    print(f"📊 {asset_id.ticker}: {price} - {quantity} ({side_name})")

# Initialize connection (Market Data only)
def main():
    key = "YOUR_LICENSE_KEY"
    user = "your_user@email.com"
    password = "your_password"
    
    result = profit_dll.DLLInitializeMarketLogin(
        c_wchar_p(key),
        c_wchar_p(user), 
        c_wchar_p(password),
        state_callback,     # StateCallback
        None,              # HistoryCallback  
        None,              # NewDailyCallback
        None,              # NewTradeCallback
        None,              # TheoreticalPriceCallback
        None,              # NewHistoryCallback
        None,              # ProgressCallback
        ticker_callback    # TinyBookCallback
    )
    
    if result == 0:
        print("🔄 Initializing connection...")
        
        # Wait for connection
        while not (connected and market_connected):
            pass
            
        # Subscribe to quotes
        profit_dll.SubscribeTicker(c_wchar_p("PETR4"), c_wchar_p("B"))
        
        # Keep application running
        input("Press Enter to exit...")
        
    else:
        print(f"❌ Initialization error: {result}")
    
    # Finalize
    profit_dll.DLLFinalize()

if __name__ == "__main__":
    main()
```

## 🧠 Core Concepts

### Callbacks and Threading

> ⚠️ **IMPORTANT**: All callbacks execute in a separate thread (`ConnectorThread`).

**Fundamental rules:**
- ✅ **Do**: Quick processing in callbacks
- ✅ **Do**: Store data and process in another thread
- ❌ **Avoid**: Time-consuming operations (I/O, database)
- ❌ **Never**: Call DLL functions inside callbacks

```python
import queue
import threading

# Thread-safe queue for data
data_queue = queue.Queue()

@WINFUNCTYPE(None, TAssetID, c_double, c_int, c_int)
def safe_ticker_callback(asset_id, price, quantity, side):
    # ✅ Fast: just add to queue
    data_queue.put({
        'ticker': asset_id.ticker,
        'price': price,
        'quantity': quantity,
        'side': side,
        'timestamp': time.time()
    })

def data_processor():
    """Process data in separate thread"""
    while True:
        try:
            data = data_queue.get(timeout=1)
            # ✅ Heavy processing here
            save_to_database(data)
            calculate_indicators(data)
        except queue.Empty:
            continue
```

### Main Data Types

#### Asset

```python
# Asset identification
asset = TConnectorAssetIdentifier(
    Version=0,
    Ticker="PETR4",      # Asset symbol
    Exchange="B",        # Exchange (B=Bovespa, C=CME, etc.)
    FeedType=0          # Data source (0=Nelogica)
)
```

#### Account

```python
# Account identification
account = TConnectorAccountIdentifier(
    Version=0,
    BrokerID=123,           # Broker ID
    AccountID="12345",      # Account number
    SubAccountID="001",     # Sub-account (optional)
    Reserved=0
)
```

#### Order

```python
# Order sending
order = TConnectorSendOrder(
    Version=0,
    Password="routing_password",
    OrderType=TConnectorOrderType.Limit.value,  # Limit order
    OrderSide=TConnectorOrderSide.Buy.value,    # Buy
    Price=25.50,
    StopPrice=-1,        # -1 for limit orders
    Quantity=100
)
```

## 📖 How-to Guides

### 1. Connecting to ProfitDLL

#### Connection with Routing (Market Data + Orders)

```python
def connect_with_routing():
    """Connects with full functionality"""
    
    result = profit_dll.DLLInitializeLogin(
        c_wchar_p("YOUR_KEY"),
        c_wchar_p("user@email.com"),
        c_wchar_p("password"),
        state_callback,          # Connection state
        None,                   # HistoryCallback
        None,                   # NewTradeCallback  
        account_callback,       # Account callback
        order_callback,         # Order callback
        daily_callback,         # Daily data
        None,                   # TheoreticalPriceCallback
        None,                   # NewHistoryCallback
        None,                   # AdjustHistoryCallback
        progress_callback,      # Progress
        ticker_callback         # Quotes
    )
    
    return result == 0
```

#### Market Data Only Connection

```python
def connect_market_only():
    """Connects for market data only"""
    
    result = profit_dll.DLLInitializeMarketLogin(
        c_wchar_p("YOUR_KEY"),
        c_wchar_p("user@email.com"),
        c_wchar_p("password"),
        state_callback,         # Connection state
        None,                  # HistoryCallback
        daily_callback,        # Daily data
        None,                  # NewTradeCallback
        None,                  # TheoreticalPriceCallback
        None,                  # NewHistoryCallback
        progress_callback,     # Progress
        ticker_callback        # Quotes
    )
    
    return result == 0
```

### 2. Receiving Market Data

#### Real-time Quotes

```python
# Quote callback
@WINFUNCTYPE(None, TAssetID, c_double, c_int, c_int)
def ticker_callback(asset_id, price, quantity, side):
    side_text = "Buy" if side == 0 else "Sell"
    print(f"{asset_id.ticker}: {price} - {quantity} ({side_text})")

# Subscribe to quotes
def subscribe_ticker(ticker, exchange="B"):
    result = profit_dll.SubscribeTicker(
        c_wchar_p(ticker), 
        c_wchar_p(exchange)
    )
    return result == 0

# Unsubscribe
def unsubscribe_ticker(ticker, exchange="B"):
    result = profit_dll.UnsubscribeTicker(
        c_wchar_p(ticker), 
        c_wchar_p(exchange)
    )
    return result == 0

# Usage example
subscribe_ticker("PETR4")
subscribe_ticker("VALE3")
```

#### Order Book

```python
# Order book callback
@WINFUNCTYPE(None, TConnectorAssetIdentifier, c_ubyte, c_int, c_ubyte)
def price_depth_callback(asset_id, side, position, update_type):
    side_name = "Buy" if side == 0 else "Sell"
    
    if update_type == 1:  # Edit
        price_group = TConnectorPriceGroup(Version=0)
        
        if profit_dll.GetPriceGroup(byref(asset_id), side, position, byref(price_group)) == 0:
            print(f"{asset_id.Ticker} - {side_name}: {price_group.Price} x {price_group.Quantity}")

# Set callback
profit_dll.SetPriceDepthCallback(price_depth_callback)

# Subscribe to book
def subscribe_book(ticker, exchange="B"):
    asset = TConnectorAssetIdentifier(
        Version=0,
        Ticker=ticker,
        Exchange=exchange,
        FeedType=0
    )
    
    result = profit_dll.SubscribePriceDepth(byref(asset))
    return result == 0

# Example
subscribe_book("PETR4")
```

### 3. Sending Orders

#### Limit Buy Order

```python
def send_buy_order(ticker, exchange, account_info, price, quantity, password):
    """Sends limit buy order"""
    
    order = TConnectorSendOrder(
        Version=0,
        Password=password,
        OrderType=TConnectorOrderType.Limit.value,
        OrderSide=TConnectorOrderSide.Buy.value,
        Price=price,
        StopPrice=-1,  # Not used for limit orders
        Quantity=quantity
    )
    
    # Set account
    order.AccountID = TConnectorAccountIdentifier(
        Version=0,
        BrokerID=account_info['broker_id'],
        AccountID=account_info['account_id'],
        SubAccountID=account_info.get('sub_account_id', ''),
        Reserved=0
    )
    
    # Set asset
    order.AssetID = TConnectorAssetIdentifier(
        Version=0,
        Ticker=ticker,
        Exchange=exchange,
        FeedType=0
    )
    
    # Send order
    result = profit_dll.SendOrder(byref(order))
    
    if result > 0:
        print(f"✅ Order sent - ID: {result}")
        return result
    else:
        print(f"❌ Error sending order: {result}")
        return None

# Usage example
account = {
    'broker_id': 123,
    'account_id': '12345',
    'sub_account_id': '001'
}

order_id = send_buy_order(
    ticker="PETR4",
    exchange="B", 
    account_info=account,
    price=25.50,
    quantity=100,
    password="routing_password"
)
```

#### Market Order

```python
def send_market_order(ticker, exchange, account_info, quantity, side, password):
    """Sends market order"""
    
    order = TConnectorSendOrder(
        Version=0,
        Password=password,
        OrderType=TConnectorOrderType.Market.value,
        OrderSide=side,
        Price=-1,      # Price ignored for market orders
        StopPrice=-1,  # Not used
        Quantity=quantity
    )
    
    order.AccountID = TConnectorAccountIdentifier(
        Version=0,
        BrokerID=account_info['broker_id'],
        AccountID=account_info['account_id'],
        SubAccountID=account_info.get('sub_account_id', ''),
        Reserved=0
    )
    
    order.AssetID = TConnectorAssetIdentifier(
        Version=0,
        Ticker=ticker,
        Exchange=exchange,
        FeedType=0
    )
    
    result = profit_dll.SendOrder(byref(order))
    return result if result > 0 else None

# Market buy
buy_market_id = send_market_order(
    "PETR4", "B", account, 100, 
    TConnectorOrderSide.Buy.value, "password"
)

# Market sell  
sell_market_id = send_market_order(
    "PETR4", "B", account, 100,
    TConnectorOrderSide.Sell.value, "password"
)
```

### 4. Managing Orders

#### Cancel Order

```python
def cancel_order(account_info, cl_order_id, password):
    """Cancels a specific order"""
    
    cancel_order = TConnectorCancelOrder(
        Version=0,
        Password=password
    )
    
    cancel_order.AccountID = TConnectorAccountIdentifier(
        Version=0,
        BrokerID=account_info['broker_id'],
        AccountID=account_info['account_id'],
        SubAccountID=account_info.get('sub_account_id', ''),
        Reserved=0
    )
    
    cancel_order.OrderID = TConnectorOrderIdentifier(
        Version=0,
        LocalOrderID=-1,        # Use -1 when using ClOrderID
        ClOrderID=cl_order_id   # Order ID
    )
    
    result = profit_dll.SendCancelOrderV2(byref(cancel_order))
    
    if result == 0:
        print(f"✅ Order {cl_order_id} cancelled")
        return True
    else:
        print(f"❌ Error cancelling order: {result}")
        return False
```

#### Cancel All Orders

```python
def cancel_all_orders(account_info, password):
    """Cancels all orders for the account"""
    
    cancel_all = TConnectorCancelAllOrders(
        Version=0,
        Password=password
    )
    
    cancel_all.AccountID = TConnectorAccountIdentifier(
        Version=0,
        BrokerID=account_info['broker_id'],
        AccountID=account_info['account_id'],
        SubAccountID=account_info.get('sub_account_id', ''),
        Reserved=0
    )
    
    result = profit_dll.SendCancelAllOrdersV2(byref(cancel_all))
    
    if result == 0:
        print("✅ All orders cancelled")
        return True
    else:
        print(f"❌ Error cancelling orders: {result}")
        return False
```

### 5. Querying Positions

#### Asset Position

```python
def get_position(ticker, exchange, account_info, position_type=TConnectorPositionType.Consolidated.value):
    """Queries position for a specific asset"""
    
    position = TConnectorTradingAccountPosition(
        Version=1,
        PositionType=position_type
    )
    
    position.AccountID = TConnectorAccountIdentifier(
        Version=0,
        BrokerID=account_info['broker_id'],
        AccountID=account_info['account_id'],
        SubAccountID=account_info.get('sub_account_id', ''),
        Reserved=0
    )
    
    position.AssetID = TConnectorAssetIdentifier(
        Version=0,
        Ticker=ticker,
        Exchange=exchange,
        FeedType=0
    )
    
    result = profit_dll.GetPositionV2(byref(position))
    
    if result == 0:
        return {
            'ticker': ticker,
            'open_quantity': position.OpenQuantity,
            'open_avg_price': position.OpenAveragePrice,
            'daily_buy_qty': position.DailyBuyQuantity,
            'daily_sell_qty': position.DailySellQuantity,
            'daily_avg_buy_price': position.DailyAverageBuyPrice,
            'daily_avg_sell_price': position.DailyAverageSellPrice,
            'available_qty': position.DailyQuantityAvailable
        }
    else:
        print(f"❌ Error querying position: {result}")
        return None

# Example
position = get_position("PETR4", "B", account)
if position:
    print(f"PETR4 Position:")
    print(f"  Open Quantity: {position['open_quantity']}")
    print(f"  Average Price: {position['open_avg_price']:.2f}")
    print(f"  Available: {position['available_qty']}")
```

## 📚 API Reference

### Error Codes

| Code | Constant | Description |
|------|----------|-------------|
| 0 | `NL_OK` | Success |
| -2147483647 | `NL_INTERNAL_ERROR` | Internal error |
| -2147483646 | `NL_NOT_INITIALIZED` | DLL not initialized |
| -2147483645 | `NL_INVALID_ARGS` | Invalid arguments |
| -2147483644 | `NL_WAITING_SERVER` | Waiting for server data |
| -2147483643 | `NL_NO_LOGIN` | No login found |
| -2147483642 | `NL_NO_LICENSE` | No license found |
| -2147483631 | `NL_MARKET_ONLY` | No routing available |
| -2147483630 | `NL_NO_POSITION` | No position |
| -2147483629 | `NL_NOT_FOUND` | Resource not found |

### Order Types

```python
class TConnectorOrderType(Enum):
    Market = 1    # Market order
    Limit = 2     # Limit order  
    Stop = 4      # Stop order
```

### Position Types

```python
class TConnectorPositionType(Enum):
    DayTrade = 1      # Day trade position
    Consolidated = 2  # Consolidated position
```

### Main Functions

#### Initialization

```python
# Initialization with routing
def DLLInitializeLogin(key, user, password, state_callback, history_callback, 
                      trade_callback, account_callback, order_callback, 
                      daily_callback, theoretical_callback, new_history_callback,
                      adjust_callback, progress_callback, ticker_callback)

# Market data only initialization
def DLLInitializeMarketLogin(key, user, password, state_callback, history_callback,
                           daily_callback, trade_callback, theoretical_callback,
                           new_history_callback, progress_callback, ticker_callback)

# Finalization
def DLLFinalize()
```

#### Market Data

```python
# Quotes
def SubscribeTicker(ticker, exchange)
def UnsubscribeTicker(ticker, exchange)

# Order book
def SubscribePriceDepth(asset_id)
def UnsubscribePriceDepth(asset_id)
def GetPriceGroup(asset_id, side, position, price_group)

# Theoretical prices
def GetTheoreticalValues(asset_id, theoric_price, theoric_qty)
```

#### Routing

```python  
# Order sending
def SendOrder(order)

# Order modification
def SendChangeOrderV2(change_order)

# Cancellation
def SendCancelOrderV2(cancel_order)
def SendCancelAllOrdersV2(cancel_all_orders)

# Order details
def GetOrderDetails(order_out)
```

#### Positions

```python
# Query position
def GetPositionV2(position)

# Zero position
def SendZeroPositionV2(zero_position)
```

#### Accounts

```python
# List accounts
def GetAccountCount()
def GetAccounts(skip, take, count, accounts_array)
def GetAccountDetails(account_out)

# Sub-accounts
def GetSubAccountCount(account_id)
def GetSubAccounts(account_id, skip, take, count, sub_accounts_array)
```

## 💡 Complete Examples

### Example 1: Price Monitor

```python
import time
import queue
import threading
from ctypes import WINFUNCTYPE, byref, c_int32, c_wchar_p
from profitTypes import *
from profit_dll import initializeDll

class PriceMonitor:
    def __init__(self, dll_path):
        self.profit_dll = initializeDll(dll_path)
        self.connected = False
        self.market_connected = False
        self.price_queue = queue.Queue()
        self.running = False
        
    @WINFUNCTYPE(None, c_int32, c_int32)
    def state_callback(self, connection_type, result):
        if connection_type == 0 and result == 0:
            self.connected = True
            print("✅ Login connected")
        elif connection_type == 2 and result == 4:
            self.market_connected = True
            print("✅ Market Data connected")
    
    @WINFUNCTYPE(None, TAssetID, c_double, c_int, c_int)
    def ticker_callback(self, asset_id, price, quantity, side):
        self.price_queue.put({
            'ticker': asset_id.ticker,
            'price': price,
            'quantity': quantity,
            'side': 'Buy' if side == 0 else 'Sell',
            'timestamp': time.time()
        })
    
    def price_processor(self):
        """Process prices in separate thread"""
        while self.running:
            try:
                data = self.price_queue.get(timeout=1)
                print(f"📊 {data['ticker']}: {data['price']} - {data['quantity']} ({data['side']})")
                
                # Here you can save to database, calculate indicators, etc.
                
            except queue.Empty:
                continue
    
    def connect(self, key, user, password):
        """Connect to server"""
        result = self.profit_dll.DLLInitializeMarketLogin(
            c_wchar_p(key), c_wchar_p(user), c_wchar_p(password),
            self.state_callback, None, None, None, None, None, None, self.ticker_callback
        )
        
        if result == 0:
            # Wait for connection
            while not (self.connected and self.market_connected):
                time.sleep(0.1)
            
            # Start processor
            self.running = True
            self.processor_thread = threading.Thread(target=self.price_processor)
            self.processor_thread.start()
            
            return True
        return False
    
    def subscribe(self, tickers):
        """Subscribe to list of tickers"""
        for ticker in tickers:
            result = self.profit_dll.SubscribeTicker(c_wchar_p(ticker), c_wchar_p("B"))
            if result == 0:
                print(f"✅ Subscribed: {ticker}")
            else:
                print(f"❌ Error subscribing {ticker}: {result}")
    
    def disconnect(self):
        """Disconnect and cleanup resources"""
        self.running = False
        if hasattr(self, 'processor_thread'):
            self.processor_thread.join()
        self.profit_dll.DLLFinalize()

# Usage
if __name__ == "__main__":
    monitor = PriceMonitor("./ProfitDLL.dll")
    
    if monitor.connect("YOUR_KEY", "user@email.com", "password"):
        # Subscribe to some assets
        monitor.subscribe(["PETR4", "VALE3", "ITUB4", "BBDC4"])
        
        try:
            # Keep running
            while True:
                time.sleep(1)
        except KeyboardInterrupt:
            print("Exiting...")
            monitor.disconnect()
```

## 🔧 Troubleshooting

### Common Issues

#### 1. "DLL not found" Error

```python
# ❌ Common error
profit_dll = initializeDll("ProfitDLL.dll")  # Not found

# ✅ Solution: use full path
import os
dll_path = os.path.join(os.getcwd(), "ProfitDLL.dll")
profit_dll = initializeDll(dll_path)
```

#### 2. Callbacks Don't Work

```python
# ❌ Problem: callback doesn't persist in memory
def create_callback():
    @WINFUNCTYPE(None, c_int32, c_int32)
    def callback(t, r):
        print(f"Callback: {t}, {r}")
    return callback

# Reference is lost when function ends
cb = create_callback()

# ✅ Solution: keep global reference
@WINFUNCTYPE(None, c_int32, c_int32)
def state_callback(connection_type, result):
    print(f"State: {connection_type}, {result}")

class MyApp:
    def __init__(self):
        # ✅ Keep as class attribute
        self.state_callback = state_callback
```

#### 3. "Invalid Arguments" Error

```python
# ❌ Incorrect types
profit_dll.SubscribeTicker("PETR4", "B")  # Python strings

# ✅ Use c_wchar_p
profit_dll.SubscribeTicker(c_wchar_p("PETR4"), c_wchar_p("B"))
```

#### 4. Threads and Callbacks

```python
# ❌ Call DLL inside callback
@WINFUNCTYPE(None, TAssetID, c_double, c_int, c_int)  
def bad_callback(asset_id, price, quantity, side):
    # Never do this!
    profit_dll.SubscribeTicker(c_wchar_p("VALE3"), c_wchar_p("B"))

# ✅ Use thread-safe queue
import queue

data_queue = queue.Queue()

@WINFUNCTYPE(None, TAssetID, c_double, c_int, c_int)
def good_callback(asset_id, price, quantity, side):
    data_queue.put({'action': 'subscribe', 'ticker': 'VALE3'})

def process_queue():
    while True:
        try:
            item = data_queue.get(timeout=1)
            if item['action'] == 'subscribe':
                profit_dll.SubscribeTicker(c_wchar_p(item['ticker']), c_wchar_p("B"))
        except queue.Empty:
            continue
```

### Debugging

#### 1. Check Error Codes

```python
def check_result(function_name, result):
    """Check and print DLL errors"""
    
    error_codes = {
        0: "NL_OK - Success",
        -2147483647: "NL_INTERNAL_ERROR - Internal error",
        -2147483646: "NL_NOT_INITIALIZED - DLL not initialized",
        -2147483645: "NL_INVALID_ARGS - Invalid arguments",
        -2147483644: "NL_WAITING_SERVER - Waiting for server",
        -2147483643: "NL_NO_LOGIN - No login found",
        -2147483642: "NL_NO_LICENSE - No license found",
        -2147483631: "NL_MARKET_ONLY - No routing available",
        -2147483630: "NL_NO_POSITION - No position"
    }
    
    if result in error_codes:
        status = "❌" if result != 0 else "✅"
        print(f"{status} {function_name}: {error_codes[result]}")
    else:
        print(f"❓ {function_name}: Unknown code {result}")
    
    return result == 0

# Usage
result = profit_dll.SubscribeTicker(c_wchar_p("PETR4"), c_wchar_p("B"))
check_result("SubscribeTicker", result)
```

## 📖 Additional Resources

### Official Documentation

- [ProfitDLL Manual (PT-BR)](Manual%20-%20ProfitDLL%20pt_br.pdf)
- [ProfitDLL Manual (EN-US)](Manual%20-%20ProfitDLL%20en_us.pdf)  
- [Community Manual](manual_dll.md)

### Examples by Language

- [📁 Python Example](Exemplo%20Python/) - Complete implementation
- [📁 C# Example](Exemplo%20C%23/) - Conversion reference
- [📁 Delphi Example](Exemplo%20Delphi/) - Native implementation
- [📁 C++ Example](Exemplo%20C++/) - Low-level implementation

### Support

For technical support and questions:

1. **Documentation**: Check the official manuals first
2. **Examples**: Review the provided examples
3. **Community**: Join developer forums and groups
4. **Official Support**: Contact Nelogica

---

**Developed with ❤️ for the developer community**

[📖 Portuguese Version](README.md)