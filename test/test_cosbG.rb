class TestcosbG < Test::Unit::TestCase

  def setup
      @cosbG_main_window = File.expand_path(File.dirname(__FILE__) + "/../gui/windows/cosbGuiMainWindow.glade")
  end

# Tasks

# this is a test task ..just to see if it works fine
  def test_cosbG_shell_output_task
    puts 'shel output task'
  end
  
  def test_cosbgui_main_window
    @main_window = Cosb::Cosbgui.new(@cosbG_main_window)
    assert_not_nil(@main_window)
    assert_respond_to(@main_window, :gtk_main_quit)
  end

end