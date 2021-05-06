class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journeys

  MAXIMUM_BALANCE = 90
  BALANCE_LIMIT = 1
  MINIMUM_FARE = 5
  
  def initialize
    @balance = 0
    @entry_station
    @exit_station
    @journeys = {}
  end

  def top_up(amount)
    fail "limit exceeded of #{Oystercard::MAXIMUM_BALANCE}" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail 'Not enough funds' if below_min?
    @entry_station = station
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_out(station)
    @exit_station = station
    @journeys[:entry_station] = @entry_station
    @journeys[:exit_station] = @exit_station
    deduct
    @entry_station = nil
  end

  private

  def deduct(amount=MINIMUM_FARE)
    @balance -= amount
  end

  def below_min?
    @balance < BALANCE_LIMIT
  end
end