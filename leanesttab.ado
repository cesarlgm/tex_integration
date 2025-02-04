capture program drop leanesttab
program define leanesttab
    syntax [anything]  using/, [format(string) midhead(str asis) EXhead(str asis) CTformat(string) Firsttitle(str) CEllalign(str) ncols(str) * ] 

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
            writeln "`using'"  "`exhead'"
            writeln "`using'" "`coltitle' \\"  
        }
        else {
            writeln "`using'" "\midrule `coltitle' \\"
        }    
        
        writeln "`using'" "\midrule"    
    }


    esttab `anything' using `using',  label f collabels(none) ///
        nomtitles plain  par  b(%9.`format'fc) se(%9.`format'fc) `options'

end


