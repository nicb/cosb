require 'yaml'
require 'erb'

module Cosb
  module Spec
    module Algo
      module TestHelper
    
        class ConfigurationCreator
      
          attr_reader :tmpdir, :global_output, :spaces_output
          attr_reader :global_parameters, :space_parameters, :source_parameters
      
          def initialize(t)
            @tmpdir = t
            @global_parameters = GlobalParameters.new
            @space_parameters = SpaceParameters.new(self.global_parameters)
            @source_parameters = SourceParameters.new(self.space_parameters)
          end
      
          def global
            globs = self.global_parameters
            out_path = tmp_global_path
            common_configurator(out_path, GLOBAL_TEMPLATE, binding)
          end
      
          def spaces
            spaces = self.space_parameters
            out_path = tmp_spaces_path
            common_configurator(out_path, SPACES_TEMPLATE, binding)
          end
    
          def source
            spaces = self.space_parameters
            source = self.source_parameters
            out_path = tmp_source_path
            common_configurator(out_path, SOURCE_TEMPLATE, binding)
          end
    
          def configure
            self.global
            self.spaces
            self.source
          end
      
        private
      
          def common_configurator(out_path, in_path, b)
            File.open(in_path, 'r') do
              |rfh|
              template = ERB.new(rfh.readlines.join, 0, '-')
              File.open(out_path, 'w') do
                |wfh|
                wfh.puts template.result(b)
              end
            end
          end
    
          def tmp_global_path
            File.join(self.tmpdir, 'config', 'global', 'default.yml')
          end
      
          def tmp_spaces_path
            File.join(self.tmpdir, 'config', 'spaces', 'default.yml')
          end
      
          def tmp_source_path
            File.join(self.tmpdir, 'config', 'spaces', 'source.yml')
          end
      
        end
      
      end
    end

  end
end
