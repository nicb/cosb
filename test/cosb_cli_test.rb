require File.join(File.dirname(__FILE__), "test_helper.rb")
require 'cosb/cli'

class TestCosbCli < Minitest::Test
  
  def setup
		@correct_global_config_file = File.join(File.dirname(__FILE__), 'fixtures', 'correct_global_config.yml')
		@correct_space_config_file =  File.join(File.dirname(__FILE__), 'fixtures', 'correct_space_config.yml')
		@correct_global_config = YAML.load(File.open(@correct_global_config_file, 'r'))
		@correct_space_config  = YAML.load(File.open(@correct_space_config_file, 'r'))
  end

  def test_print_default_output
    Cosb::CLI.execute(@stdout_io = StringIO.new, [])
    @stdout_io.rewind
    @stdout = @stdout_io.read
    assert_match(/sr\s*=/, @stdout)
  end

	def test_space_option
    Cosb::CLI.execute(@stdout_io = StringIO.new, [ '-s', @correct_space_config_file ])
    @stdout_io.rewind
    @stdout = @stdout_io.read
    assert_match(/sr\s*=/, @stdout)
    assert_match(/correct_space_config\.yml/, @stdout)
		#
		# retry with long option
		#
    Cosb::CLI.execute(@stdout_io = StringIO.new, [ '--space', @correct_space_config_file ])
    @stdout_io.rewind
    @stdout = @stdout_io.read
    assert_match(/sr\s*=/, @stdout)
    assert_match(/correct_space_config\.yml/, @stdout)
	end

	def test_global_option
    Cosb::CLI.execute(@stdout_io = StringIO.new, [ '-g', @correct_global_config_file ])
    @stdout_io.rewind
    @stdout = @stdout_io.read
    assert_match(/sr\s*=/, @stdout)
    assert_match(/correct_global_config\.yml/, @stdout)
		#
		# retry with long option
		#
    Cosb::CLI.execute(@stdout_io = StringIO.new, [ '--global', @correct_global_config_file ])
    @stdout_io.rewind
    @stdout = @stdout_io.read
    assert_match(/sr\s*=/, @stdout)
    assert_match(/correct_global_config\.yml/, @stdout)
	end

	def test_both_options
    Cosb::CLI.execute(@stdout_io = StringIO.new, [ '-g', @correct_global_config_file, '-s', @correct_space_config_file ])
    @stdout_io.rewind
    @stdout = @stdout_io.read
    assert_match(/sr\s*=/, @stdout)
    assert_match(/correct_global_config\.yml/, @stdout)
    assert_match(/correct_space_config\.yml/, @stdout)
		#
		# retry with long options
		#
    Cosb::CLI.execute(@stdout_io = StringIO.new, [ '--global', @correct_global_config_file, '--space', @correct_space_config_file ])
    @stdout_io.rewind
    @stdout = @stdout_io.read
    assert_match(/sr\s*=/, @stdout)
    assert_match(/correct_global_config\.yml/, @stdout)
    assert_match(/correct_space_config\.yml/, @stdout)
	end

end
