require 'erb'

module Cosb
  module Spec
    module Algo

      module Octave

        class Parameters
          attr_reader :lib_path, :in_audio_file, :out_audio_file, :out_print_file

          def initialize(lp, iaf, oaf, opf)
            @lib_path = lp
            @in_audio_file = iaf
            @out_audio_file = oaf
            @out_print_file = opf
          end

        end

      end

    end
  end
end
