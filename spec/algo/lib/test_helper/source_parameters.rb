module Cosb
  module Spec
    module Algo

      module TestHelper
      
        class SourceParameters
          attr_reader :position

          include Cosb::Spec::Algo::TestHelper::Randomizer
    
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
            i_margin = 1.05
            o_margin = 0.95
            halfw = sp.width/2
            halfd = sp.depth/2
            hdiag = Math::sqrt((halfw**2)+(halfd**2))
            angle = randomizer(0, 2*Math::PI)
            min_modulo = sp.speaker_radius
            max_modulo_x = [ halfw, (hdiag*Math::cos(angle)).abs ].min
            max_modulo_y = [ halfd, (hdiag*Math::sin(angle)).abs ].min
            max_modulo = Math::sqrt((max_modulo_x**2)+(max_modulo_y**2))
#           modulo = randomizer(min_modulo*i_margin, max_modulo*o_margin)
            modulo = max_modulo*o_margin
            x = modulo*Math::cos(angle)
            y = modulo*Math::sin(angle)
            Coordinate.new(x, y, "source at (%+.2f, %+.2f)[modulo: %.4f, angle: %.4f]" % [ x, y, modulo, angle ])
          end
    
        end
    
      end

    end
  end
end
