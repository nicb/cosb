%
% itd_samples_spec.m:
%
% this is used by itd_samples_spec.rb to produce the numerical results
%
addpath('..');

results(1).distance = 1;        % m
results(1).sample_rate = 48000; % Hz
results(1).sound_speed = 344;   % m/sec
results(1).result = itd_samples(results(1).distance); % just one argument
results(1).should_be = round((results(1).distance/results(1).sound_speed)*results(1).sample_rate);
%
results(2).distance = 10;        % m
results(2).sample_rate = 96000; % Hz
results(2).sound_speed = 344;   % m/sec
results(2).result = itd_samples(results(2).distance, results(2).sample_rate); % two argument
results(2).should_be = round((results(2).distance/results(2).sound_speed)*results(2).sample_rate);
%
results(3).distance = 100;        % m
results(3).sample_rate = 48000; % Hz
results(3).sound_speed = 330;   % m/sec
results(3).result = itd_samples(results(3).distance, results(3).sample_rate, results(3).sound_speed); % two argument
results(3).should_be = round((results(3).distance/results(3).sound_speed)*results(3).sample_rate);
%

printf("require 'test_data_structure'\n")
printf("result = []\n");

for k=1:size(results, 2)
  printf("result << ItdSamples::Data.new(%12.8f, %12.8f, %12.8f)\n", results(k).distance, results(k).should_be, results(k).result);
end
