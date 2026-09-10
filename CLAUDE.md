# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose of this repository

**This is a documentation repository, not a software project.** Its purpose is
to document Nelogica's ProfitDLL and to generate the corresponding Markdown
manuals for consumption by AI agents.

The deliverables are:

| File | Role |
|---|---|
| `Manual_ProfitDLL_pt_br.md` | Primary artefact — full 4.0.0.42 manual, pt-BR |
| `Manual_ProfitDLL_en_us.md` | Primary artefact — full 4.0.0.42 manual, en-US |
| `README.md` / `README_EN.md` | Entry point describing the repo, core DLL concepts and the *Extras* (official links, blog posts, community projects) |
| `Manual - ProfitDLL *.pdf` | Official Nelogica PDFs — the source of the conversions |
| `Exemplo {Python,C#,C++,Delphi}/` | Vendor's own examples, kept verbatim as usage reference |

**Do not modify the files under `Exemplo */`.** They ship from Nelogica and are
committed exactly as received; they are reference material, not maintained
software. There is no build system, no test suite and no CI here, and none is
wanted — nothing in this repository is meant to be compiled or run as part of
normal work.

When work here means "update the docs", the unit of work is the Markdown
manuals and the READMEs.

## Where things live

- **The manuals are a faithful copy of the PDF** below the `---` separator:
  same order, headings, wording, lists, tables, quotes and bold text. Above the
  separator sits a hand-maintained preamble for agents (front-matter, usage
  rules, version delta, deprecated-API table, quick index, type mapping,
  conversion notes). Nothing else is added to the manuals.
- **Everything that is not the vendor's manual goes to the READMEs**: the
  *Extras* section (official download link, help-center section and articles,
  the blog-post table, community repositories and acknowledgements), the
  troubleshooting table and the core-concepts notes. Keep it out of the manuals.
- `https://desenvolvedores.nelogica.com.br/` no longer resolves (checked
  2026-09-10); the official documentation link is the help center's
  *DataFeed - DLL* section.

## Regenerating the manuals from the PDFs

The two Markdown manuals are conversions of the official PDFs, not hand-written
files. When Nelogica ships a new version, the PDFs are replaced and the vendor
part of the manuals is regenerated rather than edited by hand; the preamble is
then updated by hand (version, date, page count, delta, index, notes).

The converter script is intentionally **not** in the repository (only finished
Markdown ships here); it is kept outside the repo in the maintainer's local
tooling. Facts that make the conversion possible (rediscovering these is
expensive):

- The PDFs are **Chrome print-to-PDF renders of Nelogica's own Markdown**
  (`Producer: Skia/PDF`, `HeadlessChrome`). The page footer literally reads
  `Manual_ProfitDLL_pt_br.md · <date> · N / 79`, which is where the target
  filenames and the front-matter date come from (4.0.0.42: 79 pages pt-BR,
  78 pages en-US, dated 2026-09-04).
- `pdftotext`/poppler and every Python PDF library are **absent** on this
  machine, and `Read` cannot render these PDFs. Extraction is done with a
  standalone script in pure Python: objects are plain (no object streams),
  content streams are `FlateDecode` with a direct `/Length`, fonts are
  Type0/Identity-H with 2-byte CIDs, and each font has its **own `/ToUnicode`
  CMap** (`bfchar` + `bfrange`) — using a merged CMap across fonts produces
  corrupted text. Glyph widths come from `/W` of the CIDFontType2 descendant.
  Walk `/Catalog → /Pages → /Kids` for page order; object numbers are not in
  reading order.
