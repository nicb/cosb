module Cosb
  module Spec
    module Algo

      module TestHelper
    
        class InfoReader < Reader
    
          def initialize(fp)
            super(fp)
            self.base = 'octave_info'
            setup_methods
          end

        end
    
      end
    
    end
  end
end
