*===============================================================================
*CREATES LATEX CODE FOR A REGRESSION TABLE HEADER
*Author: César Garro-Marín
*Date: 	May 29th, 2019
*===============================================================================
/*
	Modification list: 
	
*/
*===============================================================================
capture program drop textablehead
program define textablehead, rclass
	version 14.2
	/*
		arguments:
		ncols: 			number of regressions in the table
		firsttitle:		title of the first column (text column)
		title:			title of the table to be written in \caption{}
		colallignment:	allignment of regression columns. Options are l c r
						text column is always with left allignment
		key:			tex label of the table to be written in \label{}
	
	*/
	syntax using/ ,  [  coltitles(str asis) Firsttitle(str) ///
					Title(str)  COLaligment(str) key(str) DROPcolnums ///
					SUPertitle(str) EXhead(str) FULlalignment(str) ///
					LANDscape INVert  NOCaption  ADJust(str) SCHeme(str) CTformat(str) CEllalign(str) DoubleRule ncols(str) SLide] 
	

	tokenize `"`coltitles'"'


	
	local using_name= "`using'"

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
    
	tempname textable
	file open `textable' using `using_mod', replace write
	file close `textable'


	if "`ncols'"=="" {
		if `"`coltitles'"'=="" {
			display  as error "You must specify the number of columns in the table or provide column titles"
			error 1
		}
		else {
			local ncols: word count `coltitles'
		}
	}

	if "`cellalign'"=="" {
		local cellalign="c"
	}

	*First I create the variables necessary for the creation of the header
	local allignment="l"
	if "`colalignment'"=="" {
		local colalignment="c"
	}
	
	if "`dropcolnums'"==""{
		if "`invert'"=="" {
			local colnumbers="{ `ctformat' `firsttitle' }"
			local coltitle=""
		}
		else {
			local colnumbers=""
			local coltitle="{ `ctformat' `firsttitle'}"
		}
	}
	else {
		local coltitle="{`ctformat' `firsttitle'}"
	}
	
	if "`fullalignment'"!=""{
		local colalignment="`fullalignment'"
	}

	forvalues col=1/`ncols'{
		if "``col''"=="`parse'"{ 
			local `col' " "
		}
		local allignment="`allignment'"+"`colalignment'"
		local colnumbers="`colnumbers'"+"&"+"\multicolumn{1}{c}{(`col')}"
		local coltitle="`coltitle'"+"&"+"`ctformat' \makecell[`cellalign']{`bottom' ``col''}"
	}
	
	
	*I start writting the table header
	if  "`landscape'"!=""{
		writeln "`using_mod'" "\begin{landscape}"
	}

	if "`scheme'"!="aea" {
		writeln "`using_mod'" "\begin{center}"
		if "`adjust'"=="" {
			writeln "`using_mod'" "\begin{adjustbox}{max width=.9\textwidth}"
		}
		else {
			writeln "`using_mod'" "\begin{adjustbox}{max width=`adjust'\textwidth}"
		}
		writeln "`using_mod'" "\begin{threeparttable}[!h]"

		*I write the title
		if "`nocaption'"==""{
			if "`title'"!=""{
				writeln "`using_mod'" "\caption{`title'}"
				if "`key'"!=""{
					writeln "`using_mod'" "\label{`key'}"
				}
			}	
		}
	
	}
	else {
		writeln "`using_mod'" "\begin{table}[!h]"
		*I write the title
		if "`nocaption'"==""{
			if "`title'"!=""{
				writeln "`using_mod'" "\caption{`title'}"
				if "`key'"!=""{
					writeln "`using_mod'" "\label{`key'}"
				}
			}	
		}
		
		if "`adjust'"=="" {
			writeln "`using_mod'" "\resizebox{.8\textwidth}{!}{"
		}
		else {
			writeln "`using_mod'" "\resizebox{`adjut'\textwidth}{!}{"
		}
	}
	
	writeln "`using_mod'" "\begin{tabular}{`allignment'}"
	writeln "`using_mod'" "\toprule"
	if "`doublerule'"!="" {
		writeln "`using_mod'" "\toprule"
	}
	if "`exhead'"!="" {
		writeln "`using_mod'" "`exhead'"
	}
	if "`supertitle'"!="" {
		local span=`ncols'+1
		writeln "`using_mod'" "& \multicolumn{`ncols'}{c}{`supertitle'} \\"
		writeln "`using_mod'" "\cline{2-`span'}"
	}
	if "`invert'"=="" {
		if `"`coltitles'"'!="" {
			writeln "`using_mod'" "`coltitle' \\"
		}
		if "`dropcolnums'"==""{
			writeln "`using_mod'" "`colnumbers' \\"
		}
	}
	else {
		if "`dropcolnums'"==""{
			writeln "`using_mod'" "`colnumbers' \\"
		}
		if `"`coltitles'"'!="" {
			writeln "`using_mod'" "`coltitle' \\"
		}
	}
	writeln "`using_mod'" "\midrule"

	return local  new_name= "`using_mod'"
end
