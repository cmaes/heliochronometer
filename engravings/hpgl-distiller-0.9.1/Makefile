all: hpgl-distiller

hpgl-distiller: hpgl-distiller.c
	gcc -Wall hpgl-distiller.c -o hpgl-distiller

install: hpgl-distiller
	cp hpgl-distiller /usr/local/bin

clean:
	rm hpgl-distiller *.o

