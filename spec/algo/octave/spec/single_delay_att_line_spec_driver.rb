require 'rspec'

describe 'the single line dealy and attenuation function (written in matlab)' do

 result.each do
   |r|
   it "does work for sig position(#{r.signal_position.x}, #{r.signal_position.y}) and loudspeaker pos(#{r.loudspeaker_position.x}, #{r.loudspeaker_position.y})" do
     expect(r.is).to be_within(1e-6).of(r.should_be)
   end
 end

end

