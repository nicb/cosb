#!/usr/bin/env ruby
#
#  Created on 2013-09-03.
#  Author:  Daniele Scarano

class TestcosbG < Test::Unit::TestCase

  def setup
    @cosbG_main_window = File.expand_path(File.dirname(__FILE__) + "/../gui/windows/cosbGuiMainWindow.glade")

  end
  
  # This function test all the methods available for the Cosbgui object
  def test_cosbgui_main_window
    @main_window = Cosb::Cosbgui.new(@cosbG_main_window)    
    assert_not_nil(@main_window)
    assert_respond_to(@main_window, :gtk_main_quit)
    assert_respond_to(@main_window, :statusbar_write)
    assert_respond_to(@main_window, :init_std_widget)
    assert_respond_to(@main_window, :globConfigViewButton_action)
    assert_respond_to(@main_window, :spaceConfigViewButton_action)
#    assert_respond_to(@main_window, :clear_preview)
    assert_respond_to(@main_window, :setGlobalConfigDefaul)
    assert_respond_to(@main_window, :setSpaceConfigDefaul)
    assert_respond_to(@main_window, :fileChooser_show)
    assert_respond_to(@main_window, :fileChooserHide)
    assert_respond_to(@main_window, :globalConfigFileEntry)
    assert_respond_to(@main_window, :spaceConfigFileEntry)
    assert_respond_to(@main_window, :codePreview)
    assert_respond_to(@main_window, :gui_project)
  end
  
  def test_project
    @project = Cosb::Project.new()
    assert_respond_to(@project, :create_project)
  end

end