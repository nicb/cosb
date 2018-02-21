#
# $Id: Rakefile 2 2012-05-14 09:18:25Z nicb $
#
require 'rubygems'
require 'hoe'
require 'fileutils'
require './lib/cosb'

# Hoe.plugin :newgem
# Hoe.plugin :website
# Hoe.plugin :cucumberfeatures

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.spec 'cosb' do
  self.developer 'Nicola Bernardini', 'nicb@sme-ccppd.org'
  self.post_install_message = 'PostInstall.txt' # TODO remove if post-install message not required
  # self.rubyforge_name       = self.name # TODO this is default value
  # self.extra_deps         = [['activesupport','>= 2.0.2']]
end

#require 'newgem/tasks'
#Dir['lib/tasks/**/*.rake'].each { |t| load t }

# TODO - want other tests/tasks run by default? Add them to the list
# remove_task :default
# task :default => [:spec, :features]
