all: analemma.pdf analemma.dxf analemma.hpgl

analemma.asy: analemmasize.dat analemma.asx
	cat analemmasize.dat analemma.asx > analemma.asy
	head -n 3 analemma.asy
analemma.eps: analemma.asy 
	asy analemma.asy 
analemma.pdf: analemma.eps
	epstopdf analemma.eps
analemma-nofonts.ps: analemma.eps
	gs -sDEVICE=pswrite -dNOCACHE -sOutputFile=analemma-nofonts.ps -q -dbatch -dNOPAUSE analemma.eps -c quit  
analemma.dxf: analemma-nofonts.ps
	pstoedit -f dxf_s:-ctl -dt  analemma-nofonts.ps analemma.dxf
analemma.hpgl: analemma-nofonts.ps
	pstoedit -f plot-hpgl -dt analemma-nofonts.ps analemma-full.hpgl
	hpgl-distiller -i analemma-full.hpgl  -o analemma.hpgl
	rm analemma-full.hpgl
clean:
	rm analemma.pdf analemma-nofonts.ps analemma.eps analemma.dxf analemma.hpgl