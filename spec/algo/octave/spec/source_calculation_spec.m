%
% source_calculation_spec.m:
%
% this is used by source_calculation_spec.rb to produce the numerical results
%
% PLEASE NOTE: since we run a 5+1 system we *WON'T* filter
% the signal coming from the back because it is going to
% be filtered by the pinnas of the listeners anyway!
%
%
addpath('..');
pkg load signal;
pkg load statistics;

[sig sr] = audioread("../../source/bwl_pulse_1ch.wav");
sinc = 1/sr;
dur = length(sig)/sr;
amp = max(sig);
t = [0:sinc:dur-sinc]';
offset = dur/2;
s_offset = round(offset * sr);
sound_speed = 344;

%
% signal at 1,3 on a stereo pair
%
spos.x = 1; spos.y = 3;
spk(1).x = -1; spk(1).y = 1;
spk(2).x = 1;  spk(2).y = 1;
results(1).source = spos;
results(1).speakers = spk;
results(1).outer_room = [10, 3]; % outer_room dimensions: width, depth
results(1).octave_signal = source_calculation(sig, spos, [spk(1) spk(2)], results(1).outer_room, sr, sound_speed);
ldist = distance(spos, spk(1));
ldel_s = round((ldist/sound_speed) * sr);
latten = 1/ldist;
rdist = distance(spos, spk(2));
rdel_s = round((rdist/sound_speed) * sr);
ratten = 1/rdist;
reflections = refl_1st_order(spos, results(1).outer_room);
outsig = zeros(length(sig), 2);
outsig(ldel_s+1:end,1) = (sig(1:end-ldel_s) * latten);
outsig(rdel_s+1:end,2) = (sig(1:end-rdel_s) * ratten);
for k=1:length(reflections)
  for n=1:length(spk)
    refldist = distance(reflections(k), spk(n));
    refldelay = refldist/sound_speed;
    refldelay_s = round(refldelay * sr);
    reflatten = 1/refldist;
    reflsig = (sig(1:end-refldelay_s) * reflatten);
    outsig(refldelay_s+1:end,n) += reflsig;
  end
end

%
% plot to debug cosb
%
% octsz = size(results(1).octave_signal(:,1))
% csoundsz = size(results(1).csound_signal(:,1))
% tsz = size(t)
% diffs_1_sz = size(results(1).diffs(:,1))
% diffs_sz = size(results(1).diffs)
% subplot(2,1,1)
% plot(t, results(1).octave_signal(:,1), "b;octave L;", t, results(1).csound_signal(:,1), "r;csound L;")
% axis([0.5 0.58])
% subplot(2,1,2)
% plot(t, results(1).octave_signal(:,2), "b;octave R;", t, results(1).csound_signal(:,2), "r;csound R;")
% axis([0.5 0.58])
% 
% print("source_calculation_01.jpg", "-djpeg");
%
%

results(1).is = [sum(std([results(1).octave_signal(:,1) outsig(:,1)]')) sum(std([results(1).octave_signal(:,2) outsig(:,2)]'))]; % integrated standard deviation of the two signals
results(1).should_be = [0 0];

%
% signal at -1,-3 on a stereo pair
%
% insig = audioread("./fixtures/csound/source_calculation_02.src.wav");
% results(2).csound_signal = insig(:,1:2);
spos.x = -1; spos.y = -3;
spk(1).x = -1; spk(1).y = 1;
spk(2).x = 1;  spk(2).y = 1;
results(2).source = spos;
results(2).speakers = spk;
results(2).outer_room = [5, 8]; % outer_room dimensions: width, depth
result_is = source_calculation(sig, spos, [spk(1) spk(2)], results(2).outer_room, sr, sound_speed);
ldist = distance(spos, spk(1));
ldel_s = round((ldist/sound_speed) * sr);
latten = 1/ldist;
rdist = distance(spos, spk(2));
rdel_s = round((rdist/sound_speed) * sr);
ratten = 1/rdist;
reflections = refl_1st_order(spos, results(2).outer_room);
outsig = zeros(size(sig, 1), 2);
%
% since the signal is in the back, it should be filtered
% (this is NOT done, see above)
%
% lsig = pinna_filter((sig(1:end-ldel_s) * latten));
% rsig = pinna_filter((sig(1:end-rdel_s) * ratten));
lsig = sig(1:end-ldel_s) * latten;
rsig = sig(1:end-rdel_s) * ratten;
outsig(ldel_s+1:end,1) = lsig;
outsig(rdel_s+1:end,2) = rsig;
for k=1:size(reflections,2)
  for n=1:size(spk,2)
    refldist = distance(reflections(k), spk(n));
    refldelay = refldist/sound_speed;
    refldelay_s = round(refldelay * sr);
    reflatten = 1/refldist;
    reflsig = (sig(1:end-refldelay_s) * reflatten); 
    outsig(refldelay_s+1:end,n) += reflsig;
  end
