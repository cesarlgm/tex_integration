{smcl}
{* *! version 1.1  2025}{...}
{viewerjumpto "Syntax" "leanesttab##syntax"}{...}
{viewerjumpto "Description" "leanesttab##description"}{...}
{viewerjumpto "Options" "leanesttab##options"}{...}
{viewerjumpto "Examples" "leanesttab##examples"}{...}

{title:Title}
{phang}
{bf:leanesttab} {hline 2} Append regression results to a LaTeX table file

{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:leanesttab} [{it:namelist}] {cmd:using} {it:filename}{cmd:,}
[{it:options}]

{synoptset 22 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Formatting}
{synopt:{opt format(#)}}number of decimal places for coefficients and standard errors; default is {bf:2}{p_end}
{synopt:{opt ctformat(str)}}LaTeX formatting applied to mid-table column title text{p_end}
{synopt:{opt f:irsttitle(str)}}text in the first column of the mid-table header row{p_end}
{synopt:{opt ce:llalign(str)}}alignment within \makecell for the mid-table header; default is {bf:c}{p_end}
{syntab:Mid-table header}
{synopt:{opt midhead(str asis)}}tokenised list of column titles for a mid-table subheader row{p_end}
{synopt:{opt ncols(#)}}number of data columns; required with midhead() if not inferable from {it:namelist}{p_end}
{synopt:{opt ex:head(str asis)}}raw LaTeX written above the mid-table header instead of \midrule{p_end}
{syntab:Output mode}
{synopt:{opt SLide}}write output to {it:filename}_slide.tex{p_end}
{synopt:{opt Mod}}write output to {it:filename}_paper.tex{p_end}
{synopt:{opt *}}any additional options accepted by {help esttab}{p_end}
{synoptline}
{p2colreset}{...}

{marker description}{...}
{title:Description}

{pstd}
{bf:leanesttab} is a thin wrapper around {help esttab} that appends formatted
regression results to a LaTeX table file. It is designed to be called between
{help textablehead} and {help textablefoot}. The command strips
{cmd:esttab}'s default title, number labels, and column labels so that
{bf:textablehead} controls all header content.

{pstd}
Coefficients and standard errors are formatted with {cmd:b(%9.{it:#}fc)} and
{cmd:se(%9.{it:#}fc)} where {it:#} is controlled by {opt format()}. All other
{cmd:esttab} options can be passed through via {opt *}.

{pstd}
The optional {opt midhead()} adds a labelled divider row between result blocks
(for example, to separate panels within a single table), preceded by a
{\tt \midrule}.

{marker options}{...}
{title:Options}

{dlgtab:Formatting}

{phang}
{opt format(#)} number of decimal places for coefficients and standard errors.
Default is {bf:2}.

{phang}
{opt ctformat(str)} LaTeX formatting command(s) prepended to each title in the
mid-table header row specified by {opt midhead()}, for example {cmd:\small}.

{phang}
{opt firsttitle(str)} text placed in the first (labels) column of the
mid-table header row. Default is an empty cell.

{phang}
{opt cellalign(str)} alignment within the {\tt \makecell} for mid-table header
cells. Default is {cmd:c}.

{dlgtab:Mid-table header}

{phang}
{opt midhead(str asis)} a tokenised list of column titles to insert as a
subheader row between two blocks of results. The row is preceded by
{\tt \midrule}. Use compound quotes if titles contain spaces.

{phang}
{opt ncols(#)} number of data columns. Required when {opt midhead()} is
specified and the number of columns cannot be inferred from {it:namelist}.

{phang}
{opt exhead(str asis)} raw LaTeX written in place of the leading {\tt \midrule}
before the mid-table header. Use for custom separators.

{dlgtab:Output mode}

{phang}
{opt slide} appends to {it:filename}_slide.tex. Must match the {opt slide}
option in {help textablehead}.

{phang}
{opt mod} appends to {it:filename}_paper.tex.

{phang}
{opt *} any further options are passed directly to {help esttab}. Common
choices include {cmd:keep()}, {cmd:drop()}, {cmd:order()}, {cmd:star()},
{cmd:nocons}, and {cmd:scalars()}.

{marker examples}{...}
{title:Examples}

{pstd}Write two stored estimates to a table:{p_end}
{phang2}{cmd:. estimates store m_ols}{p_end}
{phang2}{cmd:. estimates store m_iv}{p_end}
{phang2}{cmd:. textablehead using output/tab/reg.tex, coltitles("OLS" "IV") title(Wage returns to education) key(tab_wage)}{p_end}
{phang2}{cmd:. leanesttab m_ols m_iv using output/tab/reg.tex}{p_end}
{phang2}{cmd:. textablefoot using output/tab/reg.tex, notes(Clustered standard errors.) nodate}{p_end}

{pstd}Two panels with a mid-table header:{p_end}
{phang2}{cmd:. leanesttab m_ols using output/tab/reg.tex, midhead("Panel A: Men")}{p_end}
{phang2}{cmd:. leanesttab m_iv  using output/tab/reg.tex, midhead("Panel B: Women")}{p_end}

{title:Also see}
{psee}{help textablehead}, {help textablefoot}, {help esttab}{p_end}

{title:Author}
{pstd}César Garro-Marín, University of Edinburgh, cgarrom@ed.ac.uk
