module Cosb
  module Spec
    module Algo

      module Octave
        ROOT = File.expand_path('..', __FILE__)
        PATH = File.join(ROOT, 'octave')
      end

    end

  end

end

require File.expand_path(File.join('..', 'test_helper'), __FILE__)

%w(
  parameters
  generator
).each { |f| require File.join(Cosb::Spec::Algo::Octave::PATH, f) }
