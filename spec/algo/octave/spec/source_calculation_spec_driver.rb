require 'rspec'

describe 'the source calculation function (written in matlab)' do

 result.each do
   |r|
   it "does work for sig position(#{r.signal_position.x}, #{r.signal_position.y}) and loudspeaker pos([(#{r.loudspeaker_positions[0].x}, #{r.loudspeaker_positions[0].y}), (#{r.loudspeaker_positions[1].x}, #{r.loudspeaker_positions[1].y})])" do
     r.is.each_index do
       |idx|
       expect(r.is[idx]).to be_within(1e-6).of(r.should_be[idx])
     end
   end
 end

end
