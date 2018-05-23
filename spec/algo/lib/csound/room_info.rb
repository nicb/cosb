module Cosb
  module Spec
    module Algo
      module Csound

        class RoomInfo

          attr_accessor :xmin, :xmax, :ymin, :ymax

          def depth
            self.ymax - self.ymin
          end

          def width
            self.xmax - self.xmin
          end

          def to_yaml
            res = "room:\n"
            [:depth, :width, :xmax, :xmin, :ymax, :ymin].each do
               |meth|
               res += ("  %s: %12.9f\n" % [meth.to_s, self.send(meth) ])
            end
            res
          end

          def parse(line, speakers)
            case line
            when /: speaker\[/
              (lidx, x, y) = line.scanf("room_definition: speaker[%d]: x=%f, y=%f")
              speakers[lidx-1].x = x
              speakers[lidx-1].y = y
            when /: room:/
              (xmax, xmin, ymax, ymin) = line.scanf("room_definition: room: xmax=%f, xmin=%f, ymax=%f, ymin=%f")
              self.xmax = xmax
              self.xmin = xmin
              self.ymax = ymax
              self.ymin = ymin
            else
              raise ParseError, "parse_room_definition: couldn't recognize line #{line}"
            end
          end

        end

      end
    end
  end
end
