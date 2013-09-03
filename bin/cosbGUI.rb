#!/usr/bin/env ruby
#
#  Created on 2012-6-16.
#  Author:  Daniele Scarano

require 'rubygems'
# require 'libglade2'
require 'gtk2'

require File.expand_path(File.dirname(__FILE__) + "/../lib/cosb")
require File.expand_path(File.dirname(__FILE__) + "/../lib/cosb/guicli")

class COSBGlade

    def initialize(path)
  
        if __FILE__ == $0
  
            Gtk.init
      
            builder = Gtk::Builder::new
      
            builder.add_from_file(path)
      
            builder.connect_signals{ |handler| method(handler) }
      
            @window = builder.get_object("window1")
            @window.show()
            
            @statusbar = builder.get_object("statusbar1")
            
            @consoleFrame = builder.get_object("frame2")
            
            @consoleText = builder.get_object("textview1")
            @consoleBuff = builder.get_object("textbuffer1")
            @outFileName = builder.get_object("outFileName")
            @flgOutFileName = builder.get_object("flgOutFileName")
            
            @gconf1 = builder.get_object("entry1")
            @gconf2 = builder.get_object("entry2")
            @gconf1.text = File.basename(Cosb::Configuration::DEFAULT_SPACE_CONFIGURATION.to_s)
            @gconf2.text = File.basename(Cosb::Configuration::DEFAULT_SPACE_CONFIGURATION.to_s)
  
        end
  
    end
    
    def console_write(text)
        buff = @consoleBuff.get_text.to_s
        @consoleBuff.text = buff + text
    end

    def status_bar_write(message)
        cid = @statusbar.get_context_id("message")
        @statusbar.push(cid, message)
    end
    
    def initWidgets

    end
    
    def gtk_main_quit
  
        puts "Ciao Gtk.main_quit"
        Gtk.main_quit()
  
    end

#   render csound code using guicli.rb
    def on_sb_render_clicked(widget)
        
        status_bar_write("Rendering code...")
        console_write("Rendering code...\n")
        
        if @flgOutFileName.active?
            text = @outFileName.text
            Cosb::GuiCLI.outfile(text)
            console_write("writing on file\n")
        else
            Cosb::GuiCLI.stdOut(STDOUT, ARGV)
            console_write("writing on stdout\n")
        end
        
        status_bar_write("Render done")
        console_write("Render done\n")
    end

#   trigger toggle "write on file"
    def on_flgOutFileName_toggled(widget)
        text = @outFileName.text
        if text.empty?
            @outFileName.text = "csound.orc"
        end
    end
  
#   console functions
    def on_button9_clicked(widget)
        if @consoleFrame.visible? then
            @consoleFrame.visible = false
        else
            @consoleFrame.visible = true
        end
    end
    def on_clearConsole_clicked(widget)
        @consoleBuff.text = "" 
    end

end

mainwindow = File.expand_path(File.dirname(__FILE__) + "/../gui/windows/w_cosb_main.glade")

gui = COSBGlade.new(mainwindow)

#gui.method(initWidgets)

Gtk.main
