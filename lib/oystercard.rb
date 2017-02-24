require_relative 'journey'

class Oystercard
attr_reader :balance, :entry_station, :exit_station, :journey_history, :journey

  def initialize
    @balance = 0
    @journey_history = []
    @entry_station = nil
    @exit_station = nil
  end

  LIMIT = 90
  MIN = 1
  MIN_FARE = 3

  def top_up(money)
    fail "The maximum amount is: £#{LIMIT}." if money > LIMIT
    @balance += money
  end

  def touch_in(station)
    check_balance
    @entry_station = station
    @journey = Journey.new(station)
    # journey.save_entry_station(station)
    #above doesnt work because we're trying to pass in a different object. Journey and journey in our test are both different
    # @entry_station = station

    # @in_transit << card
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @journey.recieve_exit_info(station)
    @exit_station = station
    @journey_history << {
      :entry_station => @entry_station,
      :exit_station => @exit_station
    }
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  def check_balance
    fail "The minimum balance needed for your journey is £#{MIN}" unless @balance > MIN
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
