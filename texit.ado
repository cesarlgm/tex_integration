

capture program drop texit
program define texit
    syntax using/, t(str) [rule space]

    local output \textit{`t'} \\

    if "`space'"!=""{ 
        local output  \hspace{3mm}`output'
    }
    if  "`rule'"!=""{
        local output \midrule`output'
    }

    writeln `using' "`output'" 
end


