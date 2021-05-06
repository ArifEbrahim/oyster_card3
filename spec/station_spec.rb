require 'station'

RSpec.describe Station do
  let(:station){Station.new(1, "Victoria")}
   it 'has the station_name' do
   expect(station.name).to eq("Victoria")
   end
   
   it 'has the zone' do
   expect(station.zone).to eq(1)
   end
end

