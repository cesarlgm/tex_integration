capture program drop leanesttab
program define leanesttab
    syntax [anything]  using/, [format(string) midhead(str asis) EXhead(str asis) CTformat(string) Firsttitle(str) CEllalign(str) ncols(str) SLide * ] 

	
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

    if "`format'"==""{
        local format 2
    }

	if "`cellalign'"=="" {
		local cellalign="c"
	}

	
    if "`collabels'"=="" {
        local collabels collabels(none)
    }

    local coltitle="`ctformat' `firsttitle'"

    if `"`midhead'"'!="" {
        tokenize  `"`midhead'"'
        if "`ncols'"=="" {
            local ncols: word count `anything'
            local ncols = `ncols'+1
        }
        forvalues col=1/`ncols' {
		    local coltitle="`coltitle'"+"&"+"`ctformat' \makecell[`cellalign']{`bottom' ``col''}"
        }

        if "`exhead'"!="" {
            writeln "`using_mod'"  "`exhead'"
            writeln "`using_mod'" "`coltitle' \\"  
        }
        else {
            writeln "`using_mod'" "\midrule `coltitle' \\"
        }    
        
        writeln "`using_mod'" "\midrule"    
    }


    esttab `anything' using `using_mod',  label f collabels(none) ///
        nomtitles plain  par  b(%9.`format'fc) se(%9.`format'fc) `options'

end


