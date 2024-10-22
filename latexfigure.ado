*===============================================================================
*CREATES LATEX CODE OUTPUTTING FIGURES
*Author: César Garro-Marín
*Date: 	May 29th, 2019
*===============================================================================
/*
	Modification list: 
	
*/
*===============================================================================
capture program drop latexfigure
program define latexfigure
	version 14.2
	
	*rowsize: 		number of graphs in a line
	*figurelist: 	namelist of pdf files that contain the figures
	*path:			figure path relative to latex file.
	*figlab:		labels for subfigures in latex file.
	*note:			note to include, if any.
	syntax using/ ,  path(str) figurelist(str) [rowsize(str) title(str) key(str) ///
		figlab(str asis) note(str) dofile(str) cont NODate]
	
	cap rm "`using'"
	
	*First I extract the number of figures
	local nfig: word count  `figurelist'
	
	if "`rowsize'"=="" {
		local rowsize=`nfig'
	}
	
	if `nfig'==1 {
		local width=1/`rowsize'
		local figurepath="`path'"+"/"+"`figurelist'"
		local graphcode="\includegraphics[width=`width'\textwidth]{`figurepath'}"
	}
	else if `nfig'>1 {
		local width=1/`rowsize'
		tokenize `" `figlab' "'
		forvalues fig=1/`nfig' {
			if mod(`fig',`rowsize')==0 {
				local sep " \\ "
			}
			else {
				local sep " "
			}
			local figurename: word `fig'  of `figurelist'
			local figurelab="``fig''"
			di "`figurename'"
			di "`figurelab'"
			local figurepath="`path'"+"/"+"`figurename'"
			local graphcode="`graphcode'"+"\subfloat[`figurelab']{\includegraphics[width=`width'\textwidth]{`figurepath'}}"+"`sep'"
		}
	}
	
	writeln `using' "\begin{figure}[!h]"
	writeln `using' "\centering"
	if "`cont'"!=""{
		writeln `using' "\ContinuedFloat"
	}
	
	if "`title'"!=""{
		writeln `using' "\caption{`title'}"
	}
	if "`key'"!=""{
		writeln `using' "\label{`key'}"
	}
	
	if "`nodate'"=="nodate" {
		local timeLegend= ""
	}
	else {
		local timeLegend= " Figure generated on `c(current_date)' at `c(current_time)'."
		if "`dofile'"!="" {
			local do_legend= " Figure generated using the dofile `dofile'."
		}
		else {
			local do_legend= ""
		}
	}
	
	
	
	writeln `using' "`graphcode'"
	if "`note'"!=""{
		writeln `using' "\par \begin{minipage}[h]{\textwidth}{\scriptsize\textit{Notes:} `note'`timeLegend'`do_legend'}\end{minipage}"
	}
	

	
	writeln `using' "\end{figure}"
	
	noi di "Latex file created in `using'", as result
end
