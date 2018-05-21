
module Cosb
  module Spec
    module Algo

      module TestHelper
        ROOT = File.expand_path('..', __FILE__)
        PATH = File.join(ROOT, 'test_helper')
      end

    end

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
  reader
  readers
  configuration_reader
).each { |f| require File.join(Cosb::Spec::Algo::TestHelper::PATH, f) }
