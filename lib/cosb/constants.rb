#
# $Id$
#

module Cosb
        
    VERSION = '0.1.0'
    ROOT_PATH = File.expand_path(File.join(File.dirname(__FILE__), ['..'] * 2))
    CONFIG_PATH = File.join(ROOT_PATH, 'config')
    TEMPLATE_PATH = File.join(ROOT_PATH, 'templates')
    OUTPUT_PATH = File.join(ROOT_PATH, 'csoundcode')

end
