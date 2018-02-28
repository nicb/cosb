$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "cosb"

require "minitest/autorun"
require 'byebug'

def set_test_paths
  @correct_config_path = File.expand_path(File.join('..', 'fixtures', 'config'), __FILE__)
  @default_config_path = File.expand_path(File.join('..', 'fixtures', 'default_config'), __FILE__)
  @correct_global_config_file = 'correct_global_config.yml'
  @correct_space_config_file =  'correct_space_config.yml'
  @correct_global_config_path = File.join(@correct_config_path, 'global', @correct_global_config_file)
  @correct_space_config_path = File.join(@correct_config_path, 'spaces', @correct_space_config_file)
  @correct_global_config = YAML.load(File.open(@correct_global_config_path, 'r'))
  @correct_space_config  = YAML.load(File.open(@correct_space_config_path, 'r'))
end
