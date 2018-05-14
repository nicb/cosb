%
% s = itd_samples(dist, sample_rate, sound_speed);
%
% itd_samples calculate the time delay (in samples)
%
% Usage: itd_samples(dist, sample_rate, sound_speed)
%
% - dist: the distance to convert
% - sample_rate: the sampling rate  (default: 48000 Hz)
% - sound_speed: the speed of sound (default: 344 m/sec)
%
function s = itd_samples(d, sr, ss)

  if(nargin < 3)
    ss = 344;
  end
  if(nargin < 2)
    sr = 48000;
  end

  s = round((d/ss)*sr);
 
end
