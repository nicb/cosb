require 'securerandom'

module Cosb
  module Spec
    module Algo

      module TestHelper
      
        class SpaceParameters
          attr_reader   :global, :speaker_radius
          attr_accessor :identifier, :speakers, :width, :depth, :reverberation_decay

          include Cosb::Spec::Algo::TestHelper::Randomizer
      
          def initialize(g)
            @global = g
            create_random_parameters
          end
    
        private
      
          def create_random_parameters
            self.identifier = random_identifier
            self.width = randomizer(10, 100)
            self.depth = randomizer(10, 100)
            self.speakers = speaker_positions(self.width, self.depth)
            self.reverberation_decay = randomizer(1.2, 4.5)
          end
      
          def random_identifier
            SecureRandom.base64
          end
      
          def speaker_positions(wid, depth)
            res = []
            small_side = [depth/2, wid/2].min
            min_mod = small_side/4;
            max_mod = small_side;
            @speaker_radius = randomizer(min_mod, max_mod)
            angles = calculate_angles(self.global.nchnls)
            p2c = (2*Math::PI)/360
            angles[:pos].each do
              |a, tag|
              y = self.speaker_radius*Math::sin((a+90)*p2c)
              x = self.speaker_radius*Math::cos((a-90)*p2c)
              res << Coordinate.new(x, y, tag)
            end
            self.identifier = angles[:tag] + " - " + self.identifier
            res
          end

          #
          # systems depend on the number of channels. They are essentially all
          # symmetrical around a "vertical/depth" axis, with the followig
          # scheme:
          #
          # 2             => stereo
          # 2.1           => 4 channels: stereo + center + sub
          # 5.1           => 6 channels: stereo + center + sub + 2 surround
          # 7.1           => 8 channels: stereo + center + sub + 4 surround
          # 9.1           => 8 channels: stereo + center + sub + 6 surround
          #
          # The angle is calculated in degrees around the longitudinal axis,
          # that is: 0 degrees is right in front of you, 180 is on your back.
          # Degrees move clockwise: +30 is 30 degrees to your right,
          # while -30 is 30 degrees to your right.
          #
          SPEAKER_DISPOSITION = {
              2 => { :tag => 'stereo',  :pos => [[-30, 'L'], [+30, 'R'] ] },
              4 => { :tag => '2.1', :pos => [[-30, 'L'], [+30, 'R'], [0, 'C'], [0, 'Sub'] ] },
              6 => { :tag => '5.1', :pos => [[-30, 'L'], [+30, 'R'], [0, 'C'], [0, 'Sub'], [-135, 'sL'], [135, 'sR'] ] },
              8 => { :tag => '7.1', :pos => [[-30, 'L'], [+30, 'R'], [0, 'C'], [0, 'Sub'], [-135, 'sL1'], [135, 'sR1'], [-158, 'sL2'], [158, 'sR2' ] ] },
             10 => { :tag => '9.1', :pos => [[-30, 'L'], [+30, 'R'], [0, 'C'], [0, 'Sub'], [-135, 'sL1'], [135, 'sR1'], [-158, 'sL2'], [158, 'sR2' ], [-90, 'lL'], [90, 'lR'] ] },
            }

          def calculate_angles(sys)
            SPEAKER_DISPOSITION[sys]
          end
      
        end
    
      end

    end
  end
end
