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
  Defines general behaviour of Cosbgui object
=end
    class Cosbgui
        
        # Initialization of main window using gtk2 xml glade file 
        def initialize(window_path)
        
            Gtk.init
            @builder = Gtk::Builder::new
            @builder.add_from_file(window_path)
            @builder.connect_signals{ |handler| method(handler) }
    
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
            @statusbar = @builder.get_object("cosbGuiStatusbar")
            id = @statusbar.get_context_id("")
            # command line message
            # puts "this is statusbar id : #{id} and this is the message #{message}"
            # statusbar message
            @statusbar.push(id, message)
        end
        
        # Clear the text shown in the preview testview
        def clear_preview()
            @preview = @builder.get_object("previewBuffer")
            @preview.text = ""
        end
        
        def codePreview()
            @preview = @builder.get_object("previewBuffer")
            #cr = Cosb::CsoundRenderer.new( Configuration::DEFAULT_SPACE_CONFIGURATION, Configuration::DEFAULT_GLOBAL_CONFIGURATION, CsoundRenderer::DEFAULT_TEMPLATES[:sound_source], CsoundRenderer::DEFAULT_TEMPLATES[:movements])
            cr = Cosb::CsoundRenderer.new( @spaceConfigFilenameEntry.text, @globConfigFilenameEntry.text)
            #cr = Cosb::CsoundRenderer.new()
            @preview.text = cr.render
        end
        
        def saveOrchestraFile()
            outFile = File.new(Configuration::DEFAULT_OUTPUT_FILE, "w+")
            if outFile
                cr = Cosb::CsoundRenderer.new( @spaceConfigFilenameEntry.text, @globConfigFilenameEntry.text)
                outFile.syswrite(cr.render)
                puts "File written"
            end
        end
        
        # Initialization of the default widgets
        def init_std_widget()
            @globConfigFilenameEntry = @builder.get_object("globConfigFilenameEntry")
            @spaceConfigFilenameEntry = @builder.get_object("spaceConfigFilenameEntry")
            @globConfigFilenameEntry.text = File.path(Cosb::Configuration::DEFAULT_GLOBAL_CONFIGURATION.to_s)
            @spaceConfigFilenameEntry.text = File.path(Cosb::Configuration::DEFAULT_SPACE_CONFIGURATION.to_s)
        end
        
        # Restore default global config file
        def setGlobalConfigDefaul()
            @globConfigFilenameEntry.text = File.path(Cosb::Configuration::DEFAULT_GLOBAL_CONFIGURATION.to_s)
        end

        # Restore default spsce config file
        def setSpaceConfigDefaul()
            @spaceConfigFilenameEntry.text = File.path(Cosb::Configuration::DEFAULT_SPACE_CONFIGURATION.to_s)
        end
        
        # Show openfile dialog window
        def fileChooser_show()
            @filechooserdialog1 = @builder.get_object("filechooserdialog1")
            puts(@filechooserdialog1.to_s)
            if @filechooserdialog1.destroyed?
                puts("creo oggetto")
                

                @filechooserdialog1 = @builder.get_object("filechooserdialog1")
                @filechooserdialog1.show
            else
                puts("rilevo oggetto dal builder")
                @filechooserdialog1.show
            end
        end
        
        # Hide openfile dialog window
        def fileChooserHide()
            @filechooserdialog1.hide
        end
        
        # Set the current entry text object to modify to global config
        def globalConfigFileEntry()
            @this_entry = @builder.get_object("globConfigFilenameEntry")
        end

        # Set the current entry text object to modify to space config
        def spaceConfigFileEntry()
            @this_entry = @builder.get_object("spaceConfigFilenameEntry")
        end
        
        # Show global config file content in preview window
        def globConfigViewButton_action()
            
            message = "Generatin Preview..."
            statusbar_write(message)
            
            b = File.open(@globConfigFilenameEntry.text, "r")
            content = b.read
            @preview = @builder.get_object("previewBuffer")
            @preview.text = content
            
            statusbar_write("Preview of file "+@globConfigFilenameEntry.text+" completed")
            
        end
        
        # Show space config file content in preview window
        def spaceConfigViewButton_action()
            
            message = "Generatin Preview..."
            statusbar_write(message)
            
            b = File.open(@spaceConfigFilenameEntry.text, "r")
            content = b.read
            @preview = @builder.get_object("previewBuffer")
            @preview.text = content
            
            statusbar_write("Preview of file "+@spaceConfigFilenameEntry.text+" completed")
            
        end
        
        # Load file into configuration field
        def on_fileChooserOpenBt_clicked()
            puts("Apro il File "+@filechooserdialog1.filename.to_s)
            if @this_entry
                @this_entry.text = @filechooserdialog1.filename.to_s
            else
                # Define this using a dialog window
                puts("An error Occured, impossible to load the selected file")
            end
        end
        
    end
    
end