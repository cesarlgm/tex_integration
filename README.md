# texlink

Stata package for writing publication-ready LaTeX tables and figures directly from Stata. Rather than relying on fixed-format exporters, `texlink` gives fine-grained control over the LaTeX output by writing raw `.tex` files line by line, making it straightforward to match any journal style.

## Commands

### Tables

The standard table workflow is: `textablehead` → body rows → `textablefoot`.

| Command | Description |
|---|---|
| `textablehead` | Opens a `.tex` file and writes the table preamble: `\begin{tabular}`, column alignment, `\toprule`, column numbers, and titles |
| `textablefoot` | Appends `\bottomrule`, tablenotes, and closing environment tags |
| `leanesttab` | Thin wrapper around `esttab` that appends regression results in a clean format |
| `write_summ_stats` | Appends summary statistics rows (N, Mean, Min, Max, SD) for a variable list |
| `texbf` | Appends a bold (or bold-italic) group heading row |
| `texspec` | Appends a specification indicator row with `\checkmark` marks |

Both `textablehead` and `textablefoot` support `scheme(aea)` for AEA journal formatting, `landscape`, and separate paper/slide output modes.

```stata
textablehead using output/tab/reg.tex, ///
    coltitles("OLS" "IV") title(Returns to education) key(tab_main)
leanesttab m_ols m_iv using output/tab/reg.tex
texspec using output/tab/reg.tex, spec(y y) label(Individual controls)
texspec using output/tab/reg.tex, spec(n y) label(Firm FE)
textablefoot using output/tab/reg.tex, ///
    notes(Standard errors clustered at the firm level.) nodate
```

### Figures

| Command | Description |
|---|---|
| `latexfigure` | Writes a complete `\begin{figure}...\end{figure}` environment, with support for single figures and multi-panel `\subfloat` layouts |

```stata
latexfigure using output/fig/wages.tex, ///
    path(../output/fig) figurelist(wages_m.pdf wages_f.pdf) ///
    rowsize(2) figlab(`" "Men" "Women" "') ///
    title(Wages by gender) key(fig_wages)
```

### Writing inline numbers

| Command | Description |
|---|---|
| `writetext` | Writes a single formatted number to a file for `\input{}` into LaTeX text |
| `writelntc` | Writes `\newcommand` definitions to a file |
| `writeln` | Low-level utility: appends an arbitrary line to a file |

```stata
sum wages
writetext, file(output/text/mean_wage.tex) text(`r(mean)')
writelntc using output/text/macros.tex, command(\Nobs) text(`r(N)') start
```

### Graph styling

| Command | Description |
|---|---|
| `grscheme` | Initialises a `plotplain`-based graph scheme with a named colour palette via `grstyle` and `colorpalette` |

```stata
grscheme, ncolor(4) palette(Set1)
```

## Paper vs. slide output

Commands that write `.tex` files accept `slide` and `mod` options to direct output to `filename_slide.tex` or `filename_paper.tex` respectively, keeping paper and presentation outputs in sync from a single do-file.

## Installation

```stata
net install texlink, from("https://raw.githubusercontent.com/cesarlgm/texlink/main") replace
```

Or from a local clone:

```stata
net install texlink, from("/path/to/texlink") replace
```

## Requirements

- Stata 14 or later
- [`esttab`](http://repec.sbe.org/bocode/e/estout.html) (from SSC) for `leanesttab`
- [`grstyle`](https://repec.sbe.org/bocode/g/grstyle.html), [`colorpalette`](https://repec.sbe.org/bocode/c/colorpalette.html), and `symbolpalette` (from SSC) for `grscheme`
- LaTeX packages: `booktabs`, `threeparttable`, `adjustbox`, `subfig`, `makecell` (and `pdflscape` for landscape tables/figures)

## Author

César Garro-Marín, University of Edinburgh — cgarrom@ed.ac.uk
