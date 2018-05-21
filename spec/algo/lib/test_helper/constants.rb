module Cosb
  module TestHelper
  
    TEMPLATE_DIR_ROOT = File.expand_path(File.join(['..']*2, 'templates'), __FILE__)
    CONFIG_TEMPLATE_PATH = File.join(TEMPLATE_DIR_ROOT, 'config')
    GLOBAL_TEMPLATE = File.join(CONFIG_TEMPLATE_PATH, 'global.yml.erb')
    SPACES_TEMPLATE = File.join(CONFIG_TEMPLATE_PATH, 'spaces.yml.erb')
    SOURCE_TEMPLATE = File.join(CONFIG_TEMPLATE_PATH, 'source.yml.erb')

  end
end
