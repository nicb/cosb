module Cosb
  module Spec
    module Algo
      module Csound

        class InfoProxy

          attr_reader :info

          def initialize(i)
            @info = i
          end

        protected
          #
          # +<<+
          #
          # adds to the yaml data
          #
          def <<(s)
            self.info += s
          end

        end

      end
    end
  end
end



