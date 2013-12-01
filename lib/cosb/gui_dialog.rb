#!/usr/bin/env ruby
#
#  Created on 2013-11-30.
#  Author:  Daniele Scarano

module Cosb
    
    class Cosbgui
    
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
        
        # Show save fiel dialog
        def file_save_dialog ()
            dialog = Gtk::FileChooserDialog.new(
                "Save File As ...",
                nil,
                Gtk::FileChooser::ACTION_SAVE,
                nil,
                [ Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL ],
                [ Gtk::Stock::SAVE, Gtk::Dialog::RESPONSE_ACCEPT ]
            )
            dialog.filename = @tempBuffer.text
            dialog.signal_connect('response') do |w, r|
                odg = case r
                    when Gtk::Dialog::RESPONSE_ACCEPT
                        filename = dialog.filename
                        preview = @builder.get_object("previewBuffer")
                        content = preview.text
                        console_write("Saving Orchestra File: "+filename)
                        saveFile(filename, content)
                    when Gtk::Dialog::RESPONSE_CANCEL;   console_write("'CANCEL' Activity interrupted by user action")
                        else; console_write("Undefined response ID; perhaps Close-x? (#{r})")
                end
                puts odg
                dialog.destroy
            end
            dialog.run
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