
module Cosb

  module TestHelper
    ROOT = File.expand_path('..', __FILE__)
    PATH = File.join(ROOT, 'test_helper')
  end

end

%w(
  constants
  randomizer
  coordinate
  global_parameters
  space_parameters
  source_parameters
  configuration_creator
).each { |f| require File.join(Cosb::TestHelper::PATH, f) }
