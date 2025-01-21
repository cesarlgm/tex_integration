capture program drop leanesttab
program define leanesttab
    syntax [anything]  using/, [format(string) midhead(string) *] 

    if "`format'"==""{
        local format 2
    }
	
    if "`collabels'"=="" {
        local collabels collabels(none)
    }


    if "`midhead'"!="" {
        local midhead ""
        local ncols: word count `anything'
        forvalues col=1/`ncols'{
            local coltitle="`coltitle'"+"&"+"\multicolumn{1}{c}{\makecell{``col''}}"
        }

        writeln "`using'" "\midrule `coltitle' \\"

        writeln "`using'" "\midrule"    
    }


    esttab `anything' using `using',  label f collabels(none) ///
        nomtitles plain  par  b(%9.`format'fc) se(%9.`format'fc) `options'

end


