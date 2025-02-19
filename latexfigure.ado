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
		figlab(str asis) note(str) SHORTnote(str) dofile(str) cont NODate SLide ]
	

	*First I extract the number of figures
	local nfig: word count  `figurelist'
	
	local using_name= "`using'"

	if "`rowsize'"=="" {
		local rowsize=`nfig'
	}
	
	if "`slide'"!="" {
		local stub="_slide"
	}
	else {
		local stub="_paper"
	}

	*This bit adds the stub slide if the figure is done for a slide
    if substr("`using_name'", -4, 4) == ".tex" {
        local using_trim = substr("`using_name'", 1, length("`using_name'") - 4)
    }
	else {
		local using_trim = "`using_name'"
	}
	

	local using_mod = "`using_trim'"+"`stub'"+".tex"
    
	*Erasing the file if it exists
	cap rm "`using_mod'"
	


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
	
	writeln "`using_mod'" "\begin{figure}[!h]"
	writeln "`using_mod'" "\centering"
	if "`cont'"!=""{
		writeln "`using_mod'" "\ContinuedFloat"
	}
	
	if "`title'"!=""{
		if "`slide'"=="" {
			*By default, figures in slide will not have a caption
			writeln "`using_mod'" "\caption{`title'}"
		}
		if "`key'"!=""{
			writeln "`using_mod'" "\label{`key'}"
		}
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

	writeln "`using_mod'" "`graphcode'"
	if "`slide'"=="" {
		if "`note'"!=""{
			writeln "`using_mod'" "\par \begin{minipage}[h]{\textwidth}{\scriptsize\textit{Notes:} `note'`timeLegend'`do_legend'}\end{minipage}"
		}
	}
	else {
		if "`shortnote'"!=""{
			writeln "`using_mod'" "\par \begin{minipage}[h]{\textwidth}{\scriptsize\textit{Notes:} `shortnote'`timeLegend'`do_legend'}\end{minipage}"
		}
		else if "`note'"!=""{
				noi di as error "No short version of the notes (shortnote) provided, using the long version instead."
				writeln "`using_mod'" "\par \begin{minipage}[h]{\textwidth}{\scriptsize\textit{Notes:} `note'`timeLegend'`do_legend'}\end{minipage}"
		}
		else {
			writeln "`using_mod'" "\par \begin{minipage}[h]{\textwidth}{\scriptsize\textit{Notes:} `timeLegend'`do_legend'}\end{minipage}"
		}
	}

	writeln "`using_mod'" "\end{figure}"
	
	noisily di  as result  "Latex file created in `using_mod'"
end
