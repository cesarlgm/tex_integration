

/*
*=======================================================================================
*STATA LATEX INTEGRATION
*Author: César Garro-Marín
*=======================================================================================
*DESCRIPTION
*Writes formated numbers for use in LaTeX documents.
*=======================================================================================
*/


capture program drop writetext
program define writetext
	syntax, file(str) text(real) [fmt(str) PERcent]

	if "`percent'"!="" {
		local fmt %9.0fc
		local text=`text' * 100
		local addtext "\%"
	}
	else if "`fmt'"==""{
		local fmt %9.2fc
	}

	local text: di `fmt' `text' 
	local text=itrim("`text'")

	tempname f
	file open `f' using `file', write replace
	file write `f' "`text'`addtext'"
	file close `f'
end

