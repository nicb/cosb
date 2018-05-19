require 'byebug'
require 'yaml'
require 'erb'
require 'securerandom'

module Cosb
  module TestHelper
  
    TEMPLATE_DIR_ROOT = File.expand_path(File.join(['..']*2, 'templates'), __FILE__)
    CONFIG_TEMPLATE_PATH = File.join(TEMPLATE_DIR_ROOT, 'config')
    GLOBAL_TEMPLATE = File.join(CONFIG_TEMPLATE_PATH, 'global.yml.erb')
    SPACES_TEMPLATE = File.join(CONFIG_TEMPLATE_PATH, 'spaces.yml.erb')
  
    class << self

      def randomizer(min, max)
        range = max - min
        (rand()*range) + min
      end

    end
  
    class GlobalParameters
      attr_accessor :sample_rate, :ksmps, :sound_speed
  
      def initialize
        create_random_parameters
      end
  
    private
  
      def create_random_parameters
        @sample_rate = random_sample_rate
        @ksmps = random_ksmps
        @sound_speed = random_sound_speed
      end
  
      def random_sample_rate
        psr = [ 32000, 44100, 48000, 88200, 96000, 192000 ]
        choice = Cosb::TestHelper::randomizer(0, psr.size-1).round
        psr[choice]
      end
  
      def random_ksmps
        dens = [1, 5, 10, 20, 50, 100, 500, 1000]
        den = Cosb::TestHelper::randomizer(0,dens.size-1).round
        (self.sample_rate/dens[den]).to_i
      end
  
      def random_sound_speed
        Cosb::TestHelper::randomizer(338, 350)
      end
  
    end

    class Speaker
      attr_reader :x, :y

      def initialize(x, y)
        @x = x
        @y = y
      end

    end
  
    class SpaceParameters
      attr_accessor :identifier, :speakers, :width, :depth, :reverberation_decay
  
      def initialize
        create_random_parameters
      end

      def rspeaker
        self.speakers[1]
      end
  
      def lspeaker
        self.speakers[0]
      end
  
    private
  
      def create_random_parameters
        self.identifier = random_identifier
        self.width = Cosb::TestHelper::randomizer(10, 100)
        self.depth = Cosb::TestHelper::randomizer(10, 100)
        self.speakers = speaker_positions(self.width, self.depth)
        self.reverberation_decay = Cosb::TestHelper::randomizer(1.2, 4.5)
      end
  
      def random_identifier
        SecureRandom.base64
      end
  
      def speaker_positions(wid, depth)
        res = []
        y = Cosb::TestHelper::randomizer(depth/10.0, depth/4.0)
        x = Cosb::TestHelper::randomizer(wid/10.0, wid/4.0)
        res << Speaker.new(-x, y) # left speaker
        res << Speaker.new(x, y)  # right speaker
        res
      end
  
    end
  
    class ConfigurationCreator
  
      attr_reader :tmpdir, :global_output, :spaces_output
  
      def initialize(t)
        @tmpdir = t
      end
  
      def global
        globs = GlobalParameters.new
        out_path = tmp_global_path
        common_configurator(out_path, GLOBAL_TEMPLATE, binding)
      end
  
      def spaces
        spaces = SpaceParameters.new
        out_path = tmp_spaces_path
        common_configurator(out_path, SPACES_TEMPLATE, binding)
      end
  
    private
  
      def common_configurator(out_path, in_path, b)
        File.open(in_path, 'r') do
          |rfh|
          template = ERB.new(rfh.readlines.join)
          File.open(out_path, 'w') do
            |wfh|
            wfh.puts template.result(b)
          end
        end
      end

      def tmp_global_path
        File.join(self.tmpdir, 'config', 'global', 'default.yml')
      end
  
      def tmp_spaces_path
        File.join(self.tmpdir, 'config', 'spaces', 'default.yml')
      end
  
    end
  
  end
end
