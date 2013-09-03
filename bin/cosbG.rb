#!/usr/bin/env ruby
#
#  Created on 2013-09-03.
#  Author:  Daniele Scarano

require 'rubygems'

require File.expand_path(File.dirname(__FILE__) + "/../lib/cosb")

# Set main window and create
mainwindow = File.expand_path(File.dirname(__FILE__) + "/../gui/windows/cosbGuiMainWindow.glade")
gui = Cosb::Cosbgui.new(mainwindow)
Gtk.main