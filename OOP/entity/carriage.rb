# Carriage for train
class Carriage
  include Manufacturer
  include InitValidator
  include CarriageSpace

  def space_data
    {
      total: space,
      occupied: space_occupied,
      free: space_free,
      name: self.class.space_key
    }
  end

  def to_s
    key = self.class.space_key
    data = space_data

    "Carriage of type #{self.class} "\
    "with #{data[:total]} #{space_data[:name]} total, "\
    "#{data[:free]} free"
  end
end

# Cargo carriage
class CargoCarriage < Carriage
  alias volume space
  alias volume_occupied space_occupied
  alias volume_free space_free

  def initialize(volume)
    @space = volume.to_i
    @space_occupied = 0
    validate!
  end

  def self.space_key
    'volume'
  end

  def occupy_volume(volume_add)
    occupy_space(volume_add.to_i)
  rescue StandardError => e
    raise e.message.gsub('space', self.class.space_key)
  end

  protected

  alias volume= space=
  alias volume_occupied= space_occupied=

  def validate!
    raise 'Volume must be greater than 0!' unless volume.positive?
  end
end

# Passenger carriage
class PassengerCarriage < Carriage
  alias seats space
  alias seats_occupied space_occupied
  alias seats_free space_free

  def initialize(seats)
    @space = seats.to_i
    @space_occupied = 0
    validate!
  end

  def self.space_key
    'seats'
  end

  def occupy_seats
    occupy_space(1)
  rescue StandardError => e
    raise e.message.gsub('space', self.class.space_key)
  end

  protected

  alias seats= space=
  alias seats_occupied= space_occupied=

  def validate!
    raise 'Number of seats must be greater than 0!' unless seats.positive?
  end
end
