module Cosb

  module Y2Sco
    ROOT = File.expand_path('..', __FILE__)
    PATH = File.join(ROOT, 'y2sco')
  end

end

%w(
  reader
  generator
).each { |f| require File.join(Cosb::Y2Sco::PATH, f) }
