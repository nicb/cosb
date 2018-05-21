require 'erb'

module Cosb
  module Spec
    module Algo

      module Octave

        class Generator
          attr_reader :configuration, :template, :output_path, :parameters

          def initialize(p, tmpl, op, pars)
            @configuration = Cosb::Spec::Algo::TestHelper::ConfigurationReader.new(p)
            @template = tmpl
            @output_path = op
            @parameters = pars
          end

          def generate
            glob = self.configuration.global
            spaces = self.configuration.spaces
            src = self.configuration.source
            parm = self.parameters
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
