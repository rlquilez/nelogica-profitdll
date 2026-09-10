# ProfitDLL — Technical Documentation

**Reference documentation for ProfitDLL 4.0.0.42 (Nelogica), in Markdown, prepared for consumption by AI agents.**

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
4. **External references**, in the *Extras* section at the end of this README:
   the official DLL download link, Nelogica's help center with its articles
   about the DLL, a summary table of every Nelogica blog post about Data
   Solution, and community projects that use ProfitDLL from C# and Python.

| File | Content |
|---|---|
| [`Manual_ProfitDLL_en_us.md`](Manual_ProfitDLL_en_us.md) | Complete 4.0.0.42 manual in English (78 converted pages) |
| [`Manual_ProfitDLL_pt_br.md`](Manual_ProfitDLL_pt_br.md) | Complete 4.0.0.42 manual in Portuguese (79 converted pages) |
| `Manual - ProfitDLL en_us.pdf` / `pt_br.pdf` | Official Nelogica 4.0.0.42 PDFs (source of the conversions) |
| `Exemplo Python/`, `Exemplo C#/`, `Exemplo C++/`, `Exemplo Delphi/` | Official vendor examples |
| *Extras* section of this README | Official download, help center, Nelogica blog posts and community projects |
| `CLAUDE.md` | Maintenance rules of the repository for coding agents: what goes into the manuals versus the READMEs, and how to regenerate the conversion |

