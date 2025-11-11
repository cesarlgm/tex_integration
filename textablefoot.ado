*===============================================================================
*TEXTTABLEFOOT
*Author: César Garro-Marín
*Date: May 29th, 2019
*===============================================================================
*Description: closes the threeparttable environment

/*
	Modification list:
	Jun 12: add option to include do file in the output.
*/
*===============================================================================



cap program drop textablefoot
program define textablefoot
	version 14.2
	*notes just adds the string passed to it as a table note
	syntax using/, [notes(str)  SHORTnotes(str) Fontsize(str) NODate dofile(str) LANDscape SCHeme(str) SLide Mod]
	
	di as result "`shortnotes'"
	di as result "`notes'"
	di as result "`slide'"

	local using_name= "`using'"

	if "`mod'"!=""|"`slide'"!="" {
		if "`slide'"!="" {
			local stub="_slide"
		}
		else {
			local stub="_paper"
		}
	}
	else {
		local stub=""
	}

	*This bit adds the stub slide if the figure is done for a slide
    if substr("`using_name'", -4, 4) == ".tex" {
        local using_trim = substr("`using_name'", 1, length("`using_name'") - 4)
    }
	else {
		local using_trim = "`using_name'"
	}
	
	
	local using_mod = "`using_trim'"+"`stub'"+".tex"

	tempname textable
	file open `textable' using `using_mod', append write
	file close `textable'

	writeln `using_mod' "\bottomrule"
	writeln `using_mod' "\bottomrule"
	writeln `using_mod' "\end{tabular}"
	if "`fontsize'"==""{
		local fontsize \footnotesize
	}
	
	if "`nodate'"=="" {
		local timeLegend= "Table generated on `c(current_date)' at `c(current_time)'."
	}
	else {
		local timeLegend= ""
	}
	
	if "`dofile'"!=""&"`nodate'"=="" {
		local do_note= " Table generated with do file `dofile'"
	}
	else {
		local do_note= ""
	}

	if "`scheme'"!="aea"{
		if "`slide'"==""{
			if "`notes'"!="" {
				writeln `using_mod' "\begin{tablenotes}"
				writeln `using_mod' "\item `fontsize' \textit{Notes:} `notes'. `timeLegend'`do_note'"
				writeln `using_mod' "\end{tablenotes}"
			}
		}
		else {
			if "`shortnotes'"!="" {
				writeln `using_mod' "\begin{tablenotes}"
				writeln `using_mod' "\item `fontsize' \textit{Notes:} `shortnotes'."
				writeln `using_mod' "\end{tablenotes}"
			}
			else if "`shortnotes'"==""&"`notes'"!=""{
				writeln `using_mod' "\begin{tablenotes}"
				writeln `using_mod' "\item `fontsize' \textit{Notes:} `notes'."
				writeln `using_mod' "\end{tablenotes}"
			}	
		}	
		writeln `using_mod' "\end{threeparttable}"
		writeln `using_mod' "\end{adjustbox}"
		writeln `using_mod' "\end{center}"
	}
	else {
		writeln `using_mod' "}"
		if "`slide'"==""{
			if "`notes'"!="" {
				writeln `using_mod' "\begin{tablenotes}[Notes]"
				writeln `using_mod' "`notes'. `timeLegend'`do_note'"
				writeln `using_mod' "\end{tablenotes}"
			}
		}
		else {
			if "`shortnotes'"!="" {
				writeln `using_mod' "\begin{tablenotes}[Notes]"
				writeln `using_mod' "`shortnotes'."
				writeln `using_mod' "\end{tablenotes}"
			}
			else if "`shortnotes'"==""&"`notes'"!=""{
				writeln `using_mod' "\begin{tablenotes}[Notes]"
				writeln `using_mod' "`notes'."
				writeln `using_mod' "\end{tablenotes}"
			}	
		}
		writeln `using_mod' "\end{table}"
	}

	if "`landscape'"!=""{ 
		writeln `using_mod' "\end{landscape}"
	}

end
