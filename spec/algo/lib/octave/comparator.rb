require 'erb'

module Cosb
  module Spec
    module Algo

      module Octave

        class Comparator
          attr_reader :template, :output_path, :in_csound_file, :in_octave_file, :output_plot_root

          def initialize(tmpl, op, icf, iof, opl)
            @template = tmpl
            @output_path = op
            @in_csound_file = icf
            @in_octave_file = iof
            @output_plot_root = opl
          end

          def generate
            File.open(self.template, 'r') do
              |tfh|
              template = ERB.new(tfh.readlines.join)
              File.open(self.output_path, 'w') do
                |wfh|
                wfh.puts template.result(binding)
              end
            end
          end

        end

      end

    end
  end
end

