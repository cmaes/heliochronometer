all: dial.pdf dial-strip.ps dial.dxf dial.hpgl

dial.eps: dial.asy 
	asy dial.asy 
dial.pdf: dial.eps
	epstopdf dial.eps
dial-strip.ps: dial.eps
	gs -sDEVICE=pswrite -dNOCACHE -sOutputFile=dial-strip.ps -q -dbatch -dNOPAUSE dial.eps -c quit 
dial.dxf: dial-strip.ps
	pstoedit -f dxf_s:-ctl -dt dial-strip.ps dial.dxf
dial.hpgl: dial-strip.ps 
	pstoedit -f plot-hpgl -dt dial-strip.ps dial-full.hpgl
	hpgl-distiller -i dial-full.hpgl -o dial.hpgl
	rm dial-full.hpgl

clean:
	rm dial.hpgl dial.dxf dial-strip.ps dial.eps dial.pdf 