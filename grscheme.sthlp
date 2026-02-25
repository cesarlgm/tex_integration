{smcl}
{* *! version 1.1  2025}{...}
{viewerjumpto "Syntax" "grscheme##syntax"}{...}
{viewerjumpto "Description" "grscheme##description"}{...}
{viewerjumpto "Options" "grscheme##options"}{...}
{viewerjumpto "Examples" "grscheme##examples"}{...}

{title:Title}
{phang}
{bf:grscheme} {hline 2} Set a colour scheme for Stata graphs

{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:grscheme}{cmd:,}
{opt ncolor(#)}
{opt palette(name)}
[{opt opacity(#)}]

{synoptset 18 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Required}
{synopt:{opt ncolor(#)}}number of colours to use from the palette{p_end}
{synopt:{opt palette(name)}}name of the colour palette (passed to {help colorpalette}){p_end}
{syntab:Optional}
{synopt:{opt opacity(#)}}opacity of colours as a percentage (0–100); default is {bf:100}{p_end}
{synoptline}
{p2colreset}{...}

{marker description}{...}
{title:Description}

{pstd}
{bf:grscheme} sets up a publication-ready graph colour scheme using the
{cmd:grstyle} and {cmd:colorpalette} packages. It initialises the
{it:plotplain} base scheme, applies the requested colour palette, configures
the legend to a compact inside-position box-free style, and assigns lean
symbols to the plot styles.

{pstd}
Requires the community-contributed packages {cmd:grstyle}, {cmd:colorpalette},
and {cmd:symbolpalette} (available from SSC).

{marker options}{...}
{title:Options}

{phang}
{opt ncolor(#)} specifies how many colours to draw from {opt palette()}.
This value is passed as the {opt n()} argument of {help colorpalette}.

{phang}
{opt palette(name)} name of the colour palette. Any palette recognised by
{help colorpalette} is valid, such as {it:Set1}, {it:Blues}, or {it:viridis}.

{phang}
{opt opacity(#)} opacity percentage applied to all colours.
Must be between 0 (fully transparent) and 100 (fully opaque).
Default is {bf:100}.

{marker examples}{...}
{title:Examples}

{phang2}{cmd:. grscheme, ncolor(4) palette(Set1)}{p_end}

{phang2}{cmd:. grscheme, ncolor(6) palette(viridis) opacity(80)}{p_end}

{title:Author}
{pstd}César Garro-Marín, University of Edinburgh, cgarrom@ed.ac.uk
