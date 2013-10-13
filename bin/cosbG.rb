#!/usr/bin/env ruby
#
#  Created on 2013-09-03.
#  Author:  Daniele Scarano

require 'rubygems'

require File.expand_path(File.dirname(__FILE__) + "/../lib/cosb")

# Set main window and create
mainwindow = File.expand_path(File.dirname(__FILE__) + "/../gui/windows/cosbGuiMainWindow.glade")
gui = Cosb::Cosbgui.new(mainwindow)
# Inozializza i widget di default per la generazione del codice
gui.init_std_widget

Gtk.main