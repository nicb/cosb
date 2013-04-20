#
# $Id$
#

module Cosb

	class Speaker

		attr_reader :x, :y, :number, :lrc
		attr_accessor :direct_output_bus, :reverb_output_bus

		def initialize(n, x, y, pos = 'c')
			@number = n.to_i
			@x = x.to_f
			@y = y.to_f
			@lrc = pos
		end

	end

end
