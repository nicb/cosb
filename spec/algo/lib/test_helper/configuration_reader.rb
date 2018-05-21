module Cosb
  module TestHelper
  
    class ConfigurationReader

      attr_reader :path, :global, :spaces, :source

      def initialize(p, g = 'default.yml', sp = 'default.yml', s = 'source.yml')
        gpath = File.join(p, 'global')
        spath = File.join(p, 'spaces')
        @global = GlobalReader.new(File.join(gpath, g))
        @spaces = SpacesReader.new(File.join(spath, sp))
        @source = SourceReader.new(File.join(spath, s))
      end
  
    end
  
  end
end
