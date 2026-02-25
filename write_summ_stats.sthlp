{smcl}
{* *! version 1.0  2025}{...}
{viewerjumpto "Syntax" "write_summ_stats##syntax"}{...}
{viewerjumpto "Description" "write_summ_stats##description"}{...}
{viewerjumpto "Options" "write_summ_stats##options"}{...}
{viewerjumpto "Examples" "write_summ_stats##examples"}{...}

{title:Title}
{phang}
{bf:write_summ_stats} {hline 2} Append summary statistics rows to a LaTeX table

{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:write_summ_stats} {varlist} {cmd:using} {it:filename}{cmd:,}
[{opt tab}]

{synoptset 10 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Optional}
{synopt:{opt tab}}indent the variable label with \hspace{{}3mm{}}{p_end}
{synoptline}
{p2colreset}{...}

{marker description}{...}
{title:Description}

{pstd}
{bf:write_summ_stats} loops over each variable in {varlist}, runs
{cmd:summarize, detail}, and appends a table row to {it:filename} of the form:

{phang2}{it:Variable label} & {it:N} & {it:Mean} & {it:Min} & {it:Max} & {it:SD} {\tt \\}

{pstd}
The columns are formatted as {cmd:%9.0fc} for N and {cmd:%9.2fc} for all other
statistics. If a variable has no variable label its name is used instead.

{pstd}
The command is designed to be called between {help textablehead} and
{help textablefoot}. The table header should define six columns: a label column
followed by N, Mean, Min, Max, and SD.

{marker options}{...}
{title:Options}

{phang}
{opt tab} prepends {\tt \hspace{{}3mm{}}} to the variable label, indenting it to
signal that the variable is a sub-item within a group.

{marker examples}{...}
{title:Examples}

{pstd}Summary statistics table:{p_end}
{phang2}{cmd:. textablehead using output/tab/summ.tex, coltitles("N" "Mean" "Min" "Max" "SD") firsttitle(Variable) title(Summary statistics) key(tab_summ) dropcolnums}{p_end}
{phang2}{cmd:. write_summ_stats wages tenure educ using output/tab/summ.tex}{p_end}
{phang2}{cmd:. textablefoot using output/tab/summ.tex, nodate}{p_end}

{pstd}With indented sub-items:{p_end}
{phang2}{cmd:. writeln output/tab/summ.tex "\textbf{Outcomes} \\"}{p_end}
{phang2}{cmd:. write_summ_stats wages hours using output/tab/summ.tex, tab}{p_end}

{title:Also see}
{psee}{help textablehead}, {help textablefoot}, {help texbf}{p_end}

{title:Author}
{pstd}César Garro-Marín, University of Edinburgh, cgarrom@ed.ac.uk
