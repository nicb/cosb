module Cosb
  module Spec
    module Algo

      module Pic
    
        #
        # TODO
        #
        # Cosb::Pic::Reader
        #
        # reads all configuration files
        #
        class Reader < ::Cosb::Spec::Algo::TestHelper::Reader
    
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
