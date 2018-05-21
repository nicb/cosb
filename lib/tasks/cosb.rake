require 'tempfile'
require 'fileutils'
require File.expand_path(File.join(['..'] * 3, 'spec', 'algo', 'lib', 'test_helper'), __FILE__)

namespace :cosb do

  namespace :test do
  
    namespace :csound do

      COSB_ROOT = File.expand_path(File.join(['..'] * 3), __FILE__)
      TEMP_PATH_ROOT = File.join(COSB_ROOT, 'spec', 'algo', 'tmp')
      TEMP_PATH = File.join(TEMP_PATH_ROOT, 'cosb-')
      temp_path = Dir::Tmpname.make_tmpname(TEMP_PATH, nil)
      COSB_EXE_PATH = File.join(COSB_ROOT, 'bin', 'cosb')
      Y2SCO_EXE_PATH = File.join(COSB_ROOT, 'spec', 'algo', 'csound', 'y2sco')
      CONFIG_PATH = File.join(temp_path, 'config')
      SOURCE_POSITION_PATH = File.join(temp_path, 'config', 'spaces', 'source.yml')
      CSOUND_TMP_DIR = File.join(temp_path, 'csound')
      CSOUND_ORC_OUTPUT = File.join(CSOUND_TMP_DIR, 'test.orc')
      CSOUND_SCO_OUTPUT = File.join(CSOUND_TMP_DIR, 'test.sco')
      CSOUND_OUTPUT     = File.join(CSOUND_TMP_DIR, 'test.wav')
      CSOUND_LOG        = File.join(CSOUND_TMP_DIR, 'test.log')
      SAMPLE_DIR        = File.join(COSB_ROOT, 'spec', 'algo', 'source')
      OCTAVE_TMP_DIR    = File.join(temp_path, 'octave')
      PIC_TMP_DIR       = File.join(temp_path, 'pic')

      task :prepare => [:full_cleanup, temp_path] do
        mkdir CONFIG_PATH
        mkdir File.join(CONFIG_PATH, 'global')
        mkdir File.join(CONFIG_PATH, 'spaces')
        mkdir CSOUND_TMP_DIR
        mkdir OCTAVE_TMP_DIR
        mkdir PIC_TMP_DIR
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
          cc = Cosb::Spec::Algo::TestHelper::ConfigurationCreator.new(temp_path)
          cc.configure
        end
  
        task :orc => [:config] do
          sh "#{COSB_EXE_PATH} -c #{CONFIG_PATH} > #{CSOUND_ORC_OUTPUT}"
        end
  
        task :sco => [:config] do
          sh "#{Y2SCO_EXE_PATH}  #{SOURCE_POSITION_PATH} > #{CSOUND_SCO_OUTPUT}"
        end

        task :generate_sample do
          sr = read_sample_rate
          cd(SAMPLE_DIR) do
            sh "make -s clean"
            sh "make -s SAMPLE_RATE=#{sr}"
          end
        end

        task :octave => [:config] do
        end

      end

      namespace :run do

        task :csound => ["create:orc", "create:sco", "create:generate_sample"] do
          csound_dir = File.join(temp_path, 'csound')
          sh "SSDIR=#{SAMPLE_DIR} csound -dWo #{CSOUND_OUTPUT} --logfile=#{CSOUND_LOG} #{CSOUND_ORC_OUTPUT} #{CSOUND_SCO_OUTPUT}"
        end
  
        task :octave => ["create:octave"]

        task :pic => [:config] do
        end

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

def read_sample_rate
  config_file = File.join(CONFIG_PATH, 'global', 'default.yml')
  data = YAML.load(File.open(config_file, 'r'))
  data['global']['sample_rate']
end
