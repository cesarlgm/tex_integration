{smcl}
{* *! version 1.1  2025}{...}
{viewerjumpto "Syntax" "textablefoot##syntax"}{...}
{viewerjumpto "Description" "textablefoot##description"}{...}
{viewerjumpto "Options" "textablefoot##options"}{...}
{viewerjumpto "Examples" "textablefoot##examples"}{...}

{title:Title}
{phang}
{bf:textablefoot} {hline 2} Append a LaTeX table footer to a .tex file

{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:textablefoot} {cmd:using} {it:filename}{cmd:,}
[{it:options}]

{synoptset 22 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Notes}
{synopt:{opt notes(str)}}table note text for paper output{p_end}
{synopt:{opt SHORTnotes(str)}}shorter version of the note for slide output{p_end}
{synopt:{opt f:ontsize(str)}}LaTeX font-size command for the note; default is {\tt \footnotesize}{p_end}
{synopt:{opt nod:ate}}suppress the auto-generated timestamp from the note{p_end}
{synopt:{opt dofile(str)}}do-file name appended to the timestamp in the note{p_end}
{syntab:Layout}
{synopt:{opt land:scape}}close the landscape environment opened by textablehead{p_end}
{syntab:Output mode and style}
{synopt:{opt scheme(str)}}set to {bf:aea} for AEA journal formatting{p_end}
{synopt:{opt SLide}}write output to {it:filename}_slide.tex{p_end}
{synopt:{opt Mod}}write output to {it:filename}_paper.tex{p_end}
{synoptline}
{p2colreset}{...}

{marker description}{...}
{title:Description}

{pstd}
{bf:textablefoot} appends the closing LaTeX code to a table file started by
{help textablehead}. It writes {\tt \bottomrule}, {\tt \end{{}tabular{}}}, the
optional tablenotes block, and the closing environment tags
({it:threeparttable}, {it:adjustbox}, {it:center}, or {it:table}/{it:resizebox}
for AEA style).

{pstd}
The output mode ({opt slide} / {opt mod}) and {opt scheme()} must match those
used in the corresponding {help textablehead} call so that the correct filename
suffix is targeted.

{pstd}
This command uses {help writeln} from the same package to append lines.

{marker options}{...}
{title:Options}

{dlgtab:Notes}

{phang}
{opt notes(str)} the table note text. In paper mode this note plus the
auto-generated timestamp are placed inside a {\tt tablenotes} environment.
In slide mode {opt shortnotes()} is used if provided; otherwise {opt notes()}
is used.

{phang}
{opt shortnotes(str)} a shorter version of the note for slide output. If not
specified and {opt slide} is active, {opt notes()} is used verbatim.

{phang}
{opt fontsize(str)} a LaTeX font-size command applied to the note block.
Default is {\tt \footnotesize}. Supply a LaTeX command such as {cmd:\small} to
override.

{phang}
{opt nodate} suppresses the automatically appended "Table generated on …"
timestamp from the note.

{phang}
{opt dofile(str)} name of the producing do-file; appended to the timestamp
text in the note when {opt nodate} is not specified.

{dlgtab:Layout}

{phang}
{opt landscape} writes {\tt \end{{}landscape{}}} after the closing table
environment tags. Use this when {opt landscape} was also specified in
{help textablehead}.

{dlgtab:Output mode and style}

{phang}
{opt scheme(str)} when set to {cmd:aea}, closes the AEA-style
{\tt \resizebox}/{\tt \begin{{}table{}}} structure and uses the AEA
{\tt tablenotes[Notes]} format.

{phang}
{opt slide} appends to {it:filename}_slide.tex. Must match the {opt slide}
option used in {help textablehead}.

{phang}
{opt mod} appends to {it:filename}_paper.tex.

{marker examples}{...}
{title:Examples}

{pstd}Simple table footer with a note:{p_end}
{phang2}{cmd:. textablefoot using output/tab/reg.tex, notes(OLS and IV estimates. Standard errors clustered at the firm level.) nodate}{p_end}

{pstd}Slide footer with a short note:{p_end}
{phang2}{cmd:. textablefoot using output/tab/reg.tex, notes(Standard errors clustered at the firm level. Sample: 2000--2020.) shortnotes(Clustered SEs. 2000--2020.) slide}{p_end}

{pstd}AEA-style footer with do-file attribution:{p_end}
{phang2}{cmd:. textablefoot using output/tab/main.tex, notes(Robust standard errors in parentheses.) scheme(aea) dofile(analysis.do)}{p_end}

{title:Also see}
{psee}{help textablehead}, {help leanesttab}, {help write_summ_stats}{p_end}

{title:Author}
{pstd}César Garro-Marín, University of Edinburgh, cgarrom@ed.ac.uk
