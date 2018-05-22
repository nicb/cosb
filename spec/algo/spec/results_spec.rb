require 'spec_helper'
require 'yaml'
require File.expand_path(File.join(['..'] * 2, 'lib', 'test_helper'), __FILE__)

describe "Cosb Csound tester" do

  TMPDIR_OCTAVE_PATH = Dir.glob(File.expand_path(File.join(['..'] * 2, 'tmp', 'cosb-*', 'octave', 'info.yml'), __FILE__)).first
  before :example do
    @info = Cosb::Spec::Algo::TestHelper::InfoReader.new(TMPDIR_OCTAVE_PATH)
  end

  it 'has an error below 10^-3 for both channels' do
    @info.error.each { |e| expect(e).to be_within(10**(-3)).of(0.0) }
  end

end
