#!/usr/bin/env ruby

require 'rubygems'
require 'libglade2'
require 'gtk2'

  #TITLE = "COSB GUI"
  #NAME = "FirstApp"
  #VERSION = "1.0"


class HelloGlade

  def initialize(path)

    if __FILE__ == $0

      Gtk.init

      builder = Gtk::Builder::new

      builder.add_from_file(path)

      builder.connect_signals{ |handler| method(handler) }

      @window = builder.get_object("window1")

      @statusbar = builder.get_object("statusbar1")

      @window.show()

    end

  end

  def gtk_main_quit

    puts "Ciao Gtk.main_quit"

    Gtk.main_quit()

  end

  def on_sb_render_clicked(widget)
    cid = @statusbar.get_context_id("message")
    puts "Context id" + cid.to_s
    @statusbar.push(cid, "FEEDBACK ACHIEVED")
  end

end

#Gnome::Program.new(HelloGlade::NAME, HelloGlade::VERSION)

HelloGlade.new("/Users/hellska/hellska/COSB-Project/cosb/trunk/gui/windows/w_cosb_main.glade")

#
#HelloGlade.new(File.dirname($0) + "/tut2libglade.glade")
Gtk.main
