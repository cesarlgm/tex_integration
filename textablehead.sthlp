{smcl}
{* *! version 1.0 20 Jun 2021}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "Install command2" "ssc install command2"}{...}
{vieweralsosee "Help command2 (if installed)" "help command2"}{...}
{viewerjumpto "Syntax" "c:\ado\personal\textablehead##syntax"}{...}
{viewerjumpto "Description" "c:\ado\personal\textablehead##description"}{...}
{viewerjumpto "Options" "c:\ado\personal\textablehead##options"}{...}
{viewerjumpto "Remarks" "c:\ado\personal\textablehead##remarks"}{...}
{viewerjumpto "Examples" "c:\ado\personal\textablehead##examples"}{...}
{title:textablehead}
{phang}
creating pretty tables in stata {hline 2} <Insert title>

{marker syntax}{...}
{title:Syntax}
{p 8 17 2}
{cmdab:textablehead}
using/
[{cmd:,}
{it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Required }
{synopt:{opt ncols(#)}} this commands assumes that all tables have ncols+1
columns. The first column has data labels, and then ncols columns will contain
data. Indicate here the number of columns with data   {p_end}
{syntab:Optional}
{syntab:Titles}
{synopt:{opt coltitles(str asis)}} string with column titles for all the columns
with data{p_end}
{synopt:{opt parse(str)}} column titles can have multiple words. This often
creates problems. This option takes care of this problem by explicitly
indicating the separator of the column titles. For example, you can write
coltitles("read car - blue car - black car") parse("-"). This tells Stata that
titles should be separated using the "-" character. If it is not indicated, the
command assumes that titles are separated by spaces " " {p_end}
{synopt:{opt f:irsttitle(str)}} title of the "labels" column. That is, the first
column of the table {p_end}
{synopt:{opt t:itle(str)}} table title {p_end}
{synopt:{opt sup:ertitle(str)}} this produces a title going from the second
column to the end of the table {p_end}
{synopt:{opt ex:head(str)}} use this to add addional tex code above the column
titles {p_end}

{syntab:Alignment }
{synopt:{opt col:alignment(str)}} the command treats the labels column
separately from the data columns. With this option you can indicate the
alignment of the all the data columns. For example colallignment(c) makes all
these columns centered. Default is c. Other options are l and r. {p_end}
{synopt:{opt ful:lalignment(str)}} this option supercedes and is more flexible than
alligment. Use it  to give a string describing the aligment of each column form
the table   {p_end}

{syntab:Other table formatting }
{synopt:{opt key(str)}} label to be used in the tex file {p_end}
{synopt:{opt drop:colnums}} drops column numbers from the output {p_end}
{synopt:{opt land:scape}} makes the table landscape {p_end}
{synopt:{opt inv:ert}} inverts ordering of column titles and column numbers in
the output {p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}

{marker description}{...}
{title:Description}
{pstd}

{marker examples}{...}
{title:Examples}
{pstd}


{title:Author:}
César Garro-Marín, Boston University
{p}


