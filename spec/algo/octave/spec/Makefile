TESTS=distance refl_1st_order itd_samples single_delay_att_line source_calculation
SPEC=rspec -I.
OCTAVE=octave --no-gui -q
RUBY=ruby -I.
PIC=groff -p -mpic -mps
PS2PDF=ps2pdf
FIXTURE_DIR=./fixtures
SOURCE_DIR=../../source

#all: fixtures $(TESTS)
all: source $(TESTS)

distance:
	($(OCTAVE) $@_spec.m; cat $@_spec_driver.rb) > $@_spec.rb
	$(SPEC) $@_spec.rb
	$(RM) $@_spec.rb

refl_1st_order:
	($(OCTAVE) $@_spec.m; cat $@_spec_driver.rb) > $@_spec.rb
	$(SPEC) $@_spec.rb
	$(RM) $@_spec.rb

itd_samples:
	($(OCTAVE) $@_spec.m; cat $@_spec_driver.rb) > $@_spec.rb
	$(SPEC) $@_spec.rb
	$(RM) $@_spec.rb

single_delay_att_line:
	($(OCTAVE) $@_spec.m; cat $@_spec_driver.rb) > $@_spec.rb
	$(SPEC) $@_spec.rb
	$(RM) $@_spec.rb

source_calculation:
	($(OCTAVE) $@_spec.m; cat $@_spec_driver.rb) > $@_spec.rb
	$(SPEC) $@_spec.rb
	$(RM) $@_spec.rb

source:
	$(MAKE) -C $(SOURCE_DIR) -$(MAKEFLAGS)

fixtures:
	$(MAKE) -C $(FIXTURE_CSOUND_DIR) -$(MAKEFLAGS)

refl_1st_order_pic.pdf: refl_1st_order_spec.m
	($(OCTAVE) $<; cat refl_1st_order_pic_driver.rb) | $(RUBY) | $(PIC) | $(PS2PDF) - $@

clean:
	$(RM) $(TESTS:=_spec.rb) *.jpg refl_1st_order_pic.pdf

.PHONY: clean distance refl_1st_order itd_samples single_delay_att_line fixtures
