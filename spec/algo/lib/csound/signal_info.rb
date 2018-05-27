module Cosb
  module Spec
    module Algo
      module Csound

        class SingleSignal
          attr_reader   :idx
          attr_accessor :x, :y

          def initialize(i)
            @idx = i
          end

        end

        class SignalInfo

          attr_reader :single_signals

          def initialize
            @single_signals = []
          end

          def to_yaml
            res = "source:\n"
            self.single_signals.each do
              |ss|
              res += ("  %d:\n" % [ ss.idx ])
              [:x, :y].each { |v| res += "    %1s: %+12.9f\n" % [v.to_s, ss.send(v)] }
            end
            res
          end

          def parse(line)
            (src, x, y) = line.scanf("point_source: source=%d, pos.x=%f, pos.y=%f")
            idx = src.to_i-1
            self.single_signals[idx] = SingleSignal.new(idx) unless self.single_signals[idx]
            # raise ParseError, "multiple sources parsing not yet implemented" if src != 1
            self.single_signals[idx].x = x
            self.single_signals[idx].y = y
          end

        end

      end
    end
  end
end