> **`ProfitDLL.dll` is not in this repository.** It is proprietary and licensed
> by Nelogica. Nothing here runs without the DLL, an activation key and account
> credentials. The official package with the DLL, the manuals and the examples
> is listed under [Extras → Official download](#official-profitdll-download).

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
  function, with the cells exactly as in the PDF.
- **Intact Delphi declarations:** lines that the PDF print wrapped were
  re-joined, and every code block is a faithful copy of the original.
- **Below the `---` separator the content is the official PDF's**, in the same
  order and wording; manual-versus-code divergences are annotated in the
  preamble, not silently dropped.
- **External resources live in this README, not in the manuals:** the official
  links, the blog posts and the community projects are in the *Extras*
  section, so that the manuals remain a faithful copy of the PDF.

Point your agent at the manual in the language you want and it has the full API
reference without ever opening the PDF.

## ProfitDLL 4.0.0.42 — overview

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
| Trade history | `GetHistoryTrades` (30-day window; WIN/WDO in slices shorter than 10 days), `SetHistoryTradeCallbackV2` |
| Order sending | `SendOrder`, `SendChangeOrderV2`, `SendCancelOrderV2` |
| Position | `GetPositionV2`, `SendZeroPositionV2`, `EnumerateAllPositionAssets` |
| Accounts and sub-accounts | `GetAccountCount`, `GetAccounts`, `GetAccountDetails`, `GetSubAccounts` |
| DLL health | `GetHealthStatus`, `SetHealthCallback` |

## Examples per language

The four examples do the same thing — initialise the DLL with an activation
key, user and password and run functions on demand — but each collects that
input differently:

- **Python** prompts for key, user and password in the terminal and enters a
  typed-command loop (`subscribe`, `offerbook`, `position`, `buyAtMarket`,
  `getHistoryTrades`, `healthStatus`, `exit`, …).
- **C#** prompts for user, password and key in the terminal; its command loop
  uses its own names (`subscribe`, `send order`, `get position`,
  `request history`, `exit`, …).
- **C++** holds key, user, password, account and broker as constants at the
  top of `main()` (marked *Preencher*, "fill in") and runs a fixed script of
  calls, with no command loop.
- **Delphi** is a VCL form with fields for the credentials and a list of
  functions to trigger.

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

API coverage is not identical across them: only the Python example binds the
health APIs (`GetHealthStatus`, `SetHealthCallback`, `TSystemHealthState`),
and the C# example kept its `request history` command while Python renamed
its own to `getHistoryTrades` in 4.0.0.42.

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
for `< 0`, not `!= 0`. The manual's table lists 32 codes; the canonical
enumeration, `Exemplo Delphi/Types/ProfitConstantsU.pas`, defines 47. The 15
that exist only in the Delphi header (13 of them added since 4.0.0.31) are
valid return values and are listed here so that no code goes unnamed:

| Code | Value | Meaning (header comment) |
|---|---|---|
| `NL_PASSWORD_HASH_SHA1` | `0x80000007` | Password is not SHA1-hashed |
| `NL_PASSWORD_HASH_MD5` | `0x80000008` | Password is not MD5-hashed |
| `NL_NOT_MY_TRADE` | `0x80000021` | Trade/offer does not belong to any of the user's accounts |
| `NL_NOT_EQUALS` | `0x80000022` | Two resources are not equal |
| `NL_INVALID_DLL_AUTH` | `0x80000023` | DLL not validated by HMAC |
| `NL_INVALID_SIGNATURE` | `0x80000024` | DLL could not validate the executable |
| `NL_NOT_IMPLEMENTED` | `0x80000025` | Feature not implemented yet |
| `NL_BROKER_NOT_ALLOWED` | `0x80000026` | Broker has no access to the back-office resource |
| `NL_FILE_NOT_EXISTS` | `0x80000027` | File does not exist |
| `NL_NTSL_PARSE_FAILED` | `0x80000028` | Language parse failed |
| `NL_NTSL_TOO_MANY_ASSETS` | `0x80000029` | Too many assets used in the NTSL code |
| `NL_NOT_CONSISTENT` | `0x8000002A` | Resource is not considered consistent |
| `NL_SINGLE_THREADED` | `0x8000002B` | (no comment in the header) |
| `NL_NOT_SAME_THREAD` | `0x8000002C` | (no comment in the header) |
| `NL_TIMEOUT` | `0x8000002D` | (no comment in the header) |

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

### Trade history has window limits

`GetHistoryTrades` rejects requests whose start date is older than 30 days
(`NL_HISTORY_PERIOD_LIMIT`). For tickers starting with `WIN` or `WDO`, the
range between `dtDateStart` and `dtDateEnd` cannot reach 10 days
(`NL_INVALID_ARGS`) — request the history of those contracts day by day and use
`TProgressCallback` to detect the end of each load.

## What is new in 4.0.0.31 → 4.0.0.42

### 4.0.0.42 at a glance

Bug-fix release: no API, structure or constant was added to or removed from
the DLL.

- **DLL:** fixed delayed delivery of order callbacks; fixed an exception when
  performing a new `SubscribeOfferBook`; fixed the process identifier (PID)
  sent by the DLL to the server.
- **Manual:** `GetHistoryTrades` now documents the 30-day
  (`NL_HISTORY_PERIOD_LIMIT`) and the 10-day WIN/WDO (`NL_INVALID_ARGS`)
  limits; the `RequestSerieHistory` section was removed — `GetHistoryTrades`
  is the only documented trade-history API.
- **Python example:** the `requestHistory` command became `getHistoryTrades`
  (the function already called `GetHistoryTrades`). The other examples did not
  change.

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

On top of these, `ProfitConstantsU.pas` gained 14 `NResult` codes since
4.0.0.31, but only `NL_HISTORY_PERIOD_LIMIT` made it into the manual's table —
the others are listed under *`NResult` return codes*.

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
- Delayed delivery of order callbacks (4.0.0.42).
- Exception when performing a new `SubscribeOfferBook` (4.0.0.42).
- Process identifier (PID) sent by the DLL to the server (4.0.0.42).

## Troubleshooting

| Symptom | Likely cause |
|---|---|
| `NL_NOT_INITIALIZED` | `DLLInitializeLogin`/`DLLInitializeMarketLogin` was not called, or failed |
| `NL_WAITING_SERVER` | First call for the resource; data was requested and will arrive via callback |
| `NL_VERSION_NOT_SUPPORTED` | The structure's `Version` field is unset or has an unsupported value |
| `NL_MARKET_ONLY` | Routing function called on a session started with `DLLInitializeMarketLogin` |
| `NL_NO_LICENSE` / `NL_LICENSE_NOT_ALLOWED` | Missing activation key, or the feature is not enabled for it |
| `NL_INVALID_TICKER` | Invalid ticker or exchange — check the one-character exchange code |
| `NL_HISTORY_PERIOD_LIMIT` | `GetHistoryTrades` with a start date older than 30 days |
| `NL_INVALID_ARGS` from `GetHistoryTrades` | `WIN*`/`WDO*` ticker with a range of 10 days or more between `dtDateStart` and `dtDateEnd` — request day by day |
| Empty strings in `*Out` structures | The second call of the *two-pass* pattern is missing |
| Random crash in a callback (C#) | Delegate collected by the GC — missing static reference |
| Callbacks stop arriving | Slow processing inside a callback is blocking the single queue |
| DLL fails to load | Architecture mismatch (32 vs 64 bits) or DLL outside the working directory |

## Extras — official resources and community

This section gathers Nelogica's official channels about ProfitDLL and open
community projects that use it. Nothing here replaces Nelogica's licence or
support.

### Official ProfitDLL download

The latest official package — 32- and 64-bit DLL, Delphi test executable,
interface files, the PDF manuals and the examples in four languages — is at:

<https://download-setup.nelogica.com.br/connector/latest/ProfitDLL.zip>

The same package is also offered in the Nelogica customer area (login →
*Assinaturas* → *DLL Feed* licence → *Download*). The DLL only works with an
activation key and an enabled account; prospective customers subscribe to Data
Solution through the [NeloStore](https://store.nelogica.com.br/data-solution).

### Official help (Nelogica)

For general questions about Data Solution (DLL) or support requests, use
Nelogica's own channels:

- Help center: <https://ajuda.nelogica.com.br/>
- *DataFeed - DLL* section of the help center, with the articles below
  (in Portuguese):
  <https://ajuda.nelogica.com.br/hc/pt-br/sections/11307712057883-DataFeed-DLL>

| Article (pt-BR) | Topic |
|---|---|
| [Ecossistema ProfitDLL e primeiros passos](https://ajuda.nelogica.com.br/hc/pt-br/articles/22396517026203) | What the DLL is, initialisation modes (market data vs. routing), callbacks |
| [Como obter acesso à ProfitDLL](https://ajuda.nelogica.com.br/hc/pt-br/articles/51583791325211) | Licensing and where to download `ProfitDLL.zip` with manual and examples |
| [Introdução ao Produto DLL Real Time](https://ajuda.nelogica.com.br/hc/pt-br/articles/11166353435035) | Overview of the DLL Real Time product |
| [Funções Real Time - DLL](https://ajuda.nelogica.com.br/hc/pt-br/articles/11168755650459) | Condensed function reference |
| [Como rotear ordens com a ProfitDLL](https://ajuda.nelogica.com.br/hc/pt-br/articles/13312468554651) | Sending, changing and cancelling orders |
| [Como requisitar trades históricos com a ProfitDLL](https://ajuda.nelogica.com.br/hc/pt-br/articles/11973319153563) | `GetHistoryTrades`, limits and history callbacks |
| [Como utilizar o Livro de Profundidade (Price Depth) via DLL Real Time](https://ajuda.nelogica.com.br/hc/pt-br/articles/50587290263835) | `SubscribePriceDepth`, `GetPriceGroup` |
| [ProfitDLL no Linux: Saiba como acessar e utilizar](https://ajuda.nelogica.com.br/hc/pt-br/articles/54973527417243) | Running the DLL on Linux |
| [Problemas e dúvidas comuns - DLL Real Time](https://ajuda.nelogica.com.br/hc/pt-br/articles/11166562187803) | Official FAQ |
| [Como saber se a DLL está conectada](https://ajuda.nelogica.com.br/hc/pt-br/articles/11168955426331) | Connection states (`TStateCallback`) |
| [Logs de DLL não são gerados usando Python, e agora?](https://ajuda.nelogica.com.br/hc/pt-br/articles/11168640008859) | DLL logs from Python |
| [Requisitando ajustes de ativos com a DLL Real Time](https://ajuda.nelogica.com.br/hc/pt-br/articles/13312278467099) | `SubscribeAdjustHistory` and adjustment callbacks |
| [Do tick ao dashboard: construa sua análise de players com a ProfitDLL](https://ajuda.nelogica.com.br/hc/pt-br/articles/11966404695195) | Buy/sell agents derived from trades |
| [Conheça os Principais Benefícios do Data Solution Nelogica](https://ajuda.nelogica.com.br/hc/pt-br/articles/11966232254619) | Commercial overview of Data Solution |
| [Introdução ao produto Base Histórica de Dados](https://ajuda.nelogica.com.br/hc/pt-br/articles/11169074066715) | Sister product: historical database (not the DLL) |
| [Tipos de Arquivos e Exemplos de Layout - Base Histórica de Dados](https://ajuda.nelogica.com.br/hc/pt-br/articles/11169423343515) | File layouts of the historical database |
| [Disponibilidade de Dados Históricos para exportação em .CSV](https://ajuda.nelogica.com.br/hc/pt-br/articles/11169188636443) | CSV coverage of the historical database |

### Nelogica blog — Data Solution category

Every post Nelogica has published in the category
<https://blog.nelogica.com.br/categoria/data-solution/> (surveyed on
2026-09-10; the posts are in Portuguese):

| Date | Post (pt-BR) | Summary | DLL relevance |
|---|---|---|---|
| 2026-08-25 | [Como usar a ProfitDLL no Linux?](https://blog.nelogica.com.br/profitdll-linux/) | Step-by-step tutorial for running ProfitDLL on Ubuntu by executing the Windows x64 Python inside Wine; ends with a WINFUT trade consumer and the precautions to take inside the callback | Direct (Python) |
| 2026-08-24 | [Quant trading: tome decisões baseadas em dados](https://blog.nelogica.com.br/quant-trading/) | Conceptual guide to quantitative trading: quantitative analysis, quant funds and algorithms, strategies and an FAQ; points to Data Solution as the data source | Conceptual |
| 2026-07-24 | [6 principais benefícios de Data Solution para traders](https://blog.nelogica.com.br/beneficios-data-solution/) | Product view: consolidated and adjusted data, a single scalable feed, low latency, 30+ years of B3 history, backtesting and automation | Product |
| 2026-07-14 | [API de dados da B3: automatize suas operações com a DLL](https://blog.nelogica.com.br/api-de-dados-da-b3/) | What a B3 data API is and what it is for (algorithms, websites, machine learning), presenting Data Solution and its DLL connectivity | Product |
| 2026-07-01 | [Como construir um replay de mercado com a Profit DLL?](https://blog.nelogica.com.br/como-construir-replay-mercado-profitdll/) | Architecture of a tick-by-tick market replay on top of ProfitDLL: swappable data source, history from file, virtual clock, instant or animated playback, Times & Trades and indicators | Direct |
| 2026-07-01 | [Como aplicar as Bandas de Bollinger com ProfitDLL?](https://blog.nelogica.com.br/bandas-bollinger-profitdll/) | Reuses the tick → candle → indicator pipeline to compute Bollinger Bands (mean ± k standard deviations), with a rolling window and warm-up | Direct |
| 2026-06-10 | [Como calcular médias móveis usando a ProfitDLL?](https://blog.nelogica.com.br/como-calcular-medias-moveis-usando-a-profitdll/) | The DLL delivers ticks, not candles: how to build the 1-minute OHLCV candle, combine 30 days of history with real time, and why the EMA seed diverges from the chart | Direct |
| 2026-06-08 | [Como requisitar os trades históricos no ProfitDLL?](https://blog.nelogica.com.br/como-requisitar-trades-historicos-profitdll/) | Request limits and format, step-by-step flow, what each callback delivers and best practices: request day by day, use the progress callback, skip weekends and never call the DLL inside callbacks | Direct |
| 2026-01-26 | [O que é o Data Solution e como usar dados de mercado da B3?](https://blog.nelogica.com.br/data-solution/) | Overview of Data Solution: use cases, advantages and the products that make it up (historical database + real-time DLL) | Product |
| 2020-12-18 | [Por que os dados históricos da B3 são essenciais para qualquer trader?](https://blog.nelogica.com.br/dados-historicos-da-b3/) | B3 historical data, available coverage and five reasons to use it (backtesting, technical analysis, robots, research, portfolio management) | Data |

### Community usage examples

Open projects, independent from Nelogica, that show ProfitDLL in real use. The
DLL itself still has to be obtained from Nelogica.

| Repository | Author | What it offers |
|---|---|---|
| [YouTrade/DLLNelogica](https://github.com/YouTrade/DLLNelogica) | Marcelo Rahal Coutinho (YouTrade) | Educational C# / .NET 9 project, *Programando o seu robô de trading* series: from login to instrument subscription and quote reception via P/Invoke, with asynchronous file logging. MIT licence. |
| [diogojrdev/profitdll-wrapper](https://github.com/diogojrdev/profitdll-wrapper) | Diogo Ribeiro | Python wrapper (ctypes, zero dependencies, Python 3.10+) with typing, enqueue-only callbacks, order routing, positions and tick-by-tick history ingestion into SQLite, PostgreSQL/TimescaleDB, Parquet and CSV; examples, tests and the `profitdll-wrapper` package on PyPI. MIT licence. |

### Acknowledgements

Thanks to **Marcelo Rahal Coutinho** (YouTrade) and **Diogo Ribeiro** for
publishing these projects as open source — beyond the official examples, they
are the best practical reference for how ProfitDLL behaves from C# and from
Python.

## Licence and credits

ProfitDLL, its manuals and the code examples are property of
**[Nelogica](https://www.nelogica.com.br/)**. This repository only organises and
converts that documentation into Markdown; it does not redistribute the library.
The community projects cited above have their own licences and authors and are
not affiliated with Nelogica.

Official ProfitDLL documentation (help center, *DataFeed - DLL* section):
<https://ajuda.nelogica.com.br/hc/pt-br/sections/11307712057883-DataFeed-DLL>
