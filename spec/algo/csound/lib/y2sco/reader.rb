require 'yaml'

module Cosb
  module Y2Sco

    class Reader
      attr_reader :filepath
      attr_reader :positions

      def initialize(fp)
        @filepath = fp
        read
      end

    private

      def read
        begin
          data = YAML.load(File.open(self.filepath, 'r'))
        rescue Errno::ENOENT
          abort("File #{self.filepath} not found!")
        end
        data = data[data.keys.first]
        
        pos_keys = data.keys.grep(/_positions/)
        pos_key = pos_keys.first
        key_name = pos_key.sub(/_positions/, '')
        
        @positions = data[pos_key]
      end

    end

  end
end
