#
# $Id$
#
require 'byebug'
require 'yaml'
require 'singleton'

module Cosb

  module ConfigurationFile

    class Base
      attr_reader :filename

      def initialize(f)
        @filename = f
        read_configuration
      end

      class ConfigurationError < CosbException; end

    protected

      def read_configuration
        raise ConfigurationError, "Pure virtual method :read_configuration called"
      end

      def read_configuration_common(tag, mandatory_args)
        conf = YAML.load(File.open(self.filename, 'r'))
        sub_conf = conf[tag]
        mandatory_args.each do
          |attr|
          val = sub_conf[attr.to_s]
          raise ConfigurationError, "Global parameter #{attr.to_s} can't be NULL" unless val
          quotes = val.is_a?(String) ? "'" : ""
          eval("@#{attr.to_s} = #{quotes}#{sub_conf[attr.to_s]}#{quotes}")
        end
        yield(sub_conf) if block_given?
        self
      end

    end

    class Global < Base

      attr_reader :sample_rate, :ksmps, :audio_sources, :simultaneous_movements, :points_per_w_object, :sound_speed
      attr_accessor :audio_sources

    protected

      def read_configuration
        read_configuration_common('global', [:sample_rate, :ksmps, :simultaneous_movements, :points_per_w_object, :sound_speed, :audio_sources])
        read_sources
      end

    private

      def read_sources
        asar = self.audio_sources
        self.audio_sources = Sources.new
        if asar.is_a?(Array)
          asar.each { |aa| self.audio_sources << Source.new(aa) }
        else
          self.audio_sources << Source.new([1, asar])
        end
#       read_configuration_common('global', ['audio_sources']) do
#         |attr|
#         attr.each do
#           |a|
#         end
#       end
      end

    end
  
    class Space < Base
  
      attr_reader :identifier, :loudspeaker_positions, :virtual_space, :reverberation_decay

      #
      # +num_channels+ returns twice the numbers of loudspeaker, because we
      # use separate tracks for direct sound and for reverberation for each
      # channel
      #
      def num_channels
        self.loudspeaker_positions.size * 2
      end

      #
      # +fix_audio_output_busses+ sets the audio output bus addresses for the
      # zak system according to the number of inputs and the number of outputs
      # the system is supposed to have
      #
      def fix_audio_output_busses(as)
        total_audio_busses = as.num_sources + self.num_channels
        self.loudspeaker_positions.each do
          |sp|
          sidx = sp.number - 1
          sidx2 = sidx * 2
          dob = total_audio_busses - self.num_channels + sidx2
          rob = total_audio_busses - self.num_channels + sidx2 + 1
          sp.direct_output_bus = dob
          sp.reverb_output_bus = rob
        end
      end

    protected

      def read_configuration
        @loudspeaker_positions = []
        read_configuration_common('space', [:identifier, :reverberation_decay]) do
          |sconf|
          sconf['loudspeaker_positions'].keys.sort.each do
            |sp|
            (posx, posy, lcr) = sconf['loudspeaker_positions'][sp]
            @loudspeaker_positions << Speaker.new(sp, posx, posy, lcr)
          end
          @virtual_space = VirtualSpace.new(sconf['virtual_space']['width'], sconf['virtual_space']['depth'])
        end
      end

    private

#     def count_audio_sources(as)
#       if as.is_a?(Array)
#         self.audio_sources = []
#         raise(StandardError, "audio sources should either be a scalar or an array of arrays") unless (as[0].is_a?(Array) && as[1].is_a?(Array))
#         as.each do
#           |ea|
#           raise(StandardError, "audio sources should either be a scalar or an array of arrays") unless ea.is_a?(Array)
#           # ea.each { |eaa| self.audio_sources << Sources.new(eaa) }
#           self.audio_sources << Sources.new(ea)
#         end
#       else
#         self.audio_sources = [ Sources.new([1, as]) ]
#       end
#       as.num_channels
#     end

    end

  end
  
  class Configuration

    include Singleton

    attr_accessor :config_root, :global_configuration, :space_configuration

    DEFAULT_CONFIGURATION_ROOT = CONFIG_PATH
    DEFAULT_GLOBAL_CONFIGURATION_FILE = DEFAULT_SPACE_CONFIGURATION_FILE = 'default.yml'
    DEFAULT_OUTPUT_FILE = File.join(OUTPUT_PATH, 'cosbOrchestra.csd')

    def load(cr = DEFAULT_CONFIGURATION_ROOT, gcf = DEFAULT_GLOBAL_CONFIGURATION_FILE, scf = DEFAULT_SPACE_CONFIGURATION_FILE)
      self.config_root = cr
      self.global_configuration_file = gcf
      self.space_configuration_file  = scf
      @global_configuration = ConfigurationFile::Global.new(global_configuration_path)
      self.space_configuration = ConfigurationFile::Space.new(space_configuration_path)
      self.space_configuration.fix_audio_output_busses(self.global_configuration.audio_sources)
    end

    class << self

      def load(cr = DEFAULT_CONFIGURATION_ROOT, gcf = DEFAULT_GLOBAL_CONFIGURATION_FILE, scf = DEFAULT_SPACE_CONFIGURATION_FILE)
        self.instance.load(cr, gcf, scf)
      end

    end

  private

    attr_accessor :global_configuration_file, :space_configuration_file

    def global_configuration_path()
      File.join(self.config_root(), 'global', global_configuration_file())
    end

    def space_configuration_path()
      File.join(self.config_root(), 'spaces', space_configuration_file())
    end

  end

end
