capture program drop leanesttab
program define leanesttab
    syntax [anything]  using/, [format(string) *] 

    if "`format'"==""{
        local format 2
    }
	

    esttab `anything' using `using',  label f collabels(none) ///
        nomtitles plain  par  b(%9.`format'fc) se(%9.`format'fc) `options'

end


