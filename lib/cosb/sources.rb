#
# $Id$
#

module Cosb

	class Sources

		attr_reader :nchnls_x_src, :n_sources

		def initialize(arr)
      raise(ArgumentError, "bad initialization argument #{arr.to_s}") unless arr.is_a?(Array) && arr.size == 2
			@nchnls_x_src = arr[1]
			@n_sources = arr[0]
		end

    def num_sources
      self.nchnls_x_src * self.n_sources
    end

	end

end
