module Cosb
  module Spec
    module Algo

      module TestHelper
      
        class GlobalParameters
          attr_accessor :sample_rate, :ksmps, :sound_speed

          include Cosb::Spec::Algo::TestHelper::Randomizer
      
          def initialize
            create_random_parameters
          end
      
        private
      
          def create_random_parameters
            @sample_rate = random_sample_rate
            @ksmps = random_ksmps
            @sound_speed = random_sound_speed
          end
      
          def random_sample_rate
            psr = [ 32000, 44100, 48000, 88200, 96000, 192000 ]
            choice = randomizer(0, psr.size-1).round
            psr[choice]
          end
      
          def random_ksmps
            dens = [1, 5, 10, 20, 50, 100, 500, 1000]
            den = randomizer(0,dens.size-1).round
            (self.sample_rate/dens[den]).to_i
          end
      
          def random_sound_speed
            randomizer(338, 350)
          end
      
        end
    
      end

    end
  end
end
