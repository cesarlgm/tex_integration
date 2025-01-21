capture program drop leanesttab
program define leanesttab
    syntax [anything]  using/, [format(string) collabels(str) *] 

    if "`format'"==""{
        local format 2
    }
	
    if "`collabels'"==""{
        local collabels collabels(none)
    }
    else {
        local collabels collabels(`collabels')
    }

    esttab `anything' using `using',  label f `collabels' ///
        nomtitles plain  par  b(%9.`format'fc) se(%9.`format'fc) `options'

end


