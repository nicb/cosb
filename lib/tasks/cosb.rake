require 'tempfile'
require 'fileutils'

LIBDIR = File.expand_path(File.join(['..'] * 3, 'spec', 'algo', 'lib'), __FILE__)

%w(
  test_helper
  octave
  pic
  csound
).each { |f| require File.join(LIBDIR, f) }

namespace :cosb do

  namespace :test do
  
    namespace :csound do

      COSB_ROOT = File.expand_path(File.join(['..'] * 3), __FILE__)
      ALGO_ROOT = File.join(COSB_ROOT, 'spec', 'algo')
      TEMP_PATH_ROOT = File.join(ALGO_ROOT, 'tmp')
      TEMP_PATH = File.join(TEMP_PATH_ROOT, 'cosb-')
      temp_path = Dir::Tmpname.make_tmpname(TEMP_PATH, nil)
      COSB_EXE_PATH = File.join(COSB_ROOT, 'bin', 'cosb')
      Y2SCO_EXE_PATH = File.join(ALGO_ROOT, 'csound', 'y2sco')
      CONFIG_PATH = File.join(temp_path, 'config')
      SOURCE_POSITION_PATH = File.join(temp_path, 'config', 'spaces', 'source.yml')
      CSOUND_TMP_DIR = File.join(temp_path, 'csound')
      CSOUND_ORC_OUTPUT = File.join(CSOUND_TMP_DIR, 'test.orc')
      CSOUND_SCO_OUTPUT = File.join(CSOUND_TMP_DIR, 'test.sco')
      CSOUND_OUTPUT     = File.join(CSOUND_TMP_DIR, 'test.wav')
      CSOUND_LOG        = File.join(CSOUND_TMP_DIR, 'test.log')
      CSOUND_INFO       = File.join(CSOUND_TMP_DIR, 'info.yml')
      SAMPLE_DIR        = File.join(ALGO_ROOT, 'source')
      SAMPLE_PATH       = File.join(SAMPLE_DIR, 'bwl_pulse_1ch.wav')
      OCTAVE_TMP_DIR    = File.join(temp_path, 'octave')
      OCTAVE_EXE        = 'octave --no-gui -q'
      OCTAVE_LIB_PATH   = File.join(ALGO_ROOT, 'octave')
      OCTAVE_OUTPUT     = File.join(OCTAVE_TMP_DIR, 'test.wav')
      OCTAVE_PLOT_OUTPUT = File.join(OCTAVE_TMP_DIR, 'test.pdf')
      OCTAVE_DRIVER_TEMPLATE = File.join(ALGO_ROOT, 'lib', 'templates', 'octave', 'driver.m.erb')
      OCTAVE_DRIVER_OUTPUT   = File.join(OCTAVE_TMP_DIR, 'driver.m')
      OCTAVE_COMPARATOR_TEMPLATE = File.join(ALGO_ROOT, 'lib', 'templates', 'octave', 'comparator.m.erb')
      OCTAVE_COMPARATOR_OUTPUT   = File.join(OCTAVE_TMP_DIR, 'comparator.m')
      OCTAVE_COMPARATOR_PLOT_ROOT= File.join(OCTAVE_TMP_DIR, 'plot')
      OCTAVE_INFO_OUTPUT  = File.join(OCTAVE_TMP_DIR, 'info.yml')
      PIC_TMP_DIR       = File.join(temp_path, 'pic')
      PIC_TEMPLATE_DIR  = File.join(ALGO_ROOT, 'lib', 'templates', 'pic')
      PIC_TEMPLATE      = File.join(PIC_TEMPLATE_DIR, 'post.pic.erb')
      PIC_MACRO_FILE    = File.join(PIC_TEMPLATE_DIR, 'room_plot.pic')
      PIC_INFO_INPUT    = OCTAVE_INFO_OUTPUT
      PIC_OUTPUT        = File.join(PIC_TMP_DIR, 'room_plot.pic')
      PIC_EXE           = 'groff -p -mpic -mps'
      PS2PDF            = 'ps2pdf'
      PIC_PDF           = File.join(PIC_TMP_DIR, 'room_plot.pdf')

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
          sh "#{COSB_EXE_PATH} -n -c #{CONFIG_PATH} > #{CSOUND_ORC_OUTPUT}"
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
          p = Cosb::Spec::Algo::Octave::Parameters.new(OCTAVE_LIB_PATH, SAMPLE_PATH, OCTAVE_OUTPUT, OCTAVE_PLOT_OUTPUT, OCTAVE_INFO_OUTPUT)
          g = Cosb::Spec::Algo::Octave::Generator.new(CONFIG_PATH, OCTAVE_DRIVER_TEMPLATE, OCTAVE_DRIVER_OUTPUT, p)
          g.generate          
        end

        task :octave_comparator => [:config] do
          c = Cosb::Spec::Algo::Octave::Comparator.new(OCTAVE_COMPARATOR_TEMPLATE, OCTAVE_COMPARATOR_OUTPUT, CSOUND_OUTPUT, OCTAVE_OUTPUT, OCTAVE_COMPARATOR_PLOT_ROOT, OCTAVE_INFO_OUTPUT)
          c.generate
        end

        task :pic => ["run:octave"] do
          g = Cosb::Spec::Algo::Pic::Generator.new(PIC_INFO_INPUT, PIC_TEMPLATE, PIC_MACRO_FILE, PIC_OUTPUT)
          g.generate
        end

        task :csound_info => ["run:csound"] do
          ci = Cosb::Spec::Algo::Csound::LogReader.new(CSOUND_LOG, CSOUND_INFO)
          ci.to_yaml
        end

      end

      namespace :run do

        task :csound => ["create:orc", "create:sco", "create:generate_sample"] do
          csound_dir = File.join(temp_path, 'csound')
          sh "SSDIR=#{SAMPLE_DIR} csound -dWo #{CSOUND_OUTPUT} --logfile=#{CSOUND_LOG} #{CSOUND_ORC_OUTPUT} #{CSOUND_SCO_OUTPUT}"
        end
  
        task :octave => ["create:octave"] do
          sh "#{OCTAVE_EXE} #{OCTAVE_DRIVER_OUTPUT}"
        end

        desc "display results"
        task :display => ["create:pic"] do
          sh "#{PIC_EXE} #{PIC_OUTPUT} | #{PS2PDF} - #{PIC_PDF}"
        end

      end

      task :compare_csound_octave => ["create:csound_info", "run:octave", "create:octave_comparator", "run:display"] do
          sh "#{OCTAVE_EXE} #{OCTAVE_COMPARATOR_OUTPUT}"
      end

    end

    desc 'test cosb csound production with random configurations'
    RSpec::Core::RakeTask.new(:spec => ["csound:compare_csound_octave"]) do
      |t|
      t.pattern = Dir.glob(File.join(COSB_ROOT, 'spec', 'algo', 'spec', '**', '*_spec.rb'))
    end

  end

end

def read_sample_rate
  config_file = File.join(CONFIG_PATH, 'global', 'default.yml')
  data = YAML.load(File.open(config_file, 'r'))
  data['global']['sample_rate']
end
