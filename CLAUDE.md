# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose of this repository

**This is a documentation repository, not a software project.** Its purpose is
to document Nelogica's ProfitDLL and to generate the corresponding Markdown
manuals for consumption by AI agents.

The deliverables are:

| File | Role |
|---|---|
| `Manual_ProfitDLL_pt_br.md` | Primary artefact — full 4.0.0.41 manual, pt-BR |
| `Manual_ProfitDLL_en_us.md` | Primary artefact — full 4.0.0.41 manual, en-US |
| `README.md` / `README_EN.md` | Entry point describing the repo and core DLL concepts |
| `Manual - ProfitDLL *.pdf` | Official Nelogica PDFs — the source of the conversions |
| `Exemplo {Python,C#,C++,Delphi}/` | Vendor's own examples, kept verbatim as usage reference |

**Do not modify the files under `Exemplo */`.** They ship from Nelogica and are
committed exactly as received; they are reference material, not maintained
software. There is no build system, no test suite and no CI here, and none is
wanted — nothing in this repository is meant to be compiled or run as part of
normal work.

When work here means "update the docs", the unit of work is the Markdown
manuals and the READMEs.

## Regenerating the manuals from the PDFs

The two Markdown manuals are conversions of the official PDFs, not hand-written
files. When Nelogica ships a new version, the PDFs are replaced and the manuals
are regenerated rather than edited by hand.

Facts that make the conversion possible (rediscovering these is expensive):

- The PDFs are **Chrome print-to-PDF renders of Nelogica's own Markdown**
  (`Producer: Skia/PDF`). The page footer literally reads
  `Manual_ProfitDLL_pt_br.md · <date> · N / 79`, which is where the target
  filenames come from.
- `pdftotext`/poppler is **not** installed on this machine, and `Read` cannot
  render these PDFs. Extraction is done with a standalone script that inflates
  the `FlateDecode` content streams and decodes each `/ToUnicode` CMap
  **per font resource of the page** — using a merged CMap across fonts produces
  corrupted text.
- Structure is recovered from font role plus geometry, not from guessing:

  | Signal | Meaning |
  |---|---|
  | size 28 / 21 / 16.4 | `#` / `##` / `###` |
  | `SegoeUI-Bold` at x=20 | `####` label |
  | `Consolas` alone at x=60, inside §3.1/§3.2 | `#### \`ApiName\`` |
  | x=44 | code block |
  | x=20 | paragraph |
  | x=30 or x≥70, multi-column | table |
  | `ArialMT` | running footer — discard |

- Headings render letter-by-letter and words split mid-token (`wat chdog`);
  merging adjacent same-role spans repairs this.
- Table columns must be assigned from **raw** spans; merging spans first fuses
  adjacent columns. Wrapped cells appear as separate lines that interleave by
  `y`, so rows and orphan fragments are matched in two passes using a
  page-global `y`.

The conversion scripts live in the session scratchpad, not in the repo — this
repository intentionally ships only the finished Markdown.

## Known divergences to preserve

These are real and should not be "fixed" silently if they resurface:

- The 4.0.0.41 error table omits `NL_PASSWORD_HASH_SHA1` (`0x80000007`) and
  `NL_PASSWORD_HASH_MD5` (`0x80000008`), though both exist in
  `Exemplo Delphi/Types/ProfitConstantsU.pas`.
- Five functions are declared in `Exemplo Delphi/Wrapper/` but appear nowhere in
  the manual: `InitializeCustom`, `ConnectorSetServerAndPort`,
  `ConnectorSetServerAndPortRoteamento`, `GetSerieHistory`, `GetLocationInfo`.
- `RequestSerieHistory` is documented but bound by none of the four examples.
- The official **English** PDF has three layout defects that the conversion
  repairs: `3. Library Interface` and ``Note on `MARKET_PARTIAL_CONNECTED` ``
  lost their heading level and merged into the following paragraph, and the
  changelog's `Bug Fixes` labels sit one level below their Portuguese
  counterparts.
- The English PDF uses the Portuguese connector `" e "` in the heading
  `GetAgentNameByID e GetAgentShortNameByID`. That is the vendor's text; keep
  it.

## Privacy constraint

The remote (`github.com/rlquilez/nelogica-profitdll`) is **public**. Everything
committed here is published.

Content in this repository must be derived **only** from the official Nelogica
PDFs and the vendor's example code. Never carry notes, identifiers, environment
variable names, internal function names, incident history or architectural
decisions from any other codebase into these documents, even as an
illustration — a previous draft of the manual had to be discarded for mixing in
material from an unrelated private project.

Before committing, scan the tracked files for such markers and stop if any
appear.

## The DLL contract (reference)

Domain knowledge needed to review or extend the documentation. These are
properties of the DLL that explain the shape of the vendor's example code.

**Callbacks run on the DLL's `ConnectorThread` and share one message queue.**
Slow work in any callback delays all others. Do not call DLL request functions
from inside a callback; the *accessory* functions (`TranslateTrade`,
`GetOrderDetails`, `GetPriceGroup`, `GetTheoreticalValues`) are the documented
exception and are meant to be called there.

**Callback references must outlive registration.** C# keeps a `static readonly`
delegate per callback (`Program.cs`, `#region Callback Holders`) because the GC
would otherwise collect the thunk. Module-level `@WINFUNCTYPE` functions do the
same in Python.

**`TConnector*` structs carry a leading `Version : Byte` that must be set.**
Unset or unsupported returns `NL_VERSION_NOT_SUPPORTED`. Most accept `0`;
`TConnectorSendOrder` accepts `0` or `1`.

**`*Out` structs use a two-pass call:** first call fills `*Length` counters, you
allocate, second call returns content. Same for `GetAgentNameLength` →
`GetAgentName` and count-then-fill array APIs.

**Returns are `NResult`:** `NL_OK` is `0`, errors negative. Order-sending
functions return a positive LocalOrderID, so test `< 0`, not `!= 0`. Canonical
list: `Exemplo Delphi/Types/ProfitConstantsU.pas`.

**Two API generations coexist.** `Legacy*` files hold the flat string-argument
API; the current API is the versioned `TConnector*` family. `DLLInitializeLogin`
still takes the legacy callbacks positionally, so the examples pass `null` and
register the modern replacements immediately after — see
`Exemplo C#/Program.cs` (`InitializeDLL`) and `Exemplo Python/main.py`
(`dllStart`).

**Connection readiness is a four-channel state machine** delivered through
`StateCallback(nConnStateType, nResult)`: `0` login (ready `0`), `1` routing
(ready `5`), `2` market data (ready `4`), `3` activation (ready `0`). Since
4.0.0.39 market data also reports `MARKET_PERFORMANCE_WARNING` (5) and
`MARKET_PARTIAL_CONNECTED` (6).

## Conventions

Identifiers and prose mix Portuguese and English throughout, following the
vendor's own vocabulary — `corretora` (broker), `bolsa` (exchange), `conta`
(account), `titular` (account holder), `roteamento` (order routing), `ativo`
(instrument), `qtd` (quantity). Match the surrounding file rather than
normalising to English.

The two READMEs and the two manuals are translations of one another. A change
to one must be mirrored in its counterpart; structural parity (heading and
table counts) is a verification step.

`.github/instructions/` is a gitignored personal collection of generic Copilot
instruction files unrelated to this project — it is not a source of rules for
this repository.
