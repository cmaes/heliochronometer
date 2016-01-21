function [tau] = sunset(delta,phi)
%
% SUNSET determines time of sunset given
%        declination delta and latitude phi

tau = acos(-tan(delta).*tan(phi));
