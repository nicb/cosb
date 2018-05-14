%
% single_delay_att_line_spec.m:
%
% this is used by single_delay_att_line_spec.rb to produce the numerical results
%
% PLEASE NOTE: since we run a 5+1 system we *WON'T* filter
% the signal coming from the back because it is going to
% be filtered by the pinnas of the listeners anyway!
%
%
addpath('..');
pkg load signal;
pkg load statistics;

sr = 48000;
sinc = 1/sr;
dur = 0.1;
t = [0:sinc:dur-sinc]';
sig = zeros(size(t,1),1); % row vector to simulate a signal
offset = dur/10;
s_offset = round(offset * sr);
sig(s_offset) = 1;
sound_speed = 344;

%
% signal and loudspeaker position
%
spos.x = 1; spos.y = 3;
lsp.x = 1; lsp.y = 1;
results(1).pos = spos;
results(1).lsp = lsp;
result_is = single_delay_att_line(sig, spos, lsp, sr, sound_speed);
dist = distance(spos, lsp);
del_s = round((dist/sound_speed) * sr);
atten = 1/dist;
outsig = zeros(size(sig, 1), 1);
outsig(del_s+1:end) = (sig(1:end-del_s) * atten);
results(1).is = sum(std([result_is outsig]')); % integrated standard deviation of the two signals
results(1).should_be = 0;
%
spos.x = -4; spos.y = -4;
lsp.x = -1; lsp.y = 1;
results(2).pos = spos;
results(2).lsp = lsp;
result_is = single_delay_att_line(sig, spos, lsp, sr, sound_speed);
dist = distance(spos, lsp);
del_s = round((dist/sound_speed) * sr);
atten = 1/dist;
outsig = zeros(size(sig, 1), 1);
outsig(del_s+1:end) = (sig(1:end-del_s) * atten);
% outsig = pinna_filter(outsig, 2000);
results(2).is = sum(std([result_is outsig]')); % integrated standard deviation of the two signals
results(2).should_be = 0;
%
for k=3:6
  spos.x = rand()*100-50; spos.y = rand()*100-50;
  lsp.x = rand()*2-1; lsp.y = rand()*2-1;
  results(k).pos = spos;
  results(k).lsp = lsp;
  result_is = single_delay_att_line(sig, spos, lsp, sr, sound_speed);
  dist = distance(spos, lsp);
  del_s = round((dist/sound_speed) * sr);
  atten = 1/dist;
  outsig = zeros(size(sig, 1), 1);
  outsig(del_s+1:end) = (sig(1:end-del_s) * atten);
  % outsig = pinna_filter(outsig, 2000);
  results(k).is = sum(std([result_is outsig]')); % integrated standard deviation of the two signals
  results(k).should_be = 0;
end


printf("require 'test_data_structure'\n")
printf("result = []\n");

for k=1:size(results, 2)
  printf("result << SingleLine::Data.new(Coord.new(%12.8f, %12.8f), Coord.new(%12.8f, %12.8f), %12.8f, %12.8f)\n", results(k).pos.x, results(k).pos.y, results(k).lsp.x, results(k).lsp.y, results(k).should_be, results(k).is);
end
