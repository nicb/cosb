module Cosb
  module Spec
    module Algo
      module Csound

        class SpeakerInfo
          attr_accessor :num, :x, :y, :distances, :delays

          def initialize
            self.distances = { 'direct' => 0.0, 'rfw' => 0.0, 'rrw' => 0.0, 'rbw' => 0.0, 'rlw' => 0.0 }
            self.delays    = { 'direct' => 0.0, 'rfw' => 0.0, 'rrw' => 0.0, 'rbw' => 0.0, 'rlw' => 0.0 }
            self.num       = 0
          end

          def to_yaml
            res = "  #{self.num}:\n"
            [:x, :y].each { |meth| res += ("    %s: %+12.9f\n" % [meth.to_s, self.send(meth) ]) }
            res += "    distances:\n"
            self.distances.each { |k, v| res += ("      %s: %12.9f\n" % [k, v]) }
            res += "    delays:\n"
            self.delays.each { |k, v| res += ("      %s: %12.9f\n" % [k, v]) }
            res
          end

          def parse(line, idx)
            case line
            when /: distances:/
               (lidx, src, dir, rfw, rrw, rbw, rlw) = line.scanf("single_speaker[%d]: distances: source=%d, direct=%f, rfw=%f, rrw=%f, rbw=%f, rlw=%f")
               self.distances['direct'] = dir
               self.distances['rfw'] = rfw
               self.distances['rrw'] = rrw
               self.distances['rbw'] = rbw
               self.distances['rlw'] = rlw
            when /: delays:/
               (lidx, src, dir, rfw, rrw, rbw, rlw) = line.scanf("single_speaker[%d]: delays: source=%d, direct=%f, rfw=%f, rrw=%f, rbw=%f, rlw=%f")
               self.delays['direct'] = dir
               self.delays['rfw'] = rfw
               self.delays['rrw'] = rrw
               self.delays['rbw'] = rbw
               self.delays['rlw'] = rlw
            else
              raise ParseError, "parse_single_speaker: couldn't recognize line #{line}"
            end
            self.num = idx
          end

        end

      end
    end
  end
end
