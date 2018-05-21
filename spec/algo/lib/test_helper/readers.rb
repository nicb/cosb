require 'yaml'

module Cosb
  module Spec
    module Algo

      module TestHelper
    
        #
        # Global Configuration reader
        #
        class GlobalReader < Reader
    
          def initialize(fp)
            super(fp)
            self.base = 'global'
            setup_methods
          end
    
        end
    
        #
        # Spaces Configuration reader
        #
        class SpacesReader < Reader
    
          def initialize(fp)
            super(fp)
            self.base = 'space'
            setup_methods
          end
    
        end
    
        #
        # Source Configuration reader
        #
        class SourceReader < Reader
    
          def initialize(fp)
            super(fp)
            self.base = 'sources'
            setup_methods
          end
    
        end
    
      end

    end
  end
end
