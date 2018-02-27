% MCPI > Monte-Carlo PI estimation
% Array opeations:
%  * vrand (x2)
%  * vsum (x1)
%  * vsquare (x2)
%  * vadd2 (x1)
%  * vless2 (x1)
%%%%
function MCPI(N)
   % Generate N points (x, y) with x,y in [0, 1]
   x = rand(1, N); % vrand
   y = rand(1, N); % vrand
   % Count points in circle
   pointsInCircle = sum((x.^2 + y.^2) < 1); % vsum, vsquare, vadd2, vless2
   % Compute ratio of points in circle and all points
   piValue = 4 * pointsInCircle / N; % (!) scalars discarded
end
