module Cosb
  module Spec
    module Algo

      module Pic
        ROOT = File.expand_path('..', __FILE__)
        PATH = File.join(ROOT, 'pic')
      end

    end

  end

end

require File.expand_path(File.join('..', 'test_helper'), __FILE__)

%w(
  reader
  generator
).each { |f| require File.join(Cosb::Spec::Algo::Pic::PATH, f) }

