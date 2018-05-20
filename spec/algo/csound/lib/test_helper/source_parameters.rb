module Cosb
  module TestHelper
  
    class SourceParameters
      attr_reader :position

      def initialize(sp)
        @position = generate_source_position(sp)
      end

    private

      #
      # generate_source_position(space_parameters)
      #
      # * minimize width/depth dimension
      # * calculate minimal modulo (speaker distance from center)
      # * calculate random angle between 0 and 2 pi
      # * calculate maximal modulo at that angle (max_x = min btw w/2 and
      #   abs(cos), max_y = min btw d/2 and abs(sin), then pythagoras
      # * randomize modulo distance between minimal modulo and max modulo
      # * explicit in cartesian coordinates
      # * create source with cartesian coordinates and appropriate label
      #
      def generate_source_position(sp)
        min_modulo = Math::sqrt((sp.rspeaker.x**2)+(sp.rspeaker.y)**2)
        angle = Cosb::TestHelper::randomizer(0, 2*Math::PI)
        max_x = [sp.width/2, ((sp.width/2)*Math::cos(angle)).abs].min
        max_y = [sp.depth/2, ((sp.depth/2)*Math::sin(angle)).abs].min
        max_modulo = Math::sqrt((max_x**2)+(max_y**2))
        modulo = Cosb::TestHelper::randomizer(min_modulo, max_modulo)
        x = modulo*Math::cos(angle)
        y = modulo*Math::sin(angle)
        Coordinate.new(x, y, "source at (%+.2f, %+.2f)" % [ x, y ])
      end

    end

  end
end
