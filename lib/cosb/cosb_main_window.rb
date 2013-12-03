#!/usr/bin/env ruby
#
#  Created on 2013-09-03.
#  Author:  Daniele Scarano
#

require 'gtk2'

require File.expand_path(File.dirname(__FILE__) + '/gui_widget.rb')
require File.expand_path(File.dirname(__FILE__) + '/gui_dialog.rb')
require File.expand_path(File.dirname(__FILE__) + '/gui_menu.rb')

module Cosb
=begin rdoc
  === GUI for cosb
  The code is built on GTK2 API
  Defines general behaviour of Cosbgui object
  Contains methods and costants Cosb main window related
=end
    class Cosbgui
        
        DEFAULT_TITLE = "COSB Csound Orchestra Spatialize Builder"
        DEFAULT_PROJECT_DIR = File.join(Cosb::ROOT_PATH, "projects/")
        
        # Initialization of main window using gtk2 xml glade file 
        def initialize(window_path)
        
            Gtk.init
            @builder = Gtk::Builder::new
            @builder.add_from_file(window_path)
            @builder.connect_signals{ |handler| method(handler) }
            
            # Init of csound renderer
            @cr = Cosb::CsoundRenderer.new()
    
            # Initialization of main window
            @cosb_main_window = @builder.get_object("cosbGuiMainWindow")
            @cosb_main_window.show()
            
        end
        
        # Close the application
        def gtk_main_quit
            puts "cosbG session ended..."
            Gtk.main_quit()
        end
        
        #This method should be private - writing in status bar is delegated to GUI widgets
        def statusbar_write(message)
            statusbar = @builder.get_object("cosbGuiStatusbar")
            id = statusbar.get_context_id("")
            statusbar.push(id, message)
        end
        
        # this method outputs information about current operation in console view
        def console_write(message)
            console = @builder.get_object("consoleBuffer")
            console.text += "\n"+message
        end
        
        def console_clear()
            console = @builder.get_object("consoleBuffer")
            console.text = ""
        end
        
        def store_current_file(text)
            @tempBuffer = @builder.get_object("tempBuffer")
            @tempBuffer.text = text 
        end
        
        def tempbuffer_check()
            if ! @tempBuffer; @tempBuffer = @builder.get_object("tempBuffer"); end
        end
        
        def tempbuffer_clear()
            if ! @tempBuffer; @tempBuffer = @builder.get_object("tempBuffer"); end
            @tempBuffer.text = ""
        end
        
        # initialize preview contest
        def preview_init(filename)
            
            message = "Generatin Preview..."
            statusbar_write(message)
            console_write("Current file in preview: " + filename + "\n")
            # read file content
            b = File.open(filename, "r")
            content = b.read
            preview_write(content)
            store_current_file(File.join(File.dirname(filename), "newfile.ext"))
            console_write("Preview of file " + filename + " completed")
            
        end
        # preview write
        def preview_write(message)
            preview = @builder.get_object("previewBuffer")
            preview.text = message
        end
        
        # Clear the text shown in the preview testview
        def preview_clear()
            preview = @builder.get_object("previewBuffer")
            preview.text = ""
            tempbuffer_check()
            @synchk.sensitive = false
            
        end
        
        # Show a code preview based on GUI settings
        def codePreview()
            cr = Cosb::CsoundRenderer.new( @spaceConfigFilenameEntry.text, @globConfigFilenameEntry.text)
            preview_write(cr.render)
            store_current_file(Cosb::Configuration::DEFAULT_OUTPUT_FILE)
            @synchk.sensitive = true
        end
        
        # Saves Csound generated code in a file
        def saveFile(infile, content)
            if infile
                outfile = File.new(infile, "w")
                outfile.syswrite(content)
                console_write("File written: " + infile)
            end
        end
        
        def gui_project
            @currprj = Cosb::Project.new()
            self.project_dialog
        end
        
    end
    
end