require_relative 'journey'

class Oystercard
attr_reader :balance, :journey_history, :journey

  def initialize
    @balance = 0
    @journey_history = []
    @in_journey = false
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
    if journey_history.any? && @journey_history[-1].exit_station == nil
        deduct(Journey::PENALTY_FARE)
    else
      @journey = Journey.new(station)
      @journey_history << @journey
    end
    @in_journey = true
  end

  def touch_out(station)
    @journey ||= Journey.new(nil)
    @journey.entry_station == nil ? deduct(Journey::PENALTY_FARE) : deduct(MIN_FARE)
    @journey.recieve_exit_info(station)
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  def check_balance
    fail "The minimum balance needed for your journey is £#{MIN}" unless @balance > MIN
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
