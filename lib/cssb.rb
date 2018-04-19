#
# $Id: cosb.rb 3 2012-05-15 03:21:07Z nicb $
#
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

# require File.expand_path(File.join('..', 'cssb', 'constants'), __FILE__)

# add each new file in lib/cssb/
%w(
	cli
).each { |f| require File.join(Cssb::LIB_PATH, 'cssb', f) }
