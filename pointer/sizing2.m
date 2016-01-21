function [x,length,width,foresight,backsight,analemmawidth,pointerlength, ...
         pointerclearance,backclearance,edgeclearance,radialclearance]= ...
        sizing2(R,thickness,thetap,thetam,analemmaspacing,bounds,x0)
%We are interested in solving the problem
% maximize backsight + foresight
% subject to 
% length   = 2*thickness + foresight + backsight + pointerlength
% R  = foresight + thickness + pointerlength + pointerclearance
% R  = backsight + thickness + backclearance
% width/2 = pointerlength*tan(thetap)
% 2R       = backclearance + length + pointerclearance
%  width   = analemmaspacing + analemmawidth
% analemmawidth = 2*tan(thetam)*(foresight+backsight)
% R^2 = (thickness + backsight)^2 + (width/2 + edgeclearance)^2
% R  = sqrt((thickness + backsight)^2 + (width/2)^2) +
% radialclearnace
%
% decision variables:
% length 
% width 
% foresight
% backsight
% analemmawidth
% pointerlength 
% pointerclearance
% backclearance
% edgeclearanace 
% radialclearance
% x is ordered according the list of decision variables above 
%
% parameters:
% R 
% thickness
% thetap
% thetam 
% analemmaspacing



l = bounds(:,1);
u = bounds(:,2);


% generate the linear equality constraints 
Atrans = ...
[   1     0 0              0  1   0               0;% length 
    0     0 0           -1/2  0   1               0;% width 
   -1     1 0              0  0   0   2*tan(thetam);% foresight
   -1     0 1              0  0   0   2*tan(thetam);% backsight
    0     0 0              0  0  -1             -1 ;% analemmawidth
   -1     1 0  tan(thetap/2)  0   0              0 ;% pointerlength 
    0     1 0              0  1   0              0 ;% pointerclearance
    0     0 1              0  1   0              0 ;% backclearance
    0     0 0              0  0   0              0 ;% edgeclearanace 
    0     0 0              0  0   0              0 ;% radialclearance
];     
Aeq = Atrans';
beq = [2*thickness; R-thickness; R-thickness; 0; 2*R; analemmaspacing; 0];

% generate objective function
myfunc = @(x)   -x(3) - x(4);

% generate nonlinear constraint 
function [c,ceq] = mycon(x)  
% R^2 = (thickness + backsight)^2 + (width/2 + edgeclearance)^2
% R  = sqrt((thickness + backsight)^2 + (width/2)^2) +
% radialclearnace
    c = [];
    ceq = [(thickness + x(4))^2 + (x(2)/2 + x(9))^2 - R^2;
           sqrt((thickness + x(4))^2 + (x(2)/2)^2) +  x(10) - R;];
end
 

eqinfeas = Aeq*x0 - beq
lowerinfeas = x0 - l 
upperinfeas = u - x0
[pass,nonlininfeas]=mycon(x0)

options = optimset('LargeScale','off','Display','iter', 'FunValCheck', 'on');
[x,fval,exitflag,output] = ...
    fmincon(myfunc,x0,[],[], Aeq,beq, l,u, @(x) mycon(x),options)
                                            
eqinfeas =  Aeq*x - beq
lowerinfeas =  x - l 
upperinfeas = u - x
[pass,nonlininfeas]=mycon(x)



length = x(1)
width  = x(2)
foresight = x(3)
backsight = x(4)
analemmawidth = x(5)
pointerlength = x(6)
pointerclearance = x(7)
backclearance = x(8)
edgeclearance = x(9)
radialclearance = x(10)


end
