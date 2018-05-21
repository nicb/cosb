module Cosb
  module Spec
    module Algo

      module TestHelper
      
        class Coordinate
          attr_reader :x, :y, :label
    
          def initialize(x, y, l = '')
            @x = x
            @y = y
            @label = lorez_label if l.empty? || l.nil?
          end
    
          def print_hirez
            print_common("%+.8f, %+.8f, \"%s\"")
          end
    
          def print_lorez
            print_common("%+.2f, %+.2f, \"%s\"")
          end
    
          def lorez_label
            "(%+.2f, %+.2f)" % [ self.x, self.y ]
          end
    
        private
    
          def print_common(format)
            format % [ self.x, self.y, self.label ]
          end
    
        end
      
      end

    end
  end
end
