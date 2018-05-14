%
% out = source_calculation(x, pos, inner_room, outer_room, sr, ss)
%
% computes the output vector matrix for a single source.
%
% Usage: out = source_calculation(x, pos, inner_room, outer_room, sr, ss)
%
% where:
% - x: input signal vector
% - pos: its coordinate position
% - inner_room: array of loudspeaker positions
% - outer_room: array of outer room dimensions (length and width)
% - sr: sample_rate (default: 48000)
% - ss: speed of sound (default: 344)
%
% - out: the output vector, which has x rows and inner_room columns
%
function out = source_calculation(x, pos, ir, or, sr, ss)

  if (nargin < 6)
    ss = 344;
  end

  if (nargin < 5)
    sr = 48000;
  end

  out = zeros(size(x, 1), size(ir, 2));

  refl = refl_1st_order(pos, or);
  %
  % direct signal
  %
  for k=1:size(ir, 2)
    sout = single_delay_att_line(x, pos, ir(k), sr, ss);
    out(:, k) += sout;
  end
  %
  % 1st order reflections
  %
  for k=1:size(refl, 2)
    for l=1:size(ir, 2)
      sout = single_delay_att_line(x, refl(k), ir(l), sr, ss);
      out(:, l) += sout;
    end
  end

  out;

end
