# ProfitDLL — Technical Documentation

**Reference documentation for ProfitDLL 4.0.0.41 (Nelogica), in Markdown, prepared for consumption by AI agents.**

[Versão em português](README.md) · [Manual en-US](Manual_ProfitDLL_en_us.md) · [Manual pt-BR](Manual_ProfitDLL_pt_br.md)

---

## What this repository is

This repository is **not a library or an SDK**. It is a documentation
repository. It gathers:

1. **The official ProfitDLL manuals converted to structured Markdown** — the
   main deliverable, designed to be read by coding assistants and AI agents.
2. **The official PDFs** those conversions were derived from.
3. **The code examples for four languages** distributed by Nelogica (Python,
   C#, C++ and Delphi), kept exactly as received, as a reference for real API
   usage.

| File | Content |
|---|---|
| [`Manual_ProfitDLL_en_us.md`](Manual_ProfitDLL_en_us.md) | Complete 4.0.0.41 manual in English (79 converted pages) |
| [`Manual_ProfitDLL_pt_br.md`](Manual_ProfitDLL_pt_br.md) | Complete 4.0.0.41 manual in Portuguese |
| `Manual - ProfitDLL en_us.pdf` / `pt_br.pdf` | Official Nelogica PDFs (source of the conversions) |
| `Exemplo Python/`, `Exemplo C#/`, `Exemplo C++/`, `Exemplo Delphi/` | Official vendor examples |

> **`ProfitDLL.dll` is not in this repository.** It is proprietary and licensed
> by Nelogica. Nothing here runs without the DLL, an activation key and account
> credentials.

## Using this with AI agents

The Markdown manuals are structured specifically for agent retrieval:

- **Every function and callback has a `####` heading with its exact name in
  backticks.** Searching for `` `SendOrder` `` jumps straight to that API's
  section.
- **YAML front-matter** at the top declares the DLL version, language and
  source.
- **Indexes at the start of the document:** delta between versions, a table of
  deprecated APIs with their replacements, a quick index of every API, and a
  Delphi → C#/C++/Python type mapping.
- **Parameter tables are preserved** (Name / Type / Description) for each
  function.
- **Manual-versus-code divergences are annotated**, not silently dropped.

Point your agent at the manual in the language you want and it has the full API
reference without ever opening the PDF.

## ProfitDLL 4.0.0.41 — overview

ProfitDLL is Nelogica's library for integrating with B3 market data and order
routing services.

- **Platform:** Windows, 32 or 64 bits — the client application must match the
  DLL's architecture.
- **Calling convention:** `stdcall`, on both architectures.
- **Modes:** *full routing* (`DLLInitializeLogin`, market data + order
  sending) or *market data only* (`DLLInitializeMarketLogin`).

### Capabilities

| Area | Main APIs |
|---|---|
| Real-time quotes and trades | `SubscribeTicker`, `SetTradeCallbackV2`, `TranslateTrade` |
| Price book (depth) | `SubscribePriceDepth`, `GetPriceGroup`, `SetPriceDepthCallback` |
| Offer book | `SubscribeOfferBook`, `SetOfferBookCallbackV2` |
| History | `GetHistoryTrades`, `SetHistoryTradeCallbackV2` |
| Order sending | `SendOrder`, `SendChangeOrderV2`, `SendCancelOrderV2` |
| Position | `GetPositionV2`, `SendZeroPositionV2`, `EnumerateAllPositionAssets` |
| Accounts and sub-accounts | `GetAccountCount`, `GetAccounts`, `GetAccountDetails`, `GetSubAccounts` |
| DLL health | `GetHealthStatus`, `SetHealthCallback` |

## Examples per language

All of them are interactive console/GUI programs: they prompt for key, user and
password, initialise the DLL and enter a typed-command loop (`subscribe`,
`send order`, `get position`, `exit`, …).

```bash
# Python — requires 3.10+ (main.py uses "X | None" annotations; breaks on 3.9).
# No external dependencies, only ctypes. It loads "./ProfitDLL.dll" at import
# time, so the working directory matters.
cd "Exemplo Python" && python main.py

# C# — net9.0, AllowUnsafeBlocks. Copy ProfitDLL.dll into the output directory.
dotnet run --project "Exemplo C#/ProfitDLLCSClient.csproj"

# C++ — no project file; the compile lines are in the header comment of main.cpp:
cl main.cpp /link ws2_32.lib kernel32.lib     # MSVC
g++ main.cpp                                  # MinGW

# Delphi — open "Exemplo Delphi/DLLClientP.dproj" in RAD Studio (VCL,
# Win32/Win64, Debug/Release) or, from a Delphi command prompt (after rsvars.bat):
msbuild DLLClientP.dproj /p:Config=Release /p:Platform=Win64
```

### How each example is organised

The four examples are the same integration rewritten in different languages.
When looking at one of them, the equivalent file in the others is:

| Layer | Python | C# | Delphi | C++ |
|---|---|---|---|---|
| Structs and enums | `profitTypes.py` | `ProfitDataTypes.cs`, `ProfitEnums.cs` | `Types/ProfitDataTypesU.pas` | `profit.h` |
| Callback signatures | (in `profitTypes.py`) | `ProfitCallbackTypes.cs` | `Types/ProfitCallbackTypesU.pas` | `profit.h` |
| Error codes | (in `main.py`) | `NResult` in `ProfitEnums.cs` | `Types/ProfitConstantsU.pas` | (in `main.cpp`) |
| DLL bindings | `profit_dll.py` | `ProfitFunctions.cs` | `Wrapper/ProfitFunctionsU.pas` | `GetProcAddress` in `main.cpp` |
| Callbacks and driver | `main.py` | `CallbackHandler.cs` + `Program.cs` | `Wrapper/CallbackHandlerU.pas` + `frmClientU.pas` | `main.cpp` |

Files prefixed with `Legacy` hold the older API (see *Deprecated APIs* in the
manual). C#/Delphi link statically by DLL name; Python uses `ctypes.WinDLL`;
C++ resolves each symbol with `LoadLibrary`/`GetProcAddress`.

## Core concepts

These rules are properties of the DLL, not style preferences. They explain why
the example code looks the way it does.

### Callbacks run on the `ConnectorThread`

Every callback runs on an internal DLL thread, and they all share **a single
message queue**. Slow work inside one callback delays delivery of all the
others.

> **Do not call DLL request functions from inside a callback.** The *accessory*
> functions — `TranslateTrade`, `GetOrderDetails`, `GetPriceGroup`,
> `GetTheoreticalValues` — are the exception: they exist to be called from
> inside the callback they accompany.

The correct pattern is to copy the data out and process it on another thread:

```python
import queue, threading

q = queue.Queue()

@WINFUNCTYPE(None, TAssetID, c_double, c_int, c_int)
def tinyBookCallback(assetId, price, qtd, side):
    q.put((assetId.ticker, price, qtd, side))   # fast: just enqueue

def consumer():
    while True:
        item = q.get()
        process(item)                            # heavy work here

threading.Thread(target=consumer, daemon=True).start()
```

### Callback references must outlive registration

In C# the garbage collector reclaims the delegate as soon as it leaves the
stack, which is why `Program.cs` keeps a `static readonly` field per callback.
In Python, module-level functions decorated with `@WINFUNCTYPE` serve the same
purpose — never build the callback object inline at the call site.

### `TConnector*` structures carry a `Version` field

Every modern structure starts with `Version : Byte`, which **you must set**
before passing the structure in. An unset or unsupported version returns
`NL_VERSION_NOT_SUPPORTED`. Most accept `0`; `TConnectorSendOrder` accepts `0`
or `1` (version 1 changes the `OrderType`/`OrderSide` encodings).

### `*Out` structures require two calls

Call once with empty string fields — the DLL fills in the `*Length` counters.
Allocate buffers of those sizes and call again to get the content. Skipping the
first call yields empty strings, not an error.

```python
def getAccountDetails(accountId):
    account = TConnectorTradingAccountOut(Version=1, AccountID=accountId)
    if profit_dll.GetAccountDetails(byref(account)) != NL_OK:
        return None
    account.BrokerName   = ' ' * account.BrokerNameLength     # allocate
    account.OwnerName    = ' ' * account.OwnerNameLength
    account.SubOwnerName = ' ' * account.SubOwnerNameLength
    if profit_dll.GetAccountDetails(byref(account)) != NL_OK: # 2nd call
        return None
    return account
```

The same pattern applies to `GetAgentNameLength` → `GetAgentName` and to the
count-then-fill APIs (`GetAccountCount` → `GetAccounts`).

### `NResult` return codes

`NL_OK` is `0`; errors are negative (`NL_INTERNAL_ERROR = 0x80000001`).
Order-sending functions return a **positive LocalOrderID** on success — so test
for `< 0`, not `!= 0`. The full table is in the manual; the canonical
enumeration is `Exemplo Delphi/Types/ProfitConstantsU.pas`.

### Connection is a four-channel state machine

`StateCallback(nConnStateType, nResult)` reports each channel separately. Only
issue requests once the relevant channels are ready:

| `nConnStateType` | Channel | Ready when `nResult` = |
|---|---|---|
| `0` | Login | `0` (`LOGIN_CONNECTED`) |
| `1` | Routing | `5` (`ROTEAMENTO_BROKER_CONNECTED`) |
| `2` | Market Data | `4` (`MARKET_CONNECTED`) |
| `3` | Activation | `0` (`CONNECTION_ACTIVATE_VALID`) |

Since 4.0.0.39 the market data channel also returns
`MARKET_PERFORMANCE_WARNING` (5) and `MARKET_PARTIAL_CONNECTED` (6) — the
server feed is fine, but local callback delivery is degraded. Treat state 6 as
a critical warning.

### Instrument identification

An instrument is the triple (ticker, exchange, feed). The exchange is a
one-character code:

| Code | Exchange | Code | Exchange |
|---|---|---|---|
| `B` | Bovespa | `M` | CME |
| `F` | BMF | `N` | Nasdaq |
| `A` | BCB | `O` | OXR |
| `D` | FX | `P` | Pioneer |
| `E` | Economic | `X` | Dow Jones |
| `K` | Metrics | `Y` | NYSE |

The feed field is `0` (Nelogica) or `255` (other).

## What is new in 4.0.0.31 → 4.0.0.41

### New APIs

| API | Version | Description |
|---|---|---|
| `GetHealthStatus` | 4.0.0.41 | *Pull* query of the DLL's internal health state |
| `SetHealthCallback` | 4.0.0.41 | Internal watchdog callback |
| `TSystemHealthState` | 4.0.0.41 | `shsResponsive` (0) / `shsFrozen` (1) |

From 4.0.0.41 the DLL monitors its internal threads (Main and Calc) with a
watchdog, and the 64-bit build writes performance logs (*sampling profiler*) to
disk.

### New constants

| Constant | Value | Version |
|---|---|---|
| `MARKET_PERFORMANCE_WARNING` | 5 | 4.0.0.39 |
| `MARKET_PARTIAL_CONNECTED` | 6 | 4.0.0.39 |
| `NL_HISTORY_PERIOD_LIMIT` | `0x8000002E` | 4.0.0.41 |
| `nTradeType` 14–18 | BBT, RFQ, MPT, TAC, TAA | 4.0.0.41 |
| `nTradeType` 33–35 | Update, Mid, Off Exchange | 4.0.0.41 |

On top of these, the `NResult` enumeration gained 14 new codes since 4.0.0.31.

### ABI change — attention

In 4.0.0.38, the `nMinOrderQtd`, `nMaxOrderQtd` and `nLote` fields of
`TAssetListInfoCallback` and `TAssetListInfoCallbackV2` changed from `Integer`
to `Int64`. **Anyone registering these callbacks must update their
signatures** — otherwise the stack is corrupted on the call.

### Relevant fixes

- `SetTradeCallbackV2` stopped receiving trades (4.0.0.38).
- Access Violation in `PopulateOrderOutV0` during volume spikes (4.0.0.39).
- Missing order callback updates: intermediate routing confirmations were
  treated as final (4.0.0.41). Expect **more** events per order; consumption
  must be idempotent.

## Troubleshooting

| Symptom | Likely cause |
|---|---|
| `NL_NOT_INITIALIZED` | `DLLInitializeLogin`/`DLLInitializeMarketLogin` was not called, or failed |
| `NL_WAITING_SERVER` | First call for the resource; data was requested and will arrive via callback |
| `NL_VERSION_NOT_SUPPORTED` | The structure's `Version` field is unset or has an unsupported value |
| `NL_MARKET_ONLY` | Routing function called on a session started with `DLLInitializeMarketLogin` |
| `NL_NO_LICENSE` / `NL_LICENSE_NOT_ALLOWED` | Missing activation key, or the feature is not enabled for it |
| `NL_INVALID_TICKER` | Invalid ticker or exchange — check the one-character exchange code |
| `NL_HISTORY_PERIOD_LIMIT` | History requested with a start date more than 30 days back |
| Empty strings in `*Out` structures | The second call of the *two-pass* pattern is missing |
| Random crash in a callback (C#) | Delegate collected by the GC — missing static reference |
| Callbacks stop arriving | Slow processing inside a callback is blocking the single queue |
| DLL fails to load | Architecture mismatch (32 vs 64 bits) or DLL outside the working directory |

## Licence and credits

ProfitDLL, its manuals and the code examples are property of
**[Nelogica](https://www.nelogica.com.br/)**. This repository only organises and
converts that documentation into Markdown; it does not redistribute the library.

Official developer documentation:
<https://desenvolvedores.nelogica.com.br/>
