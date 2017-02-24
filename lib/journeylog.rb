class JourneyLog
  attr_reader :current_journey, :logs

  def initialize
    @logs = []
  end

  def start(station)
    @current_journey = Journey.new(station)
  end

  def finish(station)
    @current_journey ||= Journey.new(nil)
    @current_journey.recieve_exit_info(station)
    @logs << @current_journey
  end

end
