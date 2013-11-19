#
# $Id: cli.rb 8 2012-05-16 01:33:58Z nicb $
#
require 'optparse'

module Cosb

    class Cosbgui
        
        attr_reader :output_file
        
        DEFAULT_OUTPUT_FILE = ""
            
        def self.stdOut(stdout, arguments=[] )
            
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
