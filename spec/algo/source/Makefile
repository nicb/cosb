SAMPLE_RATE=48000
TARGETS=bwl_pulse_1ch.wav
SOURCES=$(TARGETS:.wav=.m)
MATLAB=octave --no-gui -q
NSOURCES=23
LN=ln -sf


all: $(TARGETS)

clean:
	$(RM) $(TARGETS) soundin.*

.PHONY: clean links

.SUFFIXES: .wav .m

%.wav: %.m
	(echo 'sr=$(SAMPLE_RATE);'; cat $<; echo 'filename = "$@"; audiowrite(filename, out, sr);') | $(MATLAB)
	$(LN) $@ soundin.1
