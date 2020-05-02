# Carriage for train
class Carriage
  include Manufacturer
  include InitValidator
end

# Cargo carriage
class CargoCarriage < Carriage
end

# Passenger carriage
class PassengerCarriage < Carriage
  attr_reader :seats, :seats_occupied

  def initialize(seats)
    @seats = seats
    @seats_occupied = 0
    validate!
  end

  def occupy_seat
    raise 'All seats occupied!' if seats_occupied == seats

    self.seats_occupied += 1
  end

  def seats_free
    seats - seats_occupied
  end

  protected

  attr_writer :seats, :seats_occupied

  def validate!
    raise 'Number of seats must be greater than 0!' unless seats.positive?
  end
end
