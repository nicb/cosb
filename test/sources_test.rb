#
# $Id: test_configuration.rb 3 2012-05-15 03:21:07Z nicb $
#
require File.dirname(__FILE__) + '/test_helper.rb'

class TestSources < Minitest::Test

  def setup
    @right_args =
    {
      :multi => { :arg => [[1, 10],[4, 5]], :result => 30 },
      :zero => { :arg => [[0, 0]], :result => 0 },
    }
    @wrong_args =
    {
      :single => { :arg => 23 },
      :weird_multi => { :arg => [ 'string' ] },
      :weirder_multi => { :arg => [[ 'string', 0 ]] },
      :wrong_multi => { :arg => [[ 0, 1, 2, 3 ]] },
      :wrong_single => { :arg => 'really wrong' },
    }
  end

  def test_creation_with_no_args
    assert_raises(ArgumentError) { Cosb::Sources.new }
  end

  def test_creation_with_right_args
    @right_args.each do
      |key, ah|
      ah[:arg].each do
        |arg|
        assert(Cosb::Sources.new(arg), key)
      end
    end
  end

  def test_creation_with_wrong_args
    @wrong_args.each do
      |key, ah|
      assert_raises(ArgumentError) { Cosb::Sources.new(ah[:arg]) }
    end
  end

	def test_number_of_output_channels
    @right_args.each do
      |key, ah|
      res = 0
      ah[:arg].each do
        |arg|
        assert((srcs = Cosb::Sources.new(arg)), key)
        res += srcs.num_sources
      end
      assert_equal(res, ah[:result], key)
    end
	end

end
