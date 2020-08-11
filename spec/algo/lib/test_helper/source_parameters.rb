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
          # * create source with cartesian coordinates and appropriate label
          #
          def generate_source_position(sp)
            angle = randomizer(0, 2*Math::PI)
            (x, y, modulo) = calculate_coordinates(sp.width/2, sp.depth/2, angle, sp.speaker_radius)
            Coordinate.new(x, y, "source at (%+.2f, %+.2f)[modulo: %.4f, angle: %.4f]" % [ x, y, modulo, angle ])
          end

          #
          # calculate_coordinates(half_width, half_depth, angle, speaker_radius)
          #
          # * minimize width/depth dimension
          # * calculate minimal modulo (speaker distance from center)
          # * calculate random angle between 0 and 2 pi
          # * calculate maximal modulo at that angle (max_x = min btw w/2 and
          #   abs(cos), max_y = min btw d/2 and abs(sin), then pythagoras
          # * randomize modulo distance between minimal modulo and max modulo
          # * explicit in cartesian coordinates
          #
          def calculate_coordinates(hw, hd, angle, sp_radius)
            i_margin = 1.02
            o_margin = 0.98
            hdiag = Math::sqrt((hw**2)+(hd**2))
            min_modulo = sp_radius
byebug
            case angle
            when (angle >= -Math::PI/4 && angle < Math::PI/4) then
              max_modulo_x = hw/Math::cot(angle)
              max_modulo_y = hd * Math::tan(angle)
            when (angle >= Math::PI/4 && angle < 3*Math::PI/4) then
              max_modulo_x = hw * Math::cot(angle)
              max_modulo_y = hd/Math::tan(angle)
            when (angle >= 3*Math::PI/4 && angle < 5*Math::PI/4) then
              max_modulo_x = -(hw/Math::cot(angle))
              max_modulo_y = -(hd * Math::tan(angle))
            when (angle >= 5*Math::PI/4 && angle < 7*Math::PI/4) then
              max_modulo_x = -(hw * Math::cot(angle))
              max_modulo_y = -(hd/Math::tan(angle))
            else
              raise(ArgumentError, "calculate_coordinates: bad angle #{angle}")
            end
            max_modulo = Math::sqrt((max_modulo_x**2)+(max_modulo_y**2))
            modulo = randomizer(min_modulo*i_margin, max_modulo*o_margin)
            x = modulo*Math::cot(angle)
            y = modulo*Math::tan(angle)
            [x, y, modulo]
          end
    
        end
    
      end

    end
  end
end
