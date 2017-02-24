require 'journeylog'

describe JourneyLog do
  let(:station) {Station.new(name: "whitechapel", zone: 2)}
  let(:journeylog) {described_class.new}
  let(:journey) {Journey.new(station)}

  it {is_expected.to respond_to (:start)}
  it {is_expected.to respond_to (:finish)}
  it {is_expected.to respond_to (:logs)}

  it "initialises with an empty array" do
    expect(journeylog.logs ).to be_empty
  end

  it "starts a journey" do
    journeylog.start(station)
    expect(journeylog.current_journey.entry_station).to eq station
  end

  it "ends a journey" do
    journeylog.finish(station)
    expect(journeylog.current_journey.exit_station).to eq station
  end

  it "stores a complete journeys" do
    journeylog.start(station)
    journeylog.finish(station)
    expect(journeylog.logs).to_not be_empty
  end

  it "stores incomplete journey - 1" do
    journeylog.start(station)
    expect(journeylog.logs).to_not be_empty
  end

  it "stores incomplete journey - 2" do
    journeylog.finish(station)
    expect(journeylog.logs).to_not be_empty
  end

end
