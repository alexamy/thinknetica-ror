# Carriage for train
class Carriage
  include Manufacturer
  include InitValidator
end

# Cargo carriage
class CargoCarriage < Carriage
  attr_reader :volume, :volume_occupied

  def initialize(volume)
    @volume = volume
    @volume_occupied = 0
    validate!
  end

  def occupy_volume(volume_add)
    raise 'Added volume must be positive!' unless volume_add.positive?
    raise 'All volume is occupied!' if volume_occupied == volume

    volume_new = volume_occupied + volume_add
    raise 'Initial volume exceeded!' if volume_new > volume

    self.volume_occupied = volume_new
  end

  def volume_free
    volume - volume_occupied
  end

  def space_data
    {
      total: volume,
      occupied: volume_occupied,
      free: volume_free,
      name: 'volume'
    }
  end

  protected

  attr_writer :volume, :volume_occupied

  def validate!
    raise 'Volume must be greater than 0!' unless volume.positive?
  end
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

  def space_data
    {
      total: seats,
      occupied: seats_occupied,
      free: seats_free,
      name: 'seats'
    }
  end

  protected

  attr_writer :seats, :seats_occupied

  def validate!
    raise 'Number of seats must be greater than 0!' unless seats.positive?
  end
end
