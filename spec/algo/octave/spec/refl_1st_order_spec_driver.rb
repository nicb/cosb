require 'rspec'

describe 'the 1st order reflections function (written in matlab)' do

 result.each do
   |r|
   it "does work for p1(#{r.source.x}, #{r.source.y}) in a #{r.length}, #{r.width} room" do
     r.is.each_index do
       |idx|
       expect(r.is[idx].x).to(be_within(1e-6).of(r.should_be[idx].x), r.is[idx].label + ' x')
       expect(r.is[idx].y).to(be_within(1e-6).of(r.should_be[idx].y), r.is[idx].label + ' y')
     end
   end
 end

end

