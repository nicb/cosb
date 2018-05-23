require 'scanf'

module Cosb
  module Spec
    module Algo
      module Csound

        class ParseError < StandardError; end

        class LogReader
          attr_reader :file_in, :info, :file_out, :room, :signal, :speakers, :reflections

          def initialize(fni, fno)
            @file_in = fni
            @file_out = fno
            @info = Info.new
            @room = RoomInfo.new(self.info)
            @signal = SignalInfo.new(self.info)
            @speakers = [ SpeakerInfo.new(self.info), SpeakerInfo.new(self.info) ]
            @reflections = ReflectionsInfo.new(self.info)
            read
          end

          def to_yaml
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
              parse_point_source(line)
            when /^single_speaker/
              parse_single_speaker(line)
            when /^room_definition/
              parse_room_definition(line)
            end
          end

          def parse_point_source(line)
            (spkn, x, y) = line.scanf("point_source: source=%d, pos.x=%f, pos.y=%f")
            raise ParseError, "multiple sources parsing not yet implemented" if spkn != 1
            self.signal.x = x
            self.signal.y = y
          end

          def parse_single_speaker(line)
            case line
            when /: distances:/
               (lidx, src, dir, rfw, rrw, rbw, rlw) = line.scanf("single_speaker[%d]: distances: source=%d, direct=%f, rfw=%f, rrw=%f, rbw=%f, rlw=%f")
               self.speakers[lidx-1].distances['direct'] = dir
               self.speakers[lidx-1].distances['rfw'] = rfw
               self.speakers[lidx-1].distances['rrw'] = rrw
               self.speakers[lidx-1].distances['rbw'] = rbw
               self.speakers[lidx-1].distances['rrw'] = rrw
            when /: delays:/
               (lidx, src, dir, rfw, rrw, rbw, rlw) = line.scanf("single_speaker[%d]: delays: source=%d, direct=%f, rfw=%f, rrw=%f, rbw=%f, rlw=%f")
               self.speakers[lidx-1].delays['direct'] = dir
               self.speakers[lidx-1].delays['rfw'] = rfw
               self.speakers[lidx-1].delays['rrw'] = rrw
               self.speakers[lidx-1].delays['rbw'] = rbw
               self.speakers[lidx-1].delays['rrw'] = rrw
            else
              raise ParseError, "parse_single_speaker: couldn't recognize line #{line}"
            end
          end

          def parse_room_definition(line)
            case line
            when /: speaker\[/
              (lidx, x, y) = line.scanf("room_definition: speaker[%d]: x=%f, y=%f")
              self.speakers[lidx-1].x = x
              self.speakers[lidx-1].y = y
            when /: room:/
              (xmax, xmin, ymax, ymin) = line.scanf("room_definition: room: xmax=%f, xmin=%f, ymax=%f, ymin=%f")
              self.room.xmax = xmax
              self.room.xmin = xmin
              self.room.ymax = ymax
              self.room.ymin = ymin
            else
              raise ParseError, "parse_room_definition: couldn't recognize line #{line}"
            end
          end

        end

      end
    end
  end
end
