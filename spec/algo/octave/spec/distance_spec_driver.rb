require 'rspec'

describe 'the distance function (written in matlab)' do

 result.each do
   |r|
   it "does work for p1(#{r.p1.x}, #{r.p1.y}) and p2(#{r.p2.x}, #{r.p2.y})" do
     expect(r.should_be).to be_within(1e-6).of(r.is)
   end
 end

end
