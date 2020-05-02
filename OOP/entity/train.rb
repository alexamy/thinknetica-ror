# Train can move, has carriage and optional route
class Train
  include InstanceCounter
  include Manufacturer
  include InitValidator

  attr_reader :number, :type, :carriages,
              :velocity, :route, :station

  NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i.freeze

  def self.find(number)
    pool.find { |train| train.number == number }
  end

  def initialize(number)
    @number = number.to_s
    @carriages = []
    @velocity = 0

    validate!
    register_instance
  end

  def carriage_type
    Carriage
  end

  def add_velocity(gain = 10)
    self.velocity += gain if gain.positive?
  end

  def stop
    self.velocity = 0
  end

  def stopped?
    velocity.zero?
  end

  def carriage?
    carriages.size.positive?
  end

  def add_carriage(carriage)
    return unless stopped? && carriage.class == carriage_type

    carriages << carriage
  end

  def remove_carriage
    carriages.pop if stopped? && carriage?
  end

  def place_on_route(route)
    self.route = route

    station&.departure_train(self)
    self.station = self.route.stations.first
    station.add_train(self)
  end

  def go_to_next_station
    station_next = route&.station_next(station)
    return unless station_next

    station.departure_train(self)
    self.station = station_next
    station.add_train(self)
  end

  def go_to_previous_station
    station_previous = route&.station_previous(station)
    return unless station_previous

    station.departure_train(self)
    self.station = station_previous
    station.add_train(self)
  end

  def station_next
    route&.station_next(station)
  end

  def station_previous
    route&.station_previous(station)
  end

  def each_carriage
    carriages.each { |carriage| yield carriage }
  end

  def to_s
    "Train #{number}"\
    " with #{carriages.size} carriages"\
    " of type #{carriage_type}"\
    " #{station ? 'on station ' + station.name : 'is not on route'}"
  end

  protected

  # Only class can write its values directly
  attr_writer :number, :carriages,
              :velocity, :route, :station

  def validate!
    raise 'Empty number!' unless number
    raise 'Bad number format!' unless number =~ NUMBER_FORMAT
  end
end

# Cargo train
class CargoTrain < Train
  def carriage_type
    CargoCarriage
  end
end

# Passenger train
class PassengerTrain < Train
  def carriage_type
    PassengerCarriage
  end
end
