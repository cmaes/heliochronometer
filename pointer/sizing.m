function [x]=sizing
%We are interested in solving the problem
% maximize dbacksight + dforesight
% subject to 
%         length <= 2*R - 2*pointerclearance      (lic)
%         length/2 == dbacksight + thickness   (lec)
%         length/2 == dforesight + thickness + pointerwidth  (lec)
%         width <= 2*dmax - 2*widthclearance      (lic)
%         width = 2*analemmawidth + analemmaaxis  (lec)
%         dmax = R*sin(acos(length/2R))       (nec) 
%         analemmawidth = 2*dbacksight*tan(4.1036 degrees)   (lec)
%         analemmaheight = 2*(dbacksight + dforesight)*tan(23.44deg)(lec)
%         R - sqrt((length/2)^2 + (width/2)^2) >= radialclearance (nec)
%         radialclearance >= 1/8
%         radialclearance <= 1
%         pointerwidth = width/2
%         pointerwidth >=  1/2
%         pointerwidth <=  1
%         pointerclearance >= .050
%         pointerclearance <= .5 
%         widthclearance   >= .050
%         widthclearance   <= 1
%         analemmaaxis     >= 5/8
%         analemmaaxis     <= 3
%         length           >= 0
%         length           <= 7 
%         width            >= 0 
%         width            <= 5 
%         dbacksight       <= 7 
%         dbacksight       >= 0 
%         dforesight       >= 0 
%         dforesight       <= 7 
%         dmax             <= 5
%         dmax             >= 0
%         analemmaheight   <= 10
%         analemmaheight   >= 1
%         analemmawidth    >= 0.1 
%         analemmawidth    <=  5
%         decision variables:   length, width, dbacksight, dforesight, 
%         analemmawidth, analemmaheight, pointerwidth, pointerclearance, 
%         widthclearance, dmax, analemmaaxis, radialclearance
%         parameters :  R = 3.5  thickness = .25 
%          

%set parameters
R = 3.5;
thickness = .25;

% x is ordered according the list of decision variables above 

% generate the bounds vectors 

l = [0; 0; 0; 0; 0.1; 1; 1/4; 1/8; .1; 0; 5/8; 1/8];
u = [7; 5; 7; 7;   5; 10;  1; 1/2;  1; 5;   3; 2];

% generate the linear equality constraints 

Aeq = [0.5 0             -1              0  0  0  0 0 0 0  0 0; 
       0.5 0              0             -1  0  0 -1 0 0 0  0 0;
       0   1              0              0 -2  0  0 0 0 0 -1 0;
       0   0 -2*tan(0.0716)              0  1  0  0 0 0 0  0 0;
       0   0  2*tan(0.4091)  2*tan(0.4091)  0 -1  0 0 0 0  0 0;
       0  1/2             0              0  0  0 -1 0 0 0  0 0;
 ];
beq = [thickness; thickness; 0; 0; 0; 0];

% generate the linear inequality constraints 

Ain  = [1 0 0 0 0 0 0 2 0  0 0 0;
        0 1 0 0 0 0 0 0 2 -2 0 0];
bin  = [2*R; 0];

% generate objective function
myfunc = @(x)   -x(3) - x(4);

% generate nonlinear constraint 
function [c,ceq] = mycon(x)  
%         R - sqrt((length/2)^2 + (width/2)^2) >= radialclearance (nec)
%        -R + sqrt() +  radialclearance <= 0
       c = -R + sqrt( (x(1)/2)^2 + (x(2)/2)^2 ) + x(12);
       ceq = x(10) - R*sin(acos(x(1)/(2*R)));
end


%generate starting vector

x0 = [ 6.5; 1.2985; 3; 2.5; 0.4305; 4.7692; 0.5; 0.25; 0.05; 1.2990; ...
       7/16; 1/8];

Aeq*x0 - beq
bin-Ain*x0 
x0 - l 
u - x0
[pass,nonlin]=mycon(x0)

options = optimset('LargeScale','off','Display','iter', 'FunValCheck', 'on');

[x,fval,exitflag,output] = ...
    fmincon(myfunc,x0,Ain,bin, Aeq,beq, l,u, @(x) mycon(x),options)
                                            
Aeq*x - beq
bin-Ain*x 
x - l 
u - x
[pass,nonlin]=mycon(x)

 length = x(1)
 width = x(2)
 dbacksight = x(3)
 dforesight = x(4) 
 analemmawidth = x(5)
 analemmaheight = x(6)
  pointerwidth = x(7)
 pointerclearance = x(8)
 widthclearance = x(9)
 dmax = x(10)
 analemmaaxis = x(11)
 radialclearance = x(12)
end
