#!/usr/bin/env ruby
#
#  Created on 2013-11-18.
#  Author:  Daniele Scarano

module Cosb
    class Cosbgui

        # Initialization of the default widgets
        def init_std_widget()
            @globConfigFilenameEntry = @builder.get_object("globConfigFilenameEntry")
            @globConfigFilenameEntry.text = File.path(Cosb::Configuration::DEFAULT_GLOBAL_CONFIGURATION.to_s)
            @spaceConfigFilenameEntry = @builder.get_object("spaceConfigFilenameEntry")
            @spaceConfigFilenameEntry.text = File.path(Cosb::Configuration::DEFAULT_SPACE_CONFIGURATION.to_s)
            @srEntry = @builder.get_object("srEntry")
            @srEntry.text = @cr.configuration.global_configuration.sample_rate.to_s
            @ksmpsEntry = @builder.get_object("ksmpsEntry")
            @ksmpsEntry.text = @cr.configuration.global_configuration.ksmps.to_s
            @asEntry = @builder.get_object("asEntry")
            @asEntry.text = @cr.configuration.global_configuration.audio_sources.to_s
            @smEntry = @builder.get_object("smEntry")
            @smEntry.text = @cr.configuration.global_configuration.simultaneous_movements.to_s
            @rdEntry = @builder.get_object("rdEntry")
            @rdEntry.text = @cr.configuration.space_configuration.reverberation_decay.to_s
            @chNumberEntry = @builder.get_object("chNumberEntry")
            @chNumberEntry.text = @cr.configuration.space_configuration.num_channels.to_s
            @headerTemplateFilenameEntry = @builder.get_object("headerTemplateFilenameEntry")
            @headerTemplateFilenameEntry.text = File.basename(@cr.templates[:header].to_s)
            @soundSourceTemplateEntry = @builder.get_object("soundSourceTemplateEntry")
            @soundSourceTemplateEntry.text = File.basename(@cr.templates[:sound_source].to_s)
            @movementsTemplateEntry = @builder.get_object("movementsTemplateEntry")
            @movementsTemplateEntry.text = File.basename(@cr.templates[:movements].to_s)
            @pointSourceTemplateEntry = @builder.get_object("pointSourceTemplateEntry")
            @pointSourceTemplateEntry.text = File.basename(@cr.templates[:point_source].to_s)
            @roomDefinitionTemplateFilenameEntry = @builder.get_object("roomDefinitionTemplateFilenameEntry")
            @roomDefinitionTemplateFilenameEntry.text = File.basename(@cr.templates[:room_definition].to_s)
            @singleSpeakerTemplateFilenameEntry = @builder.get_object("singleSpeakerTemplateFilenameEntry")
            @singleSpeakerTemplateFilenameEntry.text = File.basename(@cr.templates[:single_speaker].to_s)
            @reverbAndOutputTemplateFilenameEntry = @builder.get_object("reverbAndOutputTemplateFilenameEntry")
            @reverbAndOutputTemplateFilenameEntry.text = File.basename(@cr.templates[:reverb_and_output].to_s)
            # buttons explicit
            @synchk = @builder.get_object("synchk") 
        end
        
        # Set the current entry text object to modify to global config
        def globalConfigFileEntry()
            @this_entry = @builder.get_object("globConfigFilenameEntry")
        end

        # Set the current entry text object to modify to space config
        def spaceConfigFileEntry()
            @this_entry = @builder.get_object("spaceConfigFilenameEntry")
        end

