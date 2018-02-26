#
# $Id$
#

module Cosb
        
    VERSION = '0.1.0'
    ROOT_PATH = File.expand_path(File.join(['..'] * 2), __FILE__)
    CONFIG_PATH = File.join(ROOT_PATH, 'config')
    TEMPLATE_PATH = File.join(ROOT_PATH, 'templates')
    OUTPUT_PATH = File.join(ROOT_PATH, 'csoundcode')

end
