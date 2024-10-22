
capture program drop grscheme
program define grscheme
    syntax, ncolor(string) palette(string) 

    
	grstyle init
	
	grstyle scheme plotplain

    grstyle set color `palette', n(`n_colors') opacity(60)
	
	symbolpalette lean, nogr
	
	grstyle set symbol `r(p)'
	
	
end
