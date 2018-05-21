require 'securerandom'

module Cosb
  module Spec
    module Algo

      module TestHelper
      
        class SpaceParameters
          attr_accessor :identifier, :speakers, :width, :depth, :reverberation_decay

          include Cosb::Spec::Algo::TestHelper::Randomizer
      
          def initialize
            create_random_parameters
          end
    
          def rspeaker
            self.speakers[1]
          end
      
          def lspeaker
            self.speakers[0]
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
            y = randomizer(depth/10.0, depth/4.0)
            x = randomizer(wid/10.0, wid/4.0)
            res << Coordinate.new(-x, y, 'left') # left speaker
            res << Coordinate.new(x, y, 'right')  # right speaker
            res
          end
      
        end
    
      end

    end
  end
end
