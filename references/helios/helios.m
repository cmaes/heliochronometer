function helios(name)
%
% HELIOS Plots sundials on any plane. Sundial must
%        be specified in file 'name' as shown below.
%
%        Functions called: project.m, sunset.m
%
%        Variables read from file 'name':
%        LZ    :   Longitude of Time Zone
%        LG    :   Longitude
%        PHI   :   Latitude
%        A     :   Azimuth of Perpendicular onto Dial
%        H     :   Elevation of Perpendicular onto Dial
%        g     :   Length of Gnomon
%        ksol  :   vector [firsthour lasthour] specifying
%                  interval for declination lines
%        kzon  :   same as ksol but for zone time
%        (Angles must be given in degrees!)

%        (M. Oettli, 26.5.1996)

% Astronomical Constants
L0  = -77.11;	  % Ecliptical Longitude of Perihelion
e   = 0.01672;  % Numerical Eccentricity
EPS = 23.44;    % Tilt of Ecliptic

% Read Specification of Sundial from File 'name'
figure; eval(name); hold on

% Transform Angles (Degrees -> Radians)
p = pi/180;
eps = EPS*p;  a = A*p;  phi = PHI*p;  h = H*p;


% Solstices and Equinoctial Line
k = [ksol(1):ksol(2)];
t = 15*p*(k-12);
for i=-1:1,
   d = i*eps; 
   project(t,d,phi,g,a,h,'-g');
end;
drawnow; 
  
% Babylonic and Italic Hours
if (abs(phi)+eps > 90*p),
   d0 = 90*p-phi;
else
   d0 = eps;
end
s0 = sunset(phi,d0);  k3 = fix(s0/7.5/p);
d = [-1:0.1:1]*d0;  s1 = sunset(phi,d);  
   
% Babylonic hours 
for k=0:k3,
   t = 15*p*k-s1;  
   project(t,d,phi,g,a,h,'-.r');
end;
drawnow;

% Italic hours
for k=24-k3:24, 
   t = 15*p*k+s1; 
   project(t,d,phi,g,a,h,'-.r');
end;
drawnow;

% Zone Time
L  = 3*p*[-30:90];               % sun's True Longitude
v  = L - L0*p;                   % True Anomaly
c  = sqrt((1-e)/(1+e));          % c=tan(arcos(e)/2)
E  = 2*atan(c*tan(v/2));         % Eccentric Anomaly
zk = E-e*sin(E)-v;
x  = [cos(L);                    % Sun's Coordinates in System of
      sin(L)*cos(eps);           % Celestial Equator
      sin(L)*sin(eps)];
r  = sqrt(x(1,:).^2+x(2,:).^2);
al = atan2(x(2,:),x(1,:));       % Right Ascension
d  = atan2(x(3,:),r);            % Declination
zt = L-al;
zg = atan(tan(zk+zt));           % Equation of Time
for k = kzon(1):kzon(2),
   t  = 15*p*(k-12)+zg+(LZ-LG)*p;
   project(t,d,phi,g,a,h,'-b');
end;

% Foot of perpendicular from gnomon point onto dial
plot(0,0,'+m');
title(name);
set(gca,'Box','on');
hold off
