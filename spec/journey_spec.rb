require 'journey'

describe Journey do
  
  let(:entry_station) { double(name: "Victoria") }
  let(:exit_station) { double(name: "St Pancras") }

  it "checks for an entry station" do
  #journey = Journey.new
    subject.entry(entry_station)
    expect(subject.entry_station).to eq(entry_station)
  end

  it "checks for an exit station" do
    subject.exit(exit_station)
    expect(subject.exit_station).to eq(exit_station)
  end

  describe "checks if journey complete for both entry & exit" do
    it "has no entry station recorded" do
        subject.entry(entry_station = nil)
        expect(subject.entry_station).to eq(nil)
    end

    it "has no entry station recorded" do
        subject.exit(exit_station = nil)
        expect(subject.exit_station).to eq(nil)
    end

    it "checks that the journey is complete" do
        subject.entry(entry_station)
        subject.exit(exit_station)
        expect(subject.is_complete?).to eq(true)
    end

    it "checks that the journey is incomplete" do
        subject.entry(entry_station)
        subject.exit(exit_station = nil)
        expect(subject.is_complete?).to eq(false)
    end

    it "checks that the journey is incomplete" do
        subject.entry(entry_station = nil)
        subject.exit(exit_station)
        expect(subject.is_complete?).to eq(false)
    end

    it "calculates succesful journey price" do
        subject.entry(entry_station)
        subject.exit(exit_station)
        expect(subject.calc_fare).to eq(1)
    end

    it "calculates unsuccesful journey price" do
        subject.entry(entry_station = nil)
        subject.exit(exit_station)
        expect(subject.calc_fare).to eq(6)
    end

    it "calculates unsuccesful journey price" do
        subject.entry(entry_station)
        subject.exit(exit_station = nil)
        expect(subject.calc_fare).to eq(6)
    end
  end  
end
 # journey = Journey.new
 # journey.entry(entry_station)
 # journey.exit(exit_station)
 # journey.is_complete? # if true charge fare, if false charge penalty
 # journey.fare()