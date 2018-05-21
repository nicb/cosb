module Cosb
  module TestHelper
  
    class << self

      def randomizer(min, max)
        range = max - min
        (rand()*range) + min
      end

    end
  
  end
end
