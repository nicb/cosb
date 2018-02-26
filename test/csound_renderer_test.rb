#
# $Id: test_csound_renderer.rb 3 2012-05-15 03:21:07Z nicb $
#
require File.expand_path(File.join('..', 'test_helper'), __FILE__)

class TestConfiguration < Minitest::Test

  def test_csound_renderer
		assert cr = Cosb::CsoundRenderer.new(Cosb::Configuration::DEFAULT_SPACE_CONFIGURATION, Cosb::Configuration::DEFAULT_GLOBAL_CONFIGURATION)
		assert out = cr.render
		assert_match(/sr\s*=\s*#{cr.configuration.global_configuration.sample_rate}/, out)
		assert_match(/ksmps\s*=\s*#{cr.configuration.global_configuration.ksmps}/, out)
		assert_match(/nchnls\s*=\s*#{cr.configuration.space_configuration.num_channels}/, out)
  end

end
