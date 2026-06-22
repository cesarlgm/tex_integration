{smcl}
{* *! version 1.0.0  22 Jun 2026}{...}
{viewerjumpto "Syntax" "startfile##syntax"}{...}
{viewerjumpto "Description" "startfile##description"}{...}
{viewerjumpto "Examples" "startfile##examples"}{...}
{title:Title}

{phang}
{bf:startfile} {hline 2} Initialise an output file, truncating any existing content.

{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:startfile} {it:filename}

{pstd}
{it:filename} is the path to the file to create or overwrite. Paths with spaces must be quoted.

{marker description}{...}
{title:Description}

{pstd}
{cmd:startfile} opens {it:filename} for writing and writes a single header
line ({cmd:%Start of file}) followed by a newline, then closes the file.
If {it:filename} does not yet exist it is created; if it already exists it
is truncated before the header is written.

{pstd}
{cmd:startfile} is intended as the first step in the {bf:texlink} file-writing
workflow. Because the header line begins with {cmd:%}, it is treated as a
comment by LaTeX and does not appear in compiled output. Subsequent calls to
{helpb writeln}, {helpb writelntc}, {helpb writetext}, or other texlink
commands append content to the file created by {cmd:startfile}.

{marker examples}{...}
{title:Examples}

{pstd}Initialise a new table file before building its content{p_end}
{phang2}{cmd:. startfile output/tables/tab1.tex}{p_end}

{pstd}Reinitialise a figure file, discarding any previous content{p_end}
{phang2}{cmd:. startfile "output/figures/fig 1.tex"}{p_end}

{title:Author}

{pstd}César Garro-Marín, University of Edinburgh.{p_end}
