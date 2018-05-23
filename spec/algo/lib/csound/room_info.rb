module Cosb
  module Spec
    module Algo
      module Csound

        class RoomInfo < InfoProxy

          attr_accessor :xmin, :xmax, :ymin, :ymax

          def depth
            self.ymax - self.ymin
          end

          def width
            self.xmax - self.xmin
          end

          def to_yaml(tabs)
          end

        end

      end
    end
  end
end
