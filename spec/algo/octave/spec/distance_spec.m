%
% distance_spec_driver.m:
%
% this is used by distance_spec.rb to produce the numerical results
%
addpath('..');
pkg load statistics;
p1(1).x = 1; p1(1).y = 1;
p2(1).x = 1; p2(1).y = -1;
t(1).data = [ p1(1) p2(1) ]; t(1).result = 2;
%
%
p1(2).x = -1; p1(2).y = 1;
p2(2).x = 1; p2(2).y = 1;
t(2).data = [ p1(2) p2(2) ]; t(2).result = 2;
%
%
p1(3).x = 1; p1(3).y = 1;
p2(3).x = 1; p2(3).y = 1;
t(3).data = [ p1(3) p2(3) ]; t(3).result = 0;
%
%
p1(4).x = 1; p1(4).y = 1;
p2(4).x = -1; p2(4).y = -1;
t(4).data = [ p1(4) p2(4) ]; t(4).result = sqrt(4+4);
%
%
p1(5).x = -1; p1(5).y = -1;
p2(5).x = 1; p2(5).y = 1;
t(5).data = [ p1(5) p2(5) ]; t(5).result = sqrt(4+4);
%
%
p1(6).x = -4; p1(6).y = -4;
p2(6).x = 1; p2(6).y = 1;
t(6).data = [ p1(6) p2(6) ]; t(6).result = sqrt(((p2(6).x-p1(6).x)**2)+((p2(6).y-p1(6).y)**2));
%
%
p1(7).x = 2; p1(7).y = 2;
p2(7).x = -4; p2(7).y = -8;
t(7).data = [ p1(7) p2(7) ]; t(7).result = sqrt(((p2(7).x-p1(7).x)**2)+((p2(7).y-p1(7).y)**2));
%
%
p1(8).x = rand()*100-50; p1(8).y = rand()*100-50;
p2(8).x = rand()*100-50; p2(8).y = rand()*100-50;
t(8).data = [ p1(8) p2(8) ]; t(8).result = sqrt(((p2(8).x-p1(8).x)**2)+((p2(8).y-p1(8).y)**2));

printf("require 'test_data_structure'\n")
printf("result = []\n");

for k=1:size(t, 2)
  d = distance(t(k).data(1), t(k).data(2));
  printf("p1 = Coord.new(%12.8f, %12.8f)\n", t(k).data(1).x, t(k).data(1).y);
  printf("p2 = Coord.new(%12.8f, %12.8f)\n", t(k).data(2).x, t(k).data(2).y);
  printf("result << Distance::Data.new(p1, p2, %12.8f, %12.8f)\n", t(k).result, d);
end
