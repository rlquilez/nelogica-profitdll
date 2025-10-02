# ProfitDLL - Python Integration Guide

**Guia completo de integração com a ProfitDLL da Nelogica em Python**

[Visão Geral](#visão-geral) • [Instalação](#instalação) • [Início Rápido](#início-rápido) • [Guias Práticos](#guias-práticos) • [Referência da API](#referência-da-api) • [Exemplos](#exemplos)

---

## 📋 Índice

- [Visão Geral](#visão-geral)
- [Requisitos e Instalação](#requisitos-e-instalação)
- [Início Rápido](#início-rápido)
- [Conceitos Fundamentais](#conceitos-fundamentais)
- [Guias Práticos](#guias-práticos)
- [Referência da API](#referência-da-api)
- [Exemplos Completos](#exemplos-completos)
- [Troubleshooting](#troubleshooting)
- [Recursos Adicionais](#recursos-adicionais)

## 🎯 Visão Geral

A **ProfitDLL** é uma biblioteca desenvolvida pela Nelogica que permite a integração de aplicações externas com os serviços de market data e roteamento de ordens. Esta documentação fornece um guia completo para utilizar a ProfitDLL em aplicações Python.

### Principais Funcionalidades

- 📈 **Market Data em Tempo Real**: Cotações, livro de ofertas, trades
- 📊 **Dados Históricos**: Acesso a dados históricos de preços e volumes
- 🔄 **Roteamento de Ordens**: Envio, modificação e cancelamento de ordens
- 💰 **Gestão de Posições**: Consulta e gerenciamento de posições
- 🏦 **Gestão de Contas**: Acesso a informações de contas e subconta

### Modalidades de Uso

- **Roteamento Completo**: Market data + envio de ordens
- **Market Data Only**: Apenas dados de mercado (cotações, histórico)

## 🛠 Requisitos e Instalação

### Pré-requisitos

- **Python 3.7+**
- **Windows** (a DLL é específica para Windows)
- **Chave de licença** fornecida pela Nelogica
- **Credenciais de acesso** (usuário e senha)

### Instalação

1. **Obtenha os arquivos necessários:**
   ```
   ProfitDLL.dll        # Biblioteca principal (32 ou 64 bits)
   profit_dll.py        # Wrapper Python
   profitTypes.py       # Definições de tipos
   ```

2. **Coloque os arquivos no seu projeto:**
   ```
   seu_projeto/
   ├── ProfitDLL.dll
   ├── profit_dll.py
   ├── profitTypes.py
   └── main.py          # Seu código
   ```

3. **Instale dependências:**
   ```bash
   # Não há dependências externas, apenas ctypes (built-in)
   ```

## 🚀 Início Rápido

### Exemplo Básico - Market Data

```python
from ctypes import WINFUNCTYPE, byref, c_int32, c_wchar_p
from profitTypes import *
from profit_dll import initializeDll

# Inicializar a DLL
profit_dll = initializeDll("./ProfitDLL.dll")

# Variáveis de controle
connected = False
market_connected = False

# Callback de estado da conexão
@WINFUNCTYPE(None, c_int32, c_int32)
def state_callback(connection_type, result):
    global connected, market_connected
    
    if connection_type == 0:  # Login
        if result == 0:
            connected = True
            print("✅ Login realizado com sucesso")
        else:
            print(f"❌ Erro no login: {result}")
    
    elif connection_type == 2:  # Market Data
        if result == 4:
            market_connected = True
            print("✅ Market Data conectado")
        else:
            print(f"❌ Erro no Market Data: {result}")

# Callback para cotações
@WINFUNCTYPE(None, TAssetID, c_double, c_int, c_int)
def ticker_callback(asset_id, price, quantity, side):
    side_name = "Compra" if side == 0 else "Venda"
    print(f"📊 {asset_id.ticker}: {price} - {quantity} ({side_name})")

# Inicializar conexão (apenas Market Data)
def main():
    key = "SUA_CHAVE_DE_LICENCA"
    user = "seu_usuario@email.com"
    password = "sua_senha"
    
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
        print("🔄 Inicializando conexão...")
        
        # Aguardar conexão
        while not (connected and market_connected):
            pass
            
        # Assinar cotações
        profit_dll.SubscribeTicker(c_wchar_p("PETR4"), c_wchar_p("B"))
        
        # Manter aplicação rodando
        input("Pressione Enter para sair...")
        
    else:
        print(f"❌ Erro na inicialização: {result}")
    
    # Finalizar
    profit_dll.DLLFinalize()

if __name__ == "__main__":
    main()
```

## 🧠 Conceitos Fundamentais

### Callbacks e Threading

> ⚠️ **IMPORTANTE**: Todos os callbacks executam em uma thread separada (`ConnectorThread`). 

**Regras fundamentais:**
- ✅ **Faça**: Processamento rápido nos callbacks
- ✅ **Faça**: Armazene dados e processe em outra thread
- ❌ **Evite**: Operações demoradas (I/O, banco de dados)
- ❌ **Nunca**: Chame funções da DLL dentro de callbacks

```python
import queue
import threading

# Fila thread-safe para dados
data_queue = queue.Queue()

@WINFUNCTYPE(None, TAssetID, c_double, c_int, c_int)
def safe_ticker_callback(asset_id, price, quantity, side):
    # ✅ Rápido: apenas adiciona à fila
    data_queue.put({
        'ticker': asset_id.ticker,
        'price': price,
        'quantity': quantity,
        'side': side,
        'timestamp': time.time()
    })

def data_processor():
    """Processa dados em thread separada"""
    while True:
        try:
            data = data_queue.get(timeout=1)
            # ✅ Processamento pesado aqui
            save_to_database(data)
            calculate_indicators(data)
        except queue.Empty:
            continue
```

### Tipos de Dados Principais

#### Asset (Ativo)
```python
# Identificação de um ativo
asset = TConnectorAssetIdentifier(
    Version=0,
    Ticker="PETR4",      # Código do ativo
    Exchange="B",        # Bolsa (B=Bovespa, C=CME, etc.)
    FeedType=0          # Fonte dos dados (0=Nelogica)
)
```

#### Account (Conta)
```python
# Identificação de uma conta
account = TConnectorAccountIdentifier(
    Version=0,
    BrokerID=123,           # ID da corretora
    AccountID="12345",      # Número da conta
    SubAccountID="001",     # Subconta (opcional)
    Reserved=0
)
```

#### Order (Ordem)
```python
# Envio de ordem
order = TConnectorSendOrder(
    Version=0,
    Password="senha_roteamento",
    OrderType=TConnectorOrderType.Limit.value,  # Limitada
    OrderSide=TConnectorOrderSide.Buy.value,    # Compra
    Price=25.50,
    StopPrice=-1,        # -1 para ordens limitadas
    Quantity=100
)
```

## 📖 Guias Práticos

### 1. Conectando à ProfitDLL

#### Conexão com Roteamento (Market Data + Ordens)

```python
def connect_with_routing():
    """Conecta com funcionalidades completas"""
    
    result = profit_dll.DLLInitializeLogin(
        c_wchar_p("SUA_CHAVE"),
        c_wchar_p("usuario@email.com"),
        c_wchar_p("senha"),
        state_callback,          # Estado da conexão
        None,                   # HistoryCallback
        None,                   # NewTradeCallback  
        account_callback,       # Callback de contas
        order_callback,         # Callback de ordens
        daily_callback,         # Dados diários
        None,                   # TheoreticalPriceCallback
        None,                   # NewHistoryCallback
        None,                   # AdjustHistoryCallback
        progress_callback,      # Progresso
        ticker_callback         # Cotações
    )
    
    return result == 0
```

#### Conexão Apenas Market Data

```python
def connect_market_only():
    """Conecta apenas para dados de mercado"""
    
    result = profit_dll.DLLInitializeMarketLogin(
        c_wchar_p("SUA_CHAVE"),
        c_wchar_p("usuario@email.com"),
        c_wchar_p("senha"),
        state_callback,         # Estado da conexão
        None,                  # HistoryCallback
        daily_callback,        # Dados diários
        None,                  # NewTradeCallback
        None,                  # TheoreticalPriceCallback
        None,                  # NewHistoryCallback
        progress_callback,     # Progresso
        ticker_callback        # Cotações
    )
    
    return result == 0
```

### 2. Recebendo Dados de Mercado

#### Cotações em Tempo Real

```python
# Callback para cotações
@WINFUNCTYPE(None, TAssetID, c_double, c_int, c_int)
def ticker_callback(asset_id, price, quantity, side):
    side_text = "Compra" if side == 0 else "Venda"
    print(f"{asset_id.ticker}: {price} - {quantity} ({side_text})")

# Assinar cotações
def subscribe_ticker(ticker, exchange="B"):
    result = profit_dll.SubscribeTicker(
        c_wchar_p(ticker), 
        c_wchar_p(exchange)
    )
    return result == 0

# Cancelar assinatura
def unsubscribe_ticker(ticker, exchange="B"):
    result = profit_dll.UnsubscribeTicker(
        c_wchar_p(ticker), 
        c_wchar_p(exchange)
    )
    return result == 0

# Exemplo de uso
subscribe_ticker("PETR4")
subscribe_ticker("VALE3")
```

#### Livro de Ofertas (Book)

```python
# Callback para book de ofertas
@WINFUNCTYPE(None, TConnectorAssetIdentifier, c_ubyte, c_int, c_ubyte)
def price_depth_callback(asset_id, side, position, update_type):
    side_name = "Compra" if side == 0 else "Venda"
    
    if update_type == 1:  # Edição
        price_group = TConnectorPriceGroup(Version=0)
        
        if profit_dll.GetPriceGroup(byref(asset_id), side, position, byref(price_group)) == 0:
            print(f"{asset_id.Ticker} - {side_name}: {price_group.Price} x {price_group.Quantity}")

# Configurar callback
profit_dll.SetPriceDepthCallback(price_depth_callback)

# Assinar book
def subscribe_book(ticker, exchange="B"):
    asset = TConnectorAssetIdentifier(
        Version=0,
        Ticker=ticker,
        Exchange=exchange,
        FeedType=0
    )
    
    result = profit_dll.SubscribePriceDepth(byref(asset))
    return result == 0

# Exemplo
subscribe_book("PETR4")
```

#### Trades (Negócios)

```python
# Callback para trades
@WINFUNCTYPE(None, TConnectorAssetIdentifier, c_size_t, c_uint)
def trade_callback(asset_id, trade_ptr, flags):
    is_edit = bool(flags & 1)
    
    trade = TConnectorTrade(Version=0)
    
    if profit_dll.TranslateTrade(trade_ptr, byref(trade)):
        print(f"{asset_id.Ticker}: {trade.Price} x {trade.Quantity} (Edit: {is_edit})")

# Configurar callback
profit_dll.SetTradeCallbackV2(trade_callback)
```

### 3. Enviando Ordens

#### Ordem Limitada de Compra

```python
def send_buy_order(ticker, exchange, account_info, price, quantity, password):
    """Envia ordem limitada de compra"""
    
    order = TConnectorSendOrder(
        Version=0,
        Password=password,
        OrderType=TConnectorOrderType.Limit.value,
        OrderSide=TConnectorOrderSide.Buy.value,
        Price=price,
        StopPrice=-1,  # Não usado em ordens limitadas
        Quantity=quantity
    )
    
    # Configurar conta
    order.AccountID = TConnectorAccountIdentifier(
        Version=0,
        BrokerID=account_info['broker_id'],
        AccountID=account_info['account_id'],
        SubAccountID=account_info.get('sub_account_id', ''),
        Reserved=0
    )
    
    # Configurar ativo
    order.AssetID = TConnectorAssetIdentifier(
        Version=0,
        Ticker=ticker,
        Exchange=exchange,
        FeedType=0
    )
    
    # Enviar ordem
    result = profit_dll.SendOrder(byref(order))
    
    if result > 0:
        print(f"✅ Ordem enviada - ID: {result}")
        return result
    else:
        print(f"❌ Erro ao enviar ordem: {result}")
        return None

# Exemplo de uso
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
    password="senha_roteamento"
)
```

#### Ordem a Mercado

```python
def send_market_order(ticker, exchange, account_info, quantity, side, password):
    """Envia ordem a mercado"""
    
    order = TConnectorSendOrder(
        Version=0,
        Password=password,
        OrderType=TConnectorOrderType.Market.value,
        OrderSide=side,
        Price=-1,      # Preço ignorado em ordens a mercado
        StopPrice=-1,  # Não usado
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

# Compra a mercado
buy_market_id = send_market_order(
    "PETR4", "B", account, 100, 
    TConnectorOrderSide.Buy.value, "senha"
)

# Venda a mercado  
sell_market_id = send_market_order(
    "PETR4", "B", account, 100,
    TConnectorOrderSide.Sell.value, "senha"
)
```

#### Ordem Stop

```python
def send_stop_order(ticker, exchange, account_info, price, stop_price, quantity, side, password):
    """Envia ordem stop"""
    
    order = TConnectorSendOrder(
        Version=0,
        Password=password,
        OrderType=TConnectorOrderType.Stop.value,
        OrderSide=side,
        Price=price,           # Preço de execução
        StopPrice=stop_price,  # Preço de disparo
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

# Stop Loss (venda)
stop_loss_id = send_stop_order(
    ticker="PETR4",
    exchange="B",
    account_info=account,
    price=24.00,        # Preço de execução
    stop_price=24.50,   # Disparo quando preço cair para 24.50
    quantity=100,
    side=TConnectorOrderSide.Sell.value,
    password="senha"
)

# Stop Gain (compra)
stop_gain_id = send_stop_order(
    ticker="PETR4", 
    exchange="B",
    account_info=account,
    price=26.00,        # Preço de execução
    stop_price=25.50,   # Disparo quando preço subir para 25.50
    quantity=100,
    side=TConnectorOrderSide.Buy.value,
    password="senha"
)
```

### 4. Gerenciando Ordens

#### Cancelar Ordem

```python
def cancel_order(account_info, cl_order_id, password):
    """Cancela uma ordem específica"""
    
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
        LocalOrderID=-1,        # Usar -1 quando usar ClOrderID
        ClOrderID=cl_order_id   # ID da ordem
    )
    
    result = profit_dll.SendCancelOrderV2(byref(cancel_order))
    
    if result == 0:
        print(f"✅ Ordem {cl_order_id} cancelada")
        return True
    else:
        print(f"❌ Erro ao cancelar ordem: {result}")
        return False
```

#### Cancelar Todas as Ordens

```python
def cancel_all_orders(account_info, password):
    """Cancela todas as ordens da conta"""
    
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
        print("✅ Todas as ordens canceladas")
        return True
    else:
        print(f"❌ Erro ao cancelar ordens: {result}")
        return False
```

#### Modificar Ordem

```python
def change_order(account_info, cl_order_id, new_price, new_quantity, password):
    """Modifica uma ordem existente"""
    
    change_order = TConnectorChangeOrder(
        Version=0,
        Password=password,
        Price=new_price,
        StopPrice=-1,
        Quantity=new_quantity
    )
    
    change_order.AccountID = TConnectorAccountIdentifier(
        Version=0,
        BrokerID=account_info['broker_id'],
        AccountID=account_info['account_id'],
        SubAccountID=account_info.get('sub_account_id', ''),
        Reserved=0
    )
    
    change_order.OrderID = TConnectorOrderIdentifier(
        Version=0,
        LocalOrderID=-1,
        ClOrderID=cl_order_id
    )
    
    result = profit_dll.SendChangeOrderV2(byref(change_order))
    
    if result == 0:
        print(f"✅ Ordem {cl_order_id} modificada")
        return True
    else:
        print(f"❌ Erro ao modificar ordem: {result}")
        return False
```

### 5. Consultando Posições

#### Posição de um Ativo

```python
def get_position(ticker, exchange, account_info, position_type=TConnectorPositionType.Consolidated.value):
    """Consulta posição de um ativo específico"""
    
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
        print(f"❌ Erro ao consultar posição: {result}")
        return None

# Exemplo
position = get_position("PETR4", "B", account)
if position:
    print(f"Posição PETR4:")
    print(f"  Quantidade em Aberto: {position['open_quantity']}")
    print(f"  Preço Médio: {position['open_avg_price']:.2f}")
    print(f"  Disponível: {position['available_qty']}")
```

#### Zerar Posição

```python
def zero_position(ticker, exchange, account_info, position_type, password):
    """Zera posição de um ativo"""
    
    zero_pos = TConnectorZeroPosition(
        Version=1,
        PositionType=position_type,
        Password=password,
        Price=-1.0  # Preço a mercado
    )
    
    zero_pos.AccountID = TConnectorAccountIdentifier(
        Version=0,
        BrokerID=account_info['broker_id'],
        AccountID=account_info['account_id'],
        SubAccountID=account_info.get('sub_account_id', ''),
        Reserved=0
    )
    
    zero_pos.AssetID = TConnectorAssetIdentifier(
        Version=0,
        Ticker=ticker,
        Exchange=exchange,
        FeedType=0
    )
    
    result = profit_dll.SendZeroPositionV2(byref(zero_pos))
    
    if result > 0:
        print(f"✅ Posição zerada - Ordem ID: {result}")
        return result
    else:
        print(f"❌ Erro ao zerar posição: {result}")
        return None

# Zerar posição consolidada
zero_order_id = zero_position(
    "PETR4", "B", account,
    TConnectorPositionType.Consolidated.value,
    "senha"
)
```

### 6. Consultando Contas

#### Listar Contas Disponíveis

```python
def get_accounts():
    """Lista todas as contas disponíveis"""
    
    # Obter quantidade de contas
    count = profit_dll.GetAccountCount()
    
    if count <= 0:
        print("Nenhuma conta encontrada")
        return []
    
    # Criar array para receber os dados
    accounts_array = (TConnectorAccountIdentifierOut * count)()
    
    # Obter lista de contas
    result_count = profit_dll.GetAccounts(0, 0, count, accounts_array)
    
    accounts = []
    
    for i in range(result_count):
        account_id = TConnectorAccountIdentifier(
            Version=0,
            BrokerID=accounts_array[i].BrokerID,
            AccountID=accounts_array[i].AccountID,
            SubAccountID='',
            Reserved=0
        )
        
        # Obter detalhes da conta
        account_details = get_account_details(account_id)
        
        if account_details:
            accounts.append({
                'broker_id': accounts_array[i].BrokerID,
                'account_id': accounts_array[i].AccountID,
                'owner_name': account_details.OwnerName,
                'broker_name': account_details.BrokerName,
                'account_type': account_details.AccountType
            })
    
    return accounts

def get_account_details(account_id):
    """Obtém detalhes de uma conta específica"""
    
    account = TConnectorTradingAccountOut(
        Version=1,
        AccountID=account_id
    )
    
    # Primeira chamada para obter tamanhos
    if profit_dll.GetAccountDetails(byref(account)) != 0:
        return None
    
    # Alocar strings com tamanho correto
    account.BrokerName = ' ' * account.BrokerNameLength
    account.OwnerName = ' ' * account.OwnerNameLength
    account.SubOwnerName = ' ' * account.SubOwnerNameLength
    
    # Segunda chamada para obter dados
    if profit_dll.GetAccountDetails(byref(account)) != 0:
        return None
    
    return account

# Exemplo de uso
accounts = get_accounts()
for account in accounts:
    print(f"Conta: {account['account_id']} - {account['owner_name']} ({account['broker_name']})")
```

## 📚 Referência da API

### Códigos de Erro

| Código | Constante | Descrição |
|--------|-----------|-----------|
| 0 | `NL_OK` | Sucesso |
| -2147483647 | `NL_INTERNAL_ERROR` | Erro interno |
| -2147483646 | `NL_NOT_INITIALIZED` | DLL não inicializada |
| -2147483645 | `NL_INVALID_ARGS` | Argumentos inválidos |
| -2147483644 | `NL_WAITING_SERVER` | Aguardando dados do servidor |
| -2147483643 | `NL_NO_LOGIN` | Nenhum login encontrado |
| -2147483642 | `NL_NO_LICENSE` | Nenhuma licença encontrada |
| -2147483631 | `NL_MARKET_ONLY` | Não possui roteamento |
| -2147483630 | `NL_NO_POSITION` | Não possui posição |
| -2147483629 | `NL_NOT_FOUND` | Recurso não encontrado |

### Tipos de Ordem

```python
class TConnectorOrderType(Enum):
    Market = 1    # Ordem a mercado
    Limit = 2     # Ordem limitada  
    Stop = 4      # Ordem stop
```

### Tipos de Posição

```python
class TConnectorPositionType(Enum):
    DayTrade = 1      # Posição day trade
    Consolidated = 2  # Posição consolidada
```

### Principais Funções

#### Inicialização

```python
# Inicialização com roteamento
def DLLInitializeLogin(key, user, password, state_callback, history_callback, 
                      trade_callback, account_callback, order_callback, 
                      daily_callback, theoretical_callback, new_history_callback,
                      adjust_callback, progress_callback, ticker_callback)

# Inicialização apenas market data
def DLLInitializeMarketLogin(key, user, password, state_callback, history_callback,
                           daily_callback, trade_callback, theoretical_callback,
                           new_history_callback, progress_callback, ticker_callback)

# Finalização
def DLLFinalize()
```

#### Market Data

```python
# Cotações
def SubscribeTicker(ticker, exchange)
def UnsubscribeTicker(ticker, exchange)

# Livro de ofertas
def SubscribePriceDepth(asset_id)
def UnsubscribePriceDepth(asset_id)
def GetPriceGroup(asset_id, side, position, price_group)

# Preços teóricos
def GetTheoreticalValues(asset_id, theoric_price, theoric_qty)
```

#### Roteamento

```python  
# Envio de ordens
def SendOrder(order)

# Modificação de ordens
def SendChangeOrderV2(change_order)

# Cancelamento
def SendCancelOrderV2(cancel_order)
def SendCancelAllOrdersV2(cancel_all_orders)

# Detalhes de ordem
def GetOrderDetails(order_out)
```

#### Posições

```python
# Consultar posição
def GetPositionV2(position)

# Zerar posição
def SendZeroPositionV2(zero_position)
```

#### Contas

```python
# Listar contas
def GetAccountCount()
def GetAccounts(skip, take, count, accounts_array)
def GetAccountDetails(account_out)

# Subcontas
def GetSubAccountCount(account_id)
def GetSubAccounts(account_id, skip, take, count, sub_accounts_array)
```

## 💡 Exemplos Completos

### Exemplo 1: Monitor de Cotações

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
            print("✅ Login conectado")
        elif connection_type == 2 and result == 4:
            self.market_connected = True
            print("✅ Market Data conectado")
    
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
        """Processa preços em thread separada"""
        while self.running:
            try:
                data = self.price_queue.get(timeout=1)
                print(f"📊 {data['ticker']}: {data['price']} - {data['quantity']} ({data['side']})")
                
                # Aqui você pode salvar em banco, calcular indicadores, etc.
                
            except queue.Empty:
                continue
    
    def connect(self, key, user, password):
        """Conecta ao servidor"""
        result = self.profit_dll.DLLInitializeMarketLogin(
            c_wchar_p(key), c_wchar_p(user), c_wchar_p(password),
            self.state_callback, None, None, None, None, None, None, self.ticker_callback
        )
        
        if result == 0:
            # Aguardar conexão
            while not (self.connected and self.market_connected):
                time.sleep(0.1)
            
            # Iniciar processador
            self.running = True
            self.processor_thread = threading.Thread(target=self.price_processor)
            self.processor_thread.start()
            
            return True
        return False
    
    def subscribe(self, tickers):
        """Assina lista de tickers"""
        for ticker in tickers:
            result = self.profit_dll.SubscribeTicker(c_wchar_p(ticker), c_wchar_p("B"))
            if result == 0:
                print(f"✅ Assinado: {ticker}")
            else:
                print(f"❌ Erro ao assinar {ticker}: {result}")
    
    def disconnect(self):
        """Desconecta e limpa recursos"""
        self.running = False
        if hasattr(self, 'processor_thread'):
            self.processor_thread.join()
        self.profit_dll.DLLFinalize()

# Uso
if __name__ == "__main__":
    monitor = PriceMonitor("./ProfitDLL.dll")
    
    if monitor.connect("CHAVE", "usuario@email.com", "senha"):
        # Assinar alguns ativos
        monitor.subscribe(["PETR4", "VALE3", "ITUB4", "BBDC4"])
        
        try:
            # Manter rodando
            while True:
                time.sleep(1)
        except KeyboardInterrupt:
            print("Encerrando...")
            monitor.disconnect()
```

### Exemplo 2: Sistema de Trading Automatizado

```python
import time
import threading
from datetime import datetime
from ctypes import WINFUNCTYPE, byref, c_int32, c_wchar_p
from profitTypes import *
from profit_dll import initializeDll

class AutoTrader:
    def __init__(self, dll_path, account_info):
        self.profit_dll = initializeDll(dll_path)
        self.account_info = account_info
        self.connected = False
        self.broker_connected = False
        self.positions = {}
        self.orders = {}
        
    @WINFUNCTYPE(None, c_int32, c_int32)
    def state_callback(self, connection_type, result):
        if connection_type == 0 and result == 0:
            self.connected = True
        elif connection_type == 1 and result == 5:
            self.broker_connected = True
            print("✅ Broker conectado - Trading habilitado")
    
    @WINFUNCTYPE(None, TConnectorOrderIdentifier)
    def order_callback(self, order_id):
        # Atualizar status da ordem
        self.update_order_status(order_id)
    
    @WINFUNCTYPE(None, TAssetID, c_double, c_int, c_int)
    def ticker_callback(self, asset_id, price, quantity, side):
        ticker = asset_id.ticker
        
        # Estratégia simples: comprar se preço < 25, vender se > 26
        if ticker == "PETR4":
            if price < 25.0 and ticker not in self.positions:
                self.buy_stock(ticker, 100, price + 0.01)
            elif price > 26.0 and ticker in self.positions:
                self.sell_stock(ticker, 100, price - 0.01)
    
    def buy_stock(self, ticker, quantity, price):
        """Compra ações"""
        order = TConnectorSendOrder(
            Version=0,
            Password=self.account_info['password'],
            OrderType=TConnectorOrderType.Limit.value,
            OrderSide=TConnectorOrderSide.Buy.value,
            Price=price,
            StopPrice=-1,
            Quantity=quantity
        )
        
        order.AccountID = TConnectorAccountIdentifier(
            Version=0,
            BrokerID=self.account_info['broker_id'],
            AccountID=self.account_info['account_id'],
            SubAccountID=self.account_info.get('sub_account_id', ''),
            Reserved=0
        )
        
        order.AssetID = TConnectorAssetIdentifier(
            Version=0,
            Ticker=ticker,
            Exchange="B",
            FeedType=0
        )
        
        result = self.profit_dll.SendOrder(byref(order))
        
        if result > 0:
            print(f"📈 Ordem de compra enviada: {ticker} - {quantity} @ {price}")
            self.orders[result] = {
                'ticker': ticker,
                'side': 'Buy',
                'quantity': quantity,
                'price': price
            }
        else:
            print(f"❌ Erro na compra: {result}")
    
    def sell_stock(self, ticker, quantity, price):
        """Vende ações"""
        order = TConnectorSendOrder(
            Version=0,
            Password=self.account_info['password'],
            OrderType=TConnectorOrderType.Limit.value,
            OrderSide=TConnectorOrderSide.Sell.value,
            Price=price,
            StopPrice=-1,
            Quantity=quantity
        )
        
        order.AccountID = TConnectorAccountIdentifier(
            Version=0,
            BrokerID=self.account_info['broker_id'],
            AccountID=self.account_info['account_id'],
            SubAccountID=self.account_info.get('sub_account_id', ''),
            Reserved=0
        )
        
        order.AssetID = TConnectorAssetIdentifier(
            Version=0,
            Ticker=ticker,
            Exchange="B",
            FeedType=0
        )
        
        result = self.profit_dll.SendOrder(byref(order))
        
        if result > 0:
            print(f"📉 Ordem de venda enviada: {ticker} - {quantity} @ {price}")
            self.orders[result] = {
                'ticker': ticker,
                'side': 'Sell',
                'quantity': quantity,
                'price': price
            }
        else:
            print(f"❌ Erro na venda: {result}")
    
    def update_order_status(self, order_id):
        """Atualiza status de uma ordem"""
        order = TConnectorOrderOut(
            Version=0,
            OrderID=order_id
        )
        
        if self.profit_dll.GetOrderDetails(byref(order)) == 0:
            # Alocar strings
            order.AssetID.Ticker = ' ' * order.AssetID.TickerLength
            order.AssetID.Exchange = ' ' * order.AssetID.ExchangeLength
            order.TextMessage = ' ' * order.TextMessageLength
            
            if self.profit_dll.GetOrderDetails(byref(order)) == 0:
                ticker = order.AssetID.Ticker.strip()
                
                # Se ordem foi executada completamente
                if order.OrderStatus == 2:  # Filled
                    if order.OrderSide == 1:  # Buy
                        self.positions[ticker] = order.TradedQuantity
                        print(f"✅ Compra executada: {ticker} - {order.TradedQuantity} @ {order.AveragePrice}")
                    else:  # Sell
                        if ticker in self.positions:
                            del self.positions[ticker]
                        print(f"✅ Venda executada: {ticker} - {order.TradedQuantity} @ {order.AveragePrice}")
    
    def connect(self, key, user, password):
        """Conecta com roteamento"""
        result = self.profit_dll.DLLInitializeLogin(
            c_wchar_p(key), c_wchar_p(user), c_wchar_p(password),
            self.state_callback, None, None, None, self.order_callback,
            None, None, None, None, None, self.ticker_callback
        )
        
        if result == 0:
            while not (self.connected and self.broker_connected):
                time.sleep(0.1)
            return True
        return False
    
    def start_trading(self, tickers):
        """Inicia trading nos tickers especificados"""
        for ticker in tickers:
            self.profit_dll.SubscribeTicker(c_wchar_p(ticker), c_wchar_p("B"))
        
        print(f"🤖 Trading iniciado para: {', '.join(tickers)}")

# Uso
if __name__ == "__main__":
    account = {
        'broker_id': 123,
        'account_id': '12345',
        'sub_account_id': '001',
        'password': 'senha_roteamento'
    }
    
    trader = AutoTrader("./ProfitDLL.dll", account)
    
    if trader.connect("CHAVE", "usuario@email.com", "senha"):
        trader.start_trading(["PETR4"])
        
        try:
            while True:
                time.sleep(1)
        except KeyboardInterrupt:
            trader.profit_dll.DLLFinalize()
```

### Exemplo 3: Análise de Book de Ofertas

```python
import time
from collections import defaultdict
from ctypes import WINFUNCTYPE, byref, c_int32, c_wchar_p, c_ubyte, c_int64, c_double
from profitTypes import *
from profit_dll import initializeDll

class BookAnalyzer:
    def __init__(self, dll_path):
        self.profit_dll = initializeDll(dll_path)
        self.connected = False
        self.market_connected = False
        self.books = defaultdict(lambda: {'buy': [], 'sell': []})
        
    @WINFUNCTYPE(None, c_int32, c_int32)
    def state_callback(self, connection_type, result):
        if connection_type == 0 and result == 0:
            self.connected = True
        elif connection_type == 2 and result == 4:
            self.market_connected = True
            print("✅ Market Data conectado")
    
    @WINFUNCTYPE(None, TConnectorAssetIdentifier, c_ubyte, c_int, c_ubyte)
    def book_callback(self, asset_id, side, position, update_type):
        ticker = asset_id.Ticker
        side_name = 'buy' if side == 0 else 'sell'
        
        # Processar diferentes tipos de atualização
        if update_type == 1:  # Edit
            price_group = TConnectorPriceGroup(Version=0)
            
            if self.profit_dll.GetPriceGroup(byref(asset_id), side, position, byref(price_group)) == 0:
                
                # Verificar se é preço teórico
                if price_group.PriceGroupFlags & 1:
                    theoric_price = c_double()
                    theoric_qty = c_int64()
                    
                    if self.profit_dll.GetTheoreticalValues(byref(asset_id), byref(theoric_price), byref(theoric_qty)) == 0:
                        price_group.Price = theoric_price.value
                
                # Atualizar book local
                book_entry = {
                    'price': price_group.Price,
                    'quantity': price_group.Quantity,
                    'count': price_group.Count,
                    'position': position
                }
                
                # Manter book ordenado
                book_side = self.books[ticker][side_name]
                
                # Remover posição antiga se existir
                book_side = [entry for entry in book_side if entry['position'] != position]
                
                # Inserir nova posição
                book_side.append(book_entry)
                
                # Ordenar (compra: maior preço primeiro, venda: menor preço primeiro)
                if side_name == 'buy':
                    book_side.sort(key=lambda x: x['price'], reverse=True)
                else:
                    book_side.sort(key=lambda x: x['price'])
                
                self.books[ticker][side_name] = book_side[:10]  # Manter apenas top 10
                
                # Análise do book
                self.analyze_book(ticker)
        
        elif update_type == 2:  # Delete
            book_side = self.books[ticker][side_name]
            self.books[ticker][side_name] = [entry for entry in book_side if entry['position'] != position]
        
        elif update_type == 4:  # FullBook
            print(f"📖 {ticker} - Book completo recebido")
            self.print_book(ticker)
    
    def analyze_book(self, ticker):
        """Analisa o book e gera insights"""
        book = self.books[ticker]
        
        if not book['buy'] or not book['sell']:
            return
        
        best_bid = book['buy'][0]['price']
        best_ask = book['sell'][0]['price']
        spread = best_ask - best_bid
        spread_pct = (spread / best_bid) * 100
        
        # Volume nos primeiros níveis
        buy_volume = sum(entry['quantity'] for entry in book['buy'][:3])
        sell_volume = sum(entry['quantity'] for entry in book['sell'][:3])
        
        volume_ratio = buy_volume / sell_volume if sell_volume > 0 else 0
        
        print(f"📊 {ticker}: Bid={best_bid:.2f} Ask={best_ask:.2f} Spread={spread:.2f} ({spread_pct:.2f}%) Vol_Ratio={volume_ratio:.2f}")
        
        # Alertas
        if spread_pct > 0.5:
            print(f"⚠️  {ticker}: Spread alto ({spread_pct:.2f}%)")
        
        if volume_ratio > 2:
            print(f"📈 {ticker}: Pressão compradora (ratio={volume_ratio:.2f})")
        elif volume_ratio < 0.5:
            print(f"📉 {ticker}: Pressão vendedora (ratio={volume_ratio:.2f})")
    
    def print_book(self, ticker):
        """Imprime o book formatado"""
        book = self.books[ticker]
        
        print(f"\n📖 Book - {ticker}")
        print("=" * 50)
        print("COMPRA            |           VENDA")
        print("Qtd    Preço      |      Preço    Qtd")
        print("-" * 50)
        
        max_levels = max(len(book['buy']), len(book['sell']))
        
        for i in range(max_levels):
            buy_str = "               "
            sell_str = "               "
            
            if i < len(book['buy']):
                buy = book['buy'][i]
                buy_str = f"{buy['quantity']:6} {buy['price']:8.2f}"
            
            if i < len(book['sell']):
                sell = book['sell'][i]
                sell_str = f"{sell['price']:8.2f} {sell['quantity']:6}"
            
            print(f"{buy_str}   |   {sell_str}")
        
        print("=" * 50)
    
    def subscribe_book(self, ticker, exchange="B"):
        """Assina book de ofertas"""
        asset = TConnectorAssetIdentifier(
            Version=0,
            Ticker=ticker,
            Exchange=exchange,
            FeedType=0
        )
        
        result = self.profit_dll.SubscribePriceDepth(byref(asset))
        
        if result == 0:
            print(f"✅ Book assinado: {ticker}")
        else:
            print(f"❌ Erro ao assinar book {ticker}: {result}")
    
    def connect(self, key, user, password):
        """Conecta ao market data"""
        # Configurar callback primeiro
        self.profit_dll.SetPriceDepthCallback(self.book_callback)
        
        result = self.profit_dll.DLLInitializeMarketLogin(
            c_wchar_p(key), c_wchar_p(user), c_wchar_p(password),
            self.state_callback, None, None, None, None, None, None, None
        )
        
        if result == 0:
            while not (self.connected and self.market_connected):
                time.sleep(0.1)
            return True
        return False

# Uso
if __name__ == "__main__":
    analyzer = BookAnalyzer("./ProfitDLL.dll")
    
    if analyzer.connect("CHAVE", "usuario@email.com", "senha"):
        # Assinar books
        tickers = ["PETR4", "VALE3", "ITUB4"]
        
        for ticker in tickers:
            analyzer.subscribe_book(ticker)
        
        try:
            while True:
                time.sleep(5)
                # Imprimir análise periodicamente
                for ticker in tickers:
                    analyzer.print_book(ticker)
        except KeyboardInterrupt:
            analyzer.profit_dll.DLLFinalize()
```

## 🔧 Troubleshooting

### Problemas Comuns

#### 1. Erro "DLL não encontrada"

```python
# ❌ Erro comum
profit_dll = initializeDll("ProfitDLL.dll")  # Não encontra

# ✅ Solução: usar caminho completo
import os
dll_path = os.path.join(os.getcwd(), "ProfitDLL.dll")
profit_dll = initializeDll(dll_path)
```

#### 2. Callbacks não funcionam

```python
# ❌ Problema: callback não persiste na memória
def create_callback():
    @WINFUNCTYPE(None, c_int32, c_int32)
    def callback(t, r):
        print(f"Callback: {t}, {r}")
    return callback

# A referência é perdida quando a função termina
cb = create_callback()

# ✅ Solução: manter referência global
@WINFUNCTYPE(None, c_int32, c_int32)
def state_callback(connection_type, result):
    print(f"State: {connection_type}, {result}")

class MyApp:
    def __init__(self):
        # ✅ Manter como atributo da classe
        self.state_callback = state_callback
```

#### 3. Erro "Argumentos inválidos"

```python
# ❌ Tipos incorretos
profit_dll.SubscribeTicker("PETR4", "B")  # Strings Python

# ✅ Usar c_wchar_p
profit_dll.SubscribeTicker(c_wchar_p("PETR4"), c_wchar_p("B"))
```

#### 4. Threads e callbacks

```python
# ❌ Chamar DLL dentro de callback
@WINFUNCTYPE(None, TAssetID, c_double, c_int, c_int)  
def bad_callback(asset_id, price, quantity, side):
    # Nunca faça isso!
    profit_dll.SubscribeTicker(c_wchar_p("VALE3"), c_wchar_p("B"))

# ✅ Usar fila thread-safe
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

#### 1. Verificar códigos de erro

```python
def check_result(function_name, result):
    """Verifica e imprime erros da DLL"""
    
    error_codes = {
        0: "NL_OK - Sucesso",
        -2147483647: "NL_INTERNAL_ERROR - Erro interno",
        -2147483646: "NL_NOT_INITIALIZED - DLL não inicializada",
        -2147483645: "NL_INVALID_ARGS - Argumentos inválidos",
        -2147483644: "NL_WAITING_SERVER - Aguardando servidor",
        -2147483643: "NL_NO_LOGIN - Nenhum login encontrado",
        -2147483642: "NL_NO_LICENSE - Nenhuma licença encontrada",
        -2147483631: "NL_MARKET_ONLY - Não possui roteamento",
        -2147483630: "NL_NO_POSITION - Não possui posição"
    }
    
    if result in error_codes:
        status = "❌" if result != 0 else "✅"
        print(f"{status} {function_name}: {error_codes[result]}")
    else:
        print(f"❓ {function_name}: Código desconhecido {result}")
    
    return result == 0

# Uso
result = profit_dll.SubscribeTicker(c_wchar_p("PETR4"), c_wchar_p("B"))
check_result("SubscribeTicker", result)
```

#### 2. Log detalhado

```python
import logging
from datetime import datetime

# Configurar logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('profitdll.log'),
        logging.StreamHandler()
    ]
)

logger = logging.getLogger(__name__)

@WINFUNCTYPE(None, c_int32, c_int32)
def logged_state_callback(connection_type, result):
    logger.info(f"StateCallback - Type: {connection_type}, Result: {result}")
    
    types = {0: "Login", 1: "Broker", 2: "Market", 3: "Activation"}
    type_name = types.get(connection_type, f"Unknown({connection_type})")
    
    if result == 0:
        logger.info(f"✅ {type_name} conectado com sucesso")
    else:
        logger.error(f"❌ Erro em {type_name}: {result}")

@WINFUNCTYPE(None, TAssetID, c_double, c_int, c_int)
def logged_ticker_callback(asset_id, price, quantity, side):
    logger.debug(f"Ticker: {asset_id.ticker} - {price} x {quantity} ({'Buy' if side == 0 else 'Sell'})")
```

## 📖 Recursos Adicionais

### Documentação Oficial

- [Manual ProfitDLL (PT-BR)](Manual%20-%20ProfitDLL%20pt_br.pdf)
- [Manual ProfitDLL (EN-US)](Manual%20-%20ProfitDLL%20en_us.pdf)  
- [Manual da Comunidade](manual_dll.md)

### Exemplos por Linguagem

- [📁 Exemplo Python](Exemplo%20Python/) - Implementação completa
- [📁 Exemplo C#](Exemplo%20C%23/) - Referência para conversão
- [📁 Exemplo Delphi](Exemplo%20Delphi/) - Implementação nativa
- [📁 Exemplo C++](Exemplo%20C++/) - Implementação low-level

### Suporte

Para suporte técnico e dúvidas:

1. **Documentação**: Consulte primeiro os manuais oficiais
2. **Exemplos**: Verifique os exemplos fornecidos
3. **Comunidade**: Participe de fóruns e grupos de desenvolvedores
4. **Suporte Oficial**: Entre em contato com a Nelogica

---

**Desenvolvido com ❤️ para a comunidade de desenvolvedores**

[📖 English Version](README_EN.md)

<!-- English README template will be created as README_EN.md -->
