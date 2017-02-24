require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}
  let(:entry_station) {double :entry_station}
  let(:exit_station) {double :exit_station}

  before(:each) do
    card.top_up(3)
  end

  it "initializes with an empty journey log" do
    expect(card.journey_history).to be_empty
  end

  describe "#top_up", :top_up do
    it "responds to top_up" do
      expect(card).to respond_to(:top_up)
    end

    it "puts money on card" do
      expect(card.balance).to eq 3
    end
  end

  describe "#balance" do
    it "has a balance" do
      expect(card.balance).not_to be nil
    end

    it "has a default balance" do
      allow(card).to receive(:balance).and_return 0
      expect(card.balance).to eq 0
    end

    it "has a maximum limit" do
      expect{card.top_up(91)}.to raise_error "The maximum amount is: £#{Oystercard::LIMIT}."
    end
  end

    describe "#touch_in" do

      it "responds to touch_in" do
        expect(card).to respond_to(:touch_in)
      end

      it "returns a boolean value" do
        card.touch_in(card)
        expect(subject.in_journey?).to be true
      end

      it "responds to check_balance" do
        expect(card).to respond_to(:check_balance)
      end

      it "it sets the entry station" do
        card.touch_in(entry_station)
        expect(card.entry_station).to eq entry_station
      end

      context "when balance is below the minimum" do

        it "returns an error when balance is less than the minimum" do
          card.touch_in(entry_station)
          card.touch_out(exit_station)
          error = "The minimum balance needed for your journey is £#{Oystercard::MIN}"
          expect{card.touch_in(card)}.to raise_error error
        end
      end
    end

    describe "#touch_out" do
      end
      it "reduces the balance by the minimum fare" do
        card.touch_in(entry_station) #Before block (?)
        expect{card.touch_out(exit_station)}.to change{card.balance}.by(-Oystercard::MIN_FARE)
      end

      it "sets exit_station" do
        card.touch_in(entry_station)
        card.touch_out(exit_station)
        expect(card.exit_station).to eq exit_station
      end

      it "puts station data hash into history array" do
        card.touch_in(entry_station)
        card.touch_out(exit_station)
        expect(card.journey_history).to eq [{:entry_station => entry_station, :exit_station => exit_station}]
      end

  end
