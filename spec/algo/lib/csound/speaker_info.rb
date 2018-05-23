module Cosb
  module Spec
    module Algo
      module Csound

        class SpeakerInfo < InfoProxy
          attr_accessor :x, :y, :distances, :delays

          def initialize(info)
            super
            self.distances = { 'direct' => 0.0, 'rfw' => 0.0, 'rrw' => 0.0, 'rbw' => 0.0, 'rlw' => 0.0 }
            self.delays    = { 'direct' => 0.0, 'rfw' => 0.0, 'rrw' => 0.0, 'rbw' => 0.0, 'rlw' => 0.0 }
          end

          def to_yaml(tabs)
          end

          def parse(line)
          end

        end

      end
    end
  end
end