- **Structure comes from the tagged-PDF structure tree, not from geometry.**
  `/StructTreeRoot → Document` holds `H1..H4`, `P`, `L/LI/Lbl`,
  `Table/TR/TH/TD`, `BlockQuote`, `Strong`, `Em`, inline `Code` and
  `Link/URI`; `<pre>` blocks are bare `NonStruct` children of `Document`/`LI`
  in Consolas. Text runs are `/NonStruct <</MCID n>> BDC … EMC`. `/K` arrays mix
  ints (MCID on the element's `/Pg`), `<</Type /MCR /Pg … /MCID …>>` dicts
  (continuation on another page), references to child elements and `/OBJR`
  entries (ignore) — parse the dicts out first, with `re.S`, or refs inside an
  MCR are mistaken for children.
- Geometry is used only inside a block: raw `Tm`/`Td` coordinates are CSS px
  (body at x=20, `<pre>` at x=44, list text at x=60; sizes 28/21/16.37/14; y
  is continuous through the whole document, not per page). Spans at a new `y`
  inside a paragraph or cell are joined with a space; inside a code block they
  are new lines. The `ArialMT` footer is untagged and discarded.
- **Page-break artefacts:** a `TH` repeated on the next page carries a second
  MCID with identical text (dedupe it, or headers read `NomeNome`); a code
  block's blank lines show up as a 2× line gap (19 px → 38 px), and a print
  soft-wrap shows up as a hanging space at the end of the line plus a next word
  that would not have fitted before x≈707 — re-join those, but keep the line
  breaks the vendor's own text has (e.g. `SubscribePriceDepth` is declared over
  two lines in the source).
- Editorial rule kept from the first conversion: in §3.1/§3.2 each API is a
  list item whose first block is only the API name in `Code`; it is rendered as
  `#### \`Name\`` with the parameter table and text at document level.

## Known divergences to preserve

These are real and should not be "fixed" silently if they resurface:

- The 4.0.0.42 error table omits `NL_PASSWORD_HASH_SHA1` (`0x80000007`) and
  `NL_PASSWORD_HASH_MD5` (`0x80000008`), though both exist in
  `Exemplo Delphi/Types/ProfitConstantsU.pas`.
- Five functions are declared in `Exemplo Delphi/Wrapper/` but appear nowhere in
  the manual: `InitializeCustom`, `ConnectorSetServerAndPort`,
  `ConnectorSetServerAndPortRoteamento`, `GetSerieHistory`, `GetLocationInfo`.
- `RequestSerieHistory` was documented up to 4.0.0.41 (bound by none of the
  four examples) and **removed from the manual in 4.0.0.42**; the Python
  example renamed its `requestHistory` command to `getHistoryTrades` at the
  same time. `GetHistoryTrades` is the only documented trade-history API.
- The official **English** PDF has three layout defects that the conversion
  repairs: `3. Library Interface` is printed as a numbered-list item merged
  with the following paragraph, the bold paragraph
  ``Note on `MARKET_PARTIAL_CONNECTED` `` is merged into the paragraph after
  it, and the changelog's `Bug Fixes` labels under 4.0.0.28 and 4.0.0.24 sit
  one level below their Portuguese counterparts. In both PDFs the
  `MARKET_PARTIAL_CONNECTED` note is a bold paragraph, not a heading.
- The English PDF uses the Portuguese connector `" e "` in the heading
  `GetAgentNameByID e GetAgentShortNameByID`. That is the vendor's text; keep
  it. `SetEnabledHistOrder` sits in different positions in the two PDFs (after
  `GetPosition` in pt-BR, after `GetTheoreticalValues` in en-US) — also the
  vendor's.
- The two PDFs format a few passages differently (pt-BR uses a code block and a
  plain paragraph where en-US uses bullet lists, in `GetPosition` and
  `UnsubscribePriceBook`); each manual follows its own PDF.

## Privacy constraint

The remote (`github.com/rlquilez/nelogica-profitdll`) is **public**. Everything
committed here is published.

Content in this repository must be derived **only** from the official Nelogica
PDFs, the vendor's example code and Nelogica's public pages (help center, blog,
download server) plus the two community repositories credited in the READMEs.
Never carry notes, identifiers, environment variable names, internal function
names, incident history or architectural decisions from any other codebase into
these documents, even as an illustration — a previous draft of the manual had
to be discarded for mixing in material from an unrelated private project. Do
not publish personal e-mail addresses of the community authors; credit them by
name and repository only.

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

**Trade history is window-limited.** `GetHistoryTrades` refuses a start date
older than 30 days (`NL_HISTORY_PERIOD_LIMIT`) and, for `WIN*`/`WDO*` tickers,
a range that reaches 10 days (`NL_INVALID_ARGS`); the vendor's own guidance is
to request day by day and watch `TProgressCallback`.

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