####################
        # Show global config file content in preview window
        def globConfigViewButton_action()
            
            filename = @globConfigFilenameEntry.text
            preview_init(filename)
            @synchk.sensitive = false
            
        end
        
        # Show space config file content in preview window
        def spaceConfigViewButton_action()
            
            filename = @spaceConfigFilenameEntry.text
            preview_init(filename)
            @synchk.sensitive = false
            
        end
        
        # Show template header.orc.erb
        def headerTemplateView_action()
        
            if File.exist?(@headerTemplateFilenameEntry.text)
                filename = @headerTemplateFilenameEntry.text
            else
                filename = @cr.templates[:header].to_s
            end
            preview_init(filename)
            @synchk.sensitive = false
            
        end
        
        # Show template sound_source.orc.erb
        def soundSourceTemplateView_action()
            
            if File.exist?(@soundSourceTemplateEntry.text)
                filename = @soundSourceTemplateEntry.text
            else
                filename = @cr.templates[:sound_source]
            end
            preview_init(filename)
            @synchk.sensitive = false
            
        end
        
        def movementsTemplateView_action()
            
            if File.exist?(@movementsTemplateEntry.text)
                filename = @movementsTemplateEntry.text
            else
                filename = @cr.templates[:movements]
            end

            preview_init(filename)
            @synchk.sensitive = false
            
        end
        
        def pointSourceTemplateView_action()

                    
            if File.exist?(@pointSourceTemplateEntry.text)
                filename = @pointSourceTemplateEntry.text
            else
                filename = @cr.templates[:point_source]
            end
            
            preview_init(filename)
            @synchk.sensitive = false
            
        end

        def roomDefinitionTemplateView_action()
            
            if File.exist?(@roomDefinitionTemplateFilenameEntry.text)
                filename = @roomDefinitionTemplateFilenameEntry.text
            else
                filename = @cr.templates[:room_definition]
            end
            
            preview_init(filename)
            @synchk.sensitive = false
            
        end

        def singleSpeakerTemplateView_action()

            if File.exist?(@singleSpeakerTemplateFilenameEntry.text)
                filename = @singleSpeakerTemplateFilenameEntry.text
            else
                filename = @cr.templates[:single_speaker]
            end            
            preview_init(filename)
            @synchk.sensitive = false
            
        end

        def reverbAndOutputTemplateView_action()
            
            if File.exist?(@reverbAndOutputTemplateFilenameEntry.text)
                filename = @reverbAndOutputTemplateFilenameEntry.text
            else
                filename = @cr.templates[:reverb_and_output]
            end   
            filename = @cr.templates[:reverb_and_output]
            preview_init(filename)
            @synchk.sensitive = false
            
        end
        
################# Show
        def headerTemplateFilenameEntry()
        
            @this_entry = @builder.get_object("headerTemplateFilenameEntry")
            
        end
        
        def soundSourceTemplateEntry()
            
            @this_entry = @builder.get_object("soundSourceTemplateEntry")
            
        end
        
        def movementsTemplateEntry()
            
            @this_entry = @builder.get_object("movementsTemplateEntry")
            
        end
        
        def pointSourceTemplateEntry()
            
            @this_entry = @builder.get_object("pointSourceTemplateEntry")
            
        end

        def roomDefinitionTemplateFilenameEntry()
            
            @this_entry = @builder.get_object("roomDefinitionTemplateFilenameEntry")
            
        end

        def singleSpeakerTemplateFilenameEntry()
            
            @this_entry = @builder.get_object("singleSpeakerTemplateFilenameEntry")
            
        end

        def reverbAndOutputTemplateFilenameEntry()
            
            @this_entry = @builder.get_object("reverbAndOutputTemplateFilenameEntry")
            
        end
        
################## Default

        # Restore default global config file
        def setGlobalConfigDefaul()
            @globConfigFilenameEntry.text = File.path(Cosb::Configuration::DEFAULT_GLOBAL_CONFIGURATION.to_s)
        end

        # Restore default spsce config file
        def setSpaceConfigDefaul()
            @spaceConfigFilenameEntry.text = File.path(Cosb::Configuration::DEFAULT_SPACE_CONFIGURATION.to_s)
        end
        
        def setHeaderTemplateFilenameEntryDefault()
        
            @this_entry = @builder.get_object("headerTemplateFilenameEntry")
            @this_entry.text = File.basename(@cr.templates[:header])
            
        end
        
        def setSoundSourceTemplateEntryDefault()
            
            @this_entry = @builder.get_object("soundSourceTemplateEntry")
            @this_entry.text = File.basename(@cr.templates[:sound_source])
            
        end
        
        def setMovementsTemplateEntryDefault()
            
            @this_entry = @builder.get_object("movementsTemplateEntry")
            @this_entry.text = File.basename(@cr.templates[:movements])
            
        end
        
        def setPointSourceTemplateEntryDefault()
            
            @this_entry = @builder.get_object("pointSourceTemplateEntry")
            @this_entry.text = File.basename(@cr.templates[:point_source])
            
        end

        def setRoomDefinitionTemplateFilenameEntryDefault()
            
            @this_entry = @builder.get_object("roomDefinitionTemplateFilenameEntry")
            @this_entry.text = File.basename(@cr.templates[:room_definition])
            
        end

        def setSingleSpeakerTemplateFilenameEntryDefault()
            
            @this_entry = @builder.get_object("singleSpeakerTemplateFilenameEntry")
            @this_entry.text = File.basename(@cr.templates[:single_speaker])
            
        end

        def setReverbAndOutputTemplateFilenameEntryDefault()
            
            @this_entry = @builder.get_object("reverbAndOutputTemplateFilenameEntry")
            @this_entry.text = File.basename(@cr.templates[:reverb_and_output])
            
        end
        
    end
end