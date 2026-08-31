# ProfitDLL — Documentação Técnica

**Documentação de referência da ProfitDLL 4.0.0.41 (Nelogica), em Markdown, preparada para consumo por agentes de IA.**

[English version](README_EN.md) · [Manual pt-BR](Manual_ProfitDLL_pt_br.md) · [Manual en-US](Manual_ProfitDLL_en_us.md)

---

## O que é este repositório

Este repositório **não é uma biblioteca nem um SDK**. É um repositório de
documentação. Ele reúne:

1. **Os manuais oficiais da ProfitDLL convertidos para Markdown estruturado** —
   a entrega principal, pensada para ser lida por assistentes de codificação e
   agentes de IA.
2. **Os PDFs oficiais** que deram origem a essas conversões.
3. **Os exemplos de código das quatro linguagens** distribuídos pela Nelogica
   (Python, C#, C++ e Delphi), mantidos exatamente como recebidos, como
   referência de uso real da API.

| Arquivo | Conteúdo |
|---|---|
| [`Manual_ProfitDLL_pt_br.md`](Manual_ProfitDLL_pt_br.md) | Manual completo 4.0.0.41 em português (79 páginas convertidas) |
| [`Manual_ProfitDLL_en_us.md`](Manual_ProfitDLL_en_us.md) | Manual completo 4.0.0.41 em inglês |
| `Manual - ProfitDLL pt_br.pdf` / `en_us.pdf` | PDFs oficiais da Nelogica (fonte das conversões) |
| `Exemplo Python/`, `Exemplo C#/`, `Exemplo C++/`, `Exemplo Delphi/` | Exemplos oficiais do fabricante |

> **A `ProfitDLL.dll` não está neste repositório.** Ela é proprietária e
> licenciada pela Nelogica. Nada aqui executa sem a DLL, uma chave de ativação
> e credenciais de conta.

## Como usar com agentes de IA

Os manuais em Markdown foram estruturados especificamente para recuperação por
agentes:

- **Cada função e cada callback tem um heading `####` com o nome exato entre
  crases.** Buscar por `` `SendOrder` `` leva direto à seção da API.
- **Front-matter YAML** no topo declara versão da DLL, idioma e fonte.
- **Índices no início do documento:** delta entre versões, tabela de APIs
  deprecadas com suas substitutas, índice rápido de todas as APIs e mapeamento
  de tipos Delphi → C#/C++/Python.
- **Tabelas de parâmetros preservadas** (Nome / Tipo / Descrição) para cada
  função.
- **Divergências entre manual e código são anotadas**, não silenciadas.

Aponte seu agente para o manual do idioma desejado e ele terá a referência
completa da API sem precisar abrir o PDF.

## ProfitDLL 4.0.0.41 — visão geral

A ProfitDLL é a biblioteca da Nelogica para integração com os serviços de
market data e roteamento de ordens da B3.

- **Plataforma:** Windows, 32 ou 64 bits — a aplicação cliente precisa ter a
  mesma arquitetura da DLL.
- **Convenção de chamada:** `stdcall`, em ambas as arquiteturas.
- **Modalidades:** *roteamento completo* (`DLLInitializeLogin`, market data +
  envio de ordens) ou *somente market data* (`DLLInitializeMarketLogin`).

### Funcionalidades

| Área | APIs principais |
|---|---|
| Cotações e trades em tempo real | `SubscribeTicker`, `SetTradeCallbackV2`, `TranslateTrade` |
| Livro de preços (profundidade) | `SubscribePriceDepth`, `GetPriceGroup`, `SetPriceDepthCallback` |
| Livro de ofertas | `SubscribeOfferBook`, `SetOfferBookCallbackV2` |
| Histórico | `GetHistoryTrades`, `SetHistoryTradeCallbackV2` |
| Envio de ordens | `SendOrder`, `SendChangeOrderV2`, `SendCancelOrderV2` |
| Posição | `GetPositionV2`, `SendZeroPositionV2`, `EnumerateAllPositionAssets` |
| Contas e subcontas | `GetAccountCount`, `GetAccounts`, `GetAccountDetails`, `GetSubAccounts` |
| Saúde da DLL | `GetHealthStatus`, `SetHealthCallback` |

## Exemplos por linguagem

Todos são programas de console/GUI interativos: pedem chave, usuário e senha,
inicializam a DLL e entram em um laço de comandos digitados (`subscribe`,
`send order`, `get position`, `exit`, …).

```bash
# Python — requer 3.10+ (main.py usa anotações "X | None"; quebra no 3.9).
# Sem dependências externas, só ctypes. Carrega "./ProfitDLL.dll" no import,
# portanto o diretório de trabalho importa.
cd "Exemplo Python" && python main.py

# C# — net9.0, AllowUnsafeBlocks. Copie ProfitDLL.dll para o diretório de saída.
dotnet run --project "Exemplo C#/ProfitDLLCSClient.csproj"

# C++ — sem arquivo de projeto; as linhas de compilação estão no cabeçalho de main.cpp:
cl main.cpp /link ws2_32.lib kernel32.lib     # MSVC
g++ main.cpp                                  # MinGW

# Delphi — abra "Exemplo Delphi/DLLClientP.dproj" no RAD Studio (VCL,
# Win32/Win64, Debug/Release) ou, em um prompt Delphi (após rsvars.bat):
msbuild DLLClientP.dproj /p:Config=Release /p:Platform=Win64
```

### Como cada exemplo está organizado

Os quatro exemplos são a mesma integração reescrita em linguagens diferentes.
Ao consultar um deles, o arquivo equivalente nos outros é:

| Camada | Python | C# | Delphi | C++ |
|---|---|---|---|---|
| Structs e enums | `profitTypes.py` | `ProfitDataTypes.cs`, `ProfitEnums.cs` | `Types/ProfitDataTypesU.pas` | `profit.h` |
| Assinaturas de callback | (em `profitTypes.py`) | `ProfitCallbackTypes.cs` | `Types/ProfitCallbackTypesU.pas` | `profit.h` |
| Códigos de erro | (em `main.py`) | `NResult` em `ProfitEnums.cs` | `Types/ProfitConstantsU.pas` | (em `main.cpp`) |
| Bindings da DLL | `profit_dll.py` | `ProfitFunctions.cs` | `Wrapper/ProfitFunctionsU.pas` | `GetProcAddress` em `main.cpp` |
| Callbacks e driver | `main.py` | `CallbackHandler.cs` + `Program.cs` | `Wrapper/CallbackHandlerU.pas` + `frmClientU.pas` | `main.cpp` |

Arquivos com prefixo `Legacy` contêm a API antiga (ver *APIs deprecadas* no
manual). C#/Delphi fazem link estático pelo nome da DLL; Python usa
`ctypes.WinDLL`; C++ resolve cada símbolo com `LoadLibrary`/`GetProcAddress`.

## Conceitos centrais

Estas regras são propriedades da DLL, não preferências de estilo. Elas explicam
por que o código dos exemplos tem a forma que tem.

### Callbacks rodam na `ConnectorThread`

Todos os callbacks são executados em uma thread interna da DLL e compartilham
**uma única fila de mensagens**. Trabalho lento dentro de um callback atrasa a
entrega de todos os outros.

> **Não chame funções de requisição da DLL de dentro de um callback.** As
> funções *acessórias* — `TranslateTrade`, `GetOrderDetails`, `GetPriceGroup`,
> `GetTheoreticalValues` — são a exceção: existem para serem chamadas de dentro
> do callback que as acompanha.

O padrão correto é copiar os dados e processá-los em outra thread:

```python
import queue, threading

fila = queue.Queue()

@WINFUNCTYPE(None, TAssetID, c_double, c_int, c_int)
def tinyBookCallback(assetId, price, qtd, side):
    fila.put((assetId.ticker, price, qtd, side))   # rápido: só enfileira

def consumidor():
    while True:
        dado = fila.get()
        processa(dado)                              # trabalho pesado aqui

threading.Thread(target=consumidor, daemon=True).start()
```

### Referências de callback precisam sobreviver ao registro

Em C# o coletor de lixo recolhe o *delegate* assim que ele sai da pilha; por
isso `Program.cs` mantém um campo `static readonly` por callback. Em Python, as
funções decoradas com `@WINFUNCTYPE` no nível do módulo cumprem o mesmo papel —
nunca crie o objeto de callback no próprio ponto da chamada.

### Estruturas `TConnector*` têm campo `Version`

Toda estrutura moderna começa com `Version : Byte`, que **você precisa
preencher** antes de passar a estrutura. Versão não preenchida ou não suportada
devolve `NL_VERSION_NOT_SUPPORTED`. A maioria aceita `0`; `TConnectorSendOrder`
aceita `0` ou `1` (a versão 1 muda a codificação de `OrderType`/`OrderSide`).

### Estruturas `*Out` exigem duas chamadas

Chame uma vez com os campos de texto vazios — a DLL preenche os contadores
`*Length`. Aloque os buffers com esses tamanhos e chame de novo para receber o
conteúdo. Pular a primeira chamada devolve strings vazias, não um erro.

```python
def getAccountDetails(accountId):
    account = TConnectorTradingAccountOut(Version=1, AccountID=accountId)
    if profit_dll.GetAccountDetails(byref(account)) != NL_OK:
        return None
    account.BrokerName   = ' ' * account.BrokerNameLength     # aloca
    account.OwnerName    = ' ' * account.OwnerNameLength
    account.SubOwnerName = ' ' * account.SubOwnerNameLength
    if profit_dll.GetAccountDetails(byref(account)) != NL_OK: # 2ª chamada
        return None
    return account
```

O mesmo padrão vale para `GetAgentNameLength` → `GetAgentName` e para as APIs
de contar-e-preencher (`GetAccountCount` → `GetAccounts`).

### Códigos de retorno `NResult`

`NL_OK` é `0`; erros são negativos (`NL_INTERNAL_ERROR = 0x80000001`). As
funções de envio de ordem devolvem um **LocalOrderID positivo** em caso de
sucesso — por isso teste `< 0`, e não `!= 0`. A tabela completa está no manual;
a enumeração canônica é `Exemplo Delphi/Types/ProfitConstantsU.pas`.

### Conexão é uma máquina de estados de quatro canais

O `StateCallback(nConnStateType, nResult)` informa cada canal separadamente.
Só emita requisições depois que os canais relevantes estiverem prontos:

| `nConnStateType` | Canal | Pronto quando `nResult` = |
|---|---|---|
| `0` | Login | `0` (`LOGIN_CONNECTED`) |
| `1` | Roteamento | `5` (`ROTEAMENTO_BROKER_CONNECTED`) |
| `2` | Market Data | `4` (`MARKET_CONNECTED`) |
| `3` | Ativação | `0` (`CONNECTION_ACTIVATE_VALID`) |

Desde a 4.0.0.39 o canal de market data também devolve
`MARKET_PERFORMANCE_WARNING` (5) e `MARKET_PARTIAL_CONNECTED` (6) — o feed do
servidor está bom, mas a entrega local de callbacks está degradada. Trate o
estado 6 como aviso crítico.

### Identificação de ativos

Um ativo é a tripla (ticker, bolsa, feed). A bolsa é um código de um caractere:

| Código | Bolsa | Código | Bolsa |
|---|---|---|---|
| `B` | Bovespa | `M` | CME |
| `F` | BMF | `N` | Nasdaq |
| `A` | BCB | `O` | OXR |
| `D` | Câmbio | `P` | Pioneer |
| `E` | Economic | `X` | Dow Jones |
| `K` | Metrics | `Y` | NYSE |

O campo de feed é `0` (Nelogica) ou `255` (outro).

## Novidades 4.0.0.31 → 4.0.0.41

### Novas APIs

| API | Versão | Descrição |
|---|---|---|
| `GetHealthStatus` | 4.0.0.41 | Consulta *pull* do estado de saúde interno da DLL |
| `SetHealthCallback` | 4.0.0.41 | Callback do *watchdog* interno |
| `TSystemHealthState` | 4.0.0.41 | `shsResponsive` (0) / `shsFrozen` (1) |

A partir da 4.0.0.41 a DLL monitora suas threads internas (Main e Calc) com um
*watchdog* e passa a gravar logs de performance (*sampling profiler*) em disco
na versão 64 bits.

### Novas constantes

| Constante | Valor | Versão |
|---|---|---|
| `MARKET_PERFORMANCE_WARNING` | 5 | 4.0.0.39 |
| `MARKET_PARTIAL_CONNECTED` | 6 | 4.0.0.39 |
| `NL_HISTORY_PERIOD_LIMIT` | `0x8000002E` | 4.0.0.41 |
| `nTradeType` 14–18 | BBT, RFQ, MPT, TAC, TAA | 4.0.0.41 |
| `nTradeType` 33–35 | Update, Mid, Off Exchange | 4.0.0.41 |

Além desses, a enumeração `NResult` ganhou 14 novos códigos desde a 4.0.0.31.

### Mudança de ABI — atenção

Na 4.0.0.38, os campos `nMinOrderQtd`, `nMaxOrderQtd` e `nLote` de
`TAssetListInfoCallback` e `TAssetListInfoCallbackV2` mudaram de `Integer` para
`Int64`. **Quem registra essas callbacks precisa atualizar as assinaturas** —
caso contrário a pilha é corrompida na chamada.

### Correções relevantes

- `SetTradeCallbackV2` parava de receber trades (4.0.0.38).
- Access Violation em `PopulateOrderOutV0` durante picos de volume (4.0.0.39).
- Callbacks de ordem sem atualização: confirmações intermediárias de roteamento
  eram tratadas como definitivas (4.0.0.41). Espere **mais** eventos por ordem;
  o consumo precisa ser idempotente.

## Troubleshooting

| Sintoma | Causa provável |
|---|---|
| `NL_NOT_INITIALIZED` | `DLLInitializeLogin`/`DLLInitializeMarketLogin` não foi chamada, ou falhou |
| `NL_WAITING_SERVER` | Primeira chamada para o recurso; os dados foram requisitados e virão por callback |
| `NL_VERSION_NOT_SUPPORTED` | Campo `Version` da estrutura não preenchido ou com valor não suportado |
| `NL_MARKET_ONLY` | Função de roteamento chamada em sessão iniciada com `DLLInitializeMarketLogin` |
| `NL_NO_LICENSE` / `NL_LICENSE_NOT_ALLOWED` | Chave de ativação ausente ou sem o recurso liberado |
| `NL_INVALID_TICKER` | Ticker ou bolsa inválidos — confira o código de bolsa de um caractere |
| `NL_HISTORY_PERIOD_LIMIT` | Histórico solicitado com data inicial acima de 30 dias |
| Strings vazias em estruturas `*Out` | Faltou a segunda chamada do padrão *two-pass* |
| Crash aleatório em callback (C#) | *Delegate* coletado pelo GC — falta referência estática |
| Callbacks param de chegar | Processamento lento dentro de um callback travando a fila única |
| Falha ao carregar a DLL | Arquitetura incompatível (32 vs 64 bits) ou DLL fora do diretório de trabalho |

## Licença e créditos

A ProfitDLL, seus manuais e os exemplos de código são propriedade da
**[Nelogica](https://www.nelogica.com.br/)**. Este repositório apenas organiza
e converte essa documentação para Markdown; não redistribui a biblioteca.

Documentação oficial para desenvolvedores:
<https://desenvolvedores.nelogica.com.br/>
