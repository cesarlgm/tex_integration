{smcl}
{* *! version 1.0  2025}{...}
{viewerjumpto "Syntax" "texbf##syntax"}{...}
{viewerjumpto "Description" "texbf##description"}{...}
{viewerjumpto "Options" "texbf##options"}{...}
{viewerjumpto "Examples" "texbf##examples"}{...}

{title:Title}
{phang}
{bf:texbf} {hline 2} Append a bold text row to a LaTeX table file

{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:texbf} {cmd:using} {it:filename}{cmd:,}
{opt t(str)}
[{opt it}]

{synoptset 10 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Required}
{synopt:{opt t(str)}}text to write in bold{p_end}
{syntab:Optional}
{synopt:{opt it}}also apply italic formatting (\textit\textbf){p_end}
{synoptline}
{p2colreset}{...}

{marker description}{...}
{title:Description}

{pstd}
{bf:texbf} appends a single table row containing bold text to {it:filename}.
The row spans only the first column and is terminated with {\tt \\}, making
it suitable as a group heading inside a table built with {help textablehead}
and {help textablefoot}.

{pstd}
Without {opt it} the output is {\tt \textbf{{}t{}}  \\}.
With {opt it} the output is {\tt \textit\textbf{{}t{}} \\}.

{marker options}{...}
{title:Options}

{phang}
{opt t(str)} the text to display. May contain LaTeX markup.

{phang}
{opt it} applies {\tt \textit} in addition to {\tt \textbf}, producing bold
italic text.

{marker examples}{...}
{title:Examples}

{phang2}{cmd:. texbf using output/tab/summ.tex, t(Outcome variables)}{p_end}

{phang2}{cmd:. texbf using output/tab/summ.tex, t(Control variables) it}{p_end}

{title:Also see}
{psee}{help textablehead}, {help textablefoot}, {help texspec}, {help writeln}{p_end}

{title:Author}
{pstd}César Garro-Marín, University of Edinburgh, cgarrom@ed.ac.uk
