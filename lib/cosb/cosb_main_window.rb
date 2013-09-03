#!/usr/bin/env ruby
#
#  Created on 2013-09-03.
#  Author:  Daniele Scarano

require 'gtk2'

module Cosb
    
    class Cosbgui
        
        def initialize(window_path)
    
            # Initialization of class GTK
            Gtk.init
            builder = Gtk::Builder::new
            builder.add_from_file(window_path)
            builder.connect_signals{ |handler| method(handler) }
    
            # Initialization of main window
            @cosb_main_window = builder.get_object("cosbGuiMainWindow")
            @cosb_main_window.show()
            
            # Initialization of widgets
        end
        
        # methods and widget behaviour
        def gtk_main_quit
            puts "cosbG session ended..."
            Gtk.main_quit()
        end
        
    end

end