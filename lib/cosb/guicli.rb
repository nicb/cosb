#
# $Id: cli.rb 8 2012-05-16 01:33:58Z nicb $
#
require 'optparse'

module Cosb
  class GuiCLI
          

    
    def self.stdOut(stdout, arguments=[] )
        

      #mandatory_options = %w(  )

      #parser = OptionParser.new do |opts|
      #  opts.banner = <<-BANNER.gsub(/^          /,'')
      #
      #    cosb is a generator of  orchestra  instruments  for  csound  to  run
      #    spatial simulations for any kind of location and any technological setup
      #    (from mono to stereo to multichannel to high-order ambisonics). +cosb+ reads
      #    a configuration file for the physical location, the setup and the virtual
      #    location and create the appropriate orchestra instruments in order to
      #    play with the wanted space.
      #
      #    Usage: #{File.basename($0)} [options]
      #
      #    Options are:
      #  BANNER
      #  opts.separator ""
      #  opts.on("-s", "--space FILE", String,
      #          "Use space configuration FILE",
      #          "Default: #{Configuration::DEFAULT_SPACE_CONFIGURATION}") { |arg| options[:space] = arg }
      #  opts.on("-g", "--global FILE", String,
      #          "Use global configuration FILE",
      #          "Default: #{Configuration::DEFAULT_GLOBAL_CONFIGURATION}") { |arg| options[:global] = arg }
      #  opts.on("-i", "--sound-input TEMPLATE", String,
      #          "Use sound input template TEMPLATE",
      #          "Default: #{CsoundRenderer::DEFAULT_TEMPLATES[:sound_source]}") { |arg| options[:sound_input] = arg }
      #  opts.on("-m", "--movements TEMPLATE", String,
      #          "Use movements template TEMPLATE",
      #          "Default: #{CsoundRenderer::DEFAULT_TEMPLATES[:movements]}") { |arg| options[:movements] = arg }
      #  opts.on("-h", "--help",
      #          "Show this help message.") { stdout.puts opts; exit }
      #  opts.parse!(arguments)
      #
      #  if mandatory_options && mandatory_options.find { |option| options[option.to_sym].nil? }
      #    stdout.puts opts; exit
      #  end
      #end
    
        options = {
            :space       => Configuration::DEFAULT_SPACE_CONFIGURATION,
            :global      => Configuration::DEFAULT_GLOBAL_CONFIGURATION,
            :sound_input => CsoundRenderer::DEFAULT_TEMPLATES[:sound_source],
            :movements   => CsoundRenderer::DEFAULT_TEMPLATES[:movements],
        }
        
        space_configuration  = options[:space]
        global_configuration = options[:global]
        sound_input_template = options[:sound_input]
        movements_template   = options[:movements]
        
        cr = Cosb::CsoundRenderer.new(space_configuration, global_configuration, sound_input_template, movements_template)
        stdout.puts(cr.render)
        puts "Out from GuiCLI"
        
    end
    
    def self.outfile(filename)

        outFile = File.new(filename, "w+")
        if outFile
            cr = Cosb::CsoundRenderer.new(Configuration::DEFAULT_SPACE_CONFIGURATION, Configuration::DEFAULT_GLOBAL_CONFIGURATION, CsoundRenderer::DEFAULT_TEMPLATES[:sound_source], CsoundRenderer::DEFAULT_TEMPLATES[:movements])
            outFile.syswrite(cr.render)
            puts "File written"
        else
            puts "Unable to open file csound.orc"
        end
        
    end
  end
end
