%
% itd_samples_spec.m:
%
% this is used by itd_samples_spec.rb to produce the numerical results
%
addpath('..');

s_sp = 344; % m/sec

results(1).distance = 1;        % m
results(1).sample_rate = 48000; % Hz
results(1).sound_speed = s_sp;   % m/sec
results(1).result = itd_samples(results(1).distance); % just one argument
results(1).should_be = round((results(1).distance/results(1).sound_speed)*results(1).sample_rate);
%
results(2).distance = 10;        % m
results(2).sample_rate = 96000; % Hz
results(2).sound_speed = s_sp;   % m/sec
results(2).result = itd_samples(results(2).distance, results(2).sample_rate); % two argument
results(2).should_be = round((results(2).distance/results(2).sound_speed)*results(2).sample_rate);
%
results(3).distance = 100;        % m
results(3).sample_rate = 48000; % Hz
results(3).sound_speed = s_sp - 14;   % m/sec
results(3).result = itd_samples(results(3).distance, results(3).sample_rate, results(3).sound_speed); % two argument
results(3).should_be = round((results(3).distance/results(3).sound_speed)*results(3).sample_rate);
%
n_samples = 20;

for k=4:n_samples
  results(k).distance = rand()*10000; % m
  results(k).sample_rate = round(rand()*100000+32000); % Hz
  results(k).sound_speed = s_sp + (rand()*28-14); % m/sec
  results(k).result = itd_samples(results(k).distance, results(k).sample_rate, results(k).sound_speed);
  results(k).should_be = round((results(k).distance/results(k).sound_speed)*results(k).sample_rate);
end

printf("require 'test_data_structure'\n")
printf("result = []\n");

for k=1:size(results, 2)
  printf("result << ItdSamples::Data.new(%12.8f, %12.8f, %12.8f)\n", results(k).distance, results(k).should_be, results(k).result);
end
