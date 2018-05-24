require 'spec_helper'
require 'yaml'
require File.expand_path(File.join(['..'] * 2, 'lib', 'test_helper'), __FILE__)

describe "Cosb Csound tester" do

  TMPDIR_OCTAVE_PATH = Dir.glob(File.expand_path(File.join(['..'] * 2, 'tmp', 'cosb-*', 'octave', 'info.yml'), __FILE__)).first
  before :example do
    @info = Cosb::Spec::Algo::TestHelper::InfoReader.new(TMPDIR_OCTAVE_PATH)
    @eps = 10**(-3)
    @bigeps = 10**1
  end

  it "has an deviation below #{@eps} for both channels" do
    @info.error['deviation'].each { |e| expect(e).to be_within(@eps).of(0.0) }
  end

  it "has max value index below #{@bigeps} for left channels" do
    mi = @info.error['maxindexes']
    expect(mi[0][0]).to be_within(@bigeps).of(mi[1][0])
  end

  it "has max value index below #{@bigeps} for right channels" do
    mi = @info.error['maxindexes']
    expect(mi[0][1]).to be_within(@bigeps).of(mi[1][1])
  end

end
