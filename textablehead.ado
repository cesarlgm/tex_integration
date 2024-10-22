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
program define textablehead
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
	syntax using/ , ncols(real) [ coltitles(str asis) Firsttitle(str) ///
					Title(str)  COLaligment(str) key(str) DROPcolnums ///
					SUPertitle(str) EXhead(str) FULlalignment(str) ///
					LANDscape INVert  NOCaption  ADJust(str)] 
	

	tokenize `"`coltitles'"'



	tempname textable
	file open `textable' using `using', replace write
	file close `textable'

	*First I create the variables necessary for the creation of the header
	local allignment="l"
	if "`colalignment'"=="" {
		local colalignment="c"
	}
	
	if "`dropcolnums'"=="" {
		local colnumbers="\textbf{`firsttitle'}"
		local coltitle=""
	}


	else {
		local colnumbers=""
		local coltitle="\textbf{`firsttitle'}"
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
		local coltitle="`coltitle'"+"&"+"\multicolumn{1}{c}{\textbf{``col''}}"
	}
	
	
	*I start writting the table header
	if  "`landscape'"!=""{
		writeln `using' "\begin{landscape}"
	}

	writeln `using' "\begin{center}"
	if "`adjust'"=="" {
		writeln `using' "\begin{adjustbox}{max width=.9\textwidth}"
	}
	else {
		writeln `using' "\begin{adjustbox}{max width=`adjust'\textwidth}"
	}
	writeln `using' "\begin{threeparttable}[!h]"
	
	*I write the title
	if "`nocaption'"==""{
		if "`title'"!=""{
			writeln `using' "\caption{`title'}"
			if "`key'"!=""{
				writeln `using' "\label{`key'}"
			}
		}	
	}

	writeln `using' "\begin{tabular}{`allignment'}"
	writeln `using' "\toprule"
	writeln `using' "\toprule"
	if "`exhead'"!="" {
		writeln `using' "`exhead'"
	}
	if "`supertitle'"!="" {
		local span=`ncols'+1
		writeln `using' "& \multicolumn{`ncols'}{c}{\textbf{`supertitle'}} \\"
		writeln `using' "\cline{2-`span'}"
	}
	if "`invert'"=="" {
		if `"`coltitles'"'!="" {
			writeln `using' "`coltitle' \\"
		}
		if "`dropcolnums'"==""{
			writeln `using' "`colnumbers' \\"
		}
	}
	else {
		if "`dropcolnums'"==""{
			writeln `using' "`colnumbers' \\"
		}
		if `"`coltitles'"'!="" {
			writeln `using' "`coltitle' \\"
		}
	}
	writeln `using' "\midrule"
end
