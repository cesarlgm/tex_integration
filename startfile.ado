cap program drop startfile
program define startfile
	gettoken file: 0

	tempname f
	capture confirm file "`file'"
	if _rc!=0 {
		confirm new file "`file'"
	    file open `f' using "`file'", write
	}
    else {
        file open `f' using "`file'", write replace
    }
	file write `f' "%Start of file" _n
	file close `f'
end
