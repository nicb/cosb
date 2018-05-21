require 'yaml'

module Cosb
  module Spec
    module Algo

      module TestHelper
    
        #
        # Generic YAML reader
        #
        class Reader
          attr_reader :filepath, :data
          attr_accessor :base
    
          def initialize(fp)
            @filepath = fp
            @data = read
          end
    
    
        protected
    
          def read
            begin
              d = YAML.load(File.open(self.filepath, 'r'))
            rescue Errno::ENOENT
              abort("File #{self.filepath} not found!")
            end
            d
          end
    
          def setup_methods
            keys = self.base ? self.data[base].keys : self.data.keys
            keys.each { |k| access(k.to_sym) }
          end
    
       private
    
          def access(sym)
            define_singleton_method(sym) { self.base ? self.data[self.base][sym.to_s] : self.data[sym.to_s] }
          end
    
        end
    
      end

    end
  end
end
