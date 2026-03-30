# A Complexity-Theoretic Foundation for Metrology — Books I–III

> Formalizing when single-run measurement claims are finitely certifiable. This repository contains the LaTeX sources for three volumes: **Book I – Type A (statistical) foundations**, **Book II – Attractor‑Basin program for Type B certification**, and **Book III – Finite tests, Fact Decomposition‑Independence (FDI), and implications for physics**.

## What’s inside (very short)
- **Book I — Getting started with Type A Measurements.** Formalizes the *Measurement Chain* and proves the **Guard‑Band Equivalence**: deterministic, polynomial‑size witnesses exist exactly for guard‑band predicates; positive information loss ⇒ NP‑certifiability; lossless channels push certification to \(\Pi^0_2\)-hardness.
- **Book II — The Attractor‑Basin Program for Type B Certification.** Introduces the **Minimal Certification Standard**, the **Double‑Bound** method, and proves the **Attractor‑Basin Equivalence Theorem (ABET)**. Defines the **Simple Test** (one certified tick after basin entry).
- **Book III — Finite Tests, FTE & FDI.** Proves the **Fundamental Test Equivalence (FTE)** and the **Fact Decomposition‑Independence (FDI)** theorem; pinpoints which axioms (C, T, I, EM1–EM3) are responsible for hypercomputational behavior; includes clean HALT embeddings and an audit of quantum‑measurement interpretations.

## Repository layout
```
Book_I/
  00_preamble.tex
  01_chapter_1.tex
  ...
  00_appendix.tex

Book_II/
  00_preamble.tex
  01_chapter_1.tex
  ...
  08_chapter_8.tex

Book_III/
  00_preamble.tex
  01_chapter_1.tex
  ...
  06_appendix.tex
  07_axiom_fact_diagram.tex
```
> Each `00_preamble.tex` is a master file that sets metadata and (by sectioning) encompasses the chapters in the same folder.

## Build
You’ll need a reasonably complete TeX distribution (TeX Live 2023+ recommended) with these packages: `amsmath`, `amssymb`, `amsthm`, `amsfonts`, `graphicx`, `hyperref`, `enumitem`, `tikz` (with `positioning`, `arrows.meta`, `decorations.pathreplacing`, `calc`, `backgrounds`), `pdflscape`, `braket`, and `xr`.

Build each volume to PDF with `latexmk` (or your engine of choice):
```bash
cd Book_I   && latexmk -pdf -interaction=nonstopmode 00_preamble.tex && cd ..
cd Book_II  && latexmk -pdf -interaction=nonstopmode 00_preamble.tex && cd ..
cd Book_III && latexmk -pdf -interaction=nonstopmode 00_preamble.tex && cd ..
```

> Cross‑document references use the `xr` package. Compile from the book folder so relative paths to other chapters resolve.

## Cite this work
**Dmytro Surdu. _A Complexity‑Theoretic Foundation for Metrology_, Books I–III, 2025. CC BY 4.0.**  
Repository: \<link to this repo\> • License: <https://creativecommons.org/licenses/by/4.0/>

If you reuse or adapt, please include: title, author, year, link to source, and the CC BY 4.0 notice.

## License
All text and figures are licensed **Creative Commons Attribution 4.0 International (CC BY 4.0)**. See [`LICENCE.md`](LICENCE.md) for details and a human‑readable summary.

## Contributing
Pull requests are welcome (typos, clarity edits, figures, LaTeX fixes). Please keep notation/style consistent and avoid adding non‑free assets. By contributing, you agree your changes are released under CC BY 4.0.

## Provenance (source documents)
- Book I (selected chapters & preamble).  
- Book II (selected chapters & preamble).  
- Book III (selected chapters, preamble & figures).

*Provenance markers for the current repository snapshot:*  
Book III source exemplar • Book II source exemplar • Book I source exemplar.

