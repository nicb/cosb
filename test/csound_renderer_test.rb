#
# $Id: test_csound_renderer.rb 3 2012-05-15 03:21:07Z nicb $
#
require File.expand_path(File.join('..', 'test_helper'), __FILE__)

class TestConfiguration < Minitest::Test

  def test_creation_with_no_arguments
    assert Cosb::CsoundRenderer.new
  end

  def test_csound_renderer
		assert cr = Cosb::CsoundRenderer.new(Cosb::Configuration::DEFAULT_CONFIGURATION_ROOT, Cosb::Configuration::DEFAULT_GLOBAL_CONFIGURATION_FILE, Cosb::Configuration::DEFAULT_SPACE_CONFIGURATION_FILE)
		assert out = cr.render
		assert_match(/sr\s*=\s*#{cr.configuration.global_configuration.sample_rate}/, out)
		assert_match(/ksmps\s*=\s*#{cr.configuration.global_configuration.ksmps}/, out)
		assert_match(/nchnls\s*=\s*#{cr.configuration.space_configuration.num_channels}/, out)
  end

  def test_list_numbers_single_step
		assert cr = Cosb::CsoundRenderer.new(Cosb::Configuration::DEFAULT_CONFIGURATION_ROOT, Cosb::Configuration::DEFAULT_GLOBAL_CONFIGURATION_FILE, Cosb::Configuration::DEFAULT_SPACE_CONFIGURATION_FILE)
    assert_equal cr.list_numbers(1,5), '1, 2, 3, 4, 5'
    assert_equal cr.list_numbers(23,27), '23, 24, 25, 26, 27'
    assert_equal cr.list_numbers(-2,2), '-2, -1, 0, 1, 2'
  end

  def test_list_numbers_large_step
		assert cr = Cosb::CsoundRenderer.new(Cosb::Configuration::DEFAULT_CONFIGURATION_ROOT, Cosb::Configuration::DEFAULT_GLOBAL_CONFIGURATION_FILE, Cosb::Configuration::DEFAULT_SPACE_CONFIGURATION_FILE)
    assert_equal cr.list_numbers(1,10,4), '1, 5, 9'
    assert_equal cr.list_numbers(23,27,2), '23, 25, 27'
    assert_equal cr.list_numbers(-2,2,3), '-2, 1'
  end

end
