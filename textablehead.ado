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
					Title(str)  COLAlignment(str) key(str) DROPcolnums ///
					SUPertitle(str) EXhead(str) FULlalignment(str) ///
					LANDscape INVert  NOCaption  ADJust(str) SCHeme(str) CTformat(str) cellalign(str) DoubleRule ncols(str) SLide NOFirst Mod] 
	

	tokenize `"`coltitles'"'


	
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

	*This sets the aligment of the body of the table
	if "`colalignment'"=="" {
		local colalignment="c"
	}
	else {
		local colalignment="`colalignment'"
	}

	*This sets the alignment of the header
	if "`cellalign'"=="" {
		local cellalign="c"
	}
	else {
		local cellalign="`cellalign'"
	}

	*First I create the variables necessary for the creation of the header
	if "`nofirst'"=="" {
		local allignment="l"
	}
	else {
		local allignment=""
	}

	if "`dropcolnums'"==""{
		if "`invert'"=="" {
			if "`nofirst'"=="" {
				local colnumbers="{ `ctformat' `firsttitle' }"
				local coltitle=""
			}
			else {
				local colnumbers=""
				local coltitle=""
			}
		}
		else {
			if "`nofirst'"=="" {
				local colnumbers=""
				local coltitle="{ `ctformat' `firsttitle'}"
			}
			else{
				local colnumbers=""
				local coltitle=""
			}
		}
	}
	else {
		if "`nofirst'"=="" {
			local coltitle="{`ctformat' `firsttitle'}"
		}
		else {
			local coltitle=""
		}	
	}
	

	forvalues col=1/`ncols'{
		if "``col''"=="`parse'"{ 
			local `col' " "
		}
		if "`nofirst'"=="" {
			local first_separator="&"
		}
		else {
			local first_separator=""
		}

		if `col'==1{
			local colnumbers="`colnumbers'"+"`first_separator'"+"\multicolumn{1}{c}{(`col')}"
			local coltitle="`coltitle'"+"`first_separator'"+"\makecell[`cellalign']{`ctformat' `bottom' ``col''}"
		}
		else {
			local colnumbers="`colnumbers'"+"&"+"\multicolumn{1}{c}{(`col')}"
			local coltitle="`coltitle'"+"&"+" \makecell[`cellalign']{`ctformat' `bottom' ``col''}"
		}
		local allignment="`allignment'"+"`colalignment'"	
	}
	
	
	if "`fullalignment'"!=""{
		local allignment="`fullalignment'"
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
