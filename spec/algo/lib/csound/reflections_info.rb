module Cosb
  module Spec
    module Algo
      module Csound

        class Reflection
          attr_accessor :x, :y, :distance, :delay
        end

        class ReflectionsInfo < InfoProxy
          attr_reader :reflections

          def initialize(i)
            super
            @reflections = { 'rfw' => Reflection.new, 'rrw' => Reflection.new, 'rbw' => Reflection.new, 'rlw' => Reflection.new, }
          end

          def to_yaml(tabs)
          end

        end

      end
    end
  end
end

