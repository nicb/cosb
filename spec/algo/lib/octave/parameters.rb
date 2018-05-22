require 'erb'

module Cosb
  module Spec
    module Algo

      module Octave

        class Parameters
          attr_reader :lib_path, :in_audio_file, :out_audio_file, :out_print_file, :out_info_file

          def initialize(lp, iaf, oaf, opf, oif)
            @lib_path = lp
            @in_audio_file = iaf
            @out_audio_file = oaf
            @out_print_file = opf
            @out_info_file = oif
          end

        end

      end

    end
  end
end
