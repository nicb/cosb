% bwl_pulse: generate a band limited single pulse on a column vector
%   y = bwl_pulse(size, sr)
%
% where:
%
%   size = size of the output vector (the pulse will be in the middle)
%   sr   = sample rate
%
% The pulse is zero-phase in the middle of the vector. The vector is organized
% in rows to be compatible with what is returned by the audio functions.
%
function y = bwl_pulse(sz, sr)
  y      = zeros(1, sz);
  sinc   = 1/sr;
  dur    = sz/sr;
  t      = [-dur/2:sinc:(dur/2)-sinc];
  frq0   = 1/dur;
  nharms = sr/frq0;

  for k=0:nharms-1
    y = y .+ cos(2*pi*frq0*k*t);
  end

  y = (y ./ nharms)';
end
