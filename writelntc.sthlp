{smcl}
{* *! version 1.0  2025}{...}
{viewerjumpto "Syntax" "writelntc##syntax"}{...}
{viewerjumpto "Description" "writelntc##description"}{...}
{viewerjumpto "Options" "writelntc##options"}{...}
{viewerjumpto "Examples" "writelntc##examples"}{...}

{title:Title}
{phang}
{bf:writelntc} {hline 2} Write a LaTeX \newcommand declaration to a file

{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:writelntc} {cmd:using} {it:filename}{cmd:,}
{opt command(str)}
{opt text(str)}
[{opt start}]

{synoptset 18 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Required}
{synopt:{opt command(str)}}LaTeX command name to define, including the leading backslash{p_end}
{synopt:{opt text(str)}}replacement text for the command{p_end}
{syntab:Optional}
{synopt:{opt start}}truncate {it:filename} before writing (start a new file){p_end}
{synoptline}
{p2colreset}{...}

{marker description}{...}
{title:Description}

{pstd}
{bf:writelntc} appends the line

{phang2}{\tt \newcommand{{}}{it:command}{{}}{{}{it:text}{}}}

{pstd}
to {it:filename}. Leading and trailing whitespace is trimmed from {opt text()}
before writing. The resulting file can be \input{}'d in a LaTeX document so
that inline numbers produced by Stata are always kept in sync with the
analysis.

{pstd}
Repeated calls accumulate definitions in {it:filename}. Use {opt start} on the
first call in a script to clear any previous content.

{marker options}{...}
{title:Options}

{phang}
{opt command(str)} the full LaTeX command name, including the backslash; e.g.,
{cmd:\meanwage} or {cmd:\Nobs}.

{phang}
{opt text(str)} the replacement text. Leading and trailing whitespace is
trimmed.

{phang}
{opt start} opens {it:filename} in replace mode before writing, clearing any
pre-existing content. Use this on the first {bf:writelntc} call in a script.

{marker examples}{...}
{title:Examples}

{pstd}Create a new definitions file and add two commands:{p_end}
{phang2}{cmd:. sum wages}{p_end}
{phang2}{cmd:. writelntc using output/text/numbers.tex, command(\meanwage) text(`r(mean)') start}{p_end}
{phang2}{cmd:. writelntc using output/text/numbers.tex, command(\Nobs) text(`r(N)')}{p_end}

{pstd}In the LaTeX document:{p_end}
{phang2}{\tt \input{{}output/text/numbers.tex{}}}

{title:Also see}
{psee}{help writeln}, {help writetext}{p_end}

{title:Author}
{pstd}César Garro-Marín, University of Edinburgh, cgarrom@ed.ac.uk
