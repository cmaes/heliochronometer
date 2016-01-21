unitsize(2.54cm);

real thickness = .25;
real R  = 3.5;

file fin = input("pointer.dat");
real x[] = fin;

real length           = x[0];
real width            = x[1];
real foresight        = x[2];
real backsight        = x[3];
real analemmawidth    = x[4];
real pointerlength    = x[5];
real pointerclearance = x[6];
real backclearance    = x[7];
real edgeclearance    = x[8];
real radialclearance  = x[9];




// path pointer = (length/2,width/2)--(-length/2+pointerlength,width/2)--(-length/2,0)--(-length/2+pointerlength,-width/2)--(length/2,-width/2)--cycle;
// path foresightslot = (-length/2+pointerlength,width/2)--(-length/2+pointerlength+thickness,width/2)--(-length/2+pointerlength+thickness,-width/2)--(-length/2+pointerlength,-width/2)--cycle;
// path backsightslot = (length/2-thickness,width/2)--(length/2,width/2)--(length/2,-width/2)--(length/2-thickness,-width/2)--cycle; 
// path pclearance = (-length/2,0)--(-length/2-pointerclearance,0);
// path bclearance = (length/2,0)--(length/2+backclearance,0);
// path eclearance = (length/2,width/2)--(length/2,width/2+edgeclearance);
// real clearanceangle = atan2(width/2,length/2);
// path rclearance = (length/2,width/2)--(radialclearance*(cos(clearanceangle),sin(clearanceangle)) + (length/2,width/2));

path pointer = (backsight+thickness,width/2)--(-foresight-thickness,width/2)--(-foresight-thickness-pointerlength,0)--(-foresight-thickness,-width/2)--(backsight+thickness,-width/2)--cycle;
path foresightslot = (-foresight,width/2)--(-foresight-thickness,width/2)--(-foresight-thickness,-width/2)--(-foresight,-width/2)--cycle;
path backsightslot = (backsight,width/2)--(backsight+thickness,width/2)--(backsight+thickness,-width/2)--(backsight,-width/2)--cycle;
path pclearance = (-foresight-thickness-pointerlength,0)--(-foresight-thickness-pointerlength-pointerclearance,0);
path bclearance = (backsight+thickness,0)--(backsight+thickness+backclearance,0);
path eclearance = (backsight+thickness,width/2)--(backsight+thickness,width/2+edgeclearance);
real clearanceangle = atan2(width/2,backsight+thickness);
path rclearance = (backsight+thickness,width/2)--((radialclearance*(cos(clearanceangle),sin(clearanceangle)))+(backsight+thickness,width/2));

draw(pclearance,red);
draw(bclearance,red);
draw(eclearance,red);
draw(rclearance,red);

draw(pointer);
draw(foresightslot);
draw(backsightslot);
dot((0,0));
draw(scale(R)*unitcircle);



real radius = 3.525;
real angle;
//draw(scale(radius)*unitcircle);
pen redpen = defaultpen;

draw((0,1)--(0,-1));
draw((-1,0)--(1,0));

//hours
int n = 24;
for(int i = 16; i <= 24+8; ++i){
  angle = -i*2*pi/n - 3*pi/2;
  pair a = radius*(cos(angle), sin(angle));
  draw(a--1.044a,redpen);
  real offset = 1.07;
  if(i%12 == 0)
    label("12",offset*a,redpen);
  else if (i < 24)
    label(rotate(-angle)*Label(format("%i",i%12)),offset*a,redpen);
  else
    label(rotate(angle)*Label(format("%i",i%12)),offset*a,redpen);
}

// 30 minutes 
int n = 24*2; 
for(int i=16*2; i<=(24+8)*2; ++i){
  angle = -i*2*pi/n - 3*pi/2;
  pair a = radius*(cos(angle), sin(angle));
  if(i%2 != 0)
    draw(a--a*1.04,redpen);
}

//15 minutes 
int n = 24*4; 
for(int i=16*4; i<=(24+8)*4; ++i){
  angle = -i*2pi/n - 3*pi/2;
  pair a = radius*(cos(angle), sin(angle));
  if(i%2 != 0)
    draw(a--a*1.03,redpen);
        
}

// //5 minutes
int n = 24*4*3; 
for(int i=16*4*3; i<=(24+8)*4*3; ++i){
  angle = -i*2pi/n - 3*pi/2; 
  pair a = radius*(cos(angle), sin(angle));
  if(i%3 != 0)
    draw(a--a*1.02,redpen);
}

//1 minutes
//int n = 24*60;
//for(int i=1; i<=n; ++i){
//	pair a = radius*(cos(i*2pi/n+pi/2), sin(i*2*pi/n+pi/2));
//	draw(a--a*1.01);
//}

draw(scale(3.5)*unitcircle);
draw(scale(4.0)*unitcircle);


//draw(arc((0,0),3.75-1/16,-60,-120));
//draw(arc((0,0),3.75,-60,-120),red);
//draw(arc((0,0),3.75+1/16,-60,-120));

radius = 3.75-1/16;
real offset = 3*pi/2 - 30*pi/180;
for(int i=0; i<=60; ++i){
  real angle = i*pi/180 + offset;
  pair a = radius*(cos(angle),sin(angle));
  if (i==30)
    draw(.96a--a,redpen);
  else if (i==15)
    draw(.96a--a,redpen);
  else if (i%5==0)
    draw(.98a--a,redpen);
  else
    draw(.99a--a,redpen);
}
