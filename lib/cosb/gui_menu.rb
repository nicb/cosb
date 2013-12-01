#!/usr/bin/env ruby
#
#  Created on 2013-11-18.
#  Author:  Daniele Scarano

require 'open3'

module Cosb
    class Cosbgui
        # restore default configuration and templates
        def restore_default()
            init_std_widget()
            preview_clear()
            tempbuffer_clear()
        end
        
        def csound_mac_tags
            preview = @builder.get_object("previewBuffer")
            input = "\n<CsoundSynthesizer>\n<CsOptions>\n</CsOptions>\n<CsInstruments>\n"
            input += preview.text
            input += "\n</CsInstruments>\n<CsScore>\n</CsScore>\n</CsoundSynthesizer>"
            preview.text = input
        end
        
        def csound_syntax_check
            tempf = File.new("/Users/hellska/hellska/COSB-Project/git_repo/cosb/csoundcode/tmporc.csd", "w")
            preview = @builder.get_object("previewBuffer")
            tempf.write(preview.text)
            infile = tempf.path
            tempf.close
            console_write("Checking Syntax on temporary file "+infile)
            stdout,stderr,status = Open3.capture3("csound --syntax-check-only "+infile)
            if status.success?
                console_write(stderr)
                console_write("Syntax Correct!")
                statusbar_write("Syntax Check Finished! Code Parsed Without Errors")
            else
                STDERR.puts "Syntax Incorrect!"
                console_write(stderr)
                console_write("Syntax Incorrect!")
                statusbar_write("Syntax Check Finished! Check Errors in Console")
            end
            File.delete(infile)
        end
    end
end