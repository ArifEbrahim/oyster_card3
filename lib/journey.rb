class Journey
  attr_reader :entry_station, :exit_station
  PEN_FARE = 6
  MIN_FARE = 1

  def initialize
  @entry_station = nil
  end

  def entry(entry_station = nil)
    @entry_station = entry_station
  end

  def exit(exit_station)
    @exit_station = exit_station
  end

  def is_complete?
    if @entry_station == nil || @exit_station == nil
        false
    else
        true
    end
  end

  def calc_fare
    is_complete? ? MIN_FARE : PEN_FARE
  end
end