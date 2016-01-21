% Set up the parameters 

deg2rad = pi/180; 
R = 3.5; 
thickness = .25;
thetap    = 90*deg2rad;
thetam    = 4.1036*deg2rad;
thetas    = 23.44*deg2rad;
analemmaspacing = 5/8;


% generate the bounds vectors 

bounds = [0   2*R;    % length 
          0     2;    % width 
          1   2*R;    % foresight 
          1   2*R;    % backsight
          0     2;    % analemmawidth 
          0     2;    % pointerlength 
          1/16  5;    % pointerclearance
          1/8   5;    % backclearance 
          1/16  5;    % edgeclearance 
          1/32  5;    % radialclearance
];

%generate starting vector
x0  = [5.9;    % length 
       1.5;    % width 
       3.5;    % foresight 
       2.5;    % backsight
         1;    % analemmawidth 
         2;    % pointerlength 
       1/8;    % pointerclearance
       1/8;    % backclearance 
       1/8;    % edgeclearance 
       1/8;    % radialclearance
];

% Solve the problem 
[x,length,width,foresight,backsight,analemmawidth,pointerlength, ...
  pointerclearance,backclearance,edgeclearance,radialclearance]= ...
        sizing2(R,thickness,thetap,thetam,analemmaspacing,bounds,x0)

L = foresight + backsight
analemmaheight = 2*L*tan(23.44*deg2rad)
xunit = L*tan(thetam)/(4.1036*4)
xunitcm = xunit*2.54
yunit  = analemmaheight/(2*23.44)
yunitcm = yunit*2.54

backsightwidth = width
backsightheight = analemmaheight + 1/2


% write out decision variables 
dlmwrite('pointer.dat',x,'\n');

% remake the pointer picture
!make 

% move to analemma directory 
cd ../analemma

% write out size information
fid = fopen('analemmasize.dat','w+');
fprintf(fid,'unitsize(x=%fcm,y=%fcm);\n',xunitcm,yunitcm);
fclose(fid);

% print size information 
!cat analemmasize.dat 

% make the analemma 
!make


