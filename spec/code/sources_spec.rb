require 'spec_helper'

describe Cosb::Sources do

  before :example do
    @right_args =
    {
      :multi => { :arg => [[1, 10],[4, 5]], :result => 30 },
      :zero => { :arg => [[0, 0]], :result => 0 },
    }
    @wrong_args =
    {
      :single => { :arg => 23 },
      :weird_multi => { :arg => [ 'string' ] },
      :weirder_multi => { :arg => [[ 'string', 0 ]] },
      :wrong_multi => { :arg => [[ 0, 1, 2, 3 ]] },
      :wrong_single => { :arg => 'really wrong' },
    }
  end

  it 'cannot be created without arguments' do
    expect { Cosb::Sources.new }.to raise_error(ArgumentError)
  end

  it 'can be created with the right arguments' do
    @right_args.each do
      |key, ah|
      ah[:arg].each do
        |arg|
        expect(Cosb::Sources.new(arg)).to be_truthy, key.to_s
      end
    end
  end

  it 'cannot be created with wrong arguments' do
    @wrong_args.each do
      |key, ah|
      expect{ Cosb::Sources.new(ah[:arg]) }.to raise_error(ArgumentError)
    end
  end

  it 'calculates the number of output channels correctly' do
    @right_args.each do
      |key, ah|
      res = 0
      ah[:arg].each do
        |arg|
        expect(srcs = Cosb::Sources.new(arg)).to be_truthy, key.to_s
        res += srcs.num_sources
      end
      expect(res).to(eq(ah[:result]), key.to_s)
    end
	end

end
