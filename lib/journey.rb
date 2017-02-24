class Journey
attr_accessor :entry_station, :exit_station

PENALTY_FARE = 6

  def initialize(station)
    @entry_station = station
    @exit_station = nil
  end

  def recieve_exit_info(station)
    @exit_station = station
  end

  def complete?
    !!@entry_station && !!@exit_station
  end

  def fare
    complete? ? Oystercard::MIN : PENALTY_FARE
  end

end
