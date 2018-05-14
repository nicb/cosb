class Coord
  attr_reader :x, :y, :label

  def initialize(x, y, l = 'coord')
    @x = x
    @y = y
    @label = l
  end
end

module Distance

  class Data
    attr_reader :p1, :p2, :should_be, :is
  
    def initialize(p1, p2, sb, is)
      @p1 = p1
      @p2 = p2
      @should_be = sb
      @is = is
    end
  
  end

end

module Refl1stOrder

  class Data
    attr_reader :source, :length, :width, :should_be, :is
  
    def initialize(s, l, w, sb, is)
      @source = s
      @length = l
      @width = w
      @should_be = sb
      @is = is
    end

    def to_pic
      header
      puts "pospoint(%-.8f,%-.8f,\"red\")" % [ self.source.x, self.source.y ] 
      self.should_be.each do
        |src|
        puts "pospoint(%-.8f,%-.8f,\"cyan\")" % [ src.x, src.y ]
      end
      self.is.each do
        |src|
        puts "pospoint(%-.8f,%-.8f,\"green\")" % [ src.x, src.y ]
      end
      trailer
    end

  private

    def header
      puts ".PS\ncopy \"room_plot.pic\""
      puts "htscale=boxht/%-.8f" % [ self.length ]
      puts "widscale=boxwid/%-.8f" % [ self.width ]
      puts "roominfo(%-.8f,%-.8f,%-.8f,%-.8f)" % [ self.length, self.width, self.source.x, self.source.y ]
    end

    def trailer
      puts ".PE\n.bp\n"
    end
  
  end

end

module ItdSamples

  class Data
    attr_reader :distance, :should_be, :is

    def initialize(d, sb, is)
      @distance = d
      @should_be = sb
      @is = is
    end 

  end

end

module SingleLine

  class Data

    attr_reader :signal_position, :loudspeaker_position, :should_be, :is

    def initialize(pos, lsp, sb, is)
      @signal_position = pos
      @loudspeaker_position = lsp
      @should_be = sb;
      @is = is;
    end

  end
end

module SourceCalculation

  class Data

    attr_reader :signal_position, :loudspeaker_positions, :should_be, :is

    def initialize(pos, lsps, sb, is)
      @signal_position = pos
      @loudspeaker_positions = lsps
      @should_be = sb;
      @is = is;
    end

  end

end
