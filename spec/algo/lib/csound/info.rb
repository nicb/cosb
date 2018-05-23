module Cosb
  module Spec
    module Algo
      module Csound

        class Info

          attr_reader :yaml_data

          def initialize
            @yaml_data = ""
          end

          #
          # +operator++
          #
          # adds to the yaml data
          #
          def +(s)
            self.yaml_data += s
          end

        end

      end
    end
  end
end


