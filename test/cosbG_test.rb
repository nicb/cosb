#
#  Created on 2013-09-03.
#  Author:  Daniele Scarano
#
require 'test_helper'

class TestcosbG < Minitest::Test

  def setup
    @cosbG_main_window = File.expand_path(File.join(['..'] * 2, 'gui', 'windows', 'cosbGuiMainWindow.glade'), __FILE__)
  end
  
  # This function test all the methods available for the Cosbgui object
  def test_cosbgui_main_window
    @main_window = Cosb::Cosbgui.new(@cosbG_main_window)    
    assert(!@main_window.nil?)
    assert(@main_window.respond_to?(:gtk_main_quit))
    assert(@main_window.respond_to?(:statusbar_write))
    assert(@main_window.respond_to?(:init_std_widget))
    assert(@main_window.respond_to?(:globConfigViewButton_action))
    assert(@main_window.respond_to?(:spaceConfigViewButton_action))
    assert(@main_window.respond_to?(:clear_preview))
    assert(@main_window.respond_to?(:setGlobalConfigDefaul))
    assert(@main_window.respond_to?(:setSpaceConfigDefaul))
    assert(@main_window.respond_to?(:fileChooser_show))
    assert(@main_window.respond_to?(:fileChooserHide))
    assert(@main_window.respond_to?(:globalConfigFileEntry))
    assert(@main_window.respond_to?(:spaceConfigFileEntry))
    assert(@main_window.respond_to?(:codePreview))
    assert(@main_window.respond_to?(:gui_project))
  end
  
# def test_project
#   @project = Cosb::Project.new()
#   assert(@project.respond_to?(:create_project))
# end

  def test_true
    assert(true)
  end

end
