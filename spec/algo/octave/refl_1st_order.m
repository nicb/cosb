%
% refl_1st_order: calculate the position of the four first order azimuth reflections 
% given a point source, a zero-reference system and the size of the outer
% room. It returns a vector of four coordinates points which correspond to
% [front wall reflection, right side wall reflection, back wall reflection,
% left side wall reflection]
%
% Usage: r = refl_1st_order(pointA, outer_room)
%
% where:
%        pointA - the source point (in coord data structure)
%        outer_room - a vector containing length and width of the room
%
%
function r = refl_1st_order(pointA, outer_room)
  l = outer_room(1);
  w = outer_room(2);
  hl = l/2.0;
  hw = w/2.0;
  %
  % front reflection
  %
  fwpos.x = pointA.x;
  fwpos.y = hl;
  dfr1 = distance(pointA, fwpos);
  fr1.x = fwpos.x;
  fr1.y = hl + dfr1;
  %
  % right reflection
  %
  rwpos.x = hw;
  rwpos.y = pointA.y;
  drr1 = distance(pointA, rwpos);
  rr1.y = rwpos.y;
  rr1.x = hw + drr1;
  %
  % back reflection
  %
  bwpos.x = pointA.x;
  bwpos.y = -hl;
  dbr1 = distance(pointA, bwpos);
  br1.x = bwpos.x;
  br1.y = -hl-dbr1;
  %
  % left reflection
  %
  lwpos.x = -hw;
  lwpos.y = pointA.y;
  dlr1 = distance(pointA, lwpos);
  lr1.y = lwpos.y;
  lr1.x = -hw-dlr1;

  r = [fr1 rr1 br1 lr1];
end
