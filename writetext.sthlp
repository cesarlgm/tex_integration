{smcl}
{* *! version 1.0  2025}{...}
{viewerjumpto "Syntax" "writetext##syntax"}{...}
{viewerjumpto "Description" "writetext##description"}{...}
{viewerjumpto "Options" "writetext##options"}{...}
{viewerjumpto "Examples" "writetext##examples"}{...}

{title:Title}
{phang}
{bf:writetext} {hline 2} Write a formatted number to a file for use in LaTeX

{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:writetext}{cmd:,}
{opt file(str)}
{opt text(real)}
[{opt fmt(str)}
{opt percent}]

{synoptset 16 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Required}
{synopt:{opt file(str)}}path to the output file{p_end}
{synopt:{opt text(real)}}the numeric value to format and write{p_end}
{syntab:Optional}
{synopt:{opt fmt(str)}}Stata display format; default is {bf:%9.2fc}{p_end}
{synopt:{opt percent}}multiply value by 100 and append a \% symbol; sets format to {bf:%9.0fc}{p_end}
{synoptline}
{p2colreset}{...}

{marker description}{...}
{title:Description}

{pstd}
{bf:writetext} formats a single numeric value and writes it (overwriting any
previous content) to {it:file}. The resulting file contains just the formatted
number — with no trailing newline — so that it can be \input{}'d inline in a
LaTeX sentence.

{pstd}
Leading and trailing whitespace produced by the display format is stripped
before writing.

{marker options}{...}
{title:Options}

{phang}
{opt file(str)} path to the output file. The file is opened in replace mode;
any existing content is discarded.

{phang}
{opt text(real)} the numeric value to write. Scalar expressions and stored
results are accepted.

{phang}
{opt fmt(str)} a Stata numeric display format. Default is {cmd:%9.2fc} (two
decimal places with thousands separator). Example alternatives: {cmd:%9.0fc},
{cmd:%9.3f}, {cmd:%12.4fc}.

{phang}
{opt percent} multiplies {opt text()} by 100, applies format {cmd:%9.0fc}, and
appends {\tt \%} to the output. Cannot be combined with a custom {opt fmt()}.

{marker examples}{...}
{title:Examples}

{pstd}Write a mean to a file:{p_end}
{phang2}{cmd:. sum wages}{p_end}
{phang2}{cmd:. writetext, file(output/text/mean_wage.tex) text(`r(mean)')}{p_end}

{pstd}Write a proportion as a percentage:{p_end}
{phang2}{cmd:. writetext, file(output/text/share_treated.tex) text(`r(mean)') percent}{p_end}

{pstd}In the LaTeX document:{p_end}
{phang2}{\tt The mean wage is \$\input{{}output/text/mean{\_}wage.tex{}}\$.}

{title:Also see}
{psee}{help writeln}, {help writelntc}{p_end}

{title:Author}
{pstd}César Garro-Marín, University of Edinburgh, cgarrom@ed.ac.uk
