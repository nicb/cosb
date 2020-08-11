module Cosb
  module Spec
    module Algo
      module Csound

        class LogReader
          attr_reader :file_in, :file_out, :room, :signal, :speakers, :configuration

          def initialize(fni, fno, cfg)
            @file_in = fni
            @file_out = fno
            @room = RoomInfo.new
            @signal = SignalInfo.new
            @configuration = cfg
            @speakers = []
            1.upto(self.configuration.global.nchnls) { |n| @speakers << SpeakerInfo.new(n) }
            read
          end

          def to_yaml
            res = ""
            [:room, :signal].each { |m| res += self.send(m).to_yaml }
            res += "speakers:\n"
            self.speakers.each { |s| res += s.to_yaml }
            File.open(self.file_out, 'w') { |yfh| yfh.puts(res) }
          end

        private

          def read
            File.open(self.file_in, 'r') do
              |fh|
              lines = fh.readlines
              lines.each { |l| parse(l.chomp) }
            end
          end

          def parse(line)
            case line
            when /^point_source/
              self.signal.parse(line)
            when /^single_speaker/
              sidx = speaker_index(line)
              self.speakers[sidx-1].parse(line)
            when /^room_definition/
              self.room.parse(line, self.speakers)
            end
          end

          def speaker_index(line)
            res = line.scanf("single_speaker[%d]:")
            raise ParseError, "couldn't infer speaker number from \"#{line}\"" unless res
            res.first
          end

        end

      end
    end
  end
end
