require File.join(File.dirname(__FILE__), "test_helper.rb")
require 'cosb/cli'

class TestCosbCli < Minitest::Test
  
  def setup
    #
    # +set_test_paths+ is in test_helper.rb
    #
    set_test_paths
  end

  #
  # run with all defaults
  # 
  def test_print_default_output
    Cosb::CLI.execute(@stdout_io = StringIO.new, [])
    @stdout_io.rewind
    @stdout = @stdout_io.read
    assert_match(/sr\s*=/, @stdout)
  end

  def test_wrong_config_root_setup
    assert_raises(Errno::ENOENT) { Cosb::CLI.execute(@stdout_io = StringIO.new, [ '-c', 'wrong_configuration_path' ]) }
  end

  def test_config_root_setup
    Cosb::CLI.execute(@stdout_io = StringIO.new, [ '-c', @default_config_path ])
    @stdout_io.rewind
    @stdout = @stdout_io.read
    assert_match(/sr\s*=/, @stdout)
    #
    # long option
    #
    Cosb::CLI.execute(@stdout_io = StringIO.new, [ '--config', @default_config_path ])
    @stdout_io.rewind
    @stdout = @stdout_io.read
    assert_match(/sr\s*=/, @stdout)
  end

  def test_space_option
    Cosb::CLI.execute(@stdout_io = StringIO.new, ['-c', @correct_config_path, '-s', @correct_space_config_file ])
    @stdout_io.rewind
    @stdout = @stdout_io.read
    assert_match(/sr\s*=/, @stdout)
    assert_match(/correct_space_config\.yml/, @stdout)
    #
    # retry with long option
    #
    Cosb::CLI.execute(@stdout_io = StringIO.new, ['-c', @correct_config_path, '--space', @correct_space_config_file ])
    @stdout_io.rewind
    @stdout = @stdout_io.read
    assert_match(/sr\s*=/, @stdout)
    assert_match(/correct_space_config\.yml/, @stdout)
  end

  def test_global_option
    Cosb::CLI.execute(@stdout_io = StringIO.new, ['-c', @correct_config_path, '-g', @correct_global_config_file ])
    @stdout_io.rewind
    @stdout = @stdout_io.read
    assert_match(/sr\s*=/, @stdout)
    assert_match(/correct_global_config\.yml/, @stdout)
    #
    # retry with long option
    #
    Cosb::CLI.execute(@stdout_io = StringIO.new, ['-c', @correct_config_path, '--global', @correct_global_config_file ])
    @stdout_io.rewind
    @stdout = @stdout_io.read
    assert_match(/sr\s*=/, @stdout)
    assert_match(/correct_global_config\.yml/, @stdout)
  end

  def test_both_options
    Cosb::CLI.execute(@stdout_io = StringIO.new, ['-c', @correct_config_path, '-g', @correct_global_config_file, '-s', @correct_space_config_file ])
    @stdout_io.rewind
    @stdout = @stdout_io.read
    assert_match(/sr\s*=/, @stdout)
    assert_match(/correct_global_config\.yml/, @stdout)
    assert_match(/correct_space_config\.yml/, @stdout)
    #
    # retry with long options
    #
    Cosb::CLI.execute(@stdout_io = StringIO.new, ['-c', @correct_config_path, '--global', @correct_global_config_file, '--space', @correct_space_config_file ])
    @stdout_io.rewind
    @stdout = @stdout_io.read
    assert_match(/sr\s*=/, @stdout)
    assert_match(/correct_global_config\.yml/, @stdout)
    assert_match(/correct_space_config\.yml/, @stdout)
  end

end
