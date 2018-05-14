HERE=.
OURTOP=../../../..
TOP=$(OURTOP)/../..
COSB_BINDIR=$(TOP)/bin
CONFIG_DIR= ../config
SPACE_DIR = $(CONFIG_DIR)/spaces
GLOBAL_DIR = $(TOP)/config/global
COSB = $(COSB_BINDIR)/cosb
COSB_FLAGS=-c $(CONFIG_DIR) 
CSSB = $(HERE)/y2sco
AUDIO_SRC=$(OURTOP)/source
CSOUND=SSDIR="$(AUDIO_SRC)" csound
TARGETS=source_calculation_01.src.wav source_calculation_02.src.wav
SOURCES=$(TARGETS:.wav=.yml)
LSP_SOURCES=$(TARGETS:.src.wav=.lsp.yml)
ORCS=$(TARGETS:.src.wav=.src.orc)
VPATH=.:$(SPACE_DIR)

all: audio_source $(ORCS) $(TARGETS) 

clean:
	$(RM) $(TARGETS) *.orc *.sco

audio_source:
	$(MAKE) -C $(AUDIO_SRC) -$(MAKEFLAGS) 

.SUFFIXES: .src.wav .src.yml .lsp.yml .orc

%.src.wav: %.src.yml
	$(CSSB) $< > $*.src.sco
	$(CSOUND) -dWo ./$@ $*.src.orc $*.src.sco


%.src.orc: %.lsp.yml
	$(COSB) $(COSB_FLAGS) -s `basename $<` > $@

.PHONY: audio_source clean
