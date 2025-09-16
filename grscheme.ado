
capture program drop grscheme
program define grscheme
    syntax, ncolor(string) palette(string) [opacity(str)]

	if "`opacity'"=="" {
		local opacity 100
	}

	set scheme s1color
    
	grstyle init
	
	grstyle scheme plotplain

    grstyle set color `palette', n(`ncolor') opacity(`opacity')
	
	grstyle set legend 2, inside nobox
	grstyle numstyle legend_cols 1

	symbolpalette lean, nogr
	
	grstyle set symbol `r(p)'
	
	
end
