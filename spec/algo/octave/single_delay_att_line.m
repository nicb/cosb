%
% sig_out = single_delay_att_line(sig_in, spos, lsp, sr, ss, co)
%
% where:
%
% - sig_in: signal vector in
% - spos: source position
% - lsp: loudspeaker position
% - sr: sample_rate (default: 48000)
% - ss: speed of sound (default: 344)
% - co: the cutoff of the pinna filter (back sounds) (default: 2000)
%
% returns the delay-attenuated signal vector
%
function sig_out = single_delay_att_line(sig, spos, lsp, sr, ss, co)

  if (nargin < 7)
    cutoff = 2000;
  end

  if (nargin < 6)
    ss = 344;
  end

  if (nargin < 5)
    sr = 48000;
  end

  dist = distance(spos, lsp);
  samp_delay = itd_samples(dist, sr, ss);
  atten = 1/dist;
  sig_out = zeros(size(sig, 1), 1);

  sig_out(samp_delay+1:end) = (sig(1:end-samp_delay)*atten);
  %
  % PLEASE NOTE: since we run a 5+1 system we *WON'T* filter
  % the signal coming from the back because it is going to
  % be filtered by the pinnas of the listeners anyway!
  %
  % low-pass filter signal at 2 kHz if signal is coming from behind to
  % simulate the ear pinna
  %
% if(spos.y < 0)
%   sig_out = pinna_filter(sig_out, cutoff, sr);
% end

  sig_out;

end
