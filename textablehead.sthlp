{smcl}
{* *! version 1.1  2025}{...}
{viewerjumpto "Syntax" "textablehead##syntax"}{...}
{viewerjumpto "Description" "textablehead##description"}{...}
{viewerjumpto "Options" "textablehead##options"}{...}
{viewerjumpto "Examples" "textablehead##examples"}{...}

{title:Title}
{phang}
{bf:textablehead} {hline 2} Write a LaTeX table header to a .tex file

{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:textablehead} {cmd:using} {it:filename}{cmd:,}
[{it:options}]

{synoptset 24 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Column specification}
{synopt:{opt ncols(#)}}number of data columns (required if coltitles() is not given){p_end}
{synopt:{opt coltitles(str asis)}}tokenised list of column header titles{p_end}
{syntab:Table labels}
{synopt:{opt f:irsttitle(str)}}header for the first (labels) column; default is blank{p_end}
{synopt:{opt t:itle(str)}}table caption text{p_end}
{synopt:{opt key(str)}}label key; produces \label{{}tab:key{}}{p_end}
{synopt:{opt sup:ertitle(str)}}spanning header above the data columns{p_end}
{synopt:{opt ex:head(str)}}raw LaTeX inserted above the column titles{p_end}
{syntab:Alignment}
{synopt:{opt col:alignment(str)}}alignment of data columns (l, c, or r); default is {bf:c}{p_end}
{synopt:{opt ful:lalignment(str)}}full tabular alignment string, overriding colalignment(){p_end}
{synopt:{opt cellalign(str)}}alignment inside \makecell for column headers; default is {bf:c}{p_end}
{synopt:{opt ctformat(str)}}LaTeX formatting applied to column title text{p_end}
{syntab:Layout}
{synopt:{opt drop:colnums}}omit the (1) (2) … column-number row{p_end}
{synopt:{opt inv:ert}}swap the order of column numbers and column titles{p_end}
{synopt:{opt NOFirst}}omit the first (labels) column entirely{p_end}
{synopt:{opt double:rule}}add a second \toprule for a double top rule{p_end}
{synopt:{opt adj:ust(str)}}adjustbox max width as fraction of \textwidth; default is {bf:.9}{p_end}
{synopt:{opt land:scape}}wrap table in a landscape environment{p_end}
{synopt:{opt nocap:tion}}suppress the \caption{} command{p_end}
{syntab:Output mode and style}
{synopt:{opt scheme(str)}}set to {bf:aea} for AEA journal formatting{p_end}
{synopt:{opt SLide}}write output to {it:filename}_slide.tex{p_end}
{synopt:{opt Mod}}write output to {it:filename}_paper.tex{p_end}
{synoptline}
{p2colreset}{...}

{pstd}
{bf:textablehead} returns:{p_end}
{synoptset 24}{...}
{synopt:{cmd:r(new_name)}}the output filename actually written (including any suffix){p_end}
{p2colreset}{...}

{marker description}{...}
{title:Description}

{pstd}
{bf:textablehead} opens {it:filename} (truncating any existing content) and
writes the opening LaTeX code for a regression or summary table. It writes the
{\tt \begin{{}tabular{}}} environment with column alignment, the {\tt \toprule},
optional column numbers, and column titles. The standard workflow is:

{phang2}1. {bf:textablehead} — opens the file, writes the preamble and header row{p_end}
{phang2}2. Body rows — written by {help leanesttab}, {help write_summ_stats}, {help texbf}, {help texspec}, or manual {help writeln} calls{p_end}
{phang2}3. {help textablefoot} — appends the footer and closes the environment{p_end}

{pstd}
When neither {opt slide} nor {opt mod} is specified, the output goes to
{it:filename} unchanged. When {opt slide} is specified the file becomes
{it:filename}_slide.tex; when {opt mod} is specified (paper mode) it becomes
{it:filename}_paper.tex.

{pstd}
By default the table uses a {it:threeparttable} inside an {it:adjustbox}
inside a {it:center} environment. Set {opt scheme(aea)} to switch to the AEA
journal format, which uses {\tt \resizebox} instead.

{marker options}{...}
{title:Options}

{dlgtab:Column specification}

{phang}
{opt ncols(#)} the number of data columns. Must be provided if {opt coltitles()}
is not given; otherwise the number of column titles is used automatically.

{phang}
{opt coltitles(str asis)} a tokenised list of column header titles, one per
data column. Titles containing spaces should be enclosed in compound quotes;
for example, {cmd:coltitles(`" "OLS" "IV" "')}.

{dlgtab:Table labels}

{phang}
{opt firsttitle(str)} the header text for the first column (the variable-label
column). Default is an empty cell.

{phang}
{opt title(str)} the table caption, written with {\tt \caption{{}…{}}}.
Suppressed when {opt slide} is active or {opt nocaption} is set.

{phang}
{opt key(str)} label identifier for {\tt \label{{}tab:{it:key}{}}} to allow
cross-referencing.

{phang}
{opt supertitle(str)} a spanning multicolumn header written above the column
titles, spanning all data columns, with a {\tt \cline} beneath it.

{phang}
{opt exhead(str)} raw LaTeX code inserted at the very top of the tabular
environment, before the supertitle and column titles.

{dlgtab:Alignment}

{phang}
{opt colalignment(str)} alignment character ({cmd:l}, {cmd:c}, or {cmd:r})
applied to all data columns. Default is {cmd:c}. The first (labels) column is
always left-aligned.

{phang}
{opt fullalignment(str)} a complete LaTeX column-alignment string (e.g.,
{cmd:lccr}) that overrides {opt colalignment()} and the automatic first-column
alignment. Use this for fine-grained control.

{phang}
{opt cellalign(str)} alignment within the {\tt \makecell} used for column
header text ({cmd:l}, {cmd:c}, or {cmd:r}). Default is {cmd:c}.

{phang}
{opt ctformat(str)} LaTeX font or formatting commands prepended to each column
title, for example {cmd:\small} or {cmd:\bfseries}.

{dlgtab:Layout}

{phang}
{opt dropcolnums} suppresses the row of column numbers — (1), (2), … — that
appears below the column titles.

{phang}
{opt invert} reverses the default order so that column numbers appear above
column titles rather than below.

{phang}
{opt nofirst} omits the first (labels) column from both the alignment
specification and the header rows. Use when the table has no row-label column.

{phang}
{opt doublerule} writes a second {\tt \toprule} to produce a double top rule.

{phang}
{opt adjust(str)} the max width argument passed to {\tt \begin{{}adjustbox{}}{max
width=…\textwidth}}. Default is {cmd:.9}. Ignored under {opt scheme(aea)}.

{phang}
{opt landscape} wraps the table in a {it:landscape} environment. Requires the
{it:pdflscape} or {it:lscape} LaTeX package.

{phang}
{opt nocaption} suppresses the {\tt \caption} command even when {opt title()}
is supplied.

{dlgtab:Output mode and style}

{phang}
{opt scheme(str)} when set to {cmd:aea}, uses {\tt \resizebox} and
{\tt \begin{{}table{}}} instead of the default adjustbox/threeparttable layout,
following AEA journal formatting conventions.

{phang}
{opt slide} writes output to {it:filename}_slide.tex. Caption is suppressed.

{phang}
{opt mod} writes output to {it:filename}_paper.tex. Use this to explicitly
target paper output when both paper and slide files are produced.

{marker examples}{...}
{title:Examples}

{pstd}Basic two-column regression table header:{p_end}
{phang2}{cmd:. textablehead using output/tab/reg.tex, coltitles("OLS" "IV") title(Effect of education on wages) key(tab_educ)}{p_end}

{pstd}Five-column table with a spanning supertitle and no column numbers:{p_end}
{phang2}{cmd:. textablehead using output/tab/het.tex, ncols(5) coltitles("Q1" "Q2" "Q3" "Q4" "Q5") supertitle(By income quintile) dropcolnums title(Heterogeneous effects) key(tab_het)}{p_end}

{pstd}AEA-style landscape table:{p_end}
{phang2}{cmd:. textablehead using output/tab/main.tex, ncols(3) coltitles("(1)" "(2)" "(3)") title(Main results) key(main) scheme(aea) landscape dropcolnums}{p_end}

{title:Also see}
{psee}{help textablefoot}, {help leanesttab}, {help write_summ_stats}, {help texbf}, {help texspec}{p_end}

{title:Author}
{pstd}César Garro-Marín, University of Edinburgh, cgarrom@ed.ac.uk
