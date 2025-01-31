capture program drop writelntc
program define writelntc
    syntax using/ , command(str) text(str) [start]
	
    *Start the file if required
    if "`start'"!="" {
        tempname textable
        file open `textable' using `using', replace write
        file close `textable'
    }

    local tr_text=trim("`text'")

    local line "\newcommand{`command'}{`tr_text'}"

    writeln "`using'" "`line'"
end


