# Train can move, has carriage and optional route
class Train
  attr_reader :number, :type, :carriages,
              :velocity, :route, :station

  def initialize(number, type, carriages_count)
    @number = number
    @type = type
    @carriages = carriages_count.times.map { carriage_type.new }
    @velocity = 0
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

  def set_route(route_target)
    self.route = route_target

    station&.departure_train(self)
    self.station = route.stations.first
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

  protected

  # Only class can write its values directly
  attr_writer :number, :type, :carriages,
              :velocity, :route, :station
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
