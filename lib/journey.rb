class Journey
attr_accessor :entry_station, :exit_station

  def initialize(station)
    @entry_station = station
  end

  def recieve_exit_info(station)
    @exit_station = station
  end

end
