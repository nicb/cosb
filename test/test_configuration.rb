#
# $Id: test_configuration.rb 3 2012-05-15 03:21:07Z nicb $
#
require File.dirname(__FILE__) + '/test_helper.rb'
require 'yaml'

class TestConfiguration < Test::Unit::TestCase

  def setup
		@correct_global_config_file = File.join(File.dirname(__FILE__), 'fixtures', 'correct_global_config.yml')
		@correct_space_config_file =  File.join(File.dirname(__FILE__), 'fixtures', 'correct_space_config.yml')
		@correct_global_config = YAML.load(File.open(@correct_global_config_file, 'r'))
		@correct_space_config  = YAML.load(File.open(@correct_space_config_file, 'r'))
  end

  def test_configuration_reading
    assert Cosb::Configuration.load(@correct_space_config_file, @correct_global_config_file)
		assert_equal Cosb::ConfigurationFile::Global, Cosb::Configuration.instance.global_configuration.class
		assert_equal Cosb::ConfigurationFile::Space, Cosb::Configuration.instance.space_configuration.class
		@correct_global_config['global'].keys.each do
			|key|
			assert_equal @correct_global_config['global'][key], Cosb::Configuration.instance.global_configuration.send(key)
		end
		skeys = @correct_space_config['space'].keys - ['loudspeaker_positions', 'virtual_space']
		skeys.each do
			|key|
			assert_equal @correct_space_config['space'][key], Cosb::Configuration.instance.space_configuration.send(key)
		end
		lkeys = @correct_space_config['space']['loudspeaker_positions'].keys
		lkeys.each do
			|key|
			assert aidx = key.to_i - 1
			assert nchans = Cosb::Configuration.instance.space_configuration.num_channels
			assert total_busses = Cosb::Configuration.instance.global_configuration.audio_sources + nchans
			assert dob_should_be = total_busses - nchans + (aidx * 2)
			assert rob_should_be = total_busses - nchans + (aidx * 2) + 1
			assert_equal key.to_i, Cosb::Configuration.instance.space_configuration.loudspeaker_positions[aidx].number
			assert_equal @correct_space_config['space']['loudspeaker_positions'][key][0], Cosb::Configuration.instance.space_configuration.loudspeaker_positions[aidx].x
			assert_equal @correct_space_config['space']['loudspeaker_positions'][key][1], Cosb::Configuration.instance.space_configuration.loudspeaker_positions[aidx].y
			assert_equal @correct_space_config['space']['loudspeaker_positions'][key][2], Cosb::Configuration.instance.space_configuration.loudspeaker_positions[aidx].lrc
			assert_equal dob_should_be, Cosb::Configuration.instance.space_configuration.loudspeaker_positions[aidx].direct_output_bus
			assert_equal rob_should_be, Cosb::Configuration.instance.space_configuration.loudspeaker_positions[aidx].reverb_output_bus
		end
		vskeys = @correct_space_config['space']['virtual_space'].keys
		vskeys.each do
			|key|
			assert_equal @correct_space_config['space']['virtual_space'][key], Cosb::Configuration.instance.space_configuration.virtual_space.send(key)
		end
  end

	def test_number_of_output_channels
            assert Cosb::Configuration.load(@correct_space_config_file, @correct_global_config_file)
	    assert num_channels_should_be = @correct_space_config['space']['loudspeaker_positions'].keys.size * 2
	    assert_equal num_channels_should_be, Cosb::Configuration.instance.space_configuration.num_channels
	end

end
