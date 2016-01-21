%
% realtime : plots horizontal sundial for latitude 47 degrees with
%            hour-lines for local real time (Figure 6)

% (Michael Oettli, 28.05.1996)


% Parameters
PHI  = 47;        % Latitude
A    = 0;         % South Azimut of Perpendicular onto Dial
H    = 90;        % Elevation    "  "             "    "
g    = 1;	        % Length of Gnomon
ksol = [7  17];	% Declination Lines (from, till)
krel = [9  15];	% Hour Lines (from, till)

% Astronomical Constants
EPS = 23.44;    % Tilt of the Ecliptic

% Transform Angles (Degrees -> Radians)
p = pi/180;
eps = EPS*p;  phi = PHI*p;  a = A*p;  h = H*p;

% Graphic Window
figure; hold on; axis([-5 5 -2 5]); 

% Declination Lines
d = p*[23.44 20.15 11.47 0 -11.47 -20.15 -23.44];
k = [ksol(1):0.1:ksol(2)];
t = 15*p*(k-12);
for i=1:length(d),
   project(t,d(i),phi,g,a,h,'-b'); 
end;
drawnow;
  
% Local Real Time
d = eps*[-1 1];
for k=krel(1):krel(2),
   t = 15*p*(k-12);
   project(t,d,phi,g,a,h,'-r');
end;
drawnow;

% Text
fontsz   = 16;
markersz = 8;
plot(0,0,'+r','MarkerSize',markersz); 
text(0.2,-0.4,'F','FontSize',fontsz);
text(-0.5,4.5,'North','FontSize',fontsz);

text(-1.9,4.1,'X','FontSize',fontsz);
text(-1.1,3.6,'XI','FontSize',fontsz);
text(-0.3,3.4,'XII','FontSize',fontsz);
text(0.5,3.6,'XIII','FontSize',fontsz);
text(1.3,4.1,'XIV','FontSize',fontsz);
set(gca,'FontSize',fontsz);
axis('off');
hold off
