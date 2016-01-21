function project(t,d,phi,g,a,h,cmd)
%
%  PROJECT casts shadow of gnomon point 
%          onto general plane
%
%          => Angles must be given in radians!
%
%          Parameters:
%          t   : hour angle
%          d   : declination  (if t and d are vectors: length(t)=length(d))
%          phi : latitude
%          g   : length of gnomon
%          a   : south-azimuth of perpendicular to dial
%          h   : elevation of perpendicular to dial
%          cmd : plot command (line style and color, e.g. '-.g')

%          (Michael Oettli, 15.5.1996)

% Set up sun rays in equatorial system
X = [cos(d).*cos(t);	
     cos(d).*sin(t);
     sin(d).*ones(size(t))];

% transform equatorial into horizontal coordinates
w = pi/2 - phi;
R = [cos(w)  0  -sin(w);
      0      1    0;
     sin(w)  0   cos(w)];
X = R*X;

% transform horizontal coordinates into coordinates of 
% general dial
b = pi/2 - h;
R = [cos(a)*cos(b) cos(b)*sin(a) -sin(b);
      -sin(a)      cos(a)        0;
     cos(a)*sin(b) sin(a)*sin(b) cos(b)];
X = R*X;

% plot shadow for rays coming from above
ix = (X(3,:) > 0);
if any(ix), 
   X = g*X(1:2,ix)./(ones(2,1)*X(3,ix)); 
   plot(X(2,:),X(1,:),cmd);
end

