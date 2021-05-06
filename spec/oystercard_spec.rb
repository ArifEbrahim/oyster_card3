# require './lib/oystercard.rb'

require 'oystercard'

RSpec.describe Oystercard do
  describe "#balance" do
    it "should return the balance on the card" do
      expect(subject.balance).to eq (0)
    end
  end

  describe "#top_up" do
    it 'should add to the balance' do
      expect{ subject.top_up(50) }.to change{ subject.balance }.by (50)
    end
    it 'should error if maximum balace exceeded' do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      expect { subject.top_up 1 }.to raise_error "limit exceeded of #{Oystercard::MAXIMUM_BALANCE}"
    end
  end

  describe "journeys variable" do
    it "should start empty" do
      expect(subject.journeys).to be_empty 
    end
  end

  describe '#in_journey?' do
    let (:station1){ double :station }
    let (:station2){ double :station }
    describe 'validation for touch in or out' do
      before  do 
        subject.top_up(Oystercard::BALANCE_LIMIT)
        subject.touch_in(station1)
      end
            
      it 'should return true after touching in' do
        expect(subject.in_journey?).to eq(true)
      end

      it 'should keep the information of the entry_station' do
        #station = double("Holborn")
        expect(subject.entry_station).to eq(station1)
      end
    
      it 'should return false after touching out' do
        subject.touch_out(station2)
        expect(subject.in_journey?).to eq(false)
      end

      it 'forget the entry station on touch out' do
        subject.touch_out(station2)
        expect(subject.entry_station).to eq(nil)
      end

      it 'charges the minimum fare on touch out' do
        expect{ subject.touch_out(station2) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_FARE)
      end

      it 'should keep the information of the exit_station' do
        subject.touch_out(station2)
        expect(subject.exit_station).to eq(station2)
      end

      it 'should remember user journeys' do
        subject.touch_out(station2)
        expect(subject.journeys[:entry_station]).to be(station1)
        expect(subject.journeys[:exit_station]).to be(station2)
      end

      it 'creates a journey' do
        subject.touch_out(station2)
        expect(subject.journeys.length).to eq(2)
      end
    end

    it 'raise an error if user touch_in with 0 balance' do
      expect { subject.touch_in(station1) }.to raise_error 'Not enough funds'
    end
  end
end