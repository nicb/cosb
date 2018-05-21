module Cosb
  module Spec
    module Algo

      module TestHelper

        module Randomizer
    
          def self.included(base)
            base.extend Randomizer
          end

          def randomizer(min, max)
            range = max - min
            (rand()*range) + min
          end
    
        end
      
      end

    end
  end
end
