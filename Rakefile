#
# $Id: Rakefile 2 2012-05-14 09:18:25Z nicb $
#
require 'bundler/gem_tasks'
require 'rake/testtask'

#require 'newgem/tasks'
#Dir['lib/tasks/**/*.rake'].each { |t| load t }

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*test.rb']
  t.verbose = true
end

task :default => :test
