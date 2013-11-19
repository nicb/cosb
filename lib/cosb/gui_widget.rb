module Cosb
    class Cosbgui

        # Initialization of the default widgets
        def init_std_widget()
            cr = Cosb::CsoundRenderer.new()
            @globConfigFilenameEntry = @builder.get_object("globConfigFilenameEntry")
            @globConfigFilenameEntry.text = File.path(Cosb::Configuration::DEFAULT_GLOBAL_CONFIGURATION.to_s)
            @spaceConfigFilenameEntry = @builder.get_object("spaceConfigFilenameEntry")
            @spaceConfigFilenameEntry.text = File.path(Cosb::Configuration::DEFAULT_SPACE_CONFIGURATION.to_s)
            @srEntry = @builder.get_object("srEntry")
            @srEntry.text = cr.configuration.global_configuration.sample_rate.to_s
            @ksmpsEntry = @builder.get_object("ksmpsEntry")
            @ksmpsEntry.text = cr.configuration.global_configuration.ksmps.to_s
            @asEntry = @builder.get_object("asEntry")
            @asEntry.text = cr.configuration.global_configuration.audio_sources.to_s
            @smEntry = @builder.get_object("smEntry")
            @smEntry.text = cr.configuration.global_configuration.simultaneous_movements.to_s
            @rdEntry = @builder.get_object("rdEntry")
            @rdEntry.text = cr.configuration.space_configuration.reverberation_decay.to_s
            @chNumberEntry = @builder.get_object("chNumberEntry")
            @chNumberEntry.text = cr.configuration.space_configuration.num_channels.to_s
            @headerTemplateFilenameEntry = @builder.get_object("headerTemplateFilenameEntry")
            @headerTemplateFilenameEntry.text = File.basename(cr.templates[:header].to_s)
            @soundSourceTemplateEntry = @builder.get_object("soundSourceTemplateEntry")
            @soundSourceTemplateEntry.text = File.basename(cr.templates[:sound_source].to_s)
            @movementsTemplateEntry = @builder.get_object("movementsTemplateEntry")
            @movementsTemplateEntry.text = File.basename(cr.templates[:movements].to_s)
            @pointSourceTemplateEntry = @builder.get_object("pointSourceTemplateEntry")
            @pointSourceTemplateEntry.text = File.basename(cr.templates[:point_source].to_s)
            @roomDefinitionTemplateFilenameEntry = @builder.get_object("roomDefinitionTemplateFilenameEntry")
            @roomDefinitionTemplateFilenameEntry.text = File.basename(cr.templates[:room_definition].to_s)
            @singleSpeakerTemplateFilenameEntry = @builder.get_object("singleSpeakerTemplateFilenameEntry")
            @singleSpeakerTemplateFilenameEntry.text = File.basename(cr.templates[:single_speaker].to_s)
            @reverbAndOutputTemplateFilenameEntry = @builder.get_object("reverbAndOutputTemplateFilenameEntry")
            @reverbAndOutputTemplateFilenameEntry.text = File.basename(cr.templates[:reverb_and_output].to_s)
        end
        
        # Restore default global config file
        def setGlobalConfigDefaul()
            @globConfigFilenameEntry.text = File.path(Cosb::Configuration::DEFAULT_GLOBAL_CONFIGURATION.to_s)
        end

        # Restore default spsce config file
        def setSpaceConfigDefaul()
            @spaceConfigFilenameEntry.text = File.path(Cosb::Configuration::DEFAULT_SPACE_CONFIGURATION.to_s)
        end
        
        # Set the current entry text object to modify to global config
        def globalConfigFileEntry()
            @this_entry = @builder.get_object("globConfigFilenameEntry")
        end

        # Set the current entry text object to modify to space config
        def spaceConfigFileEntry()
            @this_entry = @builder.get_object("spaceConfigFilenameEntry")
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