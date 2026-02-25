{smcl}
{* *! version 1.1  2025}{...}
{viewerjumpto "Syntax" "latexfigure##syntax"}{...}
{viewerjumpto "Description" "latexfigure##description"}{...}
{viewerjumpto "Options" "latexfigure##options"}{...}
{viewerjumpto "Examples" "latexfigure##examples"}{...}

{title:Title}
{phang}
{bf:latexfigure} {hline 2} Write a LaTeX figure environment to a .tex file

{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:latexfigure} {cmd:using} {it:filename}{cmd:,}
{opt path(str)}
{opt figurelist(str)}
[{it:options}]

{synoptset 22 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Required}
{synopt:{opt path(str)}}path to the figures directory, relative to the LaTeX document{p_end}
{synopt:{opt figurelist(str)}}space-separated list of figure filenames (without path){p_end}
{syntab:Layout}
{synopt:{opt rowsize(#)}}number of figures per row for multi-panel figures; default is all figures in one row{p_end}
{synopt:{opt width(str)}}width of each panel as a fraction of \textwidth; default is 1/rowsize{p_end}
{synopt:{opt land:scape}}wrap figure in a landscape environment{p_end}
{syntab:Labels and notes}
{synopt:{opt title(str)}}figure caption text{p_end}
{synopt:{opt key(str)}}label key; produces \label{{}fig:key{}}{p_end}
{synopt:{opt subkey(str)}}space-separated sub-figure label keys; produces \label{{}subfig:key{}}{p_end}
{synopt:{opt figlab(str asis)}}tokenised list of sub-figure captions for \subfloat{p_end}
{synopt:{opt note(str)}}note appended below the figure in a minipage{p_end}
{synopt:{opt SHORTnote(str)}}shorter note for slide output; falls back to note() if absent{p_end}
{synopt:{opt dofile(str)}}do-file name included in the auto-generated timestamp note{p_end}
{synopt:{opt nod:ate}}suppress the auto-generated date from the note{p_end}
{syntab:Output mode}
{synopt:{opt SLide}}write output to {it:filename}_slide.tex{p_end}
{synopt:{opt cont}}insert \ContinuedFloat to continue a split figure{p_end}
{synopt:{opt aea}}use AEA journal caption placement (caption after figure body){p_end}
{synoptline}
{p2colreset}{...}

{marker description}{...}
{title:Description}

{pstd}
{bf:latexfigure} writes a complete LaTeX {it:figure} environment to
{it:filename}. By default the output file is named {it:filename}_paper.tex.
When {opt slide} is specified it is named {it:filename}_slide.tex. If neither
{opt slide} nor {opt mod} is present the filename is used without any suffix
(suitable for calling without the output-mode conventions).

{pstd}
For a single figure, the command writes a plain {\tt \includegraphics}. For
multiple figures it wraps each in a {\tt \subfloat[caption]{}} command;
{opt figlab()} supplies the per-panel captions and {opt rowsize()} controls
how many panels appear on each row.

{pstd}
{bf:latexfigure} uses {help writeln} from the same package to append lines to
the output file.

{marker options}{...}
{title:Options}

{dlgtab:Required}

{phang}
{opt path(str)} the path to the directory containing the figure files, written
verbatim into the LaTeX source. Typically a relative path such as
{it:../output/fig}.

{phang}
{opt figurelist(str)} space-separated list of figure filenames (without the
leading path). For a single-panel figure supply one name; for multi-panel
figures list them in display order.

{dlgtab:Layout}

{phang}
{opt rowsize(#)} for multi-panel figures, the number of panels to place on
each row. If omitted all panels appear on a single row.

{phang}
{opt width(str)} width of each {\tt \includegraphics} call expressed as a
fraction of \textwidth. Overrides the default of 1/{it:rowsize}.

{phang}
{opt landscape} wraps the entire figure in a {it:landscape} environment.
Requires the {it:pdflscape} or {it:lscape} LaTeX package in the document
preamble.

{dlgtab:Labels and notes}

{phang}
{opt title(str)} caption text. In AEA mode this is wrapped in {\tt \scshape}.

{phang}
{opt key(str)} label identifier used in {\tt \label{{}fig:{it:key}{}}} so the
figure can be cross-referenced.

{phang}
{opt subkey(str)} space-separated identifiers for per-panel labels, applied in
order via {\tt \label{{}subfig:{it:key}{}}}.

{phang}
{opt figlab(str asis)} tokenised list of sub-figure captions for {\tt
\subfloat[...]} environments. Enclose the whole list in compound quotes if
individual captions contain spaces; e.g., {cmd:figlab(`" "Men" "Women" "')}.

{phang}
{opt note(str)} a note placed in a \footnotesize minipage below the figure.
The auto-generated timestamp is appended unless {opt nodate} is specified.

{phang}
{opt shortnote(str)} a shorter version of the note for slide output. If
omitted and {opt slide} is active, {opt note()} is used and a warning is
shown.

{phang}
{opt dofile(str)} name of the producing do-file, appended to the timestamp
in the figure note.

{phang}
{opt nodate} suppresses the auto-generated "Figure generated on …" text from
the notes.

{dlgtab:Output mode}

{phang}
{opt slide} writes output to {it:filename}_slide.tex instead of
{it:filename}_paper.tex. In slide mode no caption is written above the figure;
{opt shortnote()} is used for the note if provided.

{phang}
{opt cont} inserts {\tt \ContinuedFloat} immediately after {\tt
\begin{{}figure{}}} to signal that this is a continuation of the preceding
figure.

{phang}
{opt aea} places the caption below the figure body (after the
{\tt \includegraphics} lines) following AEA journal style, and uses {\tt
\scshape} for the caption text.

{marker examples}{...}
{title:Examples}

{pstd}Single figure for a paper:{p_end}
{phang2}{cmd:. latexfigure using output/fig/wages.tex, path(../output/fig) figurelist(wages.pdf) title(Wage trends 2000--2020) key(wage_trend)}{p_end}

{pstd}Two-panel figure with sub-captions:{p_end}
{phang2}{cmd:. latexfigure using output/fig/wages.tex, path(../output/fig) figurelist(wages_m.pdf wages_f.pdf) rowsize(2) figlab(`" "Men" "Women" "') title(Wages by gender) key(wages_gender)}{p_end}

{pstd}Slide version without a date stamp:{p_end}
{phang2}{cmd:. latexfigure using output/fig/wages.tex, path(../output/fig) figurelist(wages_m.pdf) slide nodate shortnote(Mean log wages, 2000–2020)}{p_end}

{title:Also see}
{psee}{help textablehead}, {help textablefoot}, {help writeln}{p_end}

{title:Author}
{pstd}César Garro-Marín, University of Edinburgh, cgarrom@ed.ac.uk
