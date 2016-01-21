function zg
%
% ZG     plots Equation of Time in Figure 8
%


% Astronomical Constants
L0  = -77.11;   % Longitude of Perihelion
e   = 0.01672;  % Numerical Eccentricity
EPS = 23.44;    % Tilt of Ecliptic

% Graphics
winh = figure('Position',[100,100,720,520],...
              'PaperUnits','centimeters',...
              'PaperType','a4letter',...
              'PaperPosition',[1.5,1.5,18,14]);
axis([-90 270 -15 17]); hold on;

% Equation of Time
p = pi/180;
eps = EPS*p;
L  = 3*p*[-30:90];               % sun's True Longitude
v  = L - L0*p;                   % True Anomaly
c  = sqrt((1-e)/(1+e));          % c=tan(arcos(e)/2)
E  = 2*atan(c*tan(v/2));         % Eccentric Anomaly
zk = E-e*sin(E)-v;               % Contribution from Kepler Effect
x  = [cos(L); 
      sin(L)*cos(eps);
      sin(L)*sin(eps)];
r  = sqrt(x(1,:).^2+x(2,:).^2);
al = atan2(x(2,:),x(1,:));       % Right Ascension
d  = atan2(x(3,:),r);            % Declination
zt = L-al;                       % Contribution from Tilt Effect
zg = atan(tan(zk+zt));           % Equation of Time

% plot(L/p,atan(tan(zk))/p*4,'--',...
%      L/p,atan(tan(zt))/p*4,'-.',...
%      L/p,atan(tan(zk+zt))/p*4,'-');

plot(L/p,atan(tan(zk+zt))/p*4);

% Text
fontsz   = 18;
markersz = 8;
set(gca,'FontSize',fontsz);
set(gca,'XTick',[-90:30:270]);
set(gca,'XTickLabel',[]);
ylabel('Deviation [min]');
zodiac = ['J' 'F' 'M' 'A' 'M' 'J' 'J' 'A' 'S' 'O' 'N' 'D'];
s = 1/12; x0 = 0.025;
for i=1:length(zodiac),
   text(x0+(i-1)*s,-0.06,zodiac(i),'Units','normalized','FontSize',fontsz);
end
grid;
set(gca,'Box','on');
%h = legend('Kepler Effect (zk)','Tilt Effect (zt)','Equation of Time',2);
%  pause
%axes(h); refresh;
hold off;
