#
# $Id: cli.rb 16 2013-04-19 20:43:38Z nicb $
#
require 'optparse'

module Cosb
  class CLI
    def self.execute(stdout, arguments=[])

      options = {
        :config_root         => Configuration::DEFAULT_CONFIGURATION_ROOT,
        :space               => Configuration::DEFAULT_SPACE_CONFIGURATION_FILE,
        :global              => Configuration::DEFAULT_GLOBAL_CONFIGURATION_FILE,
	      :sound_input         => CsoundRenderer::DEFAULT_TEMPLATES[:sound_source],
        :movements           => CsoundRenderer::DEFAULT_TEMPLATES[:movements],
	      :reverb_and_output   => CsoundRenderer::DEFAULT_TEMPLATES[:reverb_and_output],
	      :point_source        => CsoundRenderer::DEFAULT_TEMPLATES[:point_source],
      }
      mandatory_options = %w(  )

      OptionParser.new do |opts|
        opts.banner = <<-BANNER.gsub(/^          /,'')
				  
          cosb is a generator of  orchestra  instruments  for  csound  to  run
          spatial simulations for any kind of location and any technological setup
          (from mono to stereo to multichannel to high-order ambisonics). +cosb+ reads
          a configuration file for the physical location, the setup and the virtual
          location and create the appropriate orchestra instruments in order to
          play with the wanted space.

          Usage: #{File.basename($0)} [options]

          Options are:
        BANNER
        opts.separator ""
        opts.on("-c", "--config PATH", String,
                "Set PATH as a configuration root folder",
                "Default: #{Configuration::DEFAULT_CONFIGURATION_ROOT}") { |arg| options[:config_root] = arg }
        opts.on("-s", "--space FILE", String,
                "Use space configuration FILE",
                "Default: #{Configuration::DEFAULT_SPACE_CONFIGURATION_FILE}") { |arg| options[:space] = arg }
        opts.on("-g", "--global FILE", String,
                "Use global configuration FILE",
                "Default: #{Configuration::DEFAULT_GLOBAL_CONFIGURATION_FILE}") { |arg| options[:global] = arg }
        opts.on("-i", "--sound-input TEMPLATE", String,
                "Use sound input template TEMPLATE",
                "Default: #{CsoundRenderer::DEFAULT_TEMPLATES[:sound_source]}") { |arg| options[:sound_input] = arg }
        opts.on("-m", "--movements TEMPLATE", String,
                "Use movements template TEMPLATE",
                "Default: #{CsoundRenderer::DEFAULT_TEMPLATES[:movements]}") { |arg| options[:movements] = arg }
        opts.on("-p", "--point-source TEMPLATE", String,
                "Use point source template TEMPLATE",
                "Default: #{CsoundRenderer::DEFAULT_TEMPLATES[:point_source]}") { |arg| options[:point_source] = arg }
        opts.on("-r", "--reverb-and-output TEMPLATE", String,
                "Use reverb and output template TEMPLATE",
                "Default: #{CsoundRenderer::DEFAULT_TEMPLATES[:reverb_and_output]}") { |arg| options[:reverb_and_output] = arg }
        opts.on("-h", "--help",
                "Show this help message.") { stdout.puts opts; exit }
        opts.parse!(arguments)

        if mandatory_options && mandatory_options.find { |option| options[option.to_sym].nil? }
          stdout.puts opts; exit
        end
      end

      config_root          = options[:config_root]
      space_configuration  = options[:space]
      global_configuration = options[:global]
      sound_input_template = options[:sound_input]
      movements_template   = options[:movements]
      rao_template         = options[:reverb_and_output]
      ps_template          = options[:point_source]

      cr = Cosb::CsoundRenderer.new(config_root, global_configuration, space_configuration, sound_input_template, movements_template, rao_template, ps_template)
      stdout.puts(cr.render)
    end
  end
end