end
%
%
results(2).is = [sum(std([result_is(:,1) outsig(:,1)]')) sum(std([result_is(:,2) outsig(:,2)]'))]; % integrated standard deviation of the two signals
results(2).should_be = [0 0];
%
%
% a bunch of random position
%
npos = 20;

for k=2:npos
  spk(2).x = (rand()*5+1);
  spk(2).y = (rand()*5+1);
  spk(1).x = -spk(2).x;
  spk(2).y =  spk(1).y;
  radius = sqrt(((spk(1).x**2)+(spk(1).y**2)));
  depth  = rand()*9*radius + radius;
  width  = rand()*9*radius + radius;
  results(k).outer_room = [width, depth]; % outer_room dimensions: width, depth
  maxdist = min([width depth]);
  modulo = (rand()*(maxdist-radius)) + radius;
  angle_size = rand()*2*pi;
  spos.x = modulo * cos(angle_size);
  spos.y = modulo * sin(angle_size);
  results(k).source = spos;
  results(k).speakers = spk;
  result_is = source_calculation(sig, spos, [spk(1) spk(2)], results(k).outer_room, sr, sound_speed);
  ldist = distance(spos, spk(1));
  ldel_s = round((ldist/sound_speed) * sr);
  latten = 1/ldist;
  rdist = distance(spos, spk(2));
  rdel_s = round((rdist/sound_speed) * sr);
  ratten = 1/rdist;
  reflections = refl_1st_order(spos, results(k).outer_room);
  outsig = zeros(size(sig, 1), 2);
  %
  % since the signal is in the back, it should be filtered
  % (this is NOT done, see above)
  %
  % lsig = pinna_filter((sig(1:end-ldel_s) * latten));
  % rsig = pinna_filter((sig(1:end-rdel_s) * ratten));
  lsig = sig(1:end-ldel_s) * latten;
  rsig = sig(1:end-rdel_s) * ratten;
  outsig(ldel_s+1:end,1) = lsig;
  outsig(rdel_s+1:end,2) = rsig;
  for m=1:size(reflections,2)
    for n=1:size(spk,2)
      refldist = distance(reflections(m), spk(n));
      refldelay = refldist/sound_speed;
      refldelay_s = round(refldelay * sr);
      reflatten = 1/refldist;
      reflsig = (sig(1:end-refldelay_s) * reflatten); 
      outsig(refldelay_s+1:end,n) += reflsig;
    end
  end
  %
  %
  results(k).is = [sum(std([result_is(:,1) outsig(:,1)]')) sum(std([result_is(:,2) outsig(:,2)]'))]; % integrated standard deviation of the two signals
  results(k).should_be = [0 0];
end

printf("require 'test_data_structure'\n")
printf("result = []\n");

for k=1:size(results,2)
  printf("result << SourceCalculation::Data.new(Coord.new(%12.8f, %12.8f), [Coord.new(%12.8f, %12.8f), Coord.new(%12.8f, %12.8f)], [%12.8f, %12.8f], [%12.8f, %12.8f])\n", results(k).source.x, results(k).source.y, results(k).speakers(1).x, results(k).speakers(1).y, results(k).speakers(2).x, results(k).speakers(2).y, results(k).should_be(1), results(k).should_be(2), results(k).is(1), results(k).is(2));
end

%
% To be commented out while not debugging this code
%
% subplot(3,2,1)
% plot(t, result_is(:, 1), ';calculation results (left);')
% axis([t(1) t(end) -0.01 0.15])
% subplot(3,2,2)
% plot(t, outsig(:, 1), ';should be (left);')
% axis([t(1) t(end) -0.01 0.15])
% subplot(3,2,3)
% plot(t, result_is(:, 2), ';calculation results (right);')
% axis([t(1) t(end) -0.01 0.15])
% subplot(3,2,4)
% plot(t, outsig(:, 2), ';should be (right);')
% axis([t(1) t(end) -0.01 0.15])
% subplot(3,2,5)
% plot(t, std([result_is(:, 1) outsig(:, 1)]'), ';deviation (left);')
% subplot(3,2,6)
% plot(t, std([result_is(:, 2) outsig(:, 2)]'), ';deviation (right);')
