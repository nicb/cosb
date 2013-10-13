#
# $Id: cosb.rb 3 2012-05-15 03:21:07Z nicb $
#
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require File.join('cosb', 'constants')

# add each new file in /lib/cosb/
%w(
	exceptions
	virtual_space
	speaker
	configuration
	csound_renderer
	cli
	guicli
	cosb_main_window
).each { |f| require File.join('cosb', f) }
