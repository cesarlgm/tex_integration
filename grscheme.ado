
capture program drop grscheme
program define grscheme
    syntax, ncolor(string) palette(string) 

	set scheme s1color
    
	grstyle init
	
	grstyle scheme plotplain

    grstyle set color `palette', n(`ncolor') opacity(60)
	
	symbolpalette lean, nogr
	
	grstyle set symbol `r(p)'
	
	
end
