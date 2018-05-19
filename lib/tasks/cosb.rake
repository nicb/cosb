require 'tempfile'
require 'fileutils'
require File.expand_path(File.join(['..'] * 3, 'spec', 'algo', 'csound', 'lib', 'test_helper'), __FILE__)

namespace :test do

  namespace :cosb do
  
    namespace :csound do

      TEMP_PATH_ROOT = File.expand_path(File.join(['..'] * 3, 'spec', 'algo', 'csound', 'tmp'), __FILE__)
      TEMP_PATH = File.join(TEMP_PATH_ROOT, 'cosb-')
      temp_path = Dir::Tmpname.make_tmpname(TEMP_PATH, nil)

      task :prepare => [temp_path] do
        mkdir File.join(temp_path, 'config')
        mkdir File.join(temp_path, 'config', 'global')
        mkdir File.join(temp_path, 'config', 'spaces')
        mkdir File.join(temp_path, 'csound')
      end

      directory temp_path

      task :cleanup => [temp_path] do
        rm_r temp_path
      end

      desc "perform a complete cleanup of the tmp directory"
      task :full_cleanup do
        dirs = Dir.glob(File.join(TEMP_PATH_ROOT, '*'))
        rm_r dirs unless dirs.empty?
      end

      namespace :create do

        task :config => [:prepare] do
          cc = Cosb::TestHelper::ConfigurationCreator.new(temp_path)
          cc.global
          cc.spaces
        end
  
        task :orc => [:config]
  
        task :sco => [:config]

        task :octave => [:config]

      end

      namespace :run do

        task :csound => ["create:orc", "create:sco"]
  
        task :octave => ["create:octave"]

      end

      task :compare_csound_octave => ["run:csound", "run:octave"]

      task :spec_results => [:compare_csound_octave]

    end

    desc 'test cosb csound production with random configurations'
    task :csound => ["csound:spec_results"] do
      # Rake::Task["csound:cleanup"].invoke
    end
  
  end

end
