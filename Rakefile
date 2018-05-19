#
# $Id: Rakefile 2 2012-05-14 09:18:25Z nicb $
#
require 'bundler/gem_tasks'
require 'rake'
require 'rspec/core/rake_task'
require 'rake/testtask'

#require 'newgem/tasks'
Dir['lib/tasks/**/*.rake'].each { |t| load t }

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*test.rb']
  t.verbose = true
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
  t.rspec_opts = '--format documentation'
  # t.rspec_opts << ' more options'
  # t.rcov = true
end

task :default => [:spec, :test]
# task :default => :test
