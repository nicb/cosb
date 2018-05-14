%
% distance: calculate the geometric distance between two coordinate
% points (given a zero-reference system)
%
% Usage: d = distance(pointA, pointB);
%
% where:
%        pointA - the first point (coord data structure)
%        pointB - the second point
%
%
% and d = pointB - pointA; (geometric subtraction)
%
%
function d = distance(pointA, pointB)
  d = pdist([pointA.x pointA.y; pointB.x pointB.y]);
end
