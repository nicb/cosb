%
% refl_1st_order_spec_driver.m:
%
% this is used by refl_1st_order_spec.rb to produce the numerical results
%
pkg load statistics;
addpath('..');

%
%
% We test the 4 quadrants
%
p1.x = 1; p1.y = 1;
t(1).source =  p1; t(1).result = [ [1, 9], [3, 1], [1, -11], [-5, 1] ];
t(1).room.depth = 10; t(1).room.width = 4;
%
%
p1.x = -1; p1.y = 1;
t(2).source =  p1; t(2).result = [ [-1, 9], [5, 1], [-1, -11], [-3, 1] ];
t(2).room.depth = 10; t(2).room.width = 4;
%
%
p1.x = 1; p1.y = -1;
t(3).source = p1; t(3).result = [ [1, 11], [3, -1], [1, -9], [-5, -1] ];
t(3).room.depth = 10; t(3).room.width = 4;
%
%
p1.x = -1; p1.y = -1;
t(4).source =  p1; t(4).result = [ [-1, 11], [5, -1], [-1, -9], [-3, -1] ];
t(4).room.depth = 10; t(4).room.width = 4;
%
t(5).room.depth = rand()*37+3; t(5).room.width = rand()*37+3;
p1.x = (t(5).room.width/2)-(0.25*t(5).room.width/2); p1.y = (t(5).room.depth/2) - (0.25*t(5).room.depth/2); # upper right corner
t(5).source =  p1;
rfw = abs(t(5).room.depth/2 - t(5).source.y) + (t(5).room.depth/2);
rrw = abs(t(5).room.width/2 - t(5).source.x) + (t(5).room.width/2);
rbw = -abs(-t(5).room.depth/2 - t(5).source.y) - (t(5).room.depth/2);
rlw = -abs(-t(5).room.width/2 - t(5).source.x) - (t(5).room.width/2);
t(5).result = [ [t(5).source.x, rfw], [rrw, t(5).source.y], [t(5).source.x, rbw], [rlw, t(5).source.y] ];

labels = ["front"; "right"; "back"; "left"];

#
# random positions (within the room)
#
npos = 10;
for k=6:5+npos
  t(k).room.depth = rand()*40+3;
  t(k).room.width = rand()*40+3;
  t(k).source.x = (rand()*t(k).room.width)-(t(k).room.width/2);
  t(k).source.y = (rand()*t(k).room.depth)-(t(k).room.depth/2);
  t(k).result = zeros(1, 8);
  rfw = abs(t(k).room.depth/2 - t(k).source.y) + (t(k).room.depth/2);
  rrw = abs(t(k).room.width/2 - t(k).source.x) + (t(k).room.width/2);
  rbw = -abs(-t(k).room.depth/2 - t(k).source.y) - (t(k).room.depth/2);
  rlw = -abs(-t(k).room.width/2 - t(k).source.x) - (t(k).room.width/2);
  t(k).result(1,1:2) = [ t(k).source.x, rfw ];
  t(k).result(1,3:4) = [ rrw, t(k).source.y ];
  t(k).result(1,5:6) = [ t(k).source.x, rbw ];
  t(k).result(1,7:8) = [ rlw, t(k).source.y ];
end

printf("require 'test_data_structure'\n")
printf("result = []\n");

for k=1:size(t, 2)
  r = refl_1st_order(t(k).source, [t(k).room.width t(k).room.depth] );
  printf("source = Coord.new(%12.8f, %12.8f)\n", t(k).source.x, t(k).source.y);
  printf("rfls = []\n")
  for m=1:size(r, 2)
    printf("rfls << Coord.new(%12.8f, %12.8f, '%s')\n", r(m).x, r(m).y, [labels(m,:)  ' is']);
  end
  printf("rflssb = []\n")
  for m=1:2:size(t(k).result, 2)
    printf("rflssb << Coord.new(%12.8f, %12.8f, '%s')\n", t(k).result(m), t(k).result(m+1), [labels(((m-1)/2)+1, :) ' should be']);
  end
  printf("result << Refl1stOrder::Data.new(source, %12.8f, %12.8f, rflssb, rfls)\n", t(k).room.depth, t(k).room.width);
end
