module Cosb
  module Spec
    module Algo
      module Csound

        class SignalInfo
          attr_accessor :x, :y

          def to_yaml
            res = "source:\n"
            [:x, :y].each { |v| res += "  %1s: %+12.9f\n" % [v.to_s, self.send(v)] }
            res
          end

          def parse(line)
            (src, x, y) = line.scanf("point_source: source=%d, pos.x=%f, pos.y=%f")
            raise ParseError, "multiple sources parsing not yet implemented" if src != 1
            self.x = x
            self.y = y
          end

        end

      end
    end
  end
end
