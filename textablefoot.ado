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
	syntax using/, [notes(str) Fontsize(str) NODate dofile(str) LANDscape SCHeme(str)]
	
	tempname textable
	file open `textable' using `using', append write
	file close `textable'

	writeln `using' "\bottomrule"
	writeln `using' "\bottomrule"
	writeln `using' "\end{tabular}"
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
		if "`notes'"!="" {
			writeln `using' "\begin{tablenotes}"
			writeln `using' "\item `fontsize' \textit{Notes:} `notes'. `timeLegend'`do_note'"
			writeln `using' "\end{tablenotes}"
		}
		
		writeln `using' "\end{threeparttable}"
		writeln `using' "\end{adjustbox}"
		writeln `using' "\end{center}"
	}
	else {
		writeln `using' "}"
		if "`notes'"!="" {
			writeln `using' "\begin{tablenotes}[Notes:]"
			writeln `using' "\item `notes'. `timeLegend'`do_note'"
			writeln `using' "\end{tablenotes}"
		}
		writeln `using' "\end{table}"
	}

	if "`landscape'"!=""{ 
		writeln `using' "\end{landscape}"
	}

end
