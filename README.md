# ProfitDLL — Documentação Técnica

**Documentação de referência da ProfitDLL 4.0.0.42 (Nelogica), em Markdown, preparada para consumo por agentes de IA.**

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
4. **Referências externas**, na seção *Extras* ao final deste README: o link
   oficial de download da DLL, a central de ajuda da Nelogica com os artigos
   sobre a DLL, uma tabela-resumo de todos os posts do blog da Nelogica sobre
   Data Solution e projetos da comunidade que usam a ProfitDLL em C# e Python.

| Arquivo | Conteúdo |
|---|---|
| [`Manual_ProfitDLL_pt_br.md`](Manual_ProfitDLL_pt_br.md) | Manual completo 4.0.0.42 em português (79 páginas convertidas) |
| [`Manual_ProfitDLL_en_us.md`](Manual_ProfitDLL_en_us.md) | Manual completo 4.0.0.42 em inglês (78 páginas convertidas) |
| `Manual - ProfitDLL pt_br.pdf` / `en_us.pdf` | PDFs oficiais da Nelogica 4.0.0.42 (fonte das conversões) |
| `Exemplo Python/`, `Exemplo C#/`, `Exemplo C++/`, `Exemplo Delphi/` | Exemplos oficiais do fabricante |
| Seção *Extras* deste README | Download oficial, central de ajuda, posts do blog da Nelogica e projetos da comunidade |
| `CLAUDE.md` | Regras de manutenção do repositório para agentes de codificação: o que vai nos manuais e o que vai nos READMEs, e como regenerar a conversão |

