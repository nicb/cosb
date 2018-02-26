#!/usr/bin/env ruby
#
#  Created on 2013-11-30.
#  Author:  Daniele Scarano

module Cosb
    
    class Cosbgui

        # Hide openfile dialog window
        def fileChooserHide()
            @filechooserdialog1.hide
        end

        def clear_preview()
          # TODO
        end
        
        # Show save fiel dialog
        def file_save_dialog()
            dialog = Gtk::FileChooserDialog.new(
                "Save File As ...",
                nil,
                Gtk::FileChooser::ACTION_SAVE,
                nil,
                [ Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL ],
                [ Gtk::Stock::SAVE, Gtk::Dialog::RESPONSE_ACCEPT ]
            )
            # aggiungere project dir
            if @currprj.nil?
                dialog.filename = @tempBuffer.text
            else
                dialog.filename = @currprj.project_dir.to_s + "/deffile"
            end
            dialog.signal_connect('response') do |w, r|
                odg = case r
                    when Gtk::Dialog::RESPONSE_ACCEPT
                        filename = dialog.filename
                        preview = @builder.get_object("previewBuffer")
                        content = preview.text
                        console_write("Saving File: "+filename)
                        saveFile(filename, content)
                    when Gtk::Dialog::RESPONSE_CANCEL;   console_write("'CANCEL' Activity interrupted by user action")
                        else; console_write("Undefined response ID; perhaps Close-x? (#{r})")
                end
                puts odg
                dialog.destroy
            end
            dialog.run
        end
    
        # load score button function
        def load_score()
            
            @this_entry = @builder.get_object("tempBuffer")
            dialog = Gtk::FileChooserDialog.new(
                "Open File ...",
                nil,
                Gtk::FileChooser::ACTION_OPEN,
                nil,
                [ Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL ],
                [ Gtk::Stock::OPEN, Gtk::Dialog::RESPONSE_ACCEPT ]
            )
            if ! @currprj.nil?
                dialog.filename = @currprj.project_dir.to_s + "/deffile"
            end
            dialog.signal_connect('response') do |w, r|
                odg = case r
                    when Gtk::Dialog::RESPONSE_ACCEPT
                        filename = dialog.filename
                        @builder.get_object("previewBuffer")
                        lines = nil
                        console_write("Opened File: "+filename)
                        File.open(filename, 'r') { |fh| lines = fh.readlines }
                        content = lines.join
                        preview_write(content)
                        store_current_file(filename)
                    when Gtk::Dialog::RESPONSE_CANCEL;   console_write("'CANCEL' Activity interrupted by user action")
                        else; console_write("Undefined response ID; perhaps Close-x? (#{r})")
                end
                puts odg
                dialog.destroy
            end
            dialog.run
            
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
                
        # Load file into configuration field
        def on_fileChooserOpenBt_clicked()
            puts("Apro il File "+@filechooserdialog1.filename.to_s)
            if @this_entry
                @this_entry.text = @filechooserdialog1.filename.to_s
                header_form_update()
            else
                # Define this using a dialog window
                puts("An error Occured, impossible to load the selected file")
            end
        end
        
        # project management
        def project_dialog
            @prjdialog = @builder.get_object("projectDialog")
            if @prjdialog.destroyed?
                puts("creo oggetto")
                @prjdialog = @builder.get_object("projectDialog")
#                @prjdialog.show
            else
                puts("rilevo oggetto dal builder")
#                @prjdialog.show
            end
            @prjdialog.show
            @projectNameEntry = @builder.get_object("projectNameEntry")
        end
        
        def project_dialog_hide
            @prjdialog.hide
        end
        
        def project_dir_create
            dirname = File.join(Cosb::Cosbgui::DEFAULT_PROJECT_DIR,  @projectNameEntry.text)
            if ! Dir.exist?(dirname)
                Dir.mkdir(dirname)
                @currprj.project_dir = dirname
                @cosb_main_window.title = Cosb::Cosbgui::DEFAULT_TITLE + " - Project [" + @projectNameEntry.text + "]"
                self.project_dialog_hide
            else
                projectNameLabel = @builder.get_object("projectNameLabel")
                projectNameLabel.label = "Directory Already Exist!"
                puts("Directory Already Exist")
            end
            #prjdir = Dir.new(dirname)
            #puts(File.join(Cosb::ROOT_PATH, @projectNameEntry.text))
        end
        
        def project_select
                        
            @this_entry = @builder.get_object("tempBuffer")
            dialog = Gtk::FileChooserDialog.new(
                "Open File ...",
                nil,
                Gtk::FileChooser::ACTION_SELECT_FOLDER,
                nil,
                [ Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL ],
                [ Gtk::Stock::OPEN, Gtk::Dialog::RESPONSE_ACCEPT ]
            )
            dialog.filename = Cosb::Cosbgui::DEFAULT_PROJECT_DIR
            dialog.signal_connect('response') do |w, r|
                odg = case r
                    when Gtk::Dialog::RESPONSE_ACCEPT
                        dirname = dialog.filename
                        @builder.get_object("previewBuffer")
                        # new
                        @currprj = Cosb::Project.new()
                        @currprj.project_dir = dirname
                        console_write("Selected project: "+dirname)
                        @cosb_main_window.title = Cosb::Cosbgui::DEFAULT_TITLE + " - Project [" + File.basename(dirname) + "]"
                    when Gtk::Dialog::RESPONSE_CANCEL;   console_write("'CANCEL' Activity interrupted by user action")
                        else; console_write("Undefined response ID; perhaps Close-x? (#{r})")
                end
                puts odg
                dialog.destroy
            end
            dialog.run
            
        end
        
    end
    
end
