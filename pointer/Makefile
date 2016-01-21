all: pointer.pdf pointer.dxf

pointer.eps: pointer.dat pointer.asy 
	asy pointer.asy 
pointer.pdf: pointer.eps
	epstopdf pointer.eps
pointer-nofonts.ps: pointer.eps
	gs -sDEVICE=pswrite -dNOCACHE -sOutputFile=pointer-nofonts.ps -q -dbatch -dNOPAUSE pointer.eps -c quit  
pointer.dxf: pointer-nofonts.ps
	pstoedit -f dxf_s:-ctl -dt  pointer-nofonts.ps pointer.dxf

clean:
	rm pointer.pdf pointer-nofonts.ps pointer.eps pointer.dxf