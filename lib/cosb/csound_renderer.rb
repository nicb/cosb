#
# $Id: csound_renderer.rb 16 2013-04-19 20:43:38Z nicb $
#

require 'erb'

module Cosb

  class CsoundRenderer

    class << self

      def template(tf)
        File.join(TEMPLATE_PATH, tf)
      end

    end

    # set start range of input instruments
    DEFAULT_INPUT_INSTRUMENT_OFFSET        =    1
    # set start range of movements instruments
    DEFAULT_POINT_SOURCE_INSTRUMENT_OFFSET = 1301
    # set start range of room/reflections instruments
    DEFAULT_WIDE__SOURCE_INSTRUMENT_OFFSET = 1601
    # does reverb *and* output
    DEFAULT_REVERB_INSTRUMENT              = 5000 
    # load default templates files
    DEFAULT_TEMPLATES =
    {
        :header            => template('header.orc.erb'),
        :sound_source      => template('sound_source.orc.erb'),
        :movements         => template('movements.orc.erb'),
        :point_source      => template('point_source.orc.erb'),
        :room_definition   => template('room_definition.orc.erb'),
        :single_speaker    => template('single_speaker.orc.erb'),
        :reverb_and_output => template('reverb_and_output.orc.erb'),
    }

    attr_reader :configuration, :templates

    def initialize(cr = Configuration::DEFAULT_CONFIGURATION_ROOT, gcf = Configuration::DEFAULT_GLOBAL_CONFIGURATION_FILE, scf = Configuration::DEFAULT_SPACE_CONFIGURATION_FILE, sst = DEFAULT_TEMPLATES[:sound_source], mt = DEFAULT_TEMPLATES[:movements], rt = DEFAULT_TEMPLATES[:reverb_and_output], ps = DEFAULT_TEMPLATES[:point_source])
      @templates = DEFAULT_TEMPLATES.dup
      @configuration = Configuration.instance
      self.configuration.load(cr, gcf, scf)
      self.templates[:sound_source] = sst
      self.templates[:movements] = mt
      self.templates[:reverb_and_output] = rt
      self.templates[:point_source] = ps
    end

    # main stage of csound code generator
    def render
      full_output  = render_header
      full_output += render_sound_source
      full_output += render_movements
      full_output += render_point_sources
      full_output += render_reverb_and_output
    end

    def point_source_instrument_numbers
      start = DEFAULT_POINT_SOURCE_INSTRUMENT_OFFSET
      finish = start + self.configuration.global_configuration.simultaneous_movements
      list_numbers(start, finish)
    end

    def first_point_source_instrument
      DEFAULT_POINT_SOURCE_INSTRUMENT_OFFSET
    end

    def input_instrument_numbers
      start = DEFAULT_INPUT_INSTRUMENT_OFFSET
      finish = start + self.configuration.global_configuration.audio_sources
      list_numbers(start, finish)
    end

    def first_input_instrument
      DEFAULT_INPUT_INSTRUMENT_OFFSET
    end

    def room_definition
      render_room
    end

    def point_sources
      render_each_point_source
    end

    def number_of_zak_a_variables
      self.configuration.global_configuration.audio_sources + self.configuration.space_configuration.num_channels
    end

    def number_of_zak_k_variables
      k_variables_used_by_movements
    end

    def final_output_stage
      res = []
      self.configuration.space_configuration.loudspeaker_positions.each { |sp| res << "adir#{sp.number}" }
      self.configuration.space_configuration.loudspeaker_positions.each { |sp| res << "arev#{sp.number}" }
      res.join(', ')
    end

    def list_templates(pfx = '')
      res = []
      self.templates.each { |k, v| res << "%s%-19s %s" % [ pfx, "#{k.to_s}:", v ] }
      res
    end

    def list_numbers(start, finish, step = 1)
      res = []
      while (n <= finish)
        res << n.to_s
        n += step
      end
      res.join(', ')
    end

  private

    def k_variables_used_by_movements
      self.configuration.global_configuration.simultaneous_movements * 2 # because we have x and y for each movement, interleaved
    end

    def render_header
      render_any(:header)
    end

    def render_point_sources
      render_any(:point_source)
    end

    def render_each_point_source
      res = ''
      lines = nil
      File.open(self.templates[:single_speaker], 'r') { |fh| lines = fh.readlines }
      string_template = lines.join
      erb_obj = ERB.new(string_template)
      self.configuration.space_configuration.loudspeaker_positions.each do
        |sp|
        _s = sp # the "_s" variable is needed by the template
        b = binding
        res += erb_obj.result(b)
      end
      res
    end

    def render_room
      render_any(:room_definition)
    end

    def render_reverb_and_output
      render_any(:reverb_and_output)
    end

    def render_sound_source
      render_any(:sound_source)
    end

    def render_movements
      render_any(:movements)
    end

    def render_any(t)
      _cr = self
      lines = nil
      File.open(self.templates[t], 'r') { |fh| lines = fh.readlines }
      string_template = lines.join
      b = binding
      ERB.new(string_template).result(b)
    end

  end

end
