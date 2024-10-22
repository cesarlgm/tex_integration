{smcl}
{* *! version 1.0 17 Dec 2021}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "Install command2" "ssc install command2"}{...}
{vieweralsosee "Help command2 (if installed)" "help command2"}{...}
{viewerjumpto "Syntax" "C:\ado\personal\leanesttab##syntax"}{...}
{viewerjumpto "Description" "C:\ado\personal\leanesttab##description"}{...}
{viewerjumpto "Options" "C:\ado\personal\leanesttab##options"}{...}
{viewerjumpto "Remarks" "C:\ado\personal\leanesttab##remarks"}{...}
{viewerjumpto "Examples" "C:\ado\personal\leanesttab##examples"}{...}
{title:Title}
{phang}
{bf:leanesttab} {hline 2} Creation of pretty and simple lean tables in Stata

{marker syntax}{...}
{title:Syntax}
{p 8 17 2}
{cmdab:leanesttab}
[anything]
using/
[{cmd:,}
{it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Required }
{synopt:{opt format(string)}} number of decimals for coeffients and standard errors. {p_end}
{syntab:Optional}
{synopt:{opt *}} all other options that can be passed to esttab {p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}

{marker description}{...}
{title:Description}

{bf:leanesttab} is a wrapper that simplies creation of tables using textablehead and textablefoot.
{pstd}

{marker options}{...}
{title:Options}
{dlgtab:Main}
{phang}
{opt *}  {p_end}
{phang}
{opt format(string)}  controls the number of decimals for coeffients and
standard errors in the table. Default number of decimals is two.   {p_end}


{marker examples}{...}
{title:Examples}
{pstd}


{title:Author}
    César Garro-Marín, Economics Department, Boston University, cesarlgm@bu.edu
{p}


