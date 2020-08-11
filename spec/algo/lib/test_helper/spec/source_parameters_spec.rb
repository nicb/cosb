require 'spec_helper'
require File.expand_path(File.join(['..'] * 3, 'test_helper'), __FILE__)

describe Cosb::Spec::Algo::TestHelper::SourceParameters do

  before :example do
    @two_pi = (2*Math::PI)
    glob = Cosb::Spec::Algo::TestHelper::GlobalParameters.new
    @narrow_space = Cosb::Spec::Algo::TestHelper::SpaceParameters.new(glob)
    @narrow_space.instance_variable_set(:@speaker_radius, 1); @narrow_space.width = 4; @narrow_space.depth = 30
    @wide_space = Cosb::Spec::Algo::TestHelper::SpaceParameters.new(glob)
    @wide_space.instance_variable_set(:@speaker_radius, 1); @wide_space.width = 30; @wide_space.depth = 4
    @angle_step = (@two_pi)/400
    @angle = 0
    @ns_pos = Cosb::Spec::Algo::TestHelper::SourceParameters.new(@narrow_space)
    @ws_pos = Cosb::Spec::Algo::TestHelper::SourceParameters.new(@wide_space)
  end

  it "produces a proper source position for any angle on a narrow space" do
  while(@angle < @two_pi)
      (x, y) = @ns_pos.send(:calculate_coordinates, @narrow_space.width, @narrow_space.depth, @angle, @narrow_space.speaker_radius)
      expect(x.abs < (@narrow_space.width/2)).to(be(true), "x.abs !< @narrow_space.width/2 (#{x.abs} !< #{@narrow_space.width/2})")
      expect(y.abs < (@narrow_space.depth/2)).to(be(true), "y.abs !< @narrow_space.depth/2 (#{y.abs} !< #{@narrow_space.depth/2})")
    @angle += @angle_step
  end
  end

  it "produces a proper source position for any angle on a wide space" do
  while(@angle < @two_pi)
          (x, y) = @ws_pos.send(:calculate_coordinates, @wide_space.width, @wide_space.depth, @angle, @wide_space.speaker_radius)
      expect(x.abs < (@wide_space.width/2)).to(be(true), "x.abs !< @wide_space.width/2 (#{x.abs} !< #{@wide_space.width/2})")
      expect(y.abs < (@wide_space.depth/2)).to(be(true), "x.abs !< @wide_space.depth/2 (#{y.abs} !< #{@wide_space.depth/2})")
    @angle += @angle_step
  end
  end

end
