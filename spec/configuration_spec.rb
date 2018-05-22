require 'spec_helper'

describe Cosb::Configuration do

  before :example do
    #
    # +set_test_paths+ is in spec_helper.rb
    #
    set_test_paths
  end

  it 'can read its configuration properly' do
    expect(Cosb::Configuration.load(@correct_config_path, @correct_global_config_file, @correct_space_config_file)).not_to be_nil
    expect(Cosb::ConfigurationFile::Global).to eq(Cosb::Configuration.instance.global_configuration.class)
    expect(Cosb::ConfigurationFile::Space).to eq(Cosb::Configuration.instance.space_configuration.class)
		@correct_global_config['global'].keys.each do
			|key|
      expect(@correct_global_config['global'][key]).to eq(Cosb::Configuration.instance.global_configuration.send(key))
    end
		skeys = @correct_space_config['space'].keys - ['loudspeaker_positions', 'virtual_space']
		skeys.each do
			|key|
      expect(@correct_space_config['space'][key]).to eq(Cosb::Configuration.instance.space_configuration.send(key))
		end
		lkeys = @correct_space_config['space']['loudspeaker_positions'].keys
		lkeys.each do
			|key|
      expect(aidx = key.to_i - 1).not_to be_nil
      expect(nchans = Cosb::Configuration.instance.space_configuration.num_channels).not_to be_nil
      expect(total_busses = Cosb::Configuration.instance.global_configuration.audio_sources + nchans).not_to be_nil
			dob_should_be = total_busses - nchans + (aidx * 2)
			rob_should_be = total_busses - nchans + (aidx * 2) + 1
      expect(key.to_i).to eq(Cosb::Configuration.instance.space_configuration.loudspeaker_positions[aidx].number)
      expect(@correct_space_config['space']['loudspeaker_positions'][key][0]).to eq(Cosb::Configuration.instance.space_configuration.loudspeaker_positions[aidx].x)
      expect(@correct_space_config['space']['loudspeaker_positions'][key][1]).to eq(Cosb::Configuration.instance.space_configuration.loudspeaker_positions[aidx].y)
      expect(@correct_space_config['space']['loudspeaker_positions'][key][2]).to eq(Cosb::Configuration.instance.space_configuration.loudspeaker_positions[aidx].lrc)
      expect(dob_should_be).to eq(Cosb::Configuration.instance.space_configuration.loudspeaker_positions[aidx].direct_output_bus)
      expect(rob_should_be).to eq(Cosb::Configuration.instance.space_configuration.loudspeaker_positions[aidx].reverb_output_bus)
		end
		vskeys = @correct_space_config['space']['virtual_space'].keys
		vskeys.each do
			|key|
      expect(@correct_space_config['space']['virtual_space'][key]).to eq(Cosb::Configuration.instance.space_configuration.virtual_space.send(key))
		end
  end

  it 'has the correct number of channels' do
    expect(Cosb::Configuration.load(@correct_config_path, @correct_global_config_file, @correct_space_config_file)).not_to be_nil
    expect((num_channels_should_be = @correct_space_config['space']['loudspeaker_positions'].keys.size * 2)).not_to be_nil
    expect(num_channels_should_be).to eq Cosb::Configuration.instance.space_configuration.num_channels
  end

end
