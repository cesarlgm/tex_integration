

capture program drop texbf
program define texbf
    syntax using/, t(str) [it]

    if "`it'"!=""{ 
        local output \textit\textbf{`t'} \\
    }
    else {
        local output \textbf{`t'} \\
    }

    writeln `using' "`output'" 
end


