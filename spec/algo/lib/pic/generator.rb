require 'erb'

module Cosb
  module Spec
    module Algo

     module Pic
   
       class Generator
         attr_reader :reader, :template, :macro_file_path, :out_file
   
         def initialize(fp, tmpl, mfp, of)
           @reader = Reader.new(fp)
           @template = tmpl
           @macro_file_path = mfp
           @out_file = of
         end
   
         #
         # create()
         #
         # * copies the room_plot.pic macro library file
         # * sets up the room_wid and room_ht
         # * sets up the speakers
         # * calculate all the distances
         # * sets up the trapezoids between center, speakers and position
         # * traces dashed lines btw source, speakers and centers with numbers above
         #
         def create
           parms = self.reader
           res = header()
           File.open(self.template, 'r') do
             |tfh|
             tmpl = ERB.new(tfh.readlines.join)
             res += tmpl.result(binding)
           end
           res
         end
   
         def generate
           File.open(self.out_file, 'w') { |wfh| wfh.puts(self.create) }
         end
   
       private
   
         def header()
           ".\\\"\n.\\\" Pic script produced by the #{File.basename($0)} software\n.\\\" DO NOT EDIT! (any edit will be overwritten)\n.\\\"\n.\\\"\n"
         end
   
       end
   
     end

    end
  end
end

