require 'spec_helper'
require 'yaml'
require File.expand_path(File.join(['..'] * 2, 'lib', 'test_helper'), __FILE__)

describe "compare Cosb Csound info" do

  TMPDIR_OCTAVE_PATH = Dir.glob(File.expand_path(File.join(['..'] * 2, 'tmp', 'cosb-*', 'octave', 'info.yml'), __FILE__)).first
  TMPDIR_CSOUND_PATH = Dir.glob(File.expand_path(File.join(['..'] * 2, 'tmp', 'cosb-*', 'csound', 'info.yml'), __FILE__)).first
  before :example do
    @octave_info = Cosb::Spec::Algo::TestHelper::InfoReader.new(TMPDIR_OCTAVE_PATH)
    @csound_info = YAML.load(File.open(TMPDIR_CSOUND_PATH))
    @eps = 10**(-4)
  end

  it 'has the same room depth' do
    expect(@csound_info['room']['depth']).to be_within(@eps).of(@octave_info.room[0])
  end

  it 'has the same room width' do
    expect(@csound_info['room']['width']).to be_within(@eps).of(@octave_info.room[1])
  end

  it 'has the same louspeaker positions' do
    expect(@csound_info['speakers'][1]['x']).to be_within(@eps).of(@octave_info.speakers[1]['x'])
    expect(@csound_info['speakers'][1]['y']).to be_within(@eps).of(@octave_info.speakers[1]['y'])
    expect(@csound_info['speakers'][2]['x']).to be_within(@eps).of(@octave_info.speakers[2]['x'])
    expect(@csound_info['speakers'][2]['y']).to be_within(@eps).of(@octave_info.speakers[2]['y'])
  end

  it 'has the same source position' do
    expect(@csound_info['source']['x']).to be_within(@eps).of(@octave_info.source_position[0])
    expect(@csound_info['source']['y']).to be_within(@eps).of(@octave_info.source_position[1])
  end

  it 'has the same source->speaker distances' do
    expect(@csound_info['speakers'][1]['distances']['direct']).to be_within(@eps).of(@octave_info.speakers[1]['distances']['direct'])
    expect(@csound_info['speakers'][2]['distances']['direct']).to be_within(@eps).of(@octave_info.speakers[2]['distances']['direct'])
  end

  1.upto(2) do
    |n|
    it "has the same source/1st reflections->speaker[#{n}] distances" do
	    @csound_info['speakers'][n]['distances'].each do
	      |k, v|
        expect((c=@csound_info['speakers'][n]['distances'][k])).to(be_within(@eps).of((o = @octave_info.speakers[n]['distances'][k])), "#{k.to_s}: #{c} != #{o}")
	    end
    end
  end

  1.upto(2) do
    |n|
    it "has the same source/1st reflections->speaker[#{n}] delays" do
	    @csound_info['speakers'][n]['delays'].each do
	      |k, v|
        expect((c=@csound_info['speakers'][n]['delays'][k])).to(be_within(@eps).of((o = @octave_info.speakers[n]['delays'][k])), "#{k.to_s}: #{c} != #{o}")
	    end
    end
  end

end
