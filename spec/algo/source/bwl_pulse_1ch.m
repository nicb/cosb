sinc = 1/sr;
nchnls = 1;
offset = 0.5;
dur    = offset * (nchnls+1);
nsamp  = dur * sr;
out    = zeros(nsamp, nchnls);
sz     = 128;
hsz    = floor(sz/2);
amp    = 10**(-1.0/20.0);

at = offset*sr;
for k=1:nchnls
  yk = amp*bwl_pulse(sz, sr);
  out(at-hsz:at+hsz-1, k) += yk;
  at += (offset*sr);
end

