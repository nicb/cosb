#
# $Id$
#

module Cosb
        
    ROOT_PATH = File.expand_path(File.join(['..'] * 3), __FILE__)
    LIB_PATH = File.join(ROOT_PATH, 'lib')
    CONFIG_PATH = File.join(ROOT_PATH, 'config')
    TEMPLATE_PATH = File.join(ROOT_PATH, 'templates')
    OUTPUT_PATH = File.join(ROOT_PATH, 'csoundcode')

end
