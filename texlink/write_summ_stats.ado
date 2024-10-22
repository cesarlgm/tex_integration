
capture program drop write_summ_stats
program define write_summ_stats

syntax varlist using/, [tab]

if "`tab'"!="" {
    local tab "\hspace{3mm}"
}

foreach variable in `varlist' {
    local varlab:  variable label `variable'

    if "`varlab'"=="" {
        local varlab: `variable'
    }

    qui sum `variable', d

    local obs: display %9.0fc `r(N)'
    local mean: display %9.2fc `r(mean)'
    local min: display %9.2fc `r(min)'
    local max: display %9.2fc `r(max)'
    local sd: display %9.2fc `r(sd)'

    writeln "`using'" "`tab'`varlab' & `obs' & `mean' & `min' & `max' & `sd' \\ "
}

end 