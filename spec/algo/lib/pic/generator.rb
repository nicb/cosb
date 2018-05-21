module Cosb
  module Pic

    class Generator
      attr_reader :reader

      def initialize(fp)
        @reader = Reader.new(fp)
      end

      #
      # TODO
      #
      # generate()
      #
      # * copies the room_plot.pic macro library file
      # * sets up the room_wid and room_ht
      # * sets up the speakers
      # * calculate all the distances
      # * sets up the trapezoids between center, speakers and position
      # * traces dashed lines btw source, speakers and centers with numbers above
      #
      def generate
        res = header()
      end

      def print
        puts self.generate
      end

    private

      def header()
        ".\\\"\n.\\\" Pic script produced by the #{File.basename($0)} software\n.\\\" DO NOT EDIT! (any edit will be overwritten)\n.\\\"\n.\\\"\n"
      end

    end

  end
end