> **A `ProfitDLL.dll` não está neste repositório.** Ela é proprietária e
> licenciada pela Nelogica. Nada aqui executa sem a DLL, uma chave de ativação
> e credenciais de conta. O pacote oficial com a DLL, os manuais e os exemplos
> está em [Extras → Download oficial](#download-oficial-da-profitdll).

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
  função, com as células exatamente como no PDF.
- **Declarações Delphi íntegras:** as linhas que a impressão do PDF quebrou
  foram reunidas, e cada bloco de código é uma cópia fiel do original.
- **Abaixo do separador `---`, o conteúdo é o do PDF oficial**, na mesma ordem
  e com a mesma redação; divergências entre manual e código são anotadas no
  preâmbulo, não silenciadas.
- **Recursos externos ficam neste README, não nos manuais:** os links
  oficiais, os posts do blog e os projetos da comunidade estão na seção
  *Extras*, para que os manuais permaneçam cópia fiel do PDF.

Aponte seu agente para o manual do idioma desejado e ele terá a referência
completa da API sem precisar abrir o PDF.

## ProfitDLL 4.0.0.42 — visão geral

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
| Histórico de trades | `GetHistoryTrades` (janela de 30 dias; WIN/WDO em fatias menores que 10 dias), `SetHistoryTradeCallbackV2` |
| Envio de ordens | `SendOrder`, `SendChangeOrderV2`, `SendCancelOrderV2` |
| Posição | `GetPositionV2`, `SendZeroPositionV2`, `EnumerateAllPositionAssets` |
| Contas e subcontas | `GetAccountCount`, `GetAccounts`, `GetAccountDetails`, `GetSubAccounts` |
| Saúde da DLL | `GetHealthStatus`, `SetHealthCallback` |

## Exemplos por linguagem

Os quatro exemplos fazem o mesmo — inicializam a DLL com chave de ativação,
usuário e senha e executam funções sob demanda — mas cada um coleta esses dados
de um jeito:

- **Python** pede chave, usuário e senha no terminal e entra em um laço de
  comandos digitados (`subscribe`, `offerbook`, `position`, `buyAtMarket`,
  `getHistoryTrades`, `healthStatus`, `exit`, …).
- **C#** pede usuário, senha e chave no terminal; seu laço de comandos usa
  nomes próprios (`subscribe`, `send order`, `get position`,
  `request history`, `exit`, …).
- **C++** tem chave, usuário, senha, conta e corretora como constantes no
  início de `main()` (marcadas com *Preencher*) e executa um roteiro fixo de
  chamadas, sem laço de comandos.
- **Delphi** é um formulário VCL com campos para as credenciais e uma lista de
  funções para acionar.

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

A cobertura da API não é idêntica entre eles: só o exemplo Python faz o
binding das APIs de saúde (`GetHealthStatus`, `SetHealthCallback`,
`TSystemHealthState`), e o exemplo C# manteve o comando `request history`
enquanto o Python o renomeou para `getHistoryTrades` na 4.0.0.42.

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
sucesso — por isso teste `< 0`, e não `!= 0`. A tabela do manual lista 32
códigos; a enumeração canônica, `Exemplo Delphi/Types/ProfitConstantsU.pas`,
define 47. Os 15 que só existem no cabeçalho Delphi (13 deles adicionados
desde a 4.0.0.31) são retornos válidos e estão aqui para que nenhum código
fique sem nome:

| Código | Valor | Significado (comentário do cabeçalho) |
|---|---|---|
| `NL_PASSWORD_HASH_SHA1` | `0x80000007` | Senha não está em SHA1 |
| `NL_PASSWORD_HASH_MD5` | `0x80000008` | Senha não está em MD5 |
| `NL_NOT_MY_TRADE` | `0x80000021` | Trade/oferta não pertence a nenhuma conta do usuário |
| `NL_NOT_EQUALS` | `0x80000022` | Dois recursos não são iguais |
| `NL_INVALID_DLL_AUTH` | `0x80000023` | DLL não validada pelo HMAC |
| `NL_INVALID_SIGNATURE` | `0x80000024` | DLL não validou o executável |
| `NL_NOT_IMPLEMENTED` | `0x80000025` | Feature ainda não implementada |
| `NL_BROKER_NOT_ALLOWED` | `0x80000026` | Broker sem acesso ao recurso do backoffice |
| `NL_FILE_NOT_EXISTS` | `0x80000027` | Arquivo não existe |
| `NL_NTSL_PARSE_FAILED` | `0x80000028` | Parse do Language falhou |
| `NL_NTSL_TOO_MANY_ASSETS` | `0x80000029` | Muitos assets usados no código NTSL |
| `NL_NOT_CONSISTENT` | `0x8000002A` | Recurso não é considerado consistente |
| `NL_SINGLE_THREADED` | `0x8000002B` | (sem comentário no cabeçalho) |
| `NL_NOT_SAME_THREAD` | `0x8000002C` | (sem comentário no cabeçalho) |
| `NL_TIMEOUT` | `0x8000002D` | (sem comentário no cabeçalho) |

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

### Histórico de trades tem limites de janela

`GetHistoryTrades` recusa requisições cuja data inicial seja anterior a 30 dias
(`NL_HISTORY_PERIOD_LIMIT`). Para tickers iniciados em `WIN` ou `WDO`, o
intervalo entre `dtDateStart` e `dtDateEnd` não pode alcançar 10 dias
(`NL_INVALID_ARGS`) — requisite o histórico desses contratos dia a dia e use
`TProgressCallback` para detectar o fim de cada carga.

## Novidades 4.0.0.31 → 4.0.0.42

### 4.0.0.42 em resumo

Versão de correções: nenhuma API, estrutura ou constante foi adicionada ou
removida na DLL.

- **DLL:** corrigido atraso na entrega das callbacks de ordem; corrigida exceção
  ao realizar um novo `SubscribeOfferBook`; corrigido o identificador de
  processo (PID) enviado pela DLL ao servidor.
- **Manual:** `GetHistoryTrades` passou a documentar os limites de 30 dias
  (`NL_HISTORY_PERIOD_LIMIT`) e de 10 dias para WIN/WDO (`NL_INVALID_ARGS`);
  a seção de `RequestSerieHistory` foi removida — `GetHistoryTrades` é a única
  API de histórico de trades documentada.
- **Exemplo Python:** o comando `requestHistory` virou `getHistoryTrades`
  (a função já chamava `GetHistoryTrades`). Os demais exemplos não mudaram.

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

Além desses, `ProfitConstantsU.pas` ganhou 14 códigos `NResult` desde a
4.0.0.31, mas só `NL_HISTORY_PERIOD_LIMIT` entrou na tabela do manual — os
demais estão listados em *Códigos de retorno `NResult`*.

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
- Atraso na entrega das callbacks de ordem (4.0.0.42).
- Exceção ao realizar um novo `SubscribeOfferBook` (4.0.0.42).
- Identificador de processo (PID) enviado pela DLL ao servidor (4.0.0.42).

## Troubleshooting

| Sintoma | Causa provável |
|---|---|
| `NL_NOT_INITIALIZED` | `DLLInitializeLogin`/`DLLInitializeMarketLogin` não foi chamada, ou falhou |
| `NL_WAITING_SERVER` | Primeira chamada para o recurso; os dados foram requisitados e virão por callback |
| `NL_VERSION_NOT_SUPPORTED` | Campo `Version` da estrutura não preenchido ou com valor não suportado |
| `NL_MARKET_ONLY` | Função de roteamento chamada em sessão iniciada com `DLLInitializeMarketLogin` |
| `NL_NO_LICENSE` / `NL_LICENSE_NOT_ALLOWED` | Chave de ativação ausente ou sem o recurso liberado |
| `NL_INVALID_TICKER` | Ticker ou bolsa inválidos — confira o código de bolsa de um caractere |
| `NL_HISTORY_PERIOD_LIMIT` | `GetHistoryTrades` com data inicial anterior a 30 dias |
| `NL_INVALID_ARGS` em `GetHistoryTrades` | Ticker `WIN*`/`WDO*` com intervalo de 10 dias ou mais entre `dtDateStart` e `dtDateEnd` — requisite dia a dia |
| Strings vazias em estruturas `*Out` | Faltou a segunda chamada do padrão *two-pass* |
| Crash aleatório em callback (C#) | *Delegate* coletado pelo GC — falta referência estática |
| Callbacks param de chegar | Processamento lento dentro de um callback travando a fila única |
| Falha ao carregar a DLL | Arquitetura incompatível (32 vs 64 bits) ou DLL fora do diretório de trabalho |

## Extras — recursos oficiais e comunidade

Esta seção reúne os canais oficiais da Nelogica sobre a ProfitDLL e projetos
abertos da comunidade que a utilizam. Nada aqui substitui a licença nem o
suporte da Nelogica.

### Download oficial da ProfitDLL

A última versão do pacote oficial — DLL de 32 e 64 bits, executável de teste
em Delphi, arquivos de interface, os manuais em PDF e os exemplos nas quatro
linguagens — está em:

<https://download-setup.nelogica.com.br/connector/latest/ProfitDLL.zip>

O mesmo pacote também é oferecido na área do cliente Nelogica (login →
*Assinaturas* → licença *DLL Feed* → *Download*). A DLL só funciona com uma
chave de ativação e uma conta habilitada; quem ainda não é cliente deve
contratar o Data Solution pela [NeloStore](https://store.nelogica.com.br/data-solution).

### Ajuda oficial (Nelogica)

Para dúvidas gerais sobre o Data Solution (DLL) ou questões de suporte, use os
canais da própria Nelogica:

- Central de ajuda: <https://ajuda.nelogica.com.br/>
- Seção *DataFeed - DLL* da central de ajuda, com os artigos abaixo:
  <https://ajuda.nelogica.com.br/hc/pt-br/sections/11307712057883-DataFeed-DLL>

| Artigo | Tema |
|---|---|
| [Ecossistema ProfitDLL e primeiros passos](https://ajuda.nelogica.com.br/hc/pt-br/articles/22396517026203) | O que é a DLL, modos de inicialização (market data × roteamento), callbacks |
| [Como obter acesso à ProfitDLL](https://ajuda.nelogica.com.br/hc/pt-br/articles/51583791325211) | Licenciamento e onde baixar o `ProfitDLL.zip` com manual e exemplos |
| [Introdução ao Produto DLL Real Time](https://ajuda.nelogica.com.br/hc/pt-br/articles/11166353435035) | Visão geral do produto DLL Real Time |
| [Funções Real Time - DLL](https://ajuda.nelogica.com.br/hc/pt-br/articles/11168755650459) | Referência resumida das funções |
| [Como rotear ordens com a ProfitDLL](https://ajuda.nelogica.com.br/hc/pt-br/articles/13312468554651) | Envio, alteração e cancelamento de ordens |
| [Como requisitar trades históricos com a ProfitDLL](https://ajuda.nelogica.com.br/hc/pt-br/articles/11973319153563) | `GetHistoryTrades`, limites e callbacks de histórico |
| [Como utilizar o Livro de Profundidade (Price Depth) via DLL Real Time](https://ajuda.nelogica.com.br/hc/pt-br/articles/50587290263835) | `SubscribePriceDepth`, `GetPriceGroup` |
| [ProfitDLL no Linux: Saiba como acessar e utilizar](https://ajuda.nelogica.com.br/hc/pt-br/articles/54973527417243) | Execução da DLL em Linux |
| [Problemas e dúvidas comuns - DLL Real Time](https://ajuda.nelogica.com.br/hc/pt-br/articles/11166562187803) | FAQ oficial |
| [Como saber se a DLL está conectada](https://ajuda.nelogica.com.br/hc/pt-br/articles/11168955426331) | Estados de conexão (`TStateCallback`) |
| [Logs de DLL não são gerados usando Python, e agora?](https://ajuda.nelogica.com.br/hc/pt-br/articles/11168640008859) | Logs da DLL em Python |
| [Requisitando ajustes de ativos com a DLL Real Time](https://ajuda.nelogica.com.br/hc/pt-br/articles/13312278467099) | `SubscribeAdjustHistory` e callbacks de ajuste |
| [Do tick ao dashboard: construa sua análise de players com a ProfitDLL](https://ajuda.nelogica.com.br/hc/pt-br/articles/11966404695195) | Agentes de compra/venda a partir dos trades |
| [Conheça os Principais Benefícios do Data Solution Nelogica](https://ajuda.nelogica.com.br/hc/pt-br/articles/11966232254619) | Visão comercial do Data Solution |
| [Introdução ao produto Base Histórica de Dados](https://ajuda.nelogica.com.br/hc/pt-br/articles/11169074066715) | Produto irmão: base histórica (não é a DLL) |
| [Tipos de Arquivos e Exemplos de Layout - Base Histórica de Dados](https://ajuda.nelogica.com.br/hc/pt-br/articles/11169423343515) | Layouts dos arquivos da base histórica |
| [Disponibilidade de Dados Históricos para exportação em .CSV](https://ajuda.nelogica.com.br/hc/pt-br/articles/11169188636443) | Cobertura da base histórica em CSV |

### Blog Nelogica — categoria Data Solution

Todos os posts publicados pela Nelogica na categoria
<https://blog.nelogica.com.br/categoria/data-solution/> (levantamento de
2026-09-10; posts em português):

| Data | Post | Resumo | Relação com a DLL |
|---|---|---|---|
| 2026-08-25 | [Como usar a ProfitDLL no Linux?](https://blog.nelogica.com.br/profitdll-linux/) | Tutorial passo a passo para rodar a ProfitDLL no Ubuntu executando o Python x64 de Windows dentro do Wine; termina com um consumidor de trades do WINFUT e os cuidados dentro do callback | Direta (Python) |
| 2026-08-24 | [Quant trading: tome decisões baseadas em dados](https://blog.nelogica.com.br/quant-trading/) | Guia conceitual de trading quantitativo: análise quantitativa, fundos e algoritmos, estratégias e FAQ; aponta o Data Solution como fonte de dados | Conceitual |
| 2026-07-24 | [6 principais benefícios de Data Solution para traders](https://blog.nelogica.com.br/beneficios-data-solution/) | Visão de produto: dados consolidados e ajustados, feed único e escalável, baixa latência, histórico de 30+ anos da B3, backtesting e automação | Produto |
| 2026-07-14 | [API de dados da B3: automatize suas operações com a DLL](https://blog.nelogica.com.br/api-de-dados-da-b3/) | O que é uma API de dados da B3 e para que serve (algoritmos, sites, machine learning), apresentando o Data Solution e a conectividade via DLL | Produto |
| 2026-07-01 | [Como construir um replay de mercado com a Profit DLL?](https://blog.nelogica.com.br/como-construir-replay-mercado-profitdll/) | Arquitetura de um replay tick a tick sobre a ProfitDLL: fonte de dados intercambiável, histórico em arquivo, relógio virtual, reprodução instantânea ou animada, Times & Trades e indicadores | Direta |
| 2026-07-01 | [Como aplicar as Bandas de Bollinger com ProfitDLL?](https://blog.nelogica.com.br/bandas-bollinger-profitdll/) | Reaproveita o pipeline tick → candle → indicador para calcular Bandas de Bollinger (média ± k desvios), com janela móvel e aquecimento | Direta |
| 2026-06-10 | [Como calcular médias móveis usando a ProfitDLL?](https://blog.nelogica.com.br/como-calcular-medias-moveis-usando-a-profitdll/) | A DLL entrega ticks, não candles: como montar o candle OHLCV de 1 minuto, combinar histórico de 30 dias com tempo real e por que a semente da EMA diverge do gráfico | Direta |
| 2026-06-08 | [Como requisitar os trades históricos no ProfitDLL?](https://blog.nelogica.com.br/como-requisitar-trades-historicos-profitdll/) | Limites e formato da requisição, fluxo passo a passo, o que cada callback entrega e boas práticas: requisitar dia a dia, usar o callback de progresso, pular fins de semana e nunca chamar a DLL dentro de callbacks | Direta |
| 2026-01-26 | [O que é o Data Solution e como usar dados de mercado da B3?](https://blog.nelogica.com.br/data-solution/) | Visão geral do Data Solution: casos de uso, vantagens e os produtos que o compõem (base histórica + DLL em tempo real) | Produto |
| 2020-12-18 | [Por que os dados históricos da B3 são essenciais para qualquer trader?](https://blog.nelogica.com.br/dados-historicos-da-b3/) | Dados históricos da B3, cobertura disponível e cinco razões para usá-los (backtesting, análise técnica, robôs, pesquisa, gestão) | Dados |

### Exemplos de utilização da comunidade

Projetos abertos, independentes da Nelogica, que mostram a ProfitDLL em uso
real. A DLL em si continua tendo de ser obtida da Nelogica.

| Repositório | Autor | O que oferece |
|---|---|---|
| [YouTrade/DLLNelogica](https://github.com/YouTrade/DLLNelogica) | Marcelo Rahal Coutinho (YouTrade) | Projeto educacional em C# / .NET 9, série *Programando o seu robô de trading*: do login à assinatura de ativos e recepção de cotações via P/Invoke, com log assíncrono em arquivo. Licença MIT. |
| [diogojrdev/profitdll-wrapper](https://github.com/diogojrdev/profitdll-wrapper) | Diogo Ribeiro | Wrapper Python (ctypes, sem dependências, Python 3.10+) com tipagem, callbacks que apenas enfileiram, roteamento de ordens, posição e ingestão de histórico tick a tick em SQLite, PostgreSQL/TimescaleDB, Parquet e CSV; exemplos, testes e pacote `profitdll-wrapper` no PyPI. Licença MIT. |

### Agradecimentos

Obrigado a **Marcelo Rahal Coutinho** (YouTrade) e a **Diogo Ribeiro** por
publicarem esses projetos em código aberto — eles são a melhor referência
prática, além dos exemplos oficiais, de como a ProfitDLL se comporta em C# e
em Python.

## Licença e créditos

A ProfitDLL, seus manuais e os exemplos de código são propriedade da
**[Nelogica](https://www.nelogica.com.br/)**. Este repositório apenas organiza
e converte essa documentação para Markdown; não redistribui a biblioteca. Os
projetos da comunidade citados acima têm licenças e autores próprios e não
são afiliados à Nelogica.

Documentação oficial da ProfitDLL (central de ajuda, seção *DataFeed - DLL*):
<https://ajuda.nelogica.com.br/hc/pt-br/sections/11307712057883-DataFeed-DLL>
