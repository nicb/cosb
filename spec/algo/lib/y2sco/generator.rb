module Cosb
  module Y2Sco

    class Generator
      attr_reader :reader
      attr_accessor :at, :step, :dur

      SOURCE_INSTRUMENT_BASE = 0
      STATIC_POSITION_BASE = 300
      ROOM_BASE = 1300
      DEFAULT_AT = 0
      DEFAULT_STEP = 2
      DEFAULT_DUR = 1
        

      def initialize(fp, at = DEFAULT_AT, step = DEFAULT_STEP, dur = DEFAULT_DUR)
        self.at = at
        self.step = step
        self.dur = dur
        @reader = Reader.new(fp)
      end

      def generate
        res = ""
        res += header()
        
        self.reader.positions.each do
          |k, v|
          idx = k.to_i
          res += "i%-4d %8.4f %8.4f -0.0 1 ; %s\n" % [ SOURCE_INSTRUMENT_BASE+idx, self.at, self.dur, v[2] ]
          res += "i%-4d %8.4f %8.4f %+9.5f %+9.5f %+9.5f %+9.5f\n" % [ STATIC_POSITION_BASE+idx, self.at, self.dur, v[0], v[0], v[1], v[1] ]
          res += "i%-3d %8.4f %8.4f 0.0 0.0\n" % [ ROOM_BASE+idx, self.at, self.dur ]
        
          self.at += self.step
        end
        
        res += "\n\ni5000 0.0 %8.4f" % [ dur ]
        res
      end

      def print
        puts self.generate
      end

    private

      def header()
        ";\n; Score produced by the #{File.basename($0)} software\n; DO NOT EDIT! (any edit will be overwritten)\n;\n;\n"
      end

    end

  end
end
