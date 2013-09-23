#!/usr/bin/env ruby
#
#  Created on 2013-09-03.
#  Author:  Daniele Scarano
#


require 'gtk2'

module Cosb

=begin rdoc
  === GUI for cosb

  The code is built on GTK2 API
  Defines general behaviour of cosbGUI
=end

    class Cosbgui

        def initialize(window_path)
    
            # Initialization of class GTK
            Gtk.init
            @builder = Gtk::Builder::new
            @builder.add_from_file(window_path)
            @builder.connect_signals{ |handler| method(handler) }
    
            # Initialization of main window
            @cosb_main_window = @builder.get_object("cosbGuiMainWindow")
            @cosb_main_window.show()
            
            # Initialization of widgets
        end
        
        # methods and widget behaviour
        def gtk_main_quit
            puts "cosbG session ended..."
            Gtk.main_quit()
        end
        
        def statusbar_write(message)
            @statusbar = @builder.get_object("cosbGuiStatusbar")
            id = @statusbar.get_context_id("")
            # command line message
            puts "this is statusbar id : #{id} and this is the message #{message}"
            # statusbar message
            @statusbar.push(id, message)
        end
        
        #devel this function (is it necessary?!)
        #def get_current_widget(widget)
        #    me = widget.to_s
        #    wname = @builder.get_object(me)
        #    puts "io sono #{wname} oppure #{me}"
        #end
        
        def preview_button_action(widget)
            message = "Generatin Preview..."
            statusbar_write(message)
            a = Cosb::Configuration::DEFAULT_SPACE_CONFIGURATION
            b = File.open(a.to_s, "r")
            content = b.read
            @preview = @builder.get_object("previewBuffer")
            @preview.text = content
            statusbar_write("Preview file "+a.to_s+" complete")
        end
    end

end