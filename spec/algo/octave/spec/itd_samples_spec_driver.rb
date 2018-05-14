require 'rspec'

describe 'the itd_samples function (written in matlab)' do

 result.each do
   |r|
   it "does work for distance #{r.distance}" do
     expect(r.should_be).to be_within(1e-6).of(r.is)
   end
 end

end
