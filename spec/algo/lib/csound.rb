module Cosb
  module Spec
    module Algo

      module Csound
        ROOT = File.expand_path('..', __FILE__)
        PATH = File.join(ROOT, 'csound')
      end

    end

  end

end

%w(
  info
  info_proxy
  reflections_info
  room_info
  signal_info
  speaker_info
  log_reader
).each { |f| require File.join(Cosb::Spec::Algo::Csound::PATH, f) }
