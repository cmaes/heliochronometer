// make 1 user unit 1 inch
unitsize(2.54cm);
real radius = 3.525;
real angle;
//draw(scale(radius)*unitcircle);
pen redpen = black;

//draw((0,1)--(0,-1));
//draw((-1,0)--(1,0));

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

// draw(scale(3.5)*unitcircle);
// draw(scale(4.0)*unitcircle);
// draw(arc((0,0),3.75-1/16,-60,-120));
// draw(arc((0,0),3.75,-60,-120),red);
// draw(arc((0,0),3.75+1/16,-60,-120));

radius = 3.75-1/16-1/32;
real offset = 3*pi/2 - 30*pi/180;
for(int i=0; i<=60; ++i){
  real angle = i*pi/180 + offset;
  pair a = radius*(cos(angle),sin(angle));
  if (i==30)
    draw(.97a--a,redpen);
  else if (i==15)
    draw(.97a--a,redpen);
  else if (i%5==0)
    draw(.98a--a,redpen);
  else
    draw(.99a--a,redpen);
}

// radius = 3.52;

// for(int i=0; i<=360; ++i){
//   real angle = i*pi/180;
//   pair a = radius*(cos(angle),sin(angle));
//   if (i%5 == 0)
//     draw(1/2*a---a,blue);
//   else
//     draw(1/2*a--a);
// }
