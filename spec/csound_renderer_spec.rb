require 'spec_helper'

describe Cosb::CsoundRenderer do

  it 'responds to the filter removing option' do
    expect(cr = Cosb::CsoundRenderer.new(Cosb::Configuration::DEFAULT_CONFIGURATION_ROOT, Cosb::Configuration::DEFAULT_GLOBAL_CONFIGURATION_FILE, Cosb::Configuration::DEFAULT_SPACE_CONFIGURATION_FILE, Cosb::CsoundRenderer::DEFAULT_TEMPLATES[:sound_source], Cosb::CsoundRenderer::DEFAULT_TEMPLATES[:movements], Cosb::CsoundRenderer::DEFAULT_TEMPLATES[:reverb_and_output], Cosb::CsoundRenderer::DEFAULT_TEMPLATES[:point_source], true)).not_to be_nil
    expect(cr.no_filtering?).to be true
  end

  it 'responds to the filter removing default if not added' do
    expect(cr = Cosb::CsoundRenderer.new(Cosb::Configuration::DEFAULT_CONFIGURATION_ROOT, Cosb::Configuration::DEFAULT_GLOBAL_CONFIGURATION_FILE, Cosb::Configuration::DEFAULT_SPACE_CONFIGURATION_FILE)).not_to be_nil
    expect(cr.no_filtering?).to be false
  end

  it 'responds to the filter removing if set to false' do
    expect(cr = Cosb::CsoundRenderer.new(Cosb::Configuration::DEFAULT_CONFIGURATION_ROOT, Cosb::Configuration::DEFAULT_GLOBAL_CONFIGURATION_FILE, Cosb::Configuration::DEFAULT_SPACE_CONFIGURATION_FILE, Cosb::CsoundRenderer::DEFAULT_TEMPLATES[:sound_source], Cosb::CsoundRenderer::DEFAULT_TEMPLATES[:movements], Cosb::CsoundRenderer::DEFAULT_TEMPLATES[:reverb_and_output], Cosb::CsoundRenderer::DEFAULT_TEMPLATES[:point_source], false)).not_to be_nil
    expect(cr.no_filtering?).to be false
  end

end
