%
% pinna_filter: filters out high-frequencies if 
% the sound comes from the rear.
%
% Usage: out = pinna_filter(sig, cutoff, sr);
%
% where:
%        sig - the input signal
%        cutoff - the cutoff frequency (default: 2000)
%        sr  - sampling rate (default: 48000)
%
function out = pinna_filter(sig, cutoff, sr)
  if (nargin < 2)
    cutoff = 2000;
  end
  if (nargin < 3)
    sr = 48000;
  end

  %
  % this replicates the 'tone' csound filter
  %
  b = 2 - cos(2*pi*(cutoff/sr));
  c2 = b - sqrt((b**2) - 1.0);
  c1 = 1 - c2;

  out = zeros(length(sig), 1);

  out(1) = sig(1);
  for k=2:length(out)
    out(k) = (c1*sig(k)) + (c2*out(k-1));
  end

  out;
end
