# Carriage for train
class Carriage
  include Manufacturer
  include CarriageSpace

  def space_data
    {
      total: space,
      occupied: space_occupied,
      free: space_free,
      name: space_key
    }
  end

  def space_key
    self.class::SPACE_KEY
  end

  def to_s
    data = space_data
    "Carriage of type #{self.class} "\
    "with #{data[:total]} #{space_data[:name]} total, "\
    "#{data[:free]} free"
  end
end

# Cargo carriage
class CargoCarriage < Carriage
  extend Validation

  SPACE_KEY = 'volume'.freeze

  alias volume space
  alias volume= space=
  alias volume_occupied space_occupied
  alias volume_occupied= space_occupied=
  alias volume_free space_free

  validate :space, :positive

  def initialize(volume)
    @space = volume.to_i
    @space_occupied = 0
    validate!
  end

  def occupy_volume(volume_add)
    occupy_space(volume_add.to_i)
  rescue StandardError => e
    raise e.message.gsub('space', SPACE_KEY)
  end
end

# Passenger carriage
class PassengerCarriage < Carriage
  extend Validation

  SPACE_KEY = 'seats'.freeze

  alias seats space
  alias seats= space=
  alias seats_occupied space_occupied
  alias seats_occupied= space_occupied=
  alias seats_free space_free

  validate :space, :positive

  def initialize(seats)
    @space = seats.to_i
    @space_occupied = 0
    validate!
  end

  def occupy_seats
    occupy_space(1)
  rescue StandardError => e
    raise e.message.gsub('space', SPACE_KEY)
  end
end
