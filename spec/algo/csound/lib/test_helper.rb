
module Cosb

  module TestHelper
    ROOT = File.expand_path('..', __FILE__)
    PATH = File.join(ROOT, 'test_helper')
  end

end

%w(
  configuration_creator
).each { |f| require File.join(Cosb::TestHelper::PATH, f) }
