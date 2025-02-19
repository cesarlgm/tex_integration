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
	version 16.1
	
	*rowsize: 		number of graphs in a line
	*figurelist: 	namelist of pdf files that contain the figures
	*path:			figure path relative to latex file.
	*figlab:		labels for subfigures in latex file.
	*note:			note to include, if any.
	syntax using/ ,  path(str) figurelist(str) [rowsize(str) title(str) key(str) ///
		figlab(str asis) note(str) shortnote(str) dofile(str) cont NODate SLide ]
	
	cap rm "`using'"
	
	*First I extract the number of figures
	local nfig: word count  `figurelist'
	
	if "`rowsize'"=="" {
		local rowsize=`nfig'
	}
	
	if "`slide'"!="" {
		local stub="_slide"
	}

	*This bit adds the stub slide if the figure is done for a slide
    if substr("`using'", -4, 4) == ".tex" {
        local using = substr("`using'", 1, length("`using'") - 4)
    } 

	local using = "`using'"+"`stub'"+".tex"
    


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
		if "`slide'"!="" {
			*By default, figures in slide will not have a caption
			writeln `using' "\caption{`title'}"
		}
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
	if "`slide'"!="" {
		if "`note'"!=""{
			writeln `using' "\par \begin{minipage}[h]{\textwidth}{\scriptsize\textit{Notes:} `note'`timeLegend'`do_legend'}\end{minipage}"
		}
	}
	else {
		if "`shortnote'"!=""{
			writeln `using' "\caption{`shortnote'`timeLegend'`do_legend'}"
		}
		else if "`note'"!=""{
				noi di as error "Not short version of the notes (shortnote) provided, using the long version instead."
				writeln `using' "\caption{`note'`timeLegend'`do_legend'}"
		}
		else {
			writeln `using' "\caption{`timeLegend'`do_legend'}"
		}
	}

	writeln `using' "\end{figure}"
	
	noisily di  as result  "Latex file created in `using'"
end
