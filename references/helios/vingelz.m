%
% Specifications for Sundial on wall of Highway N5
% at 2505 Vingelz, Switzerland
%

LG  = -(7+13/60+1/3600);	% Geographical Longitude (negative
                                % east of Greenwich)
LZ  = -15;			% Longitude of Main Meridian of Time Zone
PHI = 47+7/60+48/3600;		% Geographical Latitude
A   = -48.95;			% Azimuth of Perpendicular to Dial
H   = 5.71;			% Elevation of Perpendicular to Dial
g   = 120;			% Length of Gnomon
unit= 'cm';            	        % Unit of Measurement 


ksol = [4 13];			% Length of Solstices (from, till)
kzon = [5 13];			% Hours Time Zone (from, till)
axis([-500 200 -500 200]);	% Size of Graphic Window

