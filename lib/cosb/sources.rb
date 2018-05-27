#
# $Id$
#

module Cosb

  class Source

		attr_reader :nchnls_x_src, :n_sources
    attr_accessor :first_instrument_number

		def initialize(arr)
      raise(ArgumentError, "bad initialization argument #{arr.to_s}") unless arr.is_a?(Array) && arr.size == 2
			@nchnls_x_src = arr[0]
			@n_sources = arr[1]
      self.first_instrument_number = 0
		end

    def num_sources
      self.nchnls_x_src * self.n_sources
    end

    def last_instrument
      self.first_instrument_number+self.n_sources
    end

    def input_instrument_numbers
      res = ''
      self.first_instrument_number.upto(self.last_instrument) do
        |n|
        res += n.to_s
        res += ', ' unless (n == self.last_instrument)
      end
      res += "\n"
      res
    end

    def create_instruments
      res = list_outputs
      res += " soundin ifno\n"
      res += process_input
      res
    end

  private

    def list_outputs
      res = ''
      1.upto(self.nchnls_x_src) do
        |n|
        res += "a#{n}"
        res += ", " unless (n == self.nchnls_x_src)
      end
      res
    end

    def process_input
      res = ''
      1.upto(self.nchnls_x_src) do
        |n|
        res += ("a%d       =       a%d * iamp\n" % [ n, n ])
        res += ("a%d       linen   a%d, 0.005, idur, 0.005\n\n" % [ n, n ])
        res += ("          zawm   a%d, index+%d\n\n" % [ n, n ])
      end
      res
    end

  end

	class Sources < Array

    attr_accessor :last_n

    def initialize
      self.last_n = Cosb::CsoundRenderer::DEFAULT_INPUT_INSTRUMENT_OFFSET
    end

    def <<(src)
      src.first_instrument_number = self.last_n
      super(src)
      self.last_n += (src.n_sources + 1)
    end

    def num_sources
      res = 0
      self.each { |s| res += s.num_sources }
      res
    end

	end

end
